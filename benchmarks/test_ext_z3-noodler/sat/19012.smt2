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

(declare-sort var2853 0)
(declare-sort var1661 0)
(declare-sort var2874 0)
(declare-sort var3628 0)
(declare-sort var3072 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var1661_getInvoker/-92063731 (var1661) var2874)
(declare-fun var3072_getUrl/-275947851 (var3072) var3628)
(declare-fun cast-from-var2874-to-var3072 (var2874) var3072)
(declare-fun getAddress/-2093578336 (var3628) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1661_getProtocolServiceKey/-434455497 (var1661) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2853 var2853)
(declare-const null-var1661 var1661)
(declare-const var3162 var2853) ; Statement: r9 := @this: org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter 
(assert (not (= var3162 null-var2853)))
(declare-const var1861 var1661) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1861 null-var1661)))
(define-const var3418 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var3418 128)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(128) 

(declare-const var3418!1 String)
(declare-const var3446 Int)
(define-const var720 var2874 (var1661_getInvoker/-92063731 var1861)) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(define-const var2197 var3628 (var3072_getUrl/-275947851 (cast-from-var2874-to-var3072 var720))) ; Statement: $r3 = interfaceinvoke $r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2162 String (getAddress/-2093578336 var2197)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var2603 String (append/672562846 var3418!1 var2162)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3418!2 String)
(assert (= var3418!2 (str.++ var3418!1 var2162)))
(assert true)
(define-const var341 String (append/672562846 var2603 ":")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var2603!1 String)
(assert (= var2603!1 (str.++ var2603 ":")))
(define-const var2107 String (var1661_getProtocolServiceKey/-434455497 var1861)) ; Statement: $r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.String getProtocolServiceKey()>() 
(assert true)
;(assert (append/672562846 var341 var2107)) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var341!1 String)
(assert (= var341!1 (str.++ var341 var2107)))
(assert true)
(define-const var1090 String (toString/-2075883882 var3418!2)) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var1661_getInvoker/-92063731=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Invoker), var3072_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2874-to-var3072=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1661_getProtocolServiceKey/-434455497=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2853=org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter, var3162=r9, var1661=org.apache.dubbo.rpc.Invocation, var1861=r1, var3418=$r0, var3446=128, var2874=org.apache.dubbo.rpc.Invoker, var720=$r2, var3628=org.apache.dubbo.common.URL, var3072=org.apache.dubbo.common.Node, var2197=$r3, var2162=$r4, var2603=$r5, var341=$r7, var2107=$r6, var1090=$r8}
; {org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter=var2853, r9=var3162, org.apache.dubbo.rpc.Invocation=var1661, r1=var1861, $r0=var3418, 128=var3446, org.apache.dubbo.rpc.Invoker=var2874, $r2=var720, org.apache.dubbo.common.URL=var3628, org.apache.dubbo.common.Node=var3072, $r3=var2197, $r4=var2162, $r5=var2603, $r7=var341, $r6=var2107, $r8=var1090}
;seq <java.lang.StringBuilder: void <init>(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(128);	$r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r3 = interfaceinvoke $r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.String getProtocolServiceKey()>();	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1