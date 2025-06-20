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

(declare-sort var3197 0)
(declare-sort var3475 0)
(declare-sort var496 0)
(declare-sort var2906 0)
(declare-sort var1585 0)
(declare-sort var555 0)
(declare-sort var947 0)
(declare-sort var597 0)
(declare-sort var3097 0)
(declare-sort var2939 0)
(declare-sort var3702 0)
(declare-sort var2464 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3097!class ClassObject)
(declare-fun var496_from/-1251202111 (var3475) var496)
(declare-fun toString/1090915316 (var2906) String)
(declare-fun addParameterIfAbsent/-1295735773 (var496 String String) var496)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/1929860173 (var496 String String) var496)
(declare-fun build/935716095 (var496) var1585)
(declare-fun getParameter/506106603 (var3475 String String) String)
(declare-fun cast-from-var1585-to-var3475 (var1585) var3475)
(declare-fun var555_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getOrDefaultFrameworkModel/-1637556979 (var3475) var947)
(declare-fun getExtensionLoader/-514331157 (var2939 ClassObject) var597)
(declare-fun cast-from-var947-to-var2939 (var947) var2939)
(declare-fun hasExtension/-1450549355 (var597 String) Bool)
(declare-fun var3702-init () var3702)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2464) String)
(declare-fun cast-from-var1585-to-var2464 (var1585) var2464)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1520188505 (var3702 String) void)
(declare-const null-var3197 var3197)
(declare-const null-var3475 var3475)
(declare-const var2906-TRUE var2906)
(declare-const var3172 var3197) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol 
(assert (not (= var3172 null-var3197)))
(declare-const var2615 var3475) ; Statement: r36 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2615 null-var3475)))
(define-const var1298 var496 (var496_from/-1251202111 var2615)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder 'from'(org.apache.dubbo.common.URL)>(r36) 
(define-const var2978 var2906 var2906-TRUE) ; Statement: $r0 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var381 String (toString/1090915316 var2978)) ; Statement: $r1 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>() 
(assert true)
(define-const var1199 var496 (addParameterIfAbsent/-1295735773 var1298 "channel.readonly.sent" var381)) ; Statement: $r4 = virtualinvoke $r2.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameterIfAbsent(java.lang.String,java.lang.String)>("channel.readonly.sent", $r1) 
(define-const var377 Int (cast-from-Int-to-Int 60000)) ; Statement: $i1 = (int) 60000 
(define-const var3328 String (String_valueOf/1240665136 var377)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var497 var496 (addParameterIfAbsent/-1295735773 var1199 "heartbeat" var3328)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameterIfAbsent(java.lang.String,java.lang.String)>("heartbeat", $r3) 
(assert true)
(define-const var953 var496 (addParameter/1929860173 var497 "codec" "dubbo")) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>("codec", "dubbo") 
(assert true)
(define-const var3267 var1585 (build/935716095 var953)) ; Statement: r37 = virtualinvoke $r6.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.url.component.ServiceConfigURL build()>() 
(assert true)
(define-const var3688 String (getParameter/506106603 (cast-from-var1585-to-var3475 var3267) "server" "netty")) ; Statement: r38 = virtualinvoke r37.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("server", "netty") 
(define-const var1845 Bool (var555_isNotEmpty/-1251449450 var3688)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r38) 
 ; Statement: if $z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.remoting.exchange.ExchangeHandler requestHandler> 
(assert (not (= (ite var1845 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2610 var947 (getOrDefaultFrameworkModel/-1637556979 (cast-from-var1585-to-var3475 var3267))) ; Statement: $r17 = virtualinvoke r37.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var1870 var597 (getExtensionLoader/-514331157 (cast-from-var947-to-var2939 var2610) var3097!class)) ; Statement: $r18 = virtualinvoke $r17.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Transporter;") 
(assert true)
(define-const var1531 Bool (hasExtension/-1450549355 var1870 var3688)) ; Statement: $z3 = virtualinvoke $r18.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r38) 
 ; Statement: if $z3 != 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.remoting.exchange.ExchangeHandler requestHandler> 
(assert (not (not (= (ite var1531 1 0) 0)))) ; Negate: Cond: $z3 != 0  
(define-const var3779 var3702 var3702-init) ; Statement: $r41 = new org.apache.dubbo.rpc.RpcException 
(define-const var3738 String String-init) ; Statement: $r40 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3738)) ; Statement: specialinvoke $r40.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3738!1 String)
(assert (= var3738!1 ""))
(assert true)
(define-const var1577 String (append/672562846 var3738!1 "Unsupported server type: ")) ; Statement: $r22 = virtualinvoke $r40.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported server type: ") 
(declare-const var3738!2 String)
(assert (= var3738!2 (str.++ var3738!1 "Unsupported server type: ")))
(assert true)
(define-const var2434 String (append/672562846 var1577 var3688)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r38) 
(declare-const var1577!1 String)
(assert (= var1577!1 (str.++ var1577 var3688)))
(assert true)
(define-const var3323 String (append/672562846 var2434 ", url: ")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", url: ") 
(declare-const var2434!1 String)
(assert (= var2434!1 (str.++ var2434 ", url: ")))
(assert true)
(define-const var2106 String (append/-1031950772 var3323 (cast-from-var1585-to-var2464 var3267))) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r37) 
(declare-const var3323!1 String)
(assert (str.prefixof var3323 var3323!1))
(assert true)
(define-const var3564 String (toString/-2075883882 var2106)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1520188505 var3779 var3564)) ; Statement: specialinvoke $r41.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r26) 

