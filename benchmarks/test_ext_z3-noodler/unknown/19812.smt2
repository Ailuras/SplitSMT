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

(declare-sort var2830 0)
(declare-sort var1992 0)
(declare-sort var1039 0)
(declare-sort var3141 0)
(declare-sort var842 0)
(declare-sort var839 0)
(declare-sort var3603 0)
(declare-sort var54 0)
(declare-sort var1972 0)
(declare-sort var943 0)
(declare-sort var1434 0)
(declare-sort var2835 0)
(declare-sort var3224 0)
(declare-sort var2942 0)
(declare-sort var1097 0)
(declare-sort var3700 0)
(declare-sort var2759 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1992-to-var1039 (var1992) var1039)
(declare-fun var3141_getMethodName/-516674313 (var1992) String)
(declare-fun getUrl/-945338117 (var839) var842)
(declare-fun cast-from-var2830-to-var839 (var2830) var839)
(declare-fun getPath/898047937 (var842) String)
(declare-fun setAttachment/548019834 (var1039 String String) void)
(declare-fun version/372342001 (var839) String)
(declare-fun clientsProvider/-221711885 (var2830) var3603)
(declare-fun var3603_getClients/1571454421 (var3603) var54)
(declare-fun var54_size/-959786421 (var54) Int)
(declare-fun var54_get/-1216255739 (var54 Int) var1972)
(declare-fun cast-from-var1972-to-var943 (var1972) var943)
(declare-fun var2835_getServiceContext/735675290 () var1434)
(declare-fun var2942_getLocalAddress/2019899378 (var2942) var3224)
(declare-fun cast-from-var943-to-var2942 (var943) var2942)
(declare-fun setLocalAddress/-1391674272 (var1434 var3224) var1434)
(declare-fun var3700-init () var3700)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1972) String)
(declare-fun cast-from-var842-to-var1972 (var842) var1972)
(declare-fun getMessage/849299655 (var2759) String)
(declare-fun cast-from-var1097-to-var2759 (var1097) var2759)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/456387396 (var3700 Int String var2759) void)
(declare-const null-var2830 var2830)
(declare-const null-var1992 var1992)
(declare-const null-var1097 var1097)
(declare-const var3196 var2830) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker 
(assert (not (= var3196 null-var2830)))
(declare-const var3081 var1992) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3081 null-var1992)))
(define-const var3447 var1039 (cast-from-var1992-to-var1039 var3081)) ; Statement: r1 = (org.apache.dubbo.rpc.RpcInvocation) r0 
(define-const var327 String (var3141_getMethodName/-516674313 var3081)) ; Statement: r2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert true)
(define-const var1884 var842 (getUrl/-945338117 (cast-from-var2830-to-var839 var3196))) ; Statement: $r4 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2642 String (getPath/898047937 var1884)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
;(assert (setAttachment/548019834 var3447 "path" var2642)) ; Statement: virtualinvoke r1.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>("path", $r5) 

(declare-const var3447!1 var1039)
(declare-const var1678 String)
(declare-const var2642!1 String)
(define-const var3848 String (version/372342001 (cast-from-var2830-to-var839 var3196))) ; Statement: $r6 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: java.lang.String version> 
(assert true)
;(assert (setAttachment/548019834 var3447!1 "version" var3848)) ; Statement: virtualinvoke r1.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>("version", $r6) 

(declare-const var3447!2 var1039)
(declare-const var1534 String)
(declare-const var3848!1 String)
(define-const var1269 var3603 (clientsProvider/-221711885 var3196)) ; Statement: $r7 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider clientsProvider> 
(define-const var1661 var54 (var3603_getClients/1571454421 var1269)) ; Statement: r8 = interfaceinvoke $r7.<org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider: java.util.List getClients()>() 
(define-const var3777 Int (var54_size/-959786421 var1661)) ; Statement: $i0 = interfaceinvoke r8.<java.util.List: int size()>() 
 ; Statement: if $i0 != 1 goto $r9 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.utils.AtomicPositiveInteger index> 
(assert (not (not (= var3777 1)))) ; Negate: Cond: $i0 != 1  
(define-const var143 var1972 (var54_get/-1216255739 var1661 0)) ; Statement: $r42 = interfaceinvoke r8.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var3231 var943 (cast-from-var1972-to-var943 var143)) ; Statement: r72 = (org.apache.dubbo.remoting.exchange.ExchangeClient) $r42 
 ; Statement: goto [?= $r12 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>()] 
