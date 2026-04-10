#!/bin/bash
set -e

echo "=== 0. 修复提取文件夹权限 ==="
sudo chmod -R 777 system_files product_files system_ext_files 2>/dev/null || true

echo "=== 1. 动态寻找并安装 HyperOS 系统框架 ==="
FW_RES=$(find system_files -type f -name "framework-res.apk" 2>/dev/null | head -n 1)
MIUI_FW=$(find system_files -type f -name "miui-framework-res.apk" 2>/dev/null | head -n 1)

if [ -n "$FW_RES" ]; then
    echo "    [成功] 找到基础框架: $FW_RES"
    apktool if "$FW_RES"
else
    echo "    [警告] 未找到 framework-res.apk！"
fi

if [ -n "$MIUI_FW" ]; then
    echo "    [成功] 找到 MIUI 框架: $MIUI_FW"
    apktool if "$MIUI_FW"
fi

echo "=== 2. 动态定位目标 APK ==="
MSA_APK=$(find product_files -type f -name "MSA.apk" 2>/dev/null | head -n 1)
SEC_APK=$(find product_files -type f -name "MIUISecurityCenter.apk" 2>/dev/null | head -n 1)
SET_APK=$(find system_ext_files -type f -name "Settings.apk" 2>/dev/null | head -n 1)

APK_PATHS=()
[ -n "$MSA_APK" ] && APK_PATHS+=("$MSA_APK")
[ -n "$SEC_APK" ] && APK_PATHS+=("$SEC_APK")
[ -n "$SET_APK" ] && APK_PATHS+=("$SET_APK")

