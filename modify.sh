#!/bin/bash
set -e

echo "=== 0. 修复提取文件夹权限 ==="
sudo chmod -R 777 system_files product_files system_ext_files 2>/dev/null || true

echo "=== 1. 动态寻找并安装 HyperOS 系统框架 ==="
FW_RES=$(find system_files product_files system_ext_files -type f -name "framework-res.apk" 2>/dev/null | head -n 1)
MIUI_FW=$(find system_files product_files system_ext_files -type f -name "miui-framework-res.apk" 2>/dev/null | head -n 1)

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
# 全局动态搜索你需要的四个 APK
MSA_APK=$(find product_files system_files system_ext_files -type f -name "MSA.apk" 2>/dev/null | head -n 1)
SEC_APK=$(find product_files system_files system_ext_files -type f -name "MIUISecurityCenter.apk" 2>/dev/null | head -n 1)
SET_APK=$(find product_files system_files system_ext_files -type f -name "Settings.apk" 2>/dev/null | head -n 1)
PLUGIN_APK=$(find product_files system_files system_ext_files -type f -name "MIUISystemUIPlugin.apk" 2>/dev/null | head -n 1)

APK_PATHS=()
[ -n "$MSA_APK" ] && APK_PATHS+=("$MSA_APK")
[ -n "$SEC_APK" ] && APK_PATHS+=("$SEC_APK")
[ -n "$SET_APK" ] && APK_PATHS+=("$SET_APK")
[ -n "$PLUGIN_APK" ] && APK_PATHS+=("$PLUGIN_APK")

