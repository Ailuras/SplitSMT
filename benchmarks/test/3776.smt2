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

(declare-sort var2295 0)
(declare-sort var3908 0)
(declare-sort var178 0)
(declare-sort var2338 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2295!class ClassObject)
(declare-const var2338!class ClassObject)
(declare-fun var3908_currentThread/-1037784612 () var3908)
(declare-fun workerThread/315693693 (var2295) var3908)
(declare-fun var178-init () var178)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var178 String) void)
(declare-const null-var2295 var2295)
(declare-const var3758 var2295) ; Statement: r0 := @this: org.apache.dubbo.common.timer.HashedWheelTimer 
(assert (not (= var3758 null-var2295)))
(define-const var2892 var3908 var3908_currentThread/-1037784612) ; Statement: $r2 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>() 
(define-const var1143 var3908 (workerThread/315693693 var3758)) ; Statement: $r1 = r0.<org.apache.dubbo.common.timer.HashedWheelTimer: java.lang.Thread workerThread> 
 ; Statement: if $r2 != $r1 goto $r3 = <org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicIntegerFieldUpdater WORKER_STATE_UPDATER> 
(assert (not (not (= var2892 var1143)))) ; Negate: Cond: $r2 != $r1  
(define-const var149 var178 var178-init) ; Statement: $r13 = new java.lang.IllegalStateException 
(define-const var1116 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1116)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1116!1 String)
(assert (= var1116!1 ""))
(define-const var2822 ClassObject var2295!class) ; Statement: $r15 = class "Lorg/apache/dubbo/common/timer/HashedWheelTimer;" 
(assert true)
(define-const var2454 String (getSimpleName/-390194377 var2822)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var1286 String (append/672562846 var1116!1 var2454)) ; Statement: $r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var1116!2 String)
(assert (= var1116!2 (str.++ var1116!1 var2454)))
(assert true)
(define-const var1787 String (append/672562846 var1286 ".stop() cannot be called from ")) ; Statement: $r20 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".stop() cannot be called from ") 
(declare-const var1286!1 String)
(assert (= var1286!1 (str.++ var1286 ".stop() cannot be called from ")))
(define-const var1426 ClassObject var2338!class) ; Statement: $r18 = class "Lorg/apache/dubbo/common/timer/TimerTask;" 
(assert true)
(define-const var2489 String (getSimpleName/-390194377 var1426)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var2722 String (append/672562846 var1787 var2489)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var1787!1 String)
(assert (= var1787!1 (str.++ var1787 var2489)))
(assert true)
(define-const var1749 String (toString/-2075883882 var2722)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var149 var1749)) ; Statement: specialinvoke $r13.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r22) 

(declare-const var149!1 var178)
(declare-const var1749!1 String)
 ; Statement: throw $r13 
(check-sat)
; {var3908_currentThread/-1037784612=([], java.lang.Thread), workerThread/315693693=([org.apache.dubbo.common.timer.HashedWheelTimer], java.lang.Thread), var178-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getSimpleName/-390194377=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2295=org.apache.dubbo.common.timer.HashedWheelTimer, var3758=r0, var3908=java.lang.Thread, var2892=$r2, var1143=$r1, var178=java.lang.IllegalStateException, var149=$r13, var1116=$r14, var2822=$r15, var2454=$r16, var1286=$r17, var1787=$r20, var2338=org.apache.dubbo.common.timer.TimerTask, var1426=$r18, var2489=$r19, var2722=$r21, var1749=$r22}
; {org.apache.dubbo.common.timer.HashedWheelTimer=var2295, r0=var3758, java.lang.Thread=var3908, $r2=var2892, $r1=var1143, java.lang.IllegalStateException=var178, $r13=var149, $r14=var1116, $r15=var2822, $r16=var2454, $r17=var1286, $r20=var1787, org.apache.dubbo.common.timer.TimerTask=var2338, $r18=var1426, $r19=var2489, $r21=var2722, $r22=var1749}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.timer.HashedWheelTimer;	$r2 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>();	$r1 = r0.<org.apache.dubbo.common.timer.HashedWheelTimer: java.lang.Thread workerThread>;	if $r2 != $r1 goto $r3 = <org.apache.dubbo.common.timer.HashedWheelTimer: java.util.concurrent.atomic.AtomicIntegerFieldUpdater WORKER_STATE_UPDATER>;	$r13 = new java.lang.IllegalStateException;	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r15 = class "Lorg/apache/dubbo/common/timer/HashedWheelTimer;";	$r16 = virtualinvoke $r15.<java.lang.Class: java.lang.String getSimpleName()>();	$r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r20 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".stop() cannot be called from ");	$r18 = class "Lorg/apache/dubbo/common/timer/TimerTask;";	$r19 = virtualinvoke $r18.<java.lang.Class: java.lang.String getSimpleName()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r13.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r22);	throw $r13
;block_num 2