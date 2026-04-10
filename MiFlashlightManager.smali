.class public final Lmiui/systemui/flashlight/MiFlashlightManager;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmiui/systemui/flashlight/MiFlashlightManager$Companion;
    }
.end annotation


# static fields
.field public static final Companion:Lmiui/systemui/flashlight/MiFlashlightManager$Companion;

.field public static final FLASH_TORCH_LOGIC_STRENGTH_MAX_LEVEL:I = 0x64

.field private static final KEYGUARD_SHORTCUT_LEFT:Ljava/lang/String; = "keyguard_shortcut_left"

.field private static final KEYGUARD_SHORTCUT_RIGHT:Ljava/lang/String; = "keyguard_shortcut_right"

.field private static final KEYGUARD_SHORTCUT_TAG:Ljava/lang/String; = "FLASHLIGHT_SET"

.field private static final SP_KEY_STRENGTH:Ljava/lang/String; = "mi_flashlight_strength"

.field private static final TAG:Ljava/lang/String; = "MiFlash_MiFlashlightManager"

.field private static final WINDOW_NAME:Ljava/lang/String; = "MiFlashlightWindow"


# instance fields
.field private final _miFlashlightEventFlow:Li1/t;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Li1/t;"
        }
    .end annotation
.end field

.field private cameraId:Ljava/lang/String;

.field private final cameraManager$delegate:LG0/d;

.field private final context:Landroid/content/Context;

.field private curStrength:I

.field private final layoutParams$delegate:LG0/d;

.field private final mainScope$delegate:LG0/d;

.field private maxStrength:I

.field private miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

.field private final miFlashlightComponentFactory:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent$Factory;

.field private final miFlashlightEventFlow:Li1/y;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Li1/y;"
        }
    .end annotation
.end field

.field private registerTorchCallbackJob:Lf1/l0;

.field private toggleJob:Lf1/l0;

.field private final windowManager$delegate:LG0/d;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Lmiui/systemui/flashlight/MiFlashlightManager$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lmiui/systemui/flashlight/MiFlashlightManager$Companion;-><init>(Lkotlin/jvm/internal/h;)V

    sput-object v0, Lmiui/systemui/flashlight/MiFlashlightManager;->Companion:Lmiui/systemui/flashlight/MiFlashlightManager$Companion;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lmiui/systemui/flashlight/dagger/MiFlashlightComponent$Factory;)V
    .registers 4

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "miFlashlightComponentFactory"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    iput-object p2, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponentFactory:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent$Factory;

    new-instance p1, Lmiui/systemui/flashlight/MiFlashlightManager$windowManager$2;

    invoke-direct {p1, p0}, Lmiui/systemui/flashlight/MiFlashlightManager$windowManager$2;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;)V

    invoke-static {p1}, LG0/e;->b(LU0/a;)LG0/d;

    move-result-object p1

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->windowManager$delegate:LG0/d;

    sget-object p1, Lmiui/systemui/flashlight/MiFlashlightManager$layoutParams$2;->INSTANCE:Lmiui/systemui/flashlight/MiFlashlightManager$layoutParams$2;

    invoke-static {p1}, LG0/e;->b(LU0/a;)LG0/d;

    move-result-object p1

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->layoutParams$delegate:LG0/d;

    sget-object p1, Lmiui/systemui/flashlight/MiFlashlightManager$mainScope$2;->INSTANCE:Lmiui/systemui/flashlight/MiFlashlightManager$mainScope$2;

    invoke-static {p1}, LG0/e;->b(LU0/a;)LG0/d;

    move-result-object p1

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->mainScope$delegate:LG0/d;

    new-instance p1, Lmiui/systemui/flashlight/MiFlashlightManager$cameraManager$2;

    invoke-direct {p1, p0}, Lmiui/systemui/flashlight/MiFlashlightManager$cameraManager$2;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;)V

    invoke-static {p1}, LG0/e;->b(LU0/a;)LG0/d;

    move-result-object p1

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->cameraManager$delegate:LG0/d;

    const/4 p1, 0x1

    iput p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->maxStrength:I

    const/4 p1, 0x0

    const/4 p2, 0x6

    const/4 v0, 0x0

    invoke-static {v0, v0, p1, p2, p1}, Li1/A;->b(IILh1/a;ILjava/lang/Object;)Li1/t;

    move-result-object p1

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->_miFlashlightEventFlow:Li1/t;

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightEventFlow:Li1/y;

    return-void
