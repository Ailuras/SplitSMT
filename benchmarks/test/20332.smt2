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

(declare-sort var46 0)
(declare-sort var2799 0)
(declare-sort var1658 0)
(declare-sort var185 0)
(declare-sort var3398 0)
(declare-sort var3730 0)
(declare-sort var2578 0)
(declare-sort var3570 0)
(declare-sort var20 0)
(declare-sort var926 0)
(declare-sort var1967 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1658_from/-1251202111 (var2799) var1658)
(declare-fun toString/1090915316 (var185) String)
(declare-fun addParameterIfAbsent/-1295735773 (var1658 String String) var1658)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/1929860173 (var1658 String String) var1658)
(declare-fun build/935716095 (var1658) var3398)
(declare-fun getParameter/506106603 (var2799 String String) String)
(declare-fun cast-from-var3398-to-var2799 (var3398) var2799)
(declare-fun var3730_isNotEmpty/-1251449450 (String) Bool)
(declare-fun requestHandler/91014847 (var46) var2578)
(declare-fun var20-init () var20)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var926) String)
(declare-fun cast-from-var3398-to-var926 (var3398) var926)
(declare-fun getMessage/849299655 (var1967) String)
(declare-fun cast-from-var3570-to-var1967 (var3570) var1967)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var20 String var1967) void)
(declare-const null-var46 var46)
(declare-const null-var2799 var2799)
(declare-const var185-TRUE var185)
(declare-const null-var3570 var3570)
(declare-const var367 var46) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol 
(assert (not (= var367 null-var46)))
(declare-const var343 var2799) ; Statement: r36 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var343 null-var2799)))
(define-const var2537 var1658 (var1658_from/-1251202111 var343)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder 'from'(org.apache.dubbo.common.URL)>(r36) 
(define-const var1517 var185 var185-TRUE) ; Statement: $r0 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var1189 String (toString/1090915316 var1517)) ; Statement: $r1 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>() 
(assert true)
(define-const var3415 var1658 (addParameterIfAbsent/-1295735773 var2537 "channel.readonly.sent" var1189)) ; Statement: $r4 = virtualinvoke $r2.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameterIfAbsent(java.lang.String,java.lang.String)>("channel.readonly.sent", $r1) 
(define-const var2791 Int (cast-from-Int-to-Int 60000)) ; Statement: $i1 = (int) 60000 
(define-const var3621 String (String_valueOf/1240665136 var2791)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var959 var1658 (addParameterIfAbsent/-1295735773 var3415 "heartbeat" var3621)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameterIfAbsent(java.lang.String,java.lang.String)>("heartbeat", $r3) 
(assert true)
(define-const var3029 var1658 (addParameter/1929860173 var959 "codec" "dubbo")) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>("codec", "dubbo") 
(assert true)
(define-const var2670 var3398 (build/935716095 var3029)) ; Statement: r37 = virtualinvoke $r6.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.url.component.ServiceConfigURL build()>() 
(assert true)
(define-const var3595 String (getParameter/506106603 (cast-from-var3398-to-var2799 var2670) "server" "netty")) ; Statement: r38 = virtualinvoke r37.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("server", "netty") 
(define-const var2268 Bool (var3730_isNotEmpty/-1251449450 var3595)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r38) 
 ; Statement: if $z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.remoting.exchange.ExchangeHandler requestHandler> 
(assert (= (ite var2268 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3009 var2578 (requestHandler/91014847 var367)) ; Statement: $r8 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.remoting.exchange.ExchangeHandler requestHandler> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2499 var3570) ; Statement: $r27 := @caughtexception 
(assert (not (= var2499 null-var3570)))
(define-const var1408 var20 var20-init) ; Statement: $r43 = new org.apache.dubbo.rpc.RpcException 
(define-const var2716 String String-init) ; Statement: $r42 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2716)) ; Statement: specialinvoke $r42.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2716!1 String)
(assert (= var2716!1 ""))
(assert true)
(define-const var3877 String (append/672562846 var2716!1 "Fail to start server(url: ")) ; Statement: $r30 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to start server(url: ") 
(declare-const var2716!2 String)
(assert (= var2716!2 (str.++ var2716!1 "Fail to start server(url: ")))
(assert true)
(define-const var2351 String (append/-1031950772 var3877 (cast-from-var3398-to-var926 var2670))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r37) 
(declare-const var3877!1 String)
(assert (str.prefixof var3877 var3877!1))
(assert true)
(define-const var1486 String (append/672562846 var2351 ") ")) ; Statement: $r33 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var2351!1 String)
(assert (= var2351!1 (str.++ var2351 ") ")))
(assert true)
(define-const var1602 String (getMessage/849299655 (cast-from-var3570-to-var1967 var2499))) ; Statement: $r32 = virtualinvoke $r27.<org.apache.dubbo.remoting.RemotingException: java.lang.String getMessage()>() 
(assert true)
(define-const var617 String (append/672562846 var1486 var1602)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r32) 
(declare-const var1486!1 String)
(assert (= var1486!1 (str.++ var1486 var1602)))
(assert true)
(define-const var204 String (toString/-2075883882 var617)) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var1408 var204 (cast-from-var3570-to-var1967 var2499))) ; Statement: specialinvoke $r43.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r35, $r27) 