(declare-const var3779!1 var3702)
(declare-const var3564!1 String)
 ; Statement: throw $r41 
(check-sat)
; {var496_from/-1251202111=([org.apache.dubbo.common.URL], org.apache.dubbo.common.URLBuilder), toString/1090915316=([java.lang.Boolean], java.lang.String), addParameterIfAbsent/-1295735773=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder), cast-from-Int-to-Int=([int], int), String_valueOf/1240665136=([int], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder), build/935716095=([org.apache.dubbo.common.URLBuilder], org.apache.dubbo.common.url.component.ServiceConfigURL), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), cast-from-var1585-to-var3475=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), var555_isNotEmpty/-1251449450=([java.lang.String], boolean), getOrDefaultFrameworkModel/-1637556979=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.FrameworkModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var947-to-var2939=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), var3702-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1585-to-var2464=([org.apache.dubbo.common.url.component.ServiceConfigURL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1520188505=([org.apache.dubbo.rpc.RpcException, java.lang.String], void)}
; {var3197=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var3172=r7, var3475=org.apache.dubbo.common.URL, var2615=r36, var496=org.apache.dubbo.common.URLBuilder, var1298=$r2, var2906=java.lang.Boolean, var2978=$r0, var381=$r1, var1199=$r4, var377=$i1, var3328=$r3, var497=$r5, var953=$r6, var1585=org.apache.dubbo.common.url.component.ServiceConfigURL, var3267=r37, var3688=r38, var555=org.apache.dubbo.common.utils.StringUtils, var1845=$z0, var947=org.apache.dubbo.rpc.model.FrameworkModel, var2610=$r17, var597=org.apache.dubbo.common.extension.ExtensionLoader, var3097=org.apache.dubbo.remoting.Transporter, var2939=org.apache.dubbo.common.extension.ExtensionAccessor, var1870=$r18, var1531=$z3, var3702=org.apache.dubbo.rpc.RpcException, var3779=$r41, var3738=$r40, var1577=$r22, var2434=$r23, var3323=$r24, var2464=java.lang.Object, var2106=$r25, var3564=$r26}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var3197, r7=var3172, org.apache.dubbo.common.URL=var3475, r36=var2615, org.apache.dubbo.common.URLBuilder=var496, $r2=var1298, java.lang.Boolean=var2906, $r0=var2978, $r1=var381, $r4=var1199, $i1=var377, $r3=var3328, $r5=var497, $r6=var953, org.apache.dubbo.common.url.component.ServiceConfigURL=var1585, r37=var3267, r38=var3688, org.apache.dubbo.common.utils.StringUtils=var555, $z0=var1845, org.apache.dubbo.rpc.model.FrameworkModel=var947, $r17=var2610, org.apache.dubbo.common.extension.ExtensionLoader=var597, org.apache.dubbo.remoting.Transporter=var3097, org.apache.dubbo.common.extension.ExtensionAccessor=var2939, $r18=var1870, $z3=var1531, org.apache.dubbo.rpc.RpcException=var3702, $r41=var3779, $r40=var3738, $r22=var1577, $r23=var2434, $r24=var3323, java.lang.Object=var2464, $r25=var2106, $r26=var3564}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol;	r36 := @parameter0: org.apache.dubbo.common.URL;	$r2 = staticinvoke <org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder 'from'(org.apache.dubbo.common.URL)>(r36);	$r0 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r1 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>();	$r4 = virtualinvoke $r2.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameterIfAbsent(java.lang.String,java.lang.String)>("channel.readonly.sent", $r1);	$i1 = (int) 60000;	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameterIfAbsent(java.lang.String,java.lang.String)>("heartbeat", $r3);	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>("codec", "dubbo");	r37 = virtualinvoke $r6.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.url.component.ServiceConfigURL build()>();	r38 = virtualinvoke r37.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("server", "netty");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r38);	if $z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.remoting.exchange.ExchangeHandler requestHandler>;	$r17 = virtualinvoke r37.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r18 = virtualinvoke $r17.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Transporter;");	$z3 = virtualinvoke $r18.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r38);	if $z3 != 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.remoting.exchange.ExchangeHandler requestHandler>;	$r41 = new org.apache.dubbo.rpc.RpcException;	$r40 = new java.lang.StringBuilder;	specialinvoke $r40.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r40.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported server type: ");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r38);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", url: ");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r37);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r41.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r26);	throw $r41
;block_num 3