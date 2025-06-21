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

(declare-sort var3188 0)
(declare-sort var3978 0)
(declare-sort var2816 0)
(declare-sort var3066 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRawQuery/-317309615 (var3978) String)
(declare-fun request/-1335764433 (var3188) var2816)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRawPath/-348466724 (var3978) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2816_setUri/2081210485 (var2816 String) void)
(declare-const null-var3188 var3188)
(declare-const null-var3978 var3978)
(declare-const null-String String)
(declare-const var3575 var3188) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter 
(assert (not (= var3575 null-var3188)))
(declare-const var3835 var3978) ; Statement: r5 := @parameter0: java.net.URI 
(assert (not (= var3835 null-var3978)))
(declare-const var2197 var3978) ; Statement: r0 := @parameter1: java.net.URI 
(assert (not (= var2197 null-var3978)))
(assert true)
(define-const var214 String (getRawQuery/-317309615 var2197)) ; Statement: r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>() 
(define-const var3724 var2816 (request/-1335764433 var3575)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter: org.apache.dubbo.remoting.http12.HttpRequest request> 
(define-const var2202 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2202)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2202!1 String)
(assert (= var2202!1 ""))
(assert true)
(define-const var2315 String (getRawPath/-348466724 var3835)) ; Statement: $r6 = virtualinvoke r5.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var1768 String (append/672562846 var2202!1 var2315)) ; Statement: $r8 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2202!2 String)
(assert (= var2202!2 (str.++ var2202!1 var2315)))
(assert true)
(define-const var2950 String (getRawPath/-348466724 var2197)) ; Statement: $r7 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var2573 String (append/672562846 var1768 var2950)) ; Statement: $r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1768!1 String)
(assert (= var1768!1 (str.++ var1768 var2950)))
 ; Statement: if r1 != null goto $r9 = new java.lang.StringBuilder 
(assert (not (= var214 null-String))) ; Cond: r1 != null 
(define-const var1764 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1764)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1764!1 String)
(assert (= var1764!1 ""))
(assert true)
(define-const var3259 String (append/-1166366385 var1764!1 63)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63) 
(declare-const var1764!2 String)
(assert (str.prefixof var1764!1 var1764!2))
(assert true)
(define-const var1993 String (append/672562846 var3259 var214)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3259!1 String)
(assert (= var3259!1 (str.++ var3259 var214)))
(assert true)
(define-const var1850 String (toString/-2075883882 var1993)) ; Statement: $r15 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var2952 String (append/672562846 var2573 var1850)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var2573!1 String)
(assert (= var2573!1 (str.++ var2573 var1850)))
(assert true)
(define-const var3732 String (toString/-2075883882 var2952)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2816_setUri/2081210485 var3724 var3732)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r14) 

(declare-const var3724!1 var2816)
(declare-const var3732!1 String)
 ; Statement: return 
(check-sat)
; {getRawQuery/-317309615=([java.net.URI], java.lang.String), request/-1335764433=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter], org.apache.dubbo.remoting.http12.HttpRequest), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRawPath/-348466724=([java.net.URI], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2816_setUri/2081210485=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], void)}
; {var3188=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter, var3575=r2, var3978=java.net.URI, var3835=r5, var2197=r0, var214=r1, var2816=org.apache.dubbo.remoting.http12.HttpRequest, var3724=$r4, var2202=$r3, var2315=$r6, var1768=$r8, var2950=$r7, var2573=$r12, var3066=null_type, var1764=$r9, var3259=$r10, var1993=$r11, var1850=$r15, var2952=$r13, var3732=$r14}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter=var3188, r2=var3575, java.net.URI=var3978, r5=var3835, r0=var2197, r1=var214, org.apache.dubbo.remoting.http12.HttpRequest=var2816, $r4=var3724, $r3=var2202, $r6=var2315, $r8=var1768, $r7=var2950, $r12=var2573, null_type=var3066, $r9=var1764, $r10=var3259, $r11=var1993, $r15=var1850, $r13=var2952, $r14=var3732}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter;	r5 := @parameter0: java.net.URI;	r0 := @parameter1: java.net.URI;	r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>();	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter: org.apache.dubbo.remoting.http12.HttpRequest request>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke r5.<java.net.URI: java.lang.String getRawPath()>();	$r8 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r7 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>();	$r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	if r1 != null goto $r9 = new java.lang.StringBuilder;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r15 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r14);	return
;block_num 3