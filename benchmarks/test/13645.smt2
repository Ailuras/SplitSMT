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

(declare-sort var3136 0)
(declare-sort var1089 0)
(declare-sort var3110 0)
(declare-sort var1306 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRawQuery/-317309615 (var1089) String)
(declare-fun request/-1335764433 (var3136) var3110)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRawPath/-348466724 (var1089) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3110_setUri/2081210485 (var3110 String) void)
(declare-const null-var3136 var3136)
(declare-const null-var1089 var1089)
(declare-const null-String String)
(declare-const var2592 var3136) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter 
(assert (not (= var2592 null-var3136)))
(declare-const var2188 var1089) ; Statement: r0 := @parameter0: java.net.URI 
(assert (not (= var2188 null-var1089)))
(assert true)
(define-const var2892 String (getRawQuery/-317309615 var2188)) ; Statement: r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>() 
(define-const var1046 var3110 (request/-1335764433 var2592)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter: org.apache.dubbo.remoting.http12.HttpRequest request> 
(define-const var2099 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2099)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2099!1 String)
(assert (= var2099!1 ""))
(assert true)
(define-const var910 String (getRawPath/-348466724 var2188)) ; Statement: $r5 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var2038 String (append/672562846 var2099!1 var910)) ; Statement: $r9 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2099!2 String)
(assert (= var2099!2 (str.++ var2099!1 var910)))
 ; Statement: if r1 != null goto $r6 = new java.lang.StringBuilder 
(assert (not (not (= var2892 null-String)))) ; Negate: Cond: r1 != null  
(define-const var3458 String "") ; Statement: $r12 = "" 
 ; Statement: goto [?= $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)] 
(assert true) ; Non Conditional
(assert true)
(define-const var228 String (append/672562846 var2038 var3458)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2038!1 String)
(assert (= var2038!1 (str.++ var2038 var3458)))
(assert true)
(define-const var1620 String (toString/-2075883882 var228)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3110_setUri/2081210485 var1046 var1620)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r11) 

(declare-const var1046!1 var3110)
(declare-const var1620!1 String)
 ; Statement: return 
(check-sat)
; {getRawQuery/-317309615=([java.net.URI], java.lang.String), request/-1335764433=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter], org.apache.dubbo.remoting.http12.HttpRequest), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRawPath/-348466724=([java.net.URI], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3110_setUri/2081210485=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], void)}
; {var3136=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter, var2592=r2, var1089=java.net.URI, var2188=r0, var2892=r1, var3110=org.apache.dubbo.remoting.http12.HttpRequest, var1046=$r4, var2099=$r3, var910=$r5, var2038=$r9, var1306=null_type, var3458=$r12, var228=$r10, var1620=$r11}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter=var3136, r2=var2592, java.net.URI=var1089, r0=var2188, r1=var2892, org.apache.dubbo.remoting.http12.HttpRequest=var3110, $r4=var1046, $r3=var2099, $r5=var910, $r9=var2038, null_type=var1306, $r12=var3458, $r10=var228, $r11=var1620}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter;	r0 := @parameter0: java.net.URI;	r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>();	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter: org.apache.dubbo.remoting.http12.HttpRequest request>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>();	$r9 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	if r1 != null goto $r6 = new java.lang.StringBuilder;	$r12 = "";	goto [?= $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)];	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r11);	return
;block_num 3