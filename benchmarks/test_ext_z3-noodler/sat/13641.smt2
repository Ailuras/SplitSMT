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

(declare-sort var44 0)
(declare-sort var1686 0)
(declare-sort var2539 0)
(declare-sort var1554 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRawQuery/-317309615 (var1686) String)
(declare-fun request/-517980186 (var44) var2539)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRawPath/-348466724 (var1686) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2539_setUri/2081210485 (var2539 String) void)
(declare-const null-var44 var44)
(declare-const null-var1686 var1686)
(declare-const null-String String)
(declare-const var1566 var44) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl 
(assert (not (= var1566 null-var44)))
(declare-const var3305 var1686) ; Statement: r0 := @parameter0: java.net.URI 
(assert (not (= var3305 null-var1686)))
(assert true)
(define-const var588 String (getRawQuery/-317309615 var3305)) ; Statement: r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>() 
(define-const var3489 var2539 (request/-517980186 var1566)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl: org.apache.dubbo.remoting.http12.HttpRequest request> 
(define-const var589 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var589)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var589!1 String)
(assert (= var589!1 ""))
(assert true)
(define-const var3813 String (getRawPath/-348466724 var3305)) ; Statement: $r5 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var2238 String (append/672562846 var589!1 var3813)) ; Statement: $r9 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var589!2 String)
(assert (= var589!2 (str.++ var589!1 var3813)))
 ; Statement: if r1 != null goto $r6 = new java.lang.StringBuilder 
(assert (not (not (= var588 null-String)))) ; Negate: Cond: r1 != null  
(define-const var2714 String "") ; Statement: $r12 = "" 
 ; Statement: goto [?= $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1573 String (append/672562846 var2238 var2714)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2238!1 String)
(assert (= var2238!1 (str.++ var2238 var2714)))
(assert true)
(define-const var3848 String (toString/-2075883882 var1573)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2539_setUri/2081210485 var3489 var3848)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r11) 

(declare-const var3489!1 var2539)
(declare-const var3848!1 String)
 ; Statement: return 
(check-sat)
; {getRawQuery/-317309615=([java.net.URI], java.lang.String), request/-517980186=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl], org.apache.dubbo.remoting.http12.HttpRequest), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRawPath/-348466724=([java.net.URI], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2539_setUri/2081210485=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], void)}
; {var44=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl, var1566=r2, var1686=java.net.URI, var3305=r0, var588=r1, var2539=org.apache.dubbo.remoting.http12.HttpRequest, var3489=$r4, var589=$r3, var3813=$r5, var2238=$r9, var1554=null_type, var2714=$r12, var1573=$r10, var3848=$r11}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl=var44, r2=var1566, java.net.URI=var1686, r0=var3305, r1=var588, org.apache.dubbo.remoting.http12.HttpRequest=var2539, $r4=var3489, $r3=var589, $r5=var3813, $r9=var2238, null_type=var1554, $r12=var2714, $r10=var1573, $r11=var3848}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl;	r0 := @parameter0: java.net.URI;	r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>();	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl: org.apache.dubbo.remoting.http12.HttpRequest request>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>();	$r9 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	if r1 != null goto $r6 = new java.lang.StringBuilder;	$r12 = "";	goto [?= $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)];	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r11);	return
;block_num 3