.end method

.method public static final synthetic access$getCameraId$p(Lmiui/systemui/flashlight/MiFlashlightManager;)Ljava/lang/String;
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->cameraId:Ljava/lang/String;

    return-object p0
.end method

.method public static final synthetic access$getCameraManager(Lmiui/systemui/flashlight/MiFlashlightManager;)Landroid/hardware/camera2/CameraManager;
    .registers 1

    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getCameraManager()Landroid/hardware/camera2/CameraManager;

    move-result-object p0

    return-object p0
.end method

.method public static final synthetic access$getContext$p(Lmiui/systemui/flashlight/MiFlashlightManager;)Landroid/content/Context;
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    return-object p0
.end method

.method public static final synthetic access$getCurStrength$p(Lmiui/systemui/flashlight/MiFlashlightManager;)I
    .registers 1

    iget p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->curStrength:I

    return p0
.end method

.method public static final synthetic access$getMaxStrength$p(Lmiui/systemui/flashlight/MiFlashlightManager;)I
    .registers 1

    iget p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->maxStrength:I

    return p0
.end method

.method public static final synthetic access$getRegisterTorchCallbackJob$p(Lmiui/systemui/flashlight/MiFlashlightManager;)Lf1/l0;
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->registerTorchCallbackJob:Lf1/l0;

    return-object p0
.end method

.method public static final synthetic access$get_miFlashlightEventFlow$p(Lmiui/systemui/flashlight/MiFlashlightManager;)Li1/t;
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->_miFlashlightEventFlow:Li1/t;

    return-object p0
.end method

.method public static final synthetic access$setCameraId$p(Lmiui/systemui/flashlight/MiFlashlightManager;Ljava/lang/String;)V
    .registers 2

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->cameraId:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic access$setCurStrength$p(Lmiui/systemui/flashlight/MiFlashlightManager;I)V
    .registers 2

    const/16 p1, 0x64

    iput p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->curStrength:I

    return-void
.end method

.method public static final synthetic access$setMaxStrength$p(Lmiui/systemui/flashlight/MiFlashlightManager;I)V
    .registers 2

    const/16 p1, 0x64

    iput p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->maxStrength:I

    return-void
.end method

.method public static synthetic asyncOperate$default(Lmiui/systemui/flashlight/MiFlashlightManager;ZLU0/a;ILjava/lang/Object;)V
    .registers 5

    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_5

    const/4 p2, 0x0

    :cond_5
    invoke-virtual {p0, p1, p2}, Lmiui/systemui/flashlight/MiFlashlightManager;->asyncOperate(ZLU0/a;)V

    return-void
.end method

.method public static synthetic asyncReduceBy25$default(Lmiui/systemui/flashlight/MiFlashlightManager;LU0/a;ILjava/lang/Object;)Lf1/l0;
    .registers 4

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_5

    const/4 p1, 0x0

    :cond_5
    invoke-virtual {p0, p1}, Lmiui/systemui/flashlight/MiFlashlightManager;->asyncReduceBy25(LU0/a;)Lf1/l0;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic asyncToggleFlashLight$default(Lmiui/systemui/flashlight/MiFlashlightManager;FLU0/a;ILjava/lang/Object;)V
    .registers 5

    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_5

    const/4 p2, 0x0

    :cond_5
    invoke-virtual {p0, p1, p2}, Lmiui/systemui/flashlight/MiFlashlightManager;->asyncToggleFlashLight(FLU0/a;)V

    return-void
.end method

.method public static synthetic dismiss$default(Lmiui/systemui/flashlight/MiFlashlightManager;IILjava/lang/Object;)V
    .registers 4

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_5

    const/4 p1, -0x1

    :cond_5
    invoke-virtual {p0, p1}, Lmiui/systemui/flashlight/MiFlashlightManager;->dismiss(I)V

    return-void