if [ ${#APK_PATHS[@]} -eq 0 ]; then
    echo "错误: 未找到任何目标 APK，请检查解包步骤是否成功！"
    exit 1
fi

mkdir -p output_apks

echo "=== 3. 开始批量处理 APK ==="
for apk_path in "${APK_PATHS[@]}"; do
    apk_name=$(basename "$apk_path")
    apk_base="${apk_name%.*}"
    
    echo "----------------------------------------"
    echo "正在处理: $apk_name (来源: $apk_path)"
    echo "----------------------------------------"
    
    cp -f "$apk_path" "./$apk_name"
    
    echo ">>> 正在反编译..."
    apktool d "$apk_name" -o "${apk_base}_decoded" > /dev/null
    
    echo ">>> 注入修改代码..."
    
    # ==========================================
    # 1. MSA 去广告逻辑 (精准定位)
    # ==========================================
    if [ "$apk_base" == "MSA" ]; then
        TARGET_FILE=$(find "${apk_base}_decoded/smali"* -path "*/com/miui/f/g/e.smali" 2>/dev/null | head -n 1)
        if [ -n "$TARGET_FILE" ]; then
            sed -i 's/Ljava\/io\/File;->mkdirs()Z/Ljava\/io\/File;->createNewFile()Z/g' "$TARGET_FILE"
            echo "    [成功] MSA 阻断广告缓存代码替换完成！(精准修改 e.smali)"
        fi

    # ==========================================
    # 2. MIUISecurityCenter 电池健康度扩展逻辑
    # ==========================================
    elif [ "$apk_base" == "MIUISecurityCenter" ]; then
        XML_FILE=$(grep -rl '"reference_battery_health"' "${apk_base}_decoded/res/xml" | head -n 1)
        if [ -n "$XML_FILE" ]; then
            sed -i '/"reference_battery_health"/a \        <miuix.preference.TextPreference android:title="详细电池健康度" android:key="battery_health" />' "$XML_FILE"
            sed -i '/"reference_toady_charge_time"/a \        <miuix.preference.TextPreference android:title="循环次数" android:key="battery_cycle_value" />\n        <miuix.preference.TextPreference android:title="出厂设计容量" android:key="battery_design_capacity" />\n        <miuix.preference.TextPreference android:title="实际电池容量" android:key="battery_really_capacity" />\n        <miuix.preference.TextPreference android:title="当前电量" android:key="battery_status_now" />\n        <miuix.preference.TextPreference android:title="电池温度" android:key="battery_now_temp" />' "$XML_FILE"
            echo "    [成功] XML 电池参数菜单项对齐注入完成！"
        fi

        SMALI_FILE=$(find "${apk_base}_decoded/smali"* -name "ChargeProtectFragment.smali" | head -n 1)
        if [ -n "$SMALI_FILE" ]; then
            sed -i '/^\.super/a \.field private x:Lmiuix/preference/TextPreference;\n\.field private y:Lmiuix/preference/TextPreference;\n\.field private z:Lmiuix/preference/TextPreference;' "$SMALI_FILE"
            sed -i '/const-string.*"reference_cycle_count"/i \    invoke-static {p0}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getAllBatteryInfo(Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;)V\n' "$SMALI_FILE"
            if [ -f "BatteryMod_all.smali" ]; then
                echo "" >> "$SMALI_FILE"
                cat BatteryMod_all.smali >> "$SMALI_FILE"
                echo "    [成功] Smali 方法精准注入至 reference_cycle_count 上方！"
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
    array_pattern = r'const/4 v0, 0x3\s+const/4 v1, 0x0\s+const/4 v2, 0x1\s+(?:\.line \d+\s+)?filled-new-array \{[^\}]+\}, \[I'
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
                echo "    [警告] 未在解包目录找到原始 Legal.smali，正在创建新路径..."
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

    # ==========================================
    # 4. [新增] MIUISystemUIPlugin 手电筒控制替换
    # ==========================================
    elif [ "$apk_base" == "MIUISystemUIPlugin" ]; then
        echo "--> 替换手电筒相关 Smali 核心文件..."
        
        # 1. 替换 MiFlashlightManager.smali
        if [ -f "MiFlashlightManager.smali" ]; then
            MANAGER_SMALI=$(find "${apk_base}_decoded"/smali* -path "*/miui/systemui/flashlight/MiFlashlightManager.smali" 2>/dev/null | head -n 1)
            if [ -n "$MANAGER_SMALI" ]; then
                cp -f MiFlashlightManager.smali "$MANAGER_SMALI"
                echo "    [成功] 完美覆盖 MiFlashlightManager.smali！"
            else
                echo "    [警告] 未在解包目录找到原有 Manager，强制注入新路径..."
                mkdir -p "${apk_base}_decoded/smali/miui/systemui/flashlight/"
                cp -f MiFlashlightManager.smali "${apk_base}_decoded/smali/miui/systemui/flashlight/"
            fi
        else
            echo "    [错误] 缺失 MiFlashlightManager.smali 文件！"
            exit 1
        fi

        # 2. 替换 MiFlashlightOnSystemUiReceiver.smali
        if [ -f "MiFlashlightOnSystemUiReceiver.smali" ]; then
            RECEIVER_SMALI=$(find "${apk_base}_decoded"/smali* -path "*/miui/systemui/flashlight/MiFlashlightOnSystemUiReceiver.smali" 2>/dev/null | head -n 1)
            if [ -n "$RECEIVER_SMALI" ]; then
                cp -f MiFlashlightOnSystemUiReceiver.smali "$RECEIVER_SMALI"
                echo "    [成功] 完美覆盖 MiFlashlightOnSystemUiReceiver.smali！"
            else
                echo "    [警告] 未在解包目录找到原有 Receiver，强制注入新路径..."
                mkdir -p "${apk_base}_decoded/smali/miui/systemui/flashlight/"
                cp -f MiFlashlightOnSystemUiReceiver.smali "${apk_base}_decoded/smali/miui/systemui/flashlight/"
            fi
        else
            echo "    [错误] 缺失 MiFlashlightOnSystemUiReceiver.smali 文件！"
            exit 1
        fi
    fi
    # ==========================================

    echo ">>> 正在回编译..."
    apktool b "${apk_base}_decoded" -f -o "output_apks/${apk_base}_modified.apk" > /dev/null
    
    # 🎯 动态追踪混淆资源并强行注入二进制 XML
    if [ "$apk_base" == "Settings" ] && [ -f "ad_service_settings.xml" ]; then
        echo ">>> 正在动态追踪混淆资源并注入二进制 XML..."
        mkdir -p tmp_inject/res/xml
        
        OBFUSCATED_AD=$(grep -rl "ad_service" "${apk_base}_decoded/res/xml" | head -n 1)
        if [ -n "$OBFUSCATED_AD" ]; then
            AD_NAME=$(basename "$OBFUSCATED_AD")
            cp -f ad_service_settings.xml "tmp_inject/res/xml/$AD_NAME"
            echo "    [追踪成功] 广告服务界面被混淆为: $AD_NAME"
        fi

        OBFUSCATED_LEGAL=$(grep -rl "device_info_legal" "${apk_base}_decoded/res/xml" | head -n 1)
        if [ -n "$OBFUSCATED_LEGAL" ]; then
            LEGAL_NAME=$(basename "$OBFUSCATED_LEGAL")
            cp -f device_info_legal.xml "tmp_inject/res/xml/$LEGAL_NAME"
            echo "    [追踪成功] 法律信息界面被混淆为: $LEGAL_NAME"
        fi

        OBFUSCATED_FOLD=$(grep -rl "fold_screen" "${apk_base}_decoded/res/xml" | head -n 1)
        if [ -n "$OBFUSCATED_FOLD" ]; then
            FOLD_NAME=$(basename "$OBFUSCATED_FOLD")
            cp -f fold_screen_settings.xml "tmp_inject/res/xml/$FOLD_NAME"
            echo "    [追踪成功] 折叠屏界面被混淆为: $FOLD_NAME"
        fi
        
        cd tmp_inject
        if [ "$(ls -A res/xml/ 2>/dev/null)" ]; then
            zip -q -u "../output_apks/${apk_base}_modified.apk" res/xml/*.xml
            echo "    [完美] 专属 XML 已成功伪装并强行覆盖原混淆文件！"
        else
            echo "    [警告] 未能匹配到任何混淆文件，注入跳过！"
        fi
        cd ..
        rm -rf tmp_inject
    fi

    echo "✅ $apk_name 处理完成！"
done

echo "=== 🎯 所有 APK 修改编译完毕！ ==="
