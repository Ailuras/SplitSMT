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

(declare-sort var3681 0)
(declare-sort var635 0)
(declare-sort var1415 0)
(declare-sort var3834 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRawQuery/-317309615 (var635) String)
(declare-fun request/-517980186 (var3681) var1415)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRawPath/-348466724 (var635) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1415_setUri/2081210485 (var1415 String) void)
(declare-const null-var3681 var3681)
(declare-const null-var635 var635)
(declare-const null-String String)
(declare-const var1037 var3681) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl 
(assert (not (= var1037 null-var3681)))
(declare-const var2832 var635) ; Statement: r5 := @parameter0: java.net.URI 
(assert (not (= var2832 null-var635)))
(declare-const var914 var635) ; Statement: r0 := @parameter1: java.net.URI 
(assert (not (= var914 null-var635)))
(assert true)
(define-const var2774 String (getRawQuery/-317309615 var914)) ; Statement: r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>() 
(define-const var2018 var1415 (request/-517980186 var1037)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl: org.apache.dubbo.remoting.http12.HttpRequest request> 
(define-const var3212 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3212)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3212!1 String)
(assert (= var3212!1 ""))
(assert true)
(define-const var3385 String (getRawPath/-348466724 var2832)) ; Statement: $r6 = virtualinvoke r5.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var3351 String (append/672562846 var3212!1 var3385)) ; Statement: $r8 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3212!2 String)
(assert (= var3212!2 (str.++ var3212!1 var3385)))
(assert true)
(define-const var515 String (getRawPath/-348466724 var914)) ; Statement: $r7 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var1283 String (append/672562846 var3351 var515)) ; Statement: $r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3351!1 String)
(assert (= var3351!1 (str.++ var3351 var515)))
 ; Statement: if r1 != null goto $r9 = new java.lang.StringBuilder 
(assert (not (= var2774 null-String))) ; Cond: r1 != null 
(define-const var3358 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3358)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3358!1 String)
(assert (= var3358!1 ""))
(assert true)
(define-const var2430 String (append/-1166366385 var3358!1 63)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63) 
(declare-const var3358!2 String)
(assert (str.prefixof var3358!1 var3358!2))
(assert true)
(define-const var1127 String (append/672562846 var2430 var2774)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2430!1 String)
(assert (= var2430!1 (str.++ var2430 var2774)))
(assert true)
(define-const var2788 String (toString/-2075883882 var1127)) ; Statement: $r15 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var3674 String (append/672562846 var1283 var2788)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var1283!1 String)
(assert (= var1283!1 (str.++ var1283 var2788)))
(assert true)
(define-const var2783 String (toString/-2075883882 var3674)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1415_setUri/2081210485 var2018 var2783)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r14) 

(declare-const var2018!1 var1415)
(declare-const var2783!1 String)
 ; Statement: return 
(check-sat)
; {getRawQuery/-317309615=([java.net.URI], java.lang.String), request/-517980186=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl], org.apache.dubbo.remoting.http12.HttpRequest), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRawPath/-348466724=([java.net.URI], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1415_setUri/2081210485=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], void)}
; {var3681=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl, var1037=r2, var635=java.net.URI, var2832=r5, var914=r0, var2774=r1, var1415=org.apache.dubbo.remoting.http12.HttpRequest, var2018=$r4, var3212=$r3, var3385=$r6, var3351=$r8, var515=$r7, var1283=$r12, var3834=null_type, var3358=$r9, var2430=$r10, var1127=$r11, var2788=$r15, var3674=$r13, var2783=$r14}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl=var3681, r2=var1037, java.net.URI=var635, r5=var2832, r0=var914, r1=var2774, org.apache.dubbo.remoting.http12.HttpRequest=var1415, $r4=var2018, $r3=var3212, $r6=var3385, $r8=var3351, $r7=var515, $r12=var1283, null_type=var3834, $r9=var3358, $r10=var2430, $r11=var1127, $r15=var2788, $r13=var3674, $r14=var2783}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl;	r5 := @parameter0: java.net.URI;	r0 := @parameter1: java.net.URI;	r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>();	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl: org.apache.dubbo.remoting.http12.HttpRequest request>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke r5.<java.net.URI: java.lang.String getRawPath()>();	$r8 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r7 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>();	$r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	if r1 != null goto $r9 = new java.lang.StringBuilder;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r15 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r14);	return
;block_num 3