.end method

.method private final getCameraManager()Landroid/hardware/camera2/CameraManager;
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->cameraManager$delegate:LG0/d;

    invoke-interface {p0}, LG0/d;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/hardware/camera2/CameraManager;

    return-object p0
.end method

.method private final getLayoutParams()Landroid/view/WindowManager$LayoutParams;
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->layoutParams$delegate:LG0/d;

    invoke-interface {p0}, LG0/d;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/view/WindowManager$LayoutParams;

    return-object p0
.end method

.method private final getMainScope()Lf1/E;
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->mainScope$delegate:LG0/d;

    invoke-interface {p0}, LG0/d;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lf1/E;

    return-object p0
.end method

.method public static synthetic getMiFlashlightLayout$default(Lmiui/systemui/flashlight/MiFlashlightManager;Landroid/content/Context;ZILjava/lang/Object;)Lmiui/systemui/flashlight/view/MiFlashlightLayout;
    .registers 5

    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_5

    const/4 p2, 0x1

    :cond_5
    invoke-virtual {p0, p1, p2}, Lmiui/systemui/flashlight/MiFlashlightManager;->getMiFlashlightLayout(Landroid/content/Context;Z)Lmiui/systemui/flashlight/view/MiFlashlightLayout;

    move-result-object p0

    return-object p0
.end method

.method private final getWindowManager()Landroid/view/WindowManager;
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->windowManager$delegate:LG0/d;

    invoke-interface {p0}, LG0/d;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/view/WindowManager;

    return-object p0
.end method

