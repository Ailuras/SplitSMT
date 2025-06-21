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

(declare-sort var487 0)
(declare-sort var925 0)
(declare-sort var1393 0)
(declare-sort var1774 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRawQuery/-317309615 (var925) String)
(declare-fun request/-1335764433 (var487) var1393)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRawPath/-348466724 (var925) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1393_setUri/2081210485 (var1393 String) void)
(declare-const null-var487 var487)
(declare-const null-var925 var925)
(declare-const null-String String)
(declare-const var173 var487) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter 
(assert (not (= var173 null-var487)))
(declare-const var2903 var925) ; Statement: r0 := @parameter0: java.net.URI 
(assert (not (= var2903 null-var925)))
(assert true)
(define-const var1447 String (getRawQuery/-317309615 var2903)) ; Statement: r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>() 
(define-const var2750 var1393 (request/-1335764433 var173)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter: org.apache.dubbo.remoting.http12.HttpRequest request> 
(define-const var3250 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3250)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3250!1 String)
(assert (= var3250!1 ""))
(assert true)
(define-const var1764 String (getRawPath/-348466724 var2903)) ; Statement: $r5 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>() 
(assert true)
(define-const var468 String (append/672562846 var3250!1 var1764)) ; Statement: $r9 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3250!2 String)
(assert (= var3250!2 (str.++ var3250!1 var1764)))
 ; Statement: if r1 != null goto $r6 = new java.lang.StringBuilder 
(assert (not (= var1447 null-String))) ; Cond: r1 != null 
(define-const var577 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var577)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var577!1 String)
(assert (= var577!1 ""))
(assert true)
(define-const var2112 String (append/-1166366385 var577!1 63)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63) 
(declare-const var577!2 String)
(assert (str.prefixof var577!1 var577!2))
(assert true)
(define-const var1070 String (append/672562846 var2112 var1447)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2112!1 String)
(assert (= var2112!1 (str.++ var2112 var1447)))
(assert true)
(define-const var1555 String (toString/-2075883882 var1070)) ; Statement: $r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var3835 String (append/672562846 var468 var1555)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var468!1 String)
(assert (= var468!1 (str.++ var468 var1555)))
(assert true)
(define-const var1030 String (toString/-2075883882 var3835)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1393_setUri/2081210485 var2750 var1030)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r11) 

(declare-const var2750!1 var1393)
(declare-const var1030!1 String)
 ; Statement: return 
(check-sat)
; {getRawQuery/-317309615=([java.net.URI], java.lang.String), request/-1335764433=([org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter], org.apache.dubbo.remoting.http12.HttpRequest), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRawPath/-348466724=([java.net.URI], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1393_setUri/2081210485=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], void)}
; {var487=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter, var173=r2, var925=java.net.URI, var2903=r0, var1447=r1, var1393=org.apache.dubbo.remoting.http12.HttpRequest, var2750=$r4, var3250=$r3, var1764=$r5, var468=$r9, var1774=null_type, var577=$r6, var2112=$r7, var1070=$r8, var1555=$r12, var3835=$r10, var1030=$r11}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter=var487, r2=var173, java.net.URI=var925, r0=var2903, r1=var1447, org.apache.dubbo.remoting.http12.HttpRequest=var1393, $r4=var2750, $r3=var3250, $r5=var1764, $r9=var468, null_type=var1774, $r6=var577, $r7=var2112, $r8=var1070, $r12=var1555, $r10=var3835, $r11=var1030}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter;	r0 := @parameter0: java.net.URI;	r1 = virtualinvoke r0.<java.net.URI: java.lang.String getRawQuery()>();	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.JaxrsHttpRequestAdapter: org.apache.dubbo.remoting.http12.HttpRequest request>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke r0.<java.net.URI: java.lang.String getRawPath()>();	$r9 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	if r1 != null goto $r6 = new java.lang.StringBuilder;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r12 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.HttpRequest: void setUri(java.lang.String)>($r11);	return
;block_num 3