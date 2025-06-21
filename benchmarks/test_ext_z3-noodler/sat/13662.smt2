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

(declare-sort var3568 0)
(declare-sort var2599 0)
(declare-sort var1095 0)
(declare-sort var2384 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRawQuery/-317309615 (var2599) String)
(declare-fun request/-517980186 (var3568) var1095)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRawPath/-348466724 (var2599) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1095_setUri/2081210485 (var1095 String) void)
(declare-const null-var3568 var3568)
(declare-const null-var2599 var2599)
(declare-const null-String String)
(declare-const var180 var3568) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl 
(assert (not (= var180 null-var3568)))
(declare-const var1560 var2599) ; Statement: r0 := @parameter0: java.net.URI 
(assert (not (= var1560 null-var2599)))
(assert true)
(define-const var1902 String (getRawQuery/-317309615 var1560)) ; Statement: r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>() 
(define-const var2855 var1095 (request/-517980186 var180)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl: org.apache.dubbo.remoting.http12.HttpRequest request> 
(define-const var1888 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1888)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1888!1 String)
(assert (= var1888!1 ""))
(assert true)
(define-const var3796 String (getRawPath/-348466724 var1560)) ; Statement: $r5 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var2422 String (append/672562846 var1888!1 var3796)) ; Statement: $r9 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1888!2 String)
(assert (= var1888!2 (str.++ var1888!1 var3796)))
 ; Statement: if r1 != null goto $r6 = new java.lang.StringBuilder 
(assert (not (= var1902 null-String))) ; Cond: r1 != null 
(define-const var652 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var652)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var652!1 String)
(assert (= var652!1 ""))
(assert true)
(define-const var261 String (append/-1166366385 var652!1 63)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63) 
(declare-const var652!2 String)
(assert (str.prefixof var652!1 var652!2))
(assert true)
(define-const var297 String (append/672562846 var261 var1902)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var261!1 String)
(assert (= var261!1 (str.++ var261 var1902)))
(assert true)
(define-const var188 String (toString/-2075883882 var297)) ; Statement: $r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var1919 String (append/672562846 var2422 var188)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2422!1 String)
(assert (= var2422!1 (str.++ var2422 var188)))
(assert true)
(define-const var1962 String (toString/-2075883882 var1919)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1095_setUri/2081210485 var2855 var1962)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r11) 

(declare-const var2855!1 var1095)
(declare-const var1962!1 String)
 ; Statement: return 
(check-sat)
; {getRawQuery/-317309615=([java.net.URI], java.lang.String), request/-517980186=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl], org.apache.dubbo.remoting.http12.HttpRequest), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRawPath/-348466724=([java.net.URI], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1095_setUri/2081210485=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], void)}
; {var3568=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl, var180=r2, var2599=java.net.URI, var1560=r0, var1902=r1, var1095=org.apache.dubbo.remoting.http12.HttpRequest, var2855=$r4, var1888=$r3, var3796=$r5, var2422=$r9, var2384=null_type, var652=$r6, var261=$r7, var297=$r8, var188=$r12, var1919=$r10, var1962=$r11}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl=var3568, r2=var180, java.net.URI=var2599, r0=var1560, r1=var1902, org.apache.dubbo.remoting.http12.HttpRequest=var1095, $r4=var2855, $r3=var1888, $r5=var3796, $r9=var2422, null_type=var2384, $r6=var652, $r7=var261, $r8=var297, $r12=var188, $r10=var1919, $r11=var1962}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl;	r0 := @parameter0: java.net.URI;	r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>();	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl: org.apache.dubbo.remoting.http12.HttpRequest request>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>();	$r9 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	if r1 != null goto $r6 = new java.lang.StringBuilder;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r11);	return
;block_num 3