.method private final isNoExitAnim()Z
    .registers 5

    iget-object v0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "keyguard_shortcut_left"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "keyguard_shortcut_right"

    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "keyguard_shortcut_left = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " \nkeyguard_shortcut_right = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "MiFlash_MiFlashlightManager"

    invoke-static {v3, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    const-string v2, "keyguard"

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    const-string v2, "null cannot be cast to non-null type android.app.KeyguardManager"

    invoke-static {p0, v2}, Lkotlin/jvm/internal/o;->e(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast p0, Landroid/app/KeyguardManager;

    invoke-virtual {p0}, Landroid/app/KeyguardManager;->isKeyguardLocked()Z

    move-result p0

    const/4 v2, 0x0

    if-eqz p0, :cond_6b

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const/4 v0, 0x2

    const/4 v1, 0x0

    const-string v3, "FLASHLIGHT_SET"

    invoke-static {p0, v3, v2, v0, v1}, Le1/o;->v(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_6b

    const/4 v2, 0x1

    :cond_6b
    return v2
.end method

.method public static saveStrengthToPath(I)V
    .registers 5

    const/16 v0, 0x82

    const/16 v1, 0xd

    move v2, v0

    if-lez p0, :cond_a

    if-gt p0, v1, :cond_a

    move p0, v1

    :cond_a
    if-le p0, v2, :cond_d

    move p0, v2

    :cond_d
    :try_start_d
    new-instance v0, Ljava/io/FileWriter;

    const-string v1, "/sys/class/leds/led:torch_0/brightness"

    invoke-direct {v0, v1}, Ljava/io/FileWriter;-><init>(Ljava/lang/String;)V

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/FileWriter;->flush()V

    invoke-virtual {v0}, Ljava/io/FileWriter;->close()V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Wrote strength "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " to flashlight"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MiFlash_MiFlashlightManager"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3c
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_3c} :catch_3d

    goto :goto_45

    :catch_3d
    move-exception v0

    const-string v1, "MiFlash_MiFlashlightManager"

    const-string v2, "Failed to write to brightness nodes"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_45
    return-void
.end method

.method public static synthetic showFlashlight$default(Lmiui/systemui/flashlight/MiFlashlightManager;ZLandroid/widget/FrameLayout;ZILjava/lang/Object;)V
    .registers 6

    and-int/lit8 p5, p4, 0x1

    if-eqz p5, :cond_5

    const/4 p1, 0x0

    :cond_5
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_a

    const/4 p2, 0x0

    :cond_a
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_f

    const/4 p3, 0x1

    :cond_f
    invoke-virtual {p0, p1, p2, p3}, Lmiui/systemui/flashlight/MiFlashlightManager;->showFlashlight(ZLandroid/widget/FrameLayout;Z)V

    return-void
.end method


# virtual methods
.method public final asyncOperate(ZLU0/a;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "LU0/a;",
            ")V"
        }
    .end annotation

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "asyncOperate: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MiFlash_MiFlashlightManager"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p1, :cond_1d

    invoke-virtual {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getLogicStrength()F

    move-result p1

    goto :goto_1e

    :cond_1d
    const/4 p1, 0x0

    :goto_1e
    invoke-virtual {p0, p1, p2}, Lmiui/systemui/flashlight/MiFlashlightManager;->asyncToggleFlashLight(FLU0/a;)V

    return-void
.end method

.method public final asyncReduceBy25(LU0/a;)Lf1/l0;
    .registers 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "LU0/a;",
            ")",
            "Lf1/l0;"
        }
    .end annotation

    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getMainScope()Lf1/E;

    move-result-object v0

    new-instance v3, Lmiui/systemui/flashlight/MiFlashlightManager$asyncReduceBy25$1;

    const/4 v1, 0x0

    invoke-direct {v3, p0, p1, v1}, Lmiui/systemui/flashlight/MiFlashlightManager$asyncReduceBy25$1;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;LU0/a;LK0/d;)V

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v2, 0x0

    invoke-static/range {v0 .. v5}, Lf1/f;->b(Lf1/E;LK0/g;Lf1/G;LU0/o;ILjava/lang/Object;)Lf1/l0;

    move-result-object p0

    return-object p0
.end method

.method public final asyncToggleFlashLight(FLU0/a;)V
    .registers 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(F",
            "LU0/a;",
            ")V"
        }
    .end annotation

    iget v0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->maxStrength:I

    int-to-float v0, v0

    mul-float/2addr v0, p1

    float-to-int v5, v0

    iget p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->curStrength:I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "toggleFlashLight Torch strength target "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " mCurStrength="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "MiFlash_MiFlashlightManager"

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->toggleJob:Lf1/l0;

    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getMainScope()Lf1/E;

    move-result-object p1

    new-instance v9, Lmiui/systemui/flashlight/MiFlashlightManager$asyncToggleFlashLight$1;

    const/4 v6, 0x0

    move-object v1, v9

    move-object v3, p0

    move-object v4, p2

    invoke-direct/range {v1 .. v6}, Lmiui/systemui/flashlight/MiFlashlightManager$asyncToggleFlashLight$1;-><init>(Lf1/l0;Lmiui/systemui/flashlight/MiFlashlightManager;LU0/a;ILK0/d;)V

    const/4 v10, 0x3

    const/4 v11, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v6, p1

    invoke-static/range {v6 .. v11}, Lf1/f;->b(Lf1/E;LK0/g;Lf1/G;LU0/o;ILjava/lang/Object;)Lf1/l0;

    move-result-object p1

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->toggleJob:Lf1/l0;

    return-void
.end method

.method public final dismiss()V
    .registers 4

    .line 1
    const/4 v0, 0x1

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {p0, v2, v0, v1}, Lmiui/systemui/flashlight/MiFlashlightManager;->dismiss$default(Lmiui/systemui/flashlight/MiFlashlightManager;IILjava/lang/Object;)V

    return-void
.end method

.method public final dismiss(I)V
    .registers 10

    .line 2
    iget-object v0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    const/4 v1, 0x0

    if-eqz v0, :cond_14

    invoke-interface {v0}, Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;->getRootView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_14

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_15

    :cond_14
    move-object v0, v1

    :goto_15
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dismiss miFlashlightLayoutHashCode: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, " current: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "MiFlash_MiFlashlightManager"

    invoke-static {v2, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 3
    iget-object v0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    if-eqz v0, :cond_84

    const/4 v2, -0x1

    if-eq p1, v2, :cond_45

    .line 4
    invoke-interface {v0}, Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;->getRootView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    if-eq p1, v2, :cond_45

    goto :goto_84

    .line 5
    :cond_45
    invoke-interface {v0}, Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;->getRootView()Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    instance-of p1, p1, Landroid/view/ViewRootImpl;

    if-eqz p1, :cond_5d

    .line 6
    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getWindowManager()Landroid/view/WindowManager;

    move-result-object p1

    invoke-interface {v0}, Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;->getRootView()Landroid/view/View;

    move-result-object v2

    invoke-interface {p1, v2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    goto :goto_72

    .line 7
    :cond_5d
    invoke-interface {v0}, Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;->getRootView()Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    instance-of v2, p1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_6c

    check-cast p1, Landroid/view/ViewGroup;

    goto :goto_6d

    :cond_6c
    move-object p1, v1

    :goto_6d
    if-eqz p1, :cond_72

    invoke-virtual {p1}, Landroid/view/ViewGroup;->removeAllViews()V

    .line 8
    :cond_72
    :goto_72
    iput-object v1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    .line 9
    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getMainScope()Lf1/E;

    move-result-object v2

    new-instance v5, Lmiui/systemui/flashlight/MiFlashlightManager$dismiss$1$1;

    invoke-direct {v5, p0, v0, v1}, Lmiui/systemui/flashlight/MiFlashlightManager$dismiss$1$1;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;LK0/d;)V

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lf1/f;->b(Lf1/E;LK0/g;Lf1/G;LU0/o;ILjava/lang/Object;)Lf1/l0;

    :cond_84
    :goto_84
    return-void
.end method

.method public final getCameraId(LK0/d;)Ljava/lang/Object;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "LK0/d;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    sget-object v0, Lmiui/systemui/coroutines/Dispatchers;->INSTANCE:Lmiui/systemui/coroutines/Dispatchers;

    invoke-virtual {v0}, Lmiui/systemui/coroutines/Dispatchers;->getIO()Lf1/b0;

    move-result-object v0

    new-instance v1, Lmiui/systemui/flashlight/MiFlashlightManager$getCameraId$2;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lmiui/systemui/flashlight/MiFlashlightManager$getCameraId$2;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;LK0/d;)V

    invoke-static {v0, v1, p1}, Lf1/f;->c(LK0/g;LU0/o;LK0/d;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public final getLogicStrength()F
    .registers 4

    iget-object v0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mi_flashlight_strength"

    const/high16 v2, 0x3f800000  # 1.0f

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Global;->getFloat(Landroid/content/ContentResolver;Ljava/lang/String;F)F

    move-result v0

    iget p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->maxStrength:I

    int-to-float v1, p0

    div-float v1, v2, v1

    cmpg-float v1, v0, v1

    if-gez v1, :cond_1a

    int-to-float p0, p0

    div-float/2addr v2, p0

    goto :goto_20

    :cond_1a
    cmpl-float p0, v0, v2

    if-lez p0, :cond_1f

    goto :goto_20

    :cond_1f
    move v2, v0

    :goto_20
    return v2
.end method

.method public final getMiFlashlightEventFlow()Li1/y;
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Li1/y;"
        }
    .end annotation

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightEventFlow:Li1/y;

    return-object p0
.end method

.method public final getMiFlashlightLayout(Landroid/content/Context;Z)Lmiui/systemui/flashlight/view/MiFlashlightLayout;
    .registers 6
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InflateParams"
        }
    .end annotation

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    const/4 v1, 0x0

    if-eqz v0, :cond_f

    const/4 v0, 0x0

    const/4 v2, 0x1

    invoke-static {p0, v0, v2, v1}, Lmiui/systemui/flashlight/MiFlashlightManager;->dismiss$default(Lmiui/systemui/flashlight/MiFlashlightManager;IILjava/lang/Object;)V

    :cond_f
    new-instance v0, Lmiui/systemui/flashlight/view/MiFlashlightLayout;

    const/4 v2, 0x2

    invoke-direct {v0, p1, v1, v2, v1}, Lmiui/systemui/flashlight/view/MiFlashlightLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;ILkotlin/jvm/internal/h;)V

    invoke-virtual {v0, p2}, Lmiui/systemui/flashlight/view/MiFlashlightLayout;->setNeedAnim(Z)V

    iget-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponentFactory:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent$Factory;

    invoke-interface {p1, v0}, Lmiui/systemui/flashlight/dagger/MiFlashlightComponent$Factory;->create(Lmiui/systemui/flashlight/view/MiFlashlightLayout;)Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    move-result-object p1

    invoke-interface {p1}, Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;->createController()Lmiui/systemui/flashlight/MiFlashlightController;

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    return-object v0
.end method

