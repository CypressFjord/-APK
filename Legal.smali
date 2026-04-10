# classes3.dex

.class public Lcom/android/settings/Legal;
.super Lcom/android/settings/dashboard/DashboardFragment;
.source "Legal.smali"


# static fields
.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    const-class v0, Lcom/android/settings/Legal;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/settings/Legal;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/dashboard/DashboardFragment;-><init>()V

    return-void
.end method

.method private getProp(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    invoke-static {p1, p2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method protected getLogTag()Ljava/lang/String;
    .registers 1

    sget-object p0, Lcom/android/settings/Legal;->TAG:Ljava/lang/String;

    return-object p0
.end method

.method public getName()Ljava/lang/String;
    .registers 1

    const-class p0, Lcom/android/settings/Legal;

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method protected getPreferenceScreenResId()I
    .registers 1

    sget p0, Lcom/android/settings/R$xml;->device_info_legal:I

    return p0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .registers 10
    .param p1, "savedInstanceState"  # Landroid/os/Bundle;

    .prologue
    invoke-super {p0, p1}, Lcom/android/settings/dashboard/DashboardFragment;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Landroidx/preference/PreferenceFragmentCompat;->getPreferenceScreen()Landroidx/preference/PreferenceScreen;

    move-result-object v0

    if-eqz v0, :cond_a6

    const-string/jumbo v1, "page_main_title"

    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v2

    if-nez v2, :cond_13

    goto :goto_24

    :cond_13
    const-string/jumbo v3, "ro.product.odm.marketname"

    const-string/jumbo v4, "系统信息"

    invoke-direct {p0, v3, v4}, Lcom/android/settings/Legal;->getProp(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setSelectable(Z)V

    :goto_24
    const-string/jumbo v1, "vndk_prop"

    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v2

    if-nez v2, :cond_2e

    goto :goto_3f

    :cond_2e
    const-string/jumbo v3, "ro.vendor.build.version.sdk"

    const-string/jumbo v4, "未被正确读取"

    invoke-direct {p0, v3, v4}, Lcom/android/settings/Legal;->getProp(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setSelectable(Z)V

    :goto_3f
    const-string v1, "device_code"

    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v2

    if-nez v2, :cond_48

    goto :goto_59

    :cond_48
    const-string/jumbo v3, "ro.product.odm.name"

    const-string/jumbo v4, "未被正确读取"

    invoke-direct {p0, v3, v4}, Lcom/android/settings/Legal;->getProp(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setSelectable(Z)V

    :goto_59
    const-string v1, "android_version"

    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v2

    if-nez v2, :cond_62

    goto :goto_73

    :cond_62
    const-string/jumbo v3, "ro.build.version.release"

    const-string/jumbo v4, "未被正确读取"

    invoke-direct {p0, v3, v4}, Lcom/android/settings/Legal;->getProp(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setSelectable(Z)V

    :goto_73
    const-string/jumbo v1, "miui_version"

    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v2

    if-eqz v2, :cond_a6

    const-string/jumbo v3, "ro.mi.os.version.incremental"

    const-string/jumbo v4, "未被正确读取"

    invoke-direct {p0, v3, v4}, Lcom/android/settings/Legal;->getProp(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setSelectable(Z)V

    const-string v1, "developer_version"

    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v2

    if-eqz v2, :cond_a6

    const-string/jumbo v3, "ro.xiaomi.rom.developer"

    const-string/jumbo v4, "未被正确读取"

    invoke-direct {p0, v3, v4}, Lcom/android/settings/Legal;->getProp(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setSelectable(Z)V
    
    const-string v1, "build_date"

    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v2

    if-eqz v2, :cond_a6

    const-string/jumbo v3, "ro.xiaomi.rom.builddate"

    const-string/jumbo v4, "未被正确读取"

    invoke-direct {p0, v3, v4}, Lcom/android/settings/Legal;->getProp(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroidx/preference/Preference;->setSelectable(Z)V

    :cond_a6
    return-void
.end method

.method public onStart()V
    .registers 3

    .prologue
    invoke-super {p0}, Lcom/android/settings/dashboard/DashboardFragment;->onStart()V

    invoke-virtual {p0}, Lcom/android/settingslib/preference/PreferenceFragment;->getAppCompatActionBar()Lmiuix/appcompat/app/ActionBar;

    move-result-object v0

    if-eqz v0, :cond_e

    sget v1, Lcom/android/settings/R$string;->legal_information:I

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/ActionBar;->setTitle(I)V

    :cond_e
    return-void
.end method
