#设计电池容量_full
.method public static getBatteryDesignCapacity()Ljava/lang/String;
    .registers 6
     #官方存放电池容量节点_设计容量
    const-string v0, "/sys/class/power_supply/battery/charge_full_design"
    :try_start_2
    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/FileReader;
    invoke-direct {v2, v0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v0
    const/16 v1, 0x3e8
    div-int/2addr v0, v1
    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;
    move-result-object v0
    const-string v1, "mAh"
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
    :try_end_25
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_25} :catch_25
    :catch_25
    const-string v0, "N/A"
    return-object v0
.end method



#实际
.method public static getBatteryActualCapacity()Ljava/lang/String;
    .registers 6
    #官方用来存放实际电池容量节点
    const-string v0, "/sys/class/power_supply/battery/charge_full"
    :try_start_2
    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/FileReader;
    invoke-direct {v2, v0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v0
    const/16 v1, 0x3e8
    div-int/2addr v0, v1
    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;
    move-result-object v0
    const-string v1, "mAh"
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
    :try_end_25
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_25} :catch_25
    :catch_25
    const-string v0, "N/A"
    return-object v0
.end method





#计算健康度 实际容量/设计容量
.method public static getBatteryHealthInfo()Ljava/lang/String;
    .registers 12
    .prologue
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryActualCapacity()Ljava/lang/String;
    move-result-object v0
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryDesignCapacity()Ljava/lang/String;
    move-result-object v1
    const-string v2, "mAh"
    const-string v3, ""
    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v1
    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v4
    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v5
    div-float v6, v4, v5
    const/high16 v7, 0x42c80000  # 100.0f
    mul-float v6, v6, v7
    const-string v8, "%.2f%%"
    const/4 v11, 0x1
    new-array v9, v11, [Ljava/lang/Object;
    invoke-static {v6}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;
    move-result-object v10
    const/4 v11, 0x0
    aput-object v10, v9, v11
    invoke-static {v8, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    return-object v0
    const-string v0, "N/A"
    return-object v0
.end method




#循环次数
.method public static getCycleCount()Ljava/lang/String;
    .registers 6
    #循环次数读取节点
    const-string v0, "/sys/class/power_supply/battery/cycle_count"
    :try_start_2
    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/FileReader;
    invoke-direct {v2, v0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    const-string v1, "次"
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
    :try_end_1a
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_1a} :catch_1a
    :catch_1a
    const-string v0, "N/A"
    return-object v0
.end method




#当前电池状态
.method public static getBatteryStatusNow()Ljava/lang/String;
    .registers 6
    #当前电量
    const-string v0, "/sys/class/power_supply/battery/capacity"
    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/FileReader;
    invoke-direct {v2, v0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    const-string v1, "%"
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    #当前电池所处状态（充电为charging/放电为discharging）
    const-string v1, "/sys/class/power_supply/battery/status"
    new-instance v2, Ljava/io/BufferedReader;
    new-instance v3, Ljava/io/FileReader;
    invoke-direct {v3, v1}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    invoke-direct {v2, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    const-string v2, "Discharging"
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-nez v3, :cond_3f
    const-string v2, "Charging"
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-nez v3, :cond_42
    const-string v1, "未知"
    goto :goto_44
    :cond_3f
    const-string v1, "放电中"  #翻译discharging to 放电
    goto :goto_44
    :cond_42
    const-string v1, "充电中"  #翻译charging to 充电
    :goto_44
    const-string v2, " | "  #用 < | > 隔开 得到的格式 >> 电量 | 电池充放电状态
    invoke-virtual {v0, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
    const-string v0, "未知"
    return-object v0
.end method




#当前电池温度
.method public static getBatteryNowTemperature()Ljava/lang/String;
    .registers 10
    #电池温度读取节点
    const-string v0, "/sys/class/power_supply/battery/temp"
    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/FileReader;
    invoke-direct {v2, v0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z
    move-result v7
    if-nez v7, :cond_47
    invoke-virtual {v0}, Ljava/lang/String;->length()I
    move-result v7
    const/4 v8, 0x2
    if-lt v7, v8, :cond_3a
    const/4 v5, 0x0
    const/4 v6, 0x2
    invoke-virtual {v0, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v2
    const-string v3, "%s.%s℃"
    const/4 v9, 0x2
    new-array v4, v9, [Ljava/lang/Object;
    const/4 v8, 0x0
    aput-object v1, v4, v8
    const/4 v8, 0x1
    aput-object v2, v4, v8
    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    return-object v0
    :cond_3a
    const-string v3, "%s.0℃"
    const/4 v4, 0x1
    new-array v5, v4, [Ljava/lang/Object;
    const/4 v6, 0x0
    aput-object v0, v5, v6
    invoke-static {v3, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    return-object v0
    :cond_47
    const-string v0, "N/A"
    return-object v0
.end method



#总调用 避免直接插桩在onCreatePreferences方法导致寄存器不足
.method public static getAllBatteryInfo(Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;)V
    .registers 15
    .param p0, "fragment"  # Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;
    const-string v1, "battery_cycle_value"
    invoke-virtual {p0, v1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v1
    if-eqz v1, :cond_1d
    instance-of v2, v1, Lmiuix/preference/TextPreference;
    if-eqz v2, :cond_16
    check-cast v1, Lmiuix/preference/TextPreference;
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getCycleCount()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Lmiuix/preference/TextPreference;->setText(Ljava/lang/String;)V
    goto :goto_1d
    :cond_16
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getCycleCount()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :cond_1d
    :goto_1d
    const-string v1, "battery_design_capacity"
    invoke-virtual {p0, v1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v1
    if-eqz v1, :cond_3a
    instance-of v2, v1, Lmiuix/preference/TextPreference;
    if-eqz v2, :cond_33
    check-cast v1, Lmiuix/preference/TextPreference;
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryDesignCapacity()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Lmiuix/preference/TextPreference;->setText(Ljava/lang/String;)V
    goto :goto_3a
    :cond_33
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryDesignCapacity()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :cond_3a
    :goto_3a
    const-string v1, "battery_really_capacity"
    invoke-virtual {p0, v1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v1
    if-eqz v1, :cond_57
    instance-of v2, v1, Lmiuix/preference/TextPreference;
    if-eqz v2, :cond_50
    check-cast v1, Lmiuix/preference/TextPreference;
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryActualCapacity()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Lmiuix/preference/TextPreference;->setText(Ljava/lang/String;)V
    goto :goto_57
    :cond_50
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryActualCapacity()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :cond_57
    :goto_57
    const-string v1, "battery_health"
    invoke-virtual {p0, v1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v1
    if-eqz v1, :cond_74
    instance-of v2, v1, Lmiuix/preference/TextPreference;
    if-eqz v2, :cond_6d
    check-cast v1, Lmiuix/preference/TextPreference;
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryHealthInfo()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Lmiuix/preference/TextPreference;->setText(Ljava/lang/String;)V
    goto :goto_74
    :cond_6d
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryHealthInfo()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :cond_74
    :goto_74
    const-string v1, "battery_status_now"
    invoke-virtual {p0, v1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v1
    if-eqz v1, :cond_91
    instance-of v2, v1, Lmiuix/preference/TextPreference;
    if-eqz v2, :cond_8a
    check-cast v1, Lmiuix/preference/TextPreference;
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryStatusNow()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Lmiuix/preference/TextPreference;->setText(Ljava/lang/String;)V
    goto :goto_91
    :cond_8a
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryStatusNow()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :cond_91
    :goto_91
    const-string v1, "battery_now_temp"
    invoke-virtual {p0, v1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v1
    if-eqz v1, :cond_ae
    instance-of v2, v1, Lmiuix/preference/TextPreference;
    if-eqz v2, :cond_a7
    check-cast v1, Lmiuix/preference/TextPreference;
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryNowTemperature()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Lmiuix/preference/TextPreference;->setText(Ljava/lang/String;)V
    goto :goto_ae
    :cond_a7
    invoke-static {}, Lcom/miui/powercenter/nightcharge/ChargeProtectFragment;->getBatteryNowTemperature()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :cond_ae
    :goto_ae
    return-void
.end method