.method public final hideFlashlight()Ljava/lang/Object;
    .registers 7

    iget-object v0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    const/4 v1, 0x0

    if-eqz v0, :cond_30

    invoke-interface {v0}, Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;->getRootView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_30

    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->isNoExitAnim()Z

    move-result v2

    if-eqz v2, :cond_1c

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    invoke-virtual {p0, v0}, Lmiui/systemui/flashlight/MiFlashlightManager;->dismiss(I)V

    sget-object p0, LG0/s;->a:LG0/s;

    :goto_1a
    move-object v1, p0

    goto :goto_30

    :cond_1c
    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getMainScope()Lf1/E;

    move-result-object v2

    new-instance v3, Lmiui/systemui/flashlight/MiFlashlightManager$hideFlashlight$1$1;

    invoke-direct {v3, p0, v0, v1}, Lmiui/systemui/flashlight/MiFlashlightManager$hideFlashlight$1$1;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;Landroid/view/View;LK0/d;)V

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 p0, 0x0

    move-object v0, v2

    move-object v2, p0

    invoke-static/range {v0 .. v5}, Lf1/f;->b(Lf1/E;LK0/g;Lf1/G;LU0/o;ILjava/lang/Object;)Lf1/l0;

    move-result-object p0

    goto :goto_1a

    :cond_30
    :goto_30
    return-object v1
