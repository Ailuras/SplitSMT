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

(declare-sort var1767 0)
(declare-sort var3098 0)
(declare-sort var3536 0)
(declare-sort var3951 0)
(declare-sort var3513 0)
(declare-sort var1066 0)
(declare-sort var605 0)
(declare-sort var3489 0)
(declare-sort var2624 0)
(declare-sort var3615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun tpsLimiter/-1366693661 (var1767) var3951)
(declare-fun var1066_getUrl/-275947851 (var1066) var3513)
(declare-fun cast-from-var3098-to-var1066 (var3098) var1066)
(declare-fun var3951_isAllowable/-1031056798 (var3951 var3513 var3536) Bool)
(declare-fun var605-init () var605)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3098_getInterface/-1171900879 (var3098) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var3489_getMethodName/-516674313 (var3536) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1520188505 (var605 String) void)
(declare-fun var2624_newDefaultAsyncResult/-2013762118 (var3615 var3536) var2624)
(declare-fun cast-from-var605-to-var3615 (var605) var3615)
(declare-const null-var1767 var1767)
(declare-const null-var3098 var3098)
(declare-const null-var3536 var3536)
(declare-const var2676 var1767) ; Statement: r0 := @this: org.apache.dubbo.rpc.filter.TpsLimitFilter 
(assert (not (= var2676 null-var1767)))
(declare-const var472 var3098) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var472 null-var3098)))
(declare-const var82 var3536) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var82 null-var3536)))
(define-const var2443 var3951 (tpsLimiter/-1366693661 var2676)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.filter.TpsLimitFilter: org.apache.dubbo.rpc.filter.tps.TPSLimiter tpsLimiter> 
(define-const var2591 var3513 (var1066_getUrl/-275947851 (cast-from-var3098-to-var1066 var472))) ; Statement: $r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2372 Bool (var3951_isAllowable/-1031056798 var2443 var2591 var82)) ; Statement: $z0 = interfaceinvoke $r2.<org.apache.dubbo.rpc.filter.tps.TPSLimiter: boolean isAllowable(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.Invocation)>($r4, r3) 
 ; Statement: if $z0 != 0 goto $r5 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r3) 
(assert (not (not (= (ite var2372 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var686 var605 var605-init) ; Statement: $r6 = new org.apache.dubbo.rpc.RpcException 
(define-const var2077 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2077)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2077!1 String)
(assert (= var2077!1 ""))
(assert true)
(define-const var1879 String (append/672562846 var2077!1 "Failed to invoke service ")) ; Statement: $r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke service ") 
(declare-const var2077!2 String)
(assert (= var2077!2 (str.++ var2077!1 "Failed to invoke service ")))
(define-const var1203 ClassObject (var3098_getInterface/-1171900879 var472)) ; Statement: $r8 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var3019 String (getName/-1958580599 var1203)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2819 String (append/672562846 var1879 var3019)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1879!1 String)
(assert (= var1879!1 (str.++ var1879 var3019)))
(assert true)
(define-const var3100 String (append/672562846 var2819 ".")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var2819!1 String)
(assert (= var2819!1 (str.++ var2819 ".")))
(define-const var629 String (var3489_getMethodName/-516674313 var82)) ; Statement: $r12 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3) 
(assert true)
(define-const var534 String (append/672562846 var3100 var629)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var3100!1 String)
(assert (= var3100!1 (str.++ var3100 var629)))
(assert true)
(define-const var974 String (append/672562846 var534 " because exceed max service tps.")) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" because exceed max service tps.") 
(declare-const var534!1 String)
(assert (= var534!1 (str.++ var534 " because exceed max service tps.")))
(assert true)
(define-const var3964 String (toString/-2075883882 var974)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1520188505 var686 var3964)) ; Statement: specialinvoke $r6.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r16) 

(declare-const var686!1 var605)
(declare-const var3964!1 String)
(define-const var2371 var2624 (var2624_newDefaultAsyncResult/-2013762118 (cast-from-var605-to-var3615 var686!1) var82)) ; Statement: $r17 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>($r6, r3) 
 ; Statement: return $r17 
(check-sat)
; {tpsLimiter/-1366693661=([org.apache.dubbo.rpc.filter.TpsLimitFilter], org.apache.dubbo.rpc.filter.tps.TPSLimiter), var1066_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3098-to-var1066=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), var3951_isAllowable/-1031056798=([org.apache.dubbo.rpc.filter.tps.TPSLimiter, org.apache.dubbo.common.URL, org.apache.dubbo.rpc.Invocation], boolean), var605-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3098_getInterface/-1171900879=([org.apache.dubbo.rpc.Invoker], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), var3489_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1520188505=([org.apache.dubbo.rpc.RpcException, java.lang.String], void), var2624_newDefaultAsyncResult/-2013762118=([java.lang.Throwable, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.AsyncRpcResult), cast-from-var605-to-var3615=([org.apache.dubbo.rpc.RpcException], java.lang.Throwable)}
; {var1767=org.apache.dubbo.rpc.filter.TpsLimitFilter, var2676=r0, var3098=org.apache.dubbo.rpc.Invoker, var472=r1, var3536=org.apache.dubbo.rpc.Invocation, var82=r3, var3951=org.apache.dubbo.rpc.filter.tps.TPSLimiter, var2443=$r2, var3513=org.apache.dubbo.common.URL, var1066=org.apache.dubbo.common.Node, var2591=$r4, var2372=$z0, var605=org.apache.dubbo.rpc.RpcException, var686=$r6, var2077=$r7, var1879=$r10, var1203=$r8, var3019=$r9, var2819=$r11, var3100=$r13, var3489=org.apache.dubbo.rpc.support.RpcUtils, var629=$r12, var534=$r14, var974=$r15, var3964=$r16, var2624=org.apache.dubbo.rpc.AsyncRpcResult, var3615=java.lang.Throwable, var2371=$r17}
; {org.apache.dubbo.rpc.filter.TpsLimitFilter=var1767, r0=var2676, org.apache.dubbo.rpc.Invoker=var3098, r1=var472, org.apache.dubbo.rpc.Invocation=var3536, r3=var82, org.apache.dubbo.rpc.filter.tps.TPSLimiter=var3951, $r2=var2443, org.apache.dubbo.common.URL=var3513, org.apache.dubbo.common.Node=var1066, $r4=var2591, $z0=var2372, org.apache.dubbo.rpc.RpcException=var605, $r6=var686, $r7=var2077, $r10=var1879, $r8=var1203, $r9=var3019, $r11=var2819, $r13=var3100, org.apache.dubbo.rpc.support.RpcUtils=var3489, $r12=var629, $r14=var534, $r15=var974, $r16=var3964, org.apache.dubbo.rpc.AsyncRpcResult=var2624, java.lang.Throwable=var3615, $r17=var2371}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.filter.TpsLimitFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r3 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r2 = r0.<org.apache.dubbo.rpc.filter.TpsLimitFilter: org.apache.dubbo.rpc.filter.tps.TPSLimiter tpsLimiter>;	$r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$z0 = interfaceinvoke $r2.<org.apache.dubbo.rpc.filter.tps.TPSLimiter: boolean isAllowable(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.Invocation)>($r4, r3);	if $z0 != 0 goto $r5 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r3);	$r6 = new org.apache.dubbo.rpc.RpcException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke service ");	$r8 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	$r9 = virtualinvoke $r8.<java.lang.Class: java.lang.String getName()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r12 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" because exceed max service tps.");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r6.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r16);	$r17 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>($r6, r3);	return $r17
;block_num 2