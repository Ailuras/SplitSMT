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

(declare-sort var906 0)
(declare-sort var2798 0)
(declare-sort var2050 0)
(declare-sort var611 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRawQuery/-317309615 (var2798) String)
(declare-fun request/-517980186 (var906) var2050)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRawPath/-348466724 (var2798) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2050_setUri/2081210485 (var2050 String) void)
(declare-const null-var906 var906)
(declare-const null-var2798 var2798)
(declare-const null-String String)
(declare-const var3988 var906) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl 
(assert (not (= var3988 null-var906)))
(declare-const var871 var2798) ; Statement: r5 := @parameter0: java.net.URI 
(assert (not (= var871 null-var2798)))
(declare-const var1032 var2798) ; Statement: r0 := @parameter1: java.net.URI 
(assert (not (= var1032 null-var2798)))
(assert true)
(define-const var2785 String (getRawQuery/-317309615 var1032)) ; Statement: r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>() 
(define-const var20 var2050 (request/-517980186 var3988)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl: org.apache.dubbo.remoting.http12.HttpRequest request> 
(define-const var2242 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2242)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2242!1 String)
(assert (= var2242!1 ""))
(assert true)
(define-const var106 String (getRawPath/-348466724 var871)) ; Statement: $r6 = virtualinvoke r5.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var845 String (append/672562846 var2242!1 var106)) ; Statement: $r8 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2242!2 String)
(assert (= var2242!2 (str.++ var2242!1 var106)))
(assert true)
(define-const var1328 String (getRawPath/-348466724 var1032)) ; Statement: $r7 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var1753 String (append/672562846 var845 var1328)) ; Statement: $r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var845!1 String)
(assert (= var845!1 (str.++ var845 var1328)))
 ; Statement: if r1 != null goto $r9 = new java.lang.StringBuilder 
(assert (not (not (= var2785 null-String)))) ; Negate: Cond: r1 != null  
(define-const var3141 String "") ; Statement: $r15 = "" 
 ; Statement: goto [?= $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15)] 
(assert true) ; Non Conditional
(assert true)
(define-const var3928 String (append/672562846 var1753 var3141)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var1753!1 String)
(assert (= var1753!1 (str.++ var1753 var3141)))
(assert true)
(define-const var2499 String (toString/-2075883882 var3928)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2050_setUri/2081210485 var20 var2499)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r14) 

(declare-const var20!1 var2050)
(declare-const var2499!1 String)
 ; Statement: return 
(check-sat)
; {getRawQuery/-317309615=([java.net.URI], java.lang.String), request/-517980186=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl], org.apache.dubbo.remoting.http12.HttpRequest), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRawPath/-348466724=([java.net.URI], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2050_setUri/2081210485=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], void)}
; {var906=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl, var3988=r2, var2798=java.net.URI, var871=r5, var1032=r0, var2785=r1, var2050=org.apache.dubbo.remoting.http12.HttpRequest, var20=$r4, var2242=$r3, var106=$r6, var845=$r8, var1328=$r7, var1753=$r12, var611=null_type, var3141=$r15, var3928=$r13, var2499=$r14}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl=var906, r2=var3988, java.net.URI=var2798, r5=var871, r0=var1032, r1=var2785, org.apache.dubbo.remoting.http12.HttpRequest=var2050, $r4=var20, $r3=var2242, $r6=var106, $r8=var845, $r7=var1328, $r12=var1753, null_type=var611, $r15=var3141, $r13=var3928, $r14=var2499}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl;	r5 := @parameter0: java.net.URI;	r0 := @parameter1: java.net.URI;	r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>();	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.filter.ContainerRequestContextImpl: org.apache.dubbo.remoting.http12.HttpRequest request>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke r5.<java.net.URI: java.lang.String getRawPath()>();	$r8 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r7 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>();	$r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	if r1 != null goto $r9 = new java.lang.StringBuilder;	$r15 = "";	goto [?= $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15)];	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r14);	return
;block_num 3