.end method

.method public final isHasFlashlightWindow()Z
    .registers 1

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    if-eqz p0, :cond_6

    const/4 p0, 0x1

    goto :goto_7

    :cond_6
    const/4 p0, 0x0

    :goto_7
    return p0
.end method

.method public final isSupportStrengthLevel(LK0/d;)Ljava/lang/Object;
    .registers 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "LK0/d;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p1, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;

    if-eqz v0, :cond_13

    move-object v0, p1

    check-cast v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;

    iget v1, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->label:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_13

    sub-int/2addr v1, v2

    iput v1, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->label:I

    goto :goto_18

    :cond_13
    new-instance v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;

    invoke-direct {v0, p0, p1}, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;LK0/d;)V

    :goto_18
    iget-object p1, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->result:Ljava/lang/Object;

    invoke-static {}, LL0/c;->c()Ljava/lang/Object;

    move-result-object v1

    iget v2, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->label:I

    const/4 v3, 0x1

    if-eqz v2, :cond_39

    if-ne v2, v3, :cond_31

    iget-object p0, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->L$1:Ljava/lang/Object;

    check-cast p0, Lmiui/systemui/flashlight/MiFlashlightManager;

    iget-object v0, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lmiui/systemui/flashlight/MiFlashlightManager;

    invoke-static {p1}, LG0/k;->b(Ljava/lang/Object;)V

    goto :goto_4a

    :cond_31
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_39
    invoke-static {p1}, LG0/k;->b(Ljava/lang/Object;)V

    iput-object p0, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->L$0:Ljava/lang/Object;

    iput-object p0, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->L$1:Ljava/lang/Object;

    iput v3, v0, Lmiui/systemui/flashlight/MiFlashlightManager$isSupportStrengthLevel$1;->label:I

    invoke-virtual {p0, v0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getCameraId(LK0/d;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v1, :cond_49

    return-object v1

    :cond_49
    move-object v0, p0

    :goto_4a
    check-cast p1, Ljava/lang/String;

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->cameraId:Ljava/lang/String;

    iget p0, v0, Lmiui/systemui/flashlight/MiFlashlightManager;->maxStrength:I

    const/16 p1, 0x64

    if-lt p0, p1, :cond_55

    goto :goto_56

    :cond_55
    const/4 v3, 0x0

    :goto_56
    invoke-static {v3}, LM0/b;->a(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0
.end method

.method public final onLowPowerControl(II)V
    .registers 4

    sget-object v0, Lmiui/systemui/flashlight/utils/FlashlightUtils;->INSTANCE:Lmiui/systemui/flashlight/utils/FlashlightUtils;

    invoke-virtual {v0, p1, p2}, Lmiui/systemui/flashlight/utils/FlashlightUtils;->shouldHandleLowPower(II)Z

    move-result p1

    if-eqz p1, :cond_b

    invoke-virtual {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->hideFlashlight()Ljava/lang/Object;

    :cond_b
    return-void
.end method

.method public operateBright()V
    .registers 7

    invoke-virtual {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getLogicStrength()F

    move-result v0

    const/16 v1, 0x82

    int-to-float v1, v1

    mul-float/2addr v1, v0

    float-to-int v0, v1

    invoke-static {v0}, Lmiui/systemui/flashlight/MiFlashlightManager;->saveStrengthToPath(I)V

    return-void
.end method

.method public final registerTorchCallback(Landroid/hardware/camera2/CameraManager$TorchCallback;Landroid/os/Handler;)V
    .registers 10

    const-string v0, "callback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "handler"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getMainScope()Lf1/E;

    move-result-object v1

    new-instance v4, Lmiui/systemui/flashlight/MiFlashlightManager$registerTorchCallback$1;

    const/4 v0, 0x0

    invoke-direct {v4, p0, p1, p2, v0}, Lmiui/systemui/flashlight/MiFlashlightManager$registerTorchCallback$1;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;Landroid/hardware/camera2/CameraManager$TorchCallback;Landroid/os/Handler;LK0/d;)V

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lf1/f;->b(Lf1/E;LK0/g;Lf1/G;LU0/o;ILjava/lang/Object;)Lf1/l0;

    move-result-object p1

    iput-object p1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->registerTorchCallbackJob:Lf1/l0;

    return-void
.end method

.method public final resetStatus()V
    .registers 5

    sget-object v0, Lmiui/systemui/flashlight/utils/FlashlightUtils;->INSTANCE:Lmiui/systemui/flashlight/utils/FlashlightUtils;

    iget-object v1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Lmiui/systemui/flashlight/utils/FlashlightUtils;->saveTempHighCloseTorch(ILandroid/content/Context;)V

    iget-object v1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    invoke-virtual {v0, v2, v1}, Lmiui/systemui/flashlight/utils/FlashlightUtils;->saveLowPowerCloseTorch(ZLandroid/content/Context;)V

    const/4 v1, 0x1

    iget-object v3, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    invoke-virtual {v0, v1, v3}, Lmiui/systemui/flashlight/utils/FlashlightUtils;->saveFlashlightAvailable(ZLandroid/content/Context;)V

    sget-object v0, Lmiui/systemui/flashlight/ToggleChangeReceiver;->Companion:Lmiui/systemui/flashlight/ToggleChangeReceiver$Companion;

    iget-object v1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    invoke-virtual {v0, v1, v2}, Lmiui/systemui/flashlight/ToggleChangeReceiver$Companion;->saveTorchStatus(Landroid/content/Context;Z)V

    sget-object v0, Lmiui/systemui/flashlight/NotificationManager;->INSTANCE:Lmiui/systemui/flashlight/NotificationManager;

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    invoke-virtual {v0, p0}, Lmiui/systemui/flashlight/NotificationManager;->closeNotification(Landroid/content/Context;)V

    return-void
.end method

.method public final saveLogicStrength(F)V
    .registers 3

    iget-object p0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v0, "mi_flashlight_strength"

    invoke-static {p0, v0, p1}, Landroid/provider/Settings$Global;->putFloat(Landroid/content/ContentResolver;Ljava/lang/String;F)Z

    return-void
.end method

.method public final showFlashlight()V
    .registers 7
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InflateParams"
        }
    .end annotation

    .line 1
    const/4 v4, 0x7

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lmiui/systemui/flashlight/MiFlashlightManager;->showFlashlight$default(Lmiui/systemui/flashlight/MiFlashlightManager;ZLandroid/widget/FrameLayout;ZILjava/lang/Object;)V

    return-void
.end method

.method public final showFlashlight(Z)V
    .registers 8
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InflateParams"
        }
    .end annotation

    .line 2
    const/4 v4, 0x6

    const/4 v5, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move v1, p1

    invoke-static/range {v0 .. v5}, Lmiui/systemui/flashlight/MiFlashlightManager;->showFlashlight$default(Lmiui/systemui/flashlight/MiFlashlightManager;ZLandroid/widget/FrameLayout;ZILjava/lang/Object;)V

    return-void
.end method

.method public final showFlashlight(ZLandroid/widget/FrameLayout;)V
    .registers 9
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InflateParams"
        }
    .end annotation

    .line 3
    const/4 v4, 0x4

    const/4 v5, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move v1, p1

    move-object v2, p2

    invoke-static/range {v0 .. v5}, Lmiui/systemui/flashlight/MiFlashlightManager;->showFlashlight$default(Lmiui/systemui/flashlight/MiFlashlightManager;ZLandroid/widget/FrameLayout;ZILjava/lang/Object;)V

    return-void
.end method

.method public final showFlashlight(ZLandroid/widget/FrameLayout;Z)V
    .registers 6
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InflateParams"
        }
    .end annotation

    .line 4
    iget-object v0, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->miFlashlightComponent:Lmiui/systemui/flashlight/dagger/MiFlashlightComponent;

    if-eqz v0, :cond_7

    if-nez p1, :cond_7

    return-void

    :cond_7
    const/4 p1, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 5
    invoke-static {p0, p1, v0, v1}, Lmiui/systemui/flashlight/MiFlashlightManager;->dismiss$default(Lmiui/systemui/flashlight/MiFlashlightManager;IILjava/lang/Object;)V

    if-eqz p2, :cond_13

    .line 6
    invoke-virtual {p2}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    :cond_13
    if-nez v1, :cond_17

    iget-object v1, p0, Lmiui/systemui/flashlight/MiFlashlightManager;->context:Landroid/content/Context;

    :cond_17
    invoke-virtual {p0, v1, p3}, Lmiui/systemui/flashlight/MiFlashlightManager;->getMiFlashlightLayout(Landroid/content/Context;Z)Lmiui/systemui/flashlight/view/MiFlashlightLayout;

    move-result-object p1

    if-eqz p2, :cond_21

    .line 7
    invoke-virtual {p2, p1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    goto :goto_37

    .line 8
    :cond_21
    :try_start_21
    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getWindowManager()Landroid/view/WindowManager;

    move-result-object p2

    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getLayoutParams()Landroid/view/WindowManager$LayoutParams;

    move-result-object p0

    invoke-interface {p2, p1, p0}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    sget-object p0, LG0/s;->a:LG0/s;
    :try_end_2e
    .catch Ljava/lang/Exception; {:try_start_21 .. :try_end_2e} :catch_2f

    goto :goto_37

    :catch_2f
    move-exception p0

    .line 9
    const-string p1, "MiFlash_MiFlashlightManager"

    const-string p2, "add failed."

    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_37
    return-void
.end method

.method public final unregisterTorchCallback(Landroid/hardware/camera2/CameraManager$TorchCallback;)V
    .registers 9

    const-string v0, "callback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/o;->g(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0}, Lmiui/systemui/flashlight/MiFlashlightManager;->getMainScope()Lf1/E;

    move-result-object v1

    new-instance v4, Lmiui/systemui/flashlight/MiFlashlightManager$unregisterTorchCallback$1;

    const/4 v0, 0x0

    invoke-direct {v4, p0, p1, v0}, Lmiui/systemui/flashlight/MiFlashlightManager$unregisterTorchCallback$1;-><init>(Lmiui/systemui/flashlight/MiFlashlightManager;Landroid/hardware/camera2/CameraManager$TorchCallback;LK0/d;)V

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lf1/f;->b(Lf1/E;LK0/g;Lf1/G;LU0/o;ILjava/lang/Object;)Lf1/l0;

    return-void
.end method
