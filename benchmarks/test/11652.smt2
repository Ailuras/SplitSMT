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

(declare-sort var3795 0)
(declare-sort var2797 0)
(declare-sort var2157 0)
(declare-sort var2088 0)
(declare-sort var873 0)
(declare-sort var3612 0)
(declare-sort var1018 0)
(declare-sort var898 0)
(declare-sort var2640 0)
(declare-sort var558 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var2797_getInterface/-1171900879 (var2797) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2088_getMethodName/-516674313 (var2157) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun concurrents/1148026009 (var3795) var873)
(declare-fun var1018_bootstrap$/482365356 () var3612)
(declare-fun var2640_computeIfAbsent/-1297680746 (var873 var898 var3612) var898)
(declare-fun cast-from-String-to-var898 (String) var898)
(declare-fun cast-from-var898-to-var558 (var898) var558)
(declare-const null-var3795 var3795)
(declare-const null-var2797 var2797)
(declare-const null-var2157 var2157)
(declare-const var865 var3795) ; Statement: r10 := @this: org.apache.dubbo.monitor.support.MonitorFilter 
(assert (not (= var865 null-var3795)))
(declare-const var1925 var2797) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1925 null-var2797)))
(declare-const var3885 var2157) ; Statement: r5 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3885 null-var2157)))
(define-const var1249 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1249)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1249!1 String)
(assert (= var1249!1 ""))
(define-const var347 ClassObject (var2797_getInterface/-1171900879 var1925)) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var820 String (getName/-1958580599 var347)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var611 String (append/672562846 var1249!1 var820)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1249!2 String)
(assert (= var1249!2 (str.++ var1249!1 var820)))
(assert true)
(define-const var2693 String (append/672562846 var611 ".")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var611!1 String)
(assert (= var611!1 (str.++ var611 ".")))
(define-const var1803 String (var2088_getMethodName/-516674313 var3885)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r5) 
(assert true)
(define-const var3883 String (append/672562846 var2693 var1803)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2693!1 String)
(assert (= var2693!1 (str.++ var2693 var1803)))
(assert true)
(define-const var2555 String (toString/-2075883882 var3883)) ; Statement: r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var489 var873 (concurrents/1148026009 var865)) ; Statement: $r11 = r10.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.ConcurrentMap concurrents> 
(define-const var393 var3612 var1018_bootstrap$/482365356) ; Statement: $r12 = staticinvoke <org.apache.dubbo.monitor.support.MonitorFilter$lambda_getConcurrent_0__778: java.util.function.Function bootstrap$()>() 
(define-const var3897 var898 (var2640_computeIfAbsent/-1297680746 var489 (cast-from-String-to-var898 var2555) var393)) ; Statement: $r13 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r11, r9, $r12) 
(define-const var1303 var558 (cast-from-var898-to-var558 var3897)) ; Statement: $r14 = (java.util.concurrent.atomic.AtomicInteger) $r13 
 ; Statement: return $r14 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var2797_getInterface/-1171900879=([org.apache.dubbo.rpc.Invoker], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2088_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), concurrents/1148026009=([org.apache.dubbo.monitor.support.MonitorFilter], java.util.concurrent.ConcurrentMap), var1018_bootstrap$/482365356=([], java.util.function.Function), var2640_computeIfAbsent/-1297680746=([java.util.concurrent.ConcurrentMap, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var898=([java.lang.String], java.lang.Object), cast-from-var898-to-var558=([java.lang.Object], java.util.concurrent.atomic.AtomicInteger)}
; {var3795=org.apache.dubbo.monitor.support.MonitorFilter, var865=r10, var2797=org.apache.dubbo.rpc.Invoker, var1925=r1, var2157=org.apache.dubbo.rpc.Invocation, var3885=r5, var1249=$r0, var347=$r2, var820=$r3, var611=$r4, var2693=$r7, var2088=org.apache.dubbo.rpc.support.RpcUtils, var1803=$r6, var3883=$r8, var2555=r9, var873=java.util.concurrent.ConcurrentMap, var489=$r11, var3612=java.util.function.Function, var1018=org.apache.dubbo.monitor.support.MonitorFilter$lambda_getConcurrent_0__778, var393=$r12, var898=java.lang.Object, var2640=org.apache.dubbo.common.utils.ConcurrentHashMapUtils, var3897=$r13, var558=java.util.concurrent.atomic.AtomicInteger, var1303=$r14}
; {org.apache.dubbo.monitor.support.MonitorFilter=var3795, r10=var865, org.apache.dubbo.rpc.Invoker=var2797, r1=var1925, org.apache.dubbo.rpc.Invocation=var2157, r5=var3885, $r0=var1249, $r2=var347, $r3=var820, $r4=var611, $r7=var2693, org.apache.dubbo.rpc.support.RpcUtils=var2088, $r6=var1803, $r8=var3883, r9=var2555, java.util.concurrent.ConcurrentMap=var873, $r11=var489, java.util.function.Function=var3612, org.apache.dubbo.monitor.support.MonitorFilter$lambda_getConcurrent_0__778=var1018, $r12=var393, java.lang.Object=var898, org.apache.dubbo.common.utils.ConcurrentHashMapUtils=var2640, $r13=var3897, java.util.concurrent.atomic.AtomicInteger=var558, $r14=var1303}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.monitor.support.MonitorFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r5 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r6 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r11 = r10.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.ConcurrentMap concurrents>;	$r12 = staticinvoke <org.apache.dubbo.monitor.support.MonitorFilter$lambda_getConcurrent_0__778: java.util.function.Function bootstrap$()>();	$r13 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r11, r9, $r12);	$r14 = (java.util.concurrent.atomic.AtomicInteger) $r13;	return $r14
;block_num 1