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

(declare-sort var3880 0)
(declare-sort var3272 0)
(declare-sort var2071 0)
(declare-sort var1987 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRawQuery/-317309615 (var3272) String)
(declare-fun request/-1335764433 (var3880) var2071)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRawPath/-348466724 (var3272) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2071_setUri/2081210485 (var2071 String) void)
(declare-const null-var3880 var3880)
(declare-const null-var3272 var3272)
(declare-const null-String String)
(declare-const var2324 var3880) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter 
(assert (not (= var2324 null-var3880)))
(declare-const var2308 var3272) ; Statement: r5 := @parameter0: java.net.URI 
(assert (not (= var2308 null-var3272)))
(declare-const var809 var3272) ; Statement: r0 := @parameter1: java.net.URI 
(assert (not (= var809 null-var3272)))
(assert true)
(define-const var3839 String (getRawQuery/-317309615 var809)) ; Statement: r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>() 
(define-const var2457 var2071 (request/-1335764433 var2324)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter: org.apache.dubbo.remoting.http12.HttpRequest request> 
(define-const var2238 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2238)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2238!1 String)
(assert (= var2238!1 ""))
(assert true)
(define-const var3426 String (getRawPath/-348466724 var2308)) ; Statement: $r6 = virtualinvoke r5.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var1453 String (append/672562846 var2238!1 var3426)) ; Statement: $r8 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2238!2 String)
(assert (= var2238!2 (str.++ var2238!1 var3426)))
(assert true)
(define-const var2724 String (getRawPath/-348466724 var809)) ; Statement: $r7 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var1914 String (append/672562846 var1453 var2724)) ; Statement: $r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1453!1 String)
(assert (= var1453!1 (str.++ var1453 var2724)))
 ; Statement: if r1 != null goto $r9 = new java.lang.StringBuilder 
(assert (not (not (= var3839 null-String)))) ; Negate: Cond: r1 != null  
(define-const var739 String "") ; Statement: $r15 = "" 
 ; Statement: goto [?= $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2915 String (append/672562846 var1914 var739)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var1914!1 String)
(assert (= var1914!1 (str.++ var1914 var739)))
(assert true)
(define-const var3276 String (toString/-2075883882 var2915)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2071_setUri/2081210485 var2457 var3276)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r14) 

(declare-const var2457!1 var2071)
(declare-const var3276!1 String)
 ; Statement: return 
(check-sat)
; {getRawQuery/-317309615=([java.net.URI], java.lang.String), request/-1335764433=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter], org.apache.dubbo.remoting.http12.HttpRequest), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRawPath/-348466724=([java.net.URI], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2071_setUri/2081210485=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], void)}
; {var3880=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter, var2324=r2, var3272=java.net.URI, var2308=r5, var809=r0, var3839=r1, var2071=org.apache.dubbo.remoting.http12.HttpRequest, var2457=$r4, var2238=$r3, var3426=$r6, var1453=$r8, var2724=$r7, var1914=$r12, var1987=null_type, var739=$r15, var2915=$r13, var3276=$r14}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter=var3880, r2=var2324, java.net.URI=var3272, r5=var2308, r0=var809, r1=var3839, org.apache.dubbo.remoting.http12.HttpRequest=var2071, $r4=var2457, $r3=var2238, $r6=var3426, $r8=var1453, $r7=var2724, $r12=var1914, null_type=var1987, $r15=var739, $r13=var2915, $r14=var3276}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter;	r5 := @parameter0: java.net.URI;	r0 := @parameter1: java.net.URI;	r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>();	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter: org.apache.dubbo.remoting.http12.HttpRequest request>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke r5.<java.net.URI: java.lang.String getRawPath()>();	$r8 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r7 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>();	$r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	if r1 != null goto $r9 = new java.lang.StringBuilder;	$r15 = "";	goto [?= $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15)];	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r14);	return
;block_num 3