(assert true) ; Non Conditional
(define-const var2767 var1434 var2835_getServiceContext/735675290) ; Statement: $r12 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(define-const var3888 var3224 (var2942_getLocalAddress/2019899378 (cast-from-var943-to-var2942 var3231))) ; Statement: $r11 = interfaceinvoke r72.<org.apache.dubbo.remoting.exchange.ExchangeClient: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
;(assert (setLocalAddress/-1391674272 var2767 var3888)) ; Statement: virtualinvoke $r12.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setLocalAddress(java.net.InetSocketAddress)>($r11) 

(declare-const var2767!1 var1434)
(declare-const var3888!1 var3224)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1438 var1097) ; Statement: $r59 := @caughtexception 
(assert (not (= var1438 null-var1097)))
(define-const var1242 var3700 var3700-init) ; Statement: $r60 = new org.apache.dubbo.rpc.RpcException 
(define-const var2468 String String-init) ; Statement: $r61 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2468)) ; Statement: specialinvoke $r61.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2468!1 String)
(assert (= var2468!1 ""))
(assert true)
(define-const var259 String (append/672562846 var2468!1 "Invoke remote method timeout. method: ")) ; Statement: $r63 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invoke remote method timeout. method: ") 
(declare-const var2468!2 String)
(assert (= var2468!2 (str.++ var2468!1 "Invoke remote method timeout. method: ")))
(define-const var3279 String (var3141_getMethodName/-516674313 var3081)) ; Statement: $r62 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert true)
(define-const var2920 String (append/672562846 var259 var3279)) ; Statement: $r64 = virtualinvoke $r63.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var259!1 String)
(assert (= var259!1 (str.++ var259 var3279)))
(assert true)
(define-const var3899 String (append/672562846 var2920 ", provider: ")) ; Statement: $r66 = virtualinvoke $r64.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", provider: ") 
(declare-const var2920!1 String)
(assert (= var2920!1 (str.++ var2920 ", provider: ")))
(assert true)
(define-const var2473 var842 (getUrl/-945338117 (cast-from-var2830-to-var839 var3196))) ; Statement: $r65 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3978 String (append/-1031950772 var3899 (cast-from-var842-to-var1972 var2473))) ; Statement: $r67 = virtualinvoke $r66.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r65) 
(declare-const var3899!1 String)
(assert (str.prefixof var3899 var3899!1))
(assert true)
(define-const var3462 String (append/672562846 var3978 ", cause: ")) ; Statement: $r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3978!1 String)
(assert (= var3978!1 (str.++ var3978 ", cause: ")))
(assert true)
(define-const var2599 String (getMessage/849299655 (cast-from-var1097-to-var2759 var1438))) ; Statement: $r68 = virtualinvoke $r59.<org.apache.dubbo.remoting.TimeoutException: java.lang.String getMessage()>() 
(assert true)
(define-const var3656 String (append/672562846 var3462 var2599)) ; Statement: $r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68) 
(declare-const var3462!1 String)
(assert (= var3462!1 (str.++ var3462 var2599)))
(assert true)
(define-const var2268 String (toString/-2075883882 var3656)) ; Statement: $r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/456387396 var1242 2 var2268 (cast-from-var1097-to-var2759 var1438))) ; Statement: specialinvoke $r60.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(2, $r71, $r59) 

(declare-const var1242!1 var3700)
(declare-const var2411 Int)
(declare-const var2268!1 String)
(declare-const var1438!1 var1097)
 ; Statement: throw $r60 