(declare-const var1408!1 var20)
(declare-const var204!1 String)
(declare-const var2499!1 var3570)
 ; Statement: throw $r43 
(check-sat)
; {var1658_from/-1251202111=([org.apache.dubbo.common.URL], org.apache.dubbo.common.URLBuilder), toString/1090915316=([java.lang.Boolean], java.lang.String), addParameterIfAbsent/-1295735773=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder), cast-from-Int-to-Int=([int], int), String_valueOf/1240665136=([int], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder), build/935716095=([org.apache.dubbo.common.URLBuilder], org.apache.dubbo.common.url.component.ServiceConfigURL), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), cast-from-var3398-to-var2799=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), var3730_isNotEmpty/-1251449450=([java.lang.String], boolean), requestHandler/91014847=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], org.apache.dubbo.remoting.exchange.ExchangeHandler), var20-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3398-to-var926=([org.apache.dubbo.common.url.component.ServiceConfigURL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3570-to-var1967=([org.apache.dubbo.remoting.RemotingException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var46=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var367=r7, var2799=org.apache.dubbo.common.URL, var343=r36, var1658=org.apache.dubbo.common.URLBuilder, var2537=$r2, var185=java.lang.Boolean, var1517=$r0, var1189=$r1, var3415=$r4, var2791=$i1, var3621=$r3, var959=$r5, var3029=$r6, var3398=org.apache.dubbo.common.url.component.ServiceConfigURL, var2670=r37, var3595=r38, var3730=org.apache.dubbo.common.utils.StringUtils, var2268=$z0, var2578=org.apache.dubbo.remoting.exchange.ExchangeHandler, var3009=$r8, var3570=org.apache.dubbo.remoting.RemotingException, var2499=$r27, var20=org.apache.dubbo.rpc.RpcException, var1408=$r43, var2716=$r42, var3877=$r30, var926=java.lang.Object, var2351=$r31, var1486=$r33, var1967=java.lang.Throwable, var1602=$r32, var617=$r34, var204=$r35}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var46, r7=var367, org.apache.dubbo.common.URL=var2799, r36=var343, org.apache.dubbo.common.URLBuilder=var1658, $r2=var2537, java.lang.Boolean=var185, $r0=var1517, $r1=var1189, $r4=var3415, $i1=var2791, $r3=var3621, $r5=var959, $r6=var3029, org.apache.dubbo.common.url.component.ServiceConfigURL=var3398, r37=var2670, r38=var3595, org.apache.dubbo.common.utils.StringUtils=var3730, $z0=var2268, org.apache.dubbo.remoting.exchange.ExchangeHandler=var2578, $r8=var3009, org.apache.dubbo.remoting.RemotingException=var3570, $r27=var2499, org.apache.dubbo.rpc.RpcException=var20, $r43=var1408, $r42=var2716, $r30=var3877, java.lang.Object=var926, $r31=var2351, $r33=var1486, java.lang.Throwable=var1967, $r32=var1602, $r34=var617, $r35=var204}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol;	r36 := @parameter0: org.apache.dubbo.common.URL;	$r2 = staticinvoke <org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder 'from'(org.apache.dubbo.common.URL)>(r36);	$r0 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r1 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>();	$r4 = virtualinvoke $r2.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameterIfAbsent(java.lang.String,java.lang.String)>("channel.readonly.sent", $r1);	$i1 = (int) 60000;	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameterIfAbsent(java.lang.String,java.lang.String)>("heartbeat", $r3);	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>("codec", "dubbo");	r37 = virtualinvoke $r6.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.url.component.ServiceConfigURL build()>();	r38 = virtualinvoke r37.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("server", "netty");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r38);	if $z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.remoting.exchange.ExchangeHandler requestHandler>;	$r8 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.remoting.exchange.ExchangeHandler requestHandler>;	$r27 := @caughtexception;	$r43 = new org.apache.dubbo.rpc.RpcException;	$r42 = new java.lang.StringBuilder;	specialinvoke $r42.<java.lang.StringBuilder: void <init>()>();	$r30 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to start server(url: ");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r37);	$r33 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r32 = virtualinvoke $r27.<org.apache.dubbo.remoting.RemotingException: java.lang.String getMessage()>();	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r32);	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r43.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r35, $r27);	throw $r43
;block_num 3