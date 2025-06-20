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

(declare-sort var3648 0)
(declare-sort var2561 0)
(declare-sort var2126 0)
(declare-sort var229 0)
(declare-sort var3537 0)
(declare-sort var2667 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun destroyed/-1410107996 (var3648) var2561)
(declare-fun get/2135855162 (var2561) Bool)
(declare-fun var2126-init () var2126)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInterface/-134461520 (var3648) ClassObject)
(declare-fun append/-1031950772 (String var229) String)
(declare-fun cast-from-ClassObject-to-var229 (ClassObject) var229)
(declare-fun var3537_getLocalHost/-1653363627 () String)
(declare-fun var2667_getVersion/310196261 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1520188505 (var2126 String) void)
(declare-const null-var3648 var3648)
(declare-const var1674 var3648) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker 
(assert (not (= var1674 null-var3648)))
(define-const var1312 var2561 (destroyed/-1410107996 var1674)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: java.util.concurrent.atomic.AtomicBoolean destroyed> 
(assert true)
(define-const var1611 Bool (get/2135855162 var1312)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var1611 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2968 var2126 var2126-init) ; Statement: $r2 = new org.apache.dubbo.rpc.RpcException 
(define-const var879 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var879)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var879!1 String)
(assert (= var879!1 ""))
(assert true)
(define-const var1817 String (append/672562846 var879!1 "Rpc cluster invoker for ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Rpc cluster invoker for ") 
(declare-const var879!2 String)
(assert (= var879!2 (str.++ var879!1 "Rpc cluster invoker for ")))
(assert true)
(define-const var977 ClassObject (getInterface/-134461520 var1674)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var1980 String (append/-1031950772 var1817 (cast-from-ClassObject-to-var229 var977))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var1817!1 String)
(assert (str.prefixof var1817 var1817!1))
(assert true)
(define-const var2222 String (append/672562846 var1980 " on consumer ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" on consumer ") 
(declare-const var1980!1 String)
(assert (= var1980!1 (str.++ var1980 " on consumer ")))
(define-const var2364 String var3537_getLocalHost/-1653363627) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(assert true)
(define-const var3730 String (append/672562846 var2222 var2364)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var2222!1 String)
(assert (= var2222!1 (str.++ var2222 var2364)))
(assert true)
(define-const var2509 String (append/672562846 var3730 " use dubbo version ")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" use dubbo version ") 
(declare-const var3730!1 String)
(assert (= var3730!1 (str.++ var3730 " use dubbo version ")))
(define-const var2966 String var2667_getVersion/310196261) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>() 
(assert true)
(define-const var2275 String (append/672562846 var2509 var2966)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var2509!1 String)
(assert (= var2509!1 (str.++ var2509 var2966)))
(assert true)
(define-const var912 String (append/672562846 var2275 " is now destroyed! Can not invoke any more.")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is now destroyed! Can not invoke any more.") 
(declare-const var2275!1 String)
(assert (= var2275!1 (str.++ var2275 " is now destroyed! Can not invoke any more.")))
(assert true)
(define-const var3280 String (toString/-2075883882 var912)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1520188505 var2968 var3280)) ; Statement: specialinvoke $r2.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r14) 

(declare-const var2968!1 var2126)
(declare-const var3280!1 String)
 ; Statement: throw $r2 
(check-sat)
; {destroyed/-1410107996=([org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean), var2126-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInterface/-134461520=([org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var229=([java.lang.Class], java.lang.Object), var3537_getLocalHost/-1653363627=([], java.lang.String), var2667_getVersion/310196261=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1520188505=([org.apache.dubbo.rpc.RpcException, java.lang.String], void)}
; {var3648=org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker, var1674=r0, var2561=java.util.concurrent.atomic.AtomicBoolean, var1312=$r1, var1611=$z0, var2126=org.apache.dubbo.rpc.RpcException, var2968=$r2, var879=$r3, var1817=$r5, var977=$r4, var229=java.lang.Object, var1980=$r6, var2222=$r8, var3537=org.apache.dubbo.common.utils.NetUtils, var2364=$r7, var3730=$r9, var2509=$r11, var2667=org.apache.dubbo.common.Version, var2966=$r10, var2275=$r12, var912=$r13, var3280=$r14}
; {org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker=var3648, r0=var1674, java.util.concurrent.atomic.AtomicBoolean=var2561, $r1=var1312, $z0=var1611, org.apache.dubbo.rpc.RpcException=var2126, $r2=var2968, $r3=var879, $r5=var1817, $r4=var977, java.lang.Object=var229, $r6=var1980, $r8=var2222, org.apache.dubbo.common.utils.NetUtils=var3537, $r7=var2364, $r9=var3730, $r11=var2509, org.apache.dubbo.common.Version=var2667, $r10=var2966, $r12=var2275, $r13=var912, $r14=var3280}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker;	$r1 = r0.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: java.util.concurrent.atomic.AtomicBoolean destroyed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto return;	$r2 = new org.apache.dubbo.rpc.RpcException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Rpc cluster invoker for ");	$r4 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: java.lang.Class getInterface()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" on consumer ");	$r7 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" use dubbo version ");	$r10 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is now destroyed! Can not invoke any more.");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r14);	throw $r2
;block_num 2