(check-sat)
; {cast-from-var1992-to-var1039=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.RpcInvocation), var3141_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), cast-from-var2830-to-var839=([org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker], org.apache.dubbo.rpc.protocol.AbstractInvoker), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), setAttachment/548019834=([org.apache.dubbo.rpc.RpcInvocation, java.lang.String, java.lang.String], void), version/372342001=([org.apache.dubbo.rpc.protocol.AbstractInvoker], java.lang.String), clientsProvider/-221711885=([org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker], org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider), var3603_getClients/1571454421=([org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider], java.util.List), var54_size/-959786421=([java.util.List], int), var54_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var1972-to-var943=([java.lang.Object], org.apache.dubbo.remoting.exchange.ExchangeClient), var2835_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), var2942_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var943-to-var2942=([org.apache.dubbo.remoting.exchange.ExchangeClient], org.apache.dubbo.remoting.Endpoint), setLocalAddress/-1391674272=([org.apache.dubbo.rpc.RpcServiceContext, java.net.InetSocketAddress], org.apache.dubbo.rpc.RpcServiceContext), var3700-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var842-to-var1972=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var1097-to-var2759=([org.apache.dubbo.remoting.TimeoutException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/456387396=([org.apache.dubbo.rpc.RpcException, int, java.lang.String, java.lang.Throwable], void)}
; {var2830=org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker, var3196=r3, var1992=org.apache.dubbo.rpc.Invocation, var3081=r0, var1039=org.apache.dubbo.rpc.RpcInvocation, var3447=r1, var3141=org.apache.dubbo.rpc.support.RpcUtils, var327=r2, var842=org.apache.dubbo.common.URL, var839=org.apache.dubbo.rpc.protocol.AbstractInvoker, var1884=$r4, var2642=$r5, var1678="path", var3848=$r6, var1534="version", var3603=org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider, var1269=$r7, var54=java.util.List, var1661=r8, var3777=$i0, var1972=java.lang.Object, var143=$r42, var943=org.apache.dubbo.remoting.exchange.ExchangeClient, var3231=r72, var1434=org.apache.dubbo.rpc.RpcServiceContext, var2835=org.apache.dubbo.rpc.RpcContext, var2767=$r12, var3224=java.net.InetSocketAddress, var2942=org.apache.dubbo.remoting.Endpoint, var3888=$r11, var1097=org.apache.dubbo.remoting.TimeoutException, var1438=$r59, var3700=org.apache.dubbo.rpc.RpcException, var1242=$r60, var2468=$r61, var259=$r63, var3279=$r62, var2920=$r64, var3899=$r66, var2473=$r65, var3978=$r67, var3462=$r69, var2759=java.lang.Throwable, var2599=$r68, var3656=$r70, var2268=$r71, var2411=2}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker=var2830, r3=var3196, org.apache.dubbo.rpc.Invocation=var1992, r0=var3081, org.apache.dubbo.rpc.RpcInvocation=var1039, r1=var3447, org.apache.dubbo.rpc.support.RpcUtils=var3141, r2=var327, org.apache.dubbo.common.URL=var842, org.apache.dubbo.rpc.protocol.AbstractInvoker=var839, $r4=var1884, $r5=var2642, "path"=var1678, $r6=var3848, "version"=var1534, org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider=var3603, $r7=var1269, java.util.List=var54, r8=var1661, $i0=var3777, java.lang.Object=var1972, $r42=var143, org.apache.dubbo.remoting.exchange.ExchangeClient=var943, r72=var3231, org.apache.dubbo.rpc.RpcServiceContext=var1434, org.apache.dubbo.rpc.RpcContext=var2835, $r12=var2767, java.net.InetSocketAddress=var3224, org.apache.dubbo.remoting.Endpoint=var2942, $r11=var3888, org.apache.dubbo.remoting.TimeoutException=var1097, $r59=var1438, org.apache.dubbo.rpc.RpcException=var3700, $r60=var1242, $r61=var2468, $r63=var259, $r62=var3279, $r64=var2920, $r66=var3899, $r65=var2473, $r67=var3978, $r69=var3462, java.lang.Throwable=var2759, $r68=var2599, $r70=var3656, $r71=var2268, 2=var2411}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	r1 = (org.apache.dubbo.rpc.RpcInvocation) r0;	r2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r4 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	virtualinvoke r1.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>("path", $r5);	$r6 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: java.lang.String version>;	virtualinvoke r1.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>("version", $r6);	$r7 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider clientsProvider>;	r8 = interfaceinvoke $r7.<org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider: java.util.List getClients()>();	$i0 = interfaceinvoke r8.<java.util.List: int size()>();	if $i0 != 1 goto $r9 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.utils.AtomicPositiveInteger index>;	$r42 = interfaceinvoke r8.<java.util.List: java.lang.Object get(int)>(0);	r72 = (org.apache.dubbo.remoting.exchange.ExchangeClient) $r42;	goto [?= $r12 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>()];	$r12 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r11 = interfaceinvoke r72.<org.apache.dubbo.remoting.exchange.ExchangeClient: java.net.InetSocketAddress getLocalAddress()>();	virtualinvoke $r12.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setLocalAddress(java.net.InetSocketAddress)>($r11);	$r59 := @caughtexception;	$r60 = new org.apache.dubbo.rpc.RpcException;	$r61 = new java.lang.StringBuilder;	specialinvoke $r61.<java.lang.StringBuilder: void <init>()>();	$r63 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invoke remote method timeout. method: ");	$r62 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r64 = virtualinvoke $r63.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	$r66 = virtualinvoke $r64.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", provider: ");	$r65 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.URL getUrl()>();	$r67 = virtualinvoke $r66.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r65);	$r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r68 = virtualinvoke $r59.<org.apache.dubbo.remoting.TimeoutException: java.lang.String getMessage()>();	$r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68);	$r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r60.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(2, $r71, $r59);	throw $r60
;block_num 4