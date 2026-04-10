.class public final Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver;
.super Landroid/content/BroadcastReceiver;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver$Companion;
    }
.end annotation


# static fields
.field private static final ACTION_OPERATION:Ljava/lang/String; = "miui.systemui.action.ACTION_OPERATE_FLASHLIGHT"

.field private static final ACTION_TOAST:Ljava/lang/String; = "miui.systemui.action.ACTION_FLASHLIGHT_TOAST"

.field public static final Companion:Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver$Companion;

.field private static final KEY_CAMERA_ID:Ljava/lang/String; = "miui_flashlight_camera_id"

.field private static final KEY_IS_CAN_USE_STRENGTH_LEVEL:Ljava/lang/String; = "miui_flashlight_is_can_use_strength_level"

.field private static final KEY_STRENGTH:Ljava/lang/String; = "miui_flashlight_strength"

.field private static final KEY_TOAST_TEXT:Ljava/lang/String; = "miui_flashlight_toast_text"

.field private static final TAG:Ljava/lang/String; = "MiFlash_OperationReceiver"

.field private static final TARGET_PACKAGE_NAME:Ljava/lang/String; = "com.android.systemui"


# direct methods
.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver$Companion;-><init>(Lkotlin/jvm/internal/h;)V

    sput-object v0, Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver;->Companion:Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver$Companion;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private final doCamera(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 3

    :try_start_0
    invoke-direct {p0, p1, p2}, Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver;->operateCamera(Landroid/content/Context;Landroid/content/Intent;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_3} :catch_4

    goto :goto_c

    :catch_4
    move-exception p0

    const-string p1, "MiFlash_OperationReceiver"

    const-string p2, "operateCamera error"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_c
    return-void
.end method

.method private final doShowToast(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 3

    const-string p0, "miui_flashlight_toast_text"

    invoke-virtual {p2, p0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_10

    const/4 p2, 0x0

    invoke-static {p1, p0, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    :cond_10
    return-void
.end method

.method private final operateCamera(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 8

    const-string v0, "miui_flashlight_camera_id"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "miui_flashlight_strength"

    const/4 v2, -0x1

    invoke-virtual {p2, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    const-string v2, "miui_flashlight_is_can_use_strength_level"

    const/4 v3, 0x0

    invoke-virtual {p2, v2, v3}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p2

    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result p0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onReceive cameraId="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " strength="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v4, " isCanUseStrengthLevel="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v4, " code="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v2, "MiFlash_OperationReceiver"

    invoke-static {v2, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string p0, "camera"

    invoke-virtual {p1, p0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    instance-of p1, p0, Landroid/hardware/camera2/CameraManager;

    if-eqz p1, :cond_53

    check-cast p0, Landroid/hardware/camera2/CameraManager;

    goto :goto_54

    :cond_53
    const/4 p0, 0x0

    :goto_54
    if-nez p0, :cond_57

    return-void

    :cond_57
    if-eqz v0, :cond_74

    if-nez v1, :cond_5f

    invoke-virtual {p0, v0, v3}, Landroid/hardware/camera2/CameraManager;->setTorchMode(Ljava/lang/String;Z)V

    goto :goto_74

    :cond_5f
    const/4 p1, 0x1

    if-gt p1, v1, :cond_74

    const/16 v2, 0x65

    if-ge v1, v2, :cond_74

    if-eqz p2, :cond_68

    :cond_68
    invoke-virtual {p0, v0, p1}, Landroid/hardware/camera2/CameraManager;->setTorchMode(Ljava/lang/String;Z)V

    int-to-float v2, v1

    const v4, 0x3fa66666  # 1.3f

    mul-float/2addr v2, v4

    float-to-int v2, v2

    invoke-static {v2}, Lmiui/systemui/flashlight/MiFlashlightManager;->saveStrengthToPath(I)V

    :cond_74
    :goto_74
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 5

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "intent"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string v1, "miui.systemui.action.ACTION_OPERATE_FLASHLIGHT"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/o;->c(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1a

    invoke-direct {p0, p1, p2}, Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver;->doCamera(Landroid/content/Context;Landroid/content/Intent;)V

    goto :goto_29

    :cond_1a
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string v1, "miui.systemui.action.ACTION_FLASHLIGHT_TOAST"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/o;->c(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_29

    invoke-direct {p0, p1, p2}, Lmiui/systemui/flashlight/MiFlashlightOnSystemUiReceiver;->doShowToast(Landroid/content/Context;Landroid/content/Intent;)V

    :cond_29
    :goto_29
    return-void
.end method

.method public final register(Landroid/content/Context;)V
    .registers 13

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "MiFlash_OperationReceiver"

    const-string v1, "register"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v5, Landroid/content/IntentFilter;

    invoke-direct {v5}, Landroid/content/IntentFilter;-><init>()V

    const-string v0, "miui.systemui.action.ACTION_OPERATE_FLASHLIGHT"

    invoke-virtual {v5, v0}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v0, "android.intent.category.DEFAULT"

    invoke-virtual {v5, v0}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    sget-object v9, Lmiui/systemui/util/CompatUtils$Context;->INSTANCE:Lmiui/systemui/util/CompatUtils$Context;

    sget-object v10, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    const/4 v7, 0x0

    const/4 v8, 0x4

    const/4 v6, 0x0

    move-object v1, v9

    move-object v2, p1

    move-object v3, p0

    move-object v4, v10

    invoke-virtual/range {v1 .. v8}, Lmiui/systemui/util/CompatUtils$Context;->registerReceiverAsUserCompat(Landroid/content/Context;Landroid/content/BroadcastReceiver;Landroid/os/UserHandle;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;I)Landroid/content/Intent;

    new-instance v5, Landroid/content/IntentFilter;

    invoke-direct {v5}, Landroid/content/IntentFilter;-><init>()V

    const-string v1, "miui.systemui.action.ACTION_FLASHLIGHT_TOAST"

    invoke-virtual {v5, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    move-object v1, v9

    invoke-virtual/range {v1 .. v8}, Lmiui/systemui/util/CompatUtils$Context;->registerReceiverAsUserCompat(Landroid/content/Context;Landroid/content/BroadcastReceiver;Landroid/os/UserHandle;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;I)Landroid/content/Intent;

    return-void
.end method

.method public final unRegister(Landroid/content/Context;)V
    .registers 4

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "MiFlash_OperationReceiver"

    const-string v1, "unRegister"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1, p0}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void
.end method
