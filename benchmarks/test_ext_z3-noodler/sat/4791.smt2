(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2383 0)
(declare-sort var1835 0)
(declare-sort var1580 0)
(declare-sort var2122 0)
(declare-sort var2285 0)
(declare-sort var1808 0)
(declare-sort var2640 0)
(declare-sort var3771 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1580!class ClassObject)
(declare-fun var1835_getErrorTypeAwareLogger/453021605 (ClassObject) var2383)
(declare-fun var2122-init () var2122)
(declare-fun <init>/2133929520 (var2122) void)
(declare-fun var2285-init () var2285)
(declare-fun <init>/612893978 (var2285) void)
(declare-fun var1808_newUpdater/938330711 (ClassObject String) var1808)
(declare-fun var2640_getSystemProperty/590859155 (String String) String)
(declare-fun toLowerCase/1946809429 (String var3771) String)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const var3771-US var3771)
(define-const var3281 var2383 (var1835_getErrorTypeAwareLogger/453021605 var1580!class)) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/common/timer/HashedWheelTimer;") 
(define-const var2703 var2383 var3281) ; Statement: <org.apache.dubbo.common.timer.HashedWheelTimer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r0 
(define-const var763 var2122 var2122-init) ; Statement: $r1 = new java.util.concurrent.atomic.AtomicInteger 
(assert true)
;(assert (<init>/2133929520 var763)) ; Statement: specialinvoke $r1.<java.util.concurrent.atomic.AtomicInteger: void <init>()>() 

(declare-const var763!1 var2122)
(define-const var1382 var2122 var763!1) ; Statement: <org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicInteger INSTANCE_COUNTER> = $r1 
(define-const var2389 var2285 var2285-init) ; Statement: $r2 = new java.util.concurrent.atomic.AtomicBoolean 
(assert true)
;(assert (<init>/612893978 var2389)) ; Statement: specialinvoke $r2.<java.util.concurrent.atomic.AtomicBoolean: void <init>()>() 

(declare-const var2389!1 var2285)
(define-const var3489 var2285 var2389!1) ; Statement: <org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicBoolean WARNED_TOO_MANY_INSTANCES> = $r2 
(define-const var3268 var1808 (var1808_newUpdater/938330711 var1580!class "workerState")) ; Statement: $r3 = staticinvoke <java.util.concurrent.atomic.AtomicIntegerFieldUpdater: java.util.concurrent.atomic.AtomicIntegerFieldUpdater newUpdater(java.lang.Class,java.lang.String)>(class "Lorg/apache/dubbo/common/timer/HashedWheelTimer;", "workerState") 
(define-const var1006 var1808 var3268) ; Statement: <org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicIntegerFieldUpdater WORKER_STATE_UPDATER> = $r3 
(define-const var2598 String (var2640_getSystemProperty/590859155 "os.name" "")) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("os.name", "") 
(define-const var3158 var3771 var3771-US) ; Statement: $r4 = <java.util.Locale: java.util.Locale US> 
(assert true)
(define-const var1984 String (toLowerCase/1946809429 var2598 var3158)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r4) 
(assert true)
(define-const var25 Bool (contains/1009244746 var1984 (cast-from-String-to-String "win"))) ; Statement: $z0 = virtualinvoke $r6.<java.lang.String: boolean contains(java.lang.CharSequence)>("win") 
(define-const var68 Bool var25) ; Statement: <org.apache.dubbo.common.timer.HashedWheelTimer: boolean IS_OS_WINDOWS> = $z0 
 ; Statement: return 
(check-sat)
; {var1835_getErrorTypeAwareLogger/453021605=([java.lang.Class], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var2122-init=([], java.util.concurrent.atomic.AtomicInteger), <init>/2133929520=([java.util.concurrent.atomic.AtomicInteger], void), var2285-init=([], java.util.concurrent.atomic.AtomicBoolean), <init>/612893978=([java.util.concurrent.atomic.AtomicBoolean], void), var1808_newUpdater/938330711=([java.lang.Class, java.lang.String], java.util.concurrent.atomic.AtomicIntegerFieldUpdater), var2640_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), toLowerCase/1946809429=([java.lang.String, java.util.Locale], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2383=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1835=org.apache.dubbo.common.logger.LoggerFactory, var1580=org.apache.dubbo.common.timer.HashedWheelTimer, var3281=$r0, var2703=<org.apache.dubbo.common.timer.HashedWheelTimer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>, var2122=java.util.concurrent.atomic.AtomicInteger, var763=$r1, var1382=<org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicInteger INSTANCE_COUNTER>, var2285=java.util.concurrent.atomic.AtomicBoolean, var2389=$r2, var3489=<org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicBoolean WARNED_TOO_MANY_INSTANCES>, var1808=java.util.concurrent.atomic.AtomicIntegerFieldUpdater, var3268=$r3, var1006=<org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicIntegerFieldUpdater WORKER_STATE_UPDATER>, var2640=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2598=$r5, var3771=java.util.Locale, var3158=$r4, var1984=$r6, var25=$z0, var68=<org.apache.dubbo.common.timer.HashedWheelTimer: boolean IS_OS_WINDOWS>}
; {org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2383, org.apache.dubbo.common.logger.LoggerFactory=var1835, org.apache.dubbo.common.timer.HashedWheelTimer=var1580, $r0=var3281, <org.apache.dubbo.common.timer.HashedWheelTimer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>=var2703, java.util.concurrent.atomic.AtomicInteger=var2122, $r1=var763, <org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicInteger INSTANCE_COUNTER>=var1382, java.util.concurrent.atomic.AtomicBoolean=var2285, $r2=var2389, <org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicBoolean WARNED_TOO_MANY_INSTANCES>=var3489, java.util.concurrent.atomic.AtomicIntegerFieldUpdater=var1808, $r3=var3268, <org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicIntegerFieldUpdater WORKER_STATE_UPDATER>=var1006, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2640, $r5=var2598, java.util.Locale=var3771, $r4=var3158, $r6=var1984, $z0=var25, <org.apache.dubbo.common.timer.HashedWheelTimer: boolean IS_OS_WINDOWS>=var68}
;seq <java.lang.String: java.lang.String toLowerCase(java.util.Locale)>;	<java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>": 1,"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts $r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/common/timer/HashedWheelTimer;");	<org.apache.dubbo.common.timer.HashedWheelTimer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r0;	$r1 = new java.util.concurrent.atomic.AtomicInteger;	specialinvoke $r1.<java.util.concurrent.atomic.AtomicInteger: void <init>()>();	<org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicInteger INSTANCE_COUNTER> = $r1;	$r2 = new java.util.concurrent.atomic.AtomicBoolean;	specialinvoke $r2.<java.util.concurrent.atomic.AtomicBoolean: void <init>()>();	<org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicBoolean WARNED_TOO_MANY_INSTANCES> = $r2;	$r3 = staticinvoke <java.util.concurrent.atomic.AtomicIntegerFieldUpdater: java.util.concurrent.atomic.AtomicIntegerFieldUpdater newUpdater(java.lang.Class,java.lang.String)>(class "Lorg/apache/dubbo/common/timer/HashedWheelTimer;", "workerState");	<org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicIntegerFieldUpdater WORKER_STATE_UPDATER> = $r3;	$r5 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("os.name", "");	$r4 = <java.util.Locale: java.util.Locale US>;	$r6 = virtualinvoke $r5.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r4);	$z0 = virtualinvoke $r6.<java.lang.String: boolean contains(java.lang.CharSequence)>("win");	<org.apache.dubbo.common.timer.HashedWheelTimer: boolean IS_OS_WINDOWS> = $z0;	return
;block_num 1