if [ ${#APK_PATHS[@]} -eq 0 ]; then
    echo "错误: 未找到任何目标 APK，请检查 EROFS 解包步骤是否成功释放了文件！"
    exit 1
fi

mkdir -p output_apks

echo "=== 3. 开始批量处理 APK ==="
for apk_path in "${APK_PATHS[@]}"; do
    apk_name=$(basename "$apk_path")
    apk_base="${apk_name%.*}"
    
    echo "----------------------------------------"
    echo "正在处理: $apk_name (来源路径: $apk_path)"
    echo "----------------------------------------"
    
    cp -f "$apk_path" "./$apk_name"
    
    echo ">>> 正在反编译..."
    apktool d "$apk_name" -o "${apk_base}_decoded" > /dev/null
    
    echo ">>> 注入修改代码..."
    
    # ==========================================
    # 1. MSA 去广告逻辑
    # ==========================================
    if [ "$apk_base" == "MSA" ]; then
        TARGET_FILE=$(grep -rl '"/miad/"' "${apk_base}_decoded/smali" | head -n 1)
        if [ -n "$TARGET_FILE" ]; then
            sed -i 's/Ljava\/io\/File;->mkdirs()Z/Ljava\/io\/File;->createNewFile()Z/g' "$TARGET_FILE"
            echo "    [成功] MSA 代码替换完成！"
        fi

    # ==========================================
    # 2. MIUISecurityCenter 电池健康度扩展逻辑
    # ==========================================
    elif [ "$apk_base" == "MIUISecurityCenter" ]; then
        XML_FILE=$(grep -rl '"reference_battery_health"' "${apk_base}_decoded/res/xml" | head -n 1)
        if [ -n "$XML_FILE" ]; then
            sed -i '/"reference_battery_health"/a \        <miuix.preference.TextPreference android:title="详细电池健康度" android:key="battery_health" />' "$XML_FILE"
            sed -i '/"reference_toady_charge_time"/a \        <miuix.preference.TextPreference android:title="循环次数" android:key="battery_cycle_value" />\n        <miuix.preference.TextPreference android:title="出厂设计容量" android:key="battery_design_capacity" />\n        <miuix.preference.TextPreference android:title="实际电池容量" android:key="battery_really_capacity" />\n        <miuix.preference.TextPreference android:title="当前电量" android:key="battery_status_now" />\n        <miuix.preference.TextPreference android:title="电池温度" android:key="battery_now_temp" />' "$XML_FILE"
            echo "    [成功] XML 菜单项注入完成！"
        fi

        SMALI_FILE=$(find "${apk_base}_decoded/smali"* -name "ChargeProtectFragment.smali" | head -n 1)
        if [ -n "$SMALI_FILE" ]; then
            sed -i '/^\.super/a \.field private x:Lmiuix/preference/TextPreference;\n\.field private y:Lmiuix/preference/TextPreference;\n\.field private z:Lmiuix/preference/TextPreference;' "$SMALI_FILE"
            sed -i '/"reference_toady_charge_time"/a \    invoke-static {p0}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getAllBatteryInfo(Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;)V' "$SMALI_FILE"
            if [ -f "BatteryMod_all.smali" ]; then
                echo "" >> "$SMALI_FILE"
                cat BatteryMod_all.smali >> "$SMALI_FILE"
                echo "    [成功] Smali 方法追加完成！"
            fi
        fi

    # ==========================================
    # 3. Settings 全能修改逻辑 
    # ==========================================
    elif [ "$apk_base" == "Settings" ]; then
        echo "--> 应用 Settings 综合修改..."
        
        XML_FILES=$(grep -rl '"notification_icon_counts_entries"' "${apk_base}_decoded/res/" || true)
        if [ -n "$XML_FILES" ]; then
            for file in $XML_FILES; do
python3 -c "
import re, sys
file = sys.argv[1]
with open(file, 'r', encoding='utf-8') as f: content = f.read()
entries_pattern = r'<string-array name=\"notification_icon_counts_entries\">.*?</string-array>'
new_entries = '''<string-array name=\"notification_icon_counts_entries\">\n        <item>不显示</item>\n        <item>显示1个</item>\n        <item>显示2个</item>\n        <item>显示3个</item>\n        <item>显示4个</item>\n        <item>显示5个</item>\n        <item>显示6个</item>\n        <item>显示7个</item>\n    </string-array>'''
content = re.sub(entries_pattern, new_entries, content, flags=re.DOTALL)
values_pattern = r'<string-array name=\"notification_icon_counts_values\">.*?</string-array>'
new_values = '''<string-array name=\"notification_icon_counts_values\">\n        <item>0</item>\n        <item>1</item>\n        <item>2</item>\n        <item>3</item>\n        <item>4</item>\n        <item>5</item>\n        <item>6</item>\n        <item>7</item>\n    </string-array>'''
content = re.sub(values_pattern, new_values, content, flags=re.DOTALL)
with open(file, 'w', encoding='utf-8') as f: f.write(content)
" "$file"
            done
        fi

        NOTIFY_SMALI=$(grep -rl '\.method private setupShowNotificationIconCount()V' "${apk_base}_decoded/smali"* | head -n 1)
        if [ -n "$NOTIFY_SMALI" ]; then
python3 -c "
import re, sys
file = sys.argv[1]
with open(file, 'r', encoding='utf-8') as f: content = f.read()
method_pattern = r'(\.method private setupShowNotificationIconCount\(\)V.*?\.end method)'
match = re.search(method_pattern, content, flags=re.DOTALL)
if match:
    body = match.group(1)
    body = re.sub(r'\.registers \d+', '.registers 9', body)
    
    # 【核心修复点】防吞噬的高精度正则：只允许 const/4 和 .line 指令存在于两者之间，绝对不吞标签！
    array_pattern = r'const/4 v0, 0x0(?:[\s]+(?:const/4 v\d, 0x[0-9a-f]|\.line \d+))*[\s]+filled-new-array[^\n]*\[I'
    new_array = '''const/4 v0, 0x0\n    const/4 v1, 0x1\n    const/4 v2, 0x2\n    const/4 v3, 0x3\n    const/4 v4, 0x4\n    const/4 v5, 0x5\n    const/4 v6, 0x6\n    const/4 v7, 0x7\n    filled-new-array/range {v0 .. v7}, [I'''
    
    body = re.sub(array_pattern, new_array, body)
    content = content[:match.start()] + body + content[match.end():]
    with open(file, 'w', encoding='utf-8') as f: f.write(content)
" "$NOTIFY_SMALI"
        fi
        echo "    [成功] 通知图标数量解除限制完成！"

        if [ -f "Legal.smali" ]; then
            LEGAL_TARGET=$(find "${apk_base}_decoded/smali"* -path "*/com/android/settings/Legal.smali" 2>/dev/null | head -n 1)
            if [ -n "$LEGAL_TARGET" ]; then
                cp -f Legal.smali "$LEGAL_TARGET"
                echo "    [成功] Legal.smali 核心逻辑替换完成！"
            else
                echo "    [警告] 未在解包目录找到原始 Legal.smali，正在创建新路径注入..."
                mkdir -p "${apk_base}_decoded/smali/com/android/settings/"
                cp -f Legal.smali "${apk_base}_decoded/smali/com/android/settings/"
            fi
        else
            echo "    [错误] 缺失 Legal.smali 文件！"
            exit 1
        fi

python3 -c "
import os, re, sys
base_dir = sys.argv[1]

res_dir = os.path.join(base_dir, 'res')
for root, dirs, files in os.walk(res_dir):
    if 'values' in root:
        for file in files:
            if file.endswith('.xml'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f: content = f.read()
                modified = False
                if '折叠屏专区' in content:
                    content = content.replace('折叠屏专区', 'CypressFjord®特调功能')
                    modified = True
                if '法律信息' in content:
                    content = content.replace('法律信息', '关于')
                    modified = True
                if modified:
                    with open(filepath, 'w', encoding='utf-8') as f: f.write(content)

for root, dirs, files in os.walk(base_dir):
    if 'smali' in root:
        for file in files:
            if file.endswith('.smali'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f: content = f.read()
                modified_smali = False

                pattern_support = r'\.method private static isSupportFoldScreenSettings\(\)Z.*?\.end method'
                if re.search(pattern_support, content, flags=re.DOTALL):
                    new_support = '''.method private static isSupportFoldScreenSettings()Z\n    .registers 2\n    const/4 v0, 0x1\n    return v0\n.end method'''
                    content = re.sub(pattern_support, new_support, content, flags=re.DOTALL)
                    modified_smali = True

                if file == 'MiuiFoldScreenSettings.smali':
                    pattern_display = r'\.method protected displayResourceTilesToScreen\(Landroidx/preference/PreferenceScreen;\)V.*?\.end method'
                    if re.search(pattern_display, content, flags=re.DOTALL):
                        new_display = '''.method protected displayResourceTilesToScreen(Landroidx/preference/PreferenceScreen;)V\n    .registers 2\n    return-void\n.end method'''
                        content = re.sub(pattern_display, new_display, content, flags=re.DOTALL)
                        modified_smali = True

                if modified_smali:
                    with open(filepath, 'w', encoding='utf-8') as f: f.write(content)
" "${apk_base}_decoded"
        echo "    [成功] ARSC 文本修改与折叠屏 Smali 破解完成！"
    fi
    # ==========================================

    echo ">>> 正在回编译..."
    apktool b "${apk_base}_decoded" -f -o "output_apks/${apk_base}_modified.apk" > /dev/null
    
    # 🎯 绝妙操作：在回编译完成后，强行注入二进制 XML 到 APK 中！
    if [ "$apk_base" == "Settings" ] && [ -f "ad_service_settings.xml" ]; then
        echo ">>> 正在直接注入二进制 XML 布局文件到 APK..."
        mkdir -p tmp_inject/res/xml
        cp -f ad_service_settings.xml tmp_inject/res/xml/
        cp -f device_info_legal.xml tmp_inject/res/xml/
        cp -f fold_screen_settings.xml tmp_inject/res/xml/
        
        cd tmp_inject
        zip -q -u "../output_apks/${apk_base}_modified.apk" res/xml/*.xml
        cd ..
        rm -rf tmp_inject
        
        echo "    [成功] 专属 XML 二进制布局文件强行覆盖完成！"
    fi

    echo "✅ $apk_name 处理完成！"
done

echo "=== 🎯 所有 APK 修改编译完毕！ ==="