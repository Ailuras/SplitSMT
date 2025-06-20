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

(declare-sort var1703 0)
(declare-sort var2918 0)
(declare-sort var2104 0)
(declare-sort var3311 0)
(declare-sort var292 0)
(declare-sort var863 0)
(declare-sort var3950 0)
(declare-sort var465 0)
(declare-sort var3954 0)
(declare-sort var961 0)
(declare-sort var2342 0)
(declare-sort var297 0)
(declare-sort var1099 0)
(declare-sort var936 0)
(declare-sort var2199 0)
(declare-sort var3115 0)
(declare-sort var2940 0)
(declare-sort var1152 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2918-to-var2104 (var2918) var2104)
(declare-fun var3311_getMethodName/-516674313 (var2918) String)
(declare-fun getUrl/-945338117 (var863) var292)
(declare-fun cast-from-var1703-to-var863 (var1703) var863)
(declare-fun getPath/898047937 (var292) String)
(declare-fun setAttachment/548019834 (var2104 String String) void)
(declare-fun version/372342001 (var863) String)
(declare-fun clientsProvider/-221711885 (var1703) var3950)
(declare-fun var3950_getClients/1571454421 (var3950) var465)
(declare-fun var465_size/-959786421 (var465) Int)
(declare-fun index/-221711885 (var1703) var3954)
(declare-fun getAndIncrement/701561674 (var3954) Int)
(declare-fun var465_get/-1216255739 (var465 Int) var961)
(declare-fun cast-from-var961-to-var2342 (var961) var2342)
(declare-fun var1099_getServiceContext/735675290 () var297)
(declare-fun var2199_getLocalAddress/2019899378 (var2199) var936)
(declare-fun cast-from-var2342-to-var2199 (var2342) var2199)
(declare-fun setLocalAddress/-1391674272 (var297 var936) var297)
(declare-fun var2940-init () var2940)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var961) String)
(declare-fun cast-from-var292-to-var961 (var292) var961)
(declare-fun getMessage/849299655 (var1152) String)
(declare-fun cast-from-var3115-to-var1152 (var3115) var1152)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/456387396 (var2940 Int String var1152) void)
(declare-const null-var1703 var1703)
(declare-const null-var2918 var2918)
(declare-const null-var3115 var3115)
(declare-const var3738 var1703) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker 
(assert (not (= var3738 null-var1703)))
(declare-const var1117 var2918) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1117 null-var2918)))
(define-const var3837 var2104 (cast-from-var2918-to-var2104 var1117)) ; Statement: r1 = (org.apache.dubbo.rpc.RpcInvocation) r0 
(define-const var1606 String (var3311_getMethodName/-516674313 var1117)) ; Statement: r2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert true)
(define-const var2806 var292 (getUrl/-945338117 (cast-from-var1703-to-var863 var3738))) ; Statement: $r4 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1943 String (getPath/898047937 var2806)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
;(assert (setAttachment/548019834 var3837 "path" var1943)) ; Statement: virtualinvoke r1.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>("path", $r5) 

(declare-const var3837!1 var2104)
(declare-const var3802 String)
(declare-const var1943!1 String)
(define-const var2124 String (version/372342001 (cast-from-var1703-to-var863 var3738))) ; Statement: $r6 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: java.lang.String version> 
(assert true)
;(assert (setAttachment/548019834 var3837!1 "version" var2124)) ; Statement: virtualinvoke r1.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>("version", $r6) 

(declare-const var3837!2 var2104)
(declare-const var3368 String)
(declare-const var2124!1 String)
(define-const var1976 var3950 (clientsProvider/-221711885 var3738)) ; Statement: $r7 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider clientsProvider> 
(define-const var197 var465 (var3950_getClients/1571454421 var1976)) ; Statement: r8 = interfaceinvoke $r7.<org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider: java.util.List getClients()>() 
(define-const var2778 Int (var465_size/-959786421 var197)) ; Statement: $i0 = interfaceinvoke r8.<java.util.List: int size()>() 
 ; Statement: if $i0 != 1 goto $r9 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.utils.AtomicPositiveInteger index> 
(assert (not (= var2778 1))) ; Cond: $i0 != 1 
(define-const var3531 var3954 (index/-221711885 var3738)) ; Statement: $r9 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.utils.AtomicPositiveInteger index> 
(assert true)
(define-const var3745 Int (getAndIncrement/701561674 var3531)) ; Statement: $i2 = virtualinvoke $r9.<org.apache.dubbo.common.utils.AtomicPositiveInteger: int getAndIncrement()>() 
(define-const var1385 Int (var465_size/-959786421 var197)) ; Statement: $i1 = interfaceinvoke r8.<java.util.List: int size()>() 
(define-const var2261 Int (mod var3745 var1385)) ; Statement: $i3 = $i2 % $i1 
(define-const var456 var961 (var465_get/-1216255739 var197 var2261)) ; Statement: $r10 = interfaceinvoke r8.<java.util.List: java.lang.Object get(int)>($i3) 
(define-const var2560 var2342 (cast-from-var961-to-var2342 var456)) ; Statement: r72 = (org.apache.dubbo.remoting.exchange.ExchangeClient) $r10 
(assert true) ; Non Conditional
(define-const var3199 var297 var1099_getServiceContext/735675290) ; Statement: $r12 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(define-const var271 var936 (var2199_getLocalAddress/2019899378 (cast-from-var2342-to-var2199 var2560))) ; Statement: $r11 = interfaceinvoke r72.<org.apache.dubbo.remoting.exchange.ExchangeClient: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
;(assert (setLocalAddress/-1391674272 var3199 var271)) ; Statement: virtualinvoke $r12.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setLocalAddress(java.net.InetSocketAddress)>($r11) 

(declare-const var3199!1 var297)
(declare-const var271!1 var936)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3654 var3115) ; Statement: $r59 := @caughtexception 
(assert (not (= var3654 null-var3115)))
(define-const var1205 var2940 var2940-init) ; Statement: $r60 = new org.apache.dubbo.rpc.RpcException 
(define-const var1359 String String-init) ; Statement: $r61 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1359)) ; Statement: specialinvoke $r61.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1359!1 String)
(assert (= var1359!1 ""))
(assert true)
(define-const var2867 String (append/672562846 var1359!1 "Invoke remote method timeout. method: ")) ; Statement: $r63 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invoke remote method timeout. method: ") 
(declare-const var1359!2 String)
(assert (= var1359!2 (str.++ var1359!1 "Invoke remote method timeout. method: ")))
(define-const var3543 String (var3311_getMethodName/-516674313 var1117)) ; Statement: $r62 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert true)
(define-const var3381 String (append/672562846 var2867 var3543)) ; Statement: $r64 = virtualinvoke $r63.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var2867!1 String)
(assert (= var2867!1 (str.++ var2867 var3543)))
(assert true)
(define-const var2743 String (append/672562846 var3381 ", provider: ")) ; Statement: $r66 = virtualinvoke $r64.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", provider: ") 
(declare-const var3381!1 String)
(assert (= var3381!1 (str.++ var3381 ", provider: ")))
(assert true)
(define-const var1238 var292 (getUrl/-945338117 (cast-from-var1703-to-var863 var3738))) ; Statement: $r65 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var659 String (append/-1031950772 var2743 (cast-from-var292-to-var961 var1238))) ; Statement: $r67 = virtualinvoke $r66.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r65) 
(declare-const var2743!1 String)
(assert (str.prefixof var2743 var2743!1))
(assert true)
(define-const var157 String (append/672562846 var659 ", cause: ")) ; Statement: $r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var659!1 String)
(assert (= var659!1 (str.++ var659 ", cause: ")))
(assert true)
(define-const var2894 String (getMessage/849299655 (cast-from-var3115-to-var1152 var3654))) ; Statement: $r68 = virtualinvoke $r59.<org.apache.dubbo.remoting.TimeoutException: java.lang.String getMessage()>() 
(assert true)
(define-const var2732 String (append/672562846 var157 var2894)) ; Statement: $r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68) 
(declare-const var157!1 String)
(assert (= var157!1 (str.++ var157 var2894)))
(assert true)
(define-const var1690 String (toString/-2075883882 var2732)) ; Statement: $r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/456387396 var1205 2 var1690 (cast-from-var3115-to-var1152 var3654))) ; Statement: specialinvoke $r60.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(2, $r71, $r59) 

(declare-const var1205!1 var2940)
(declare-const var554 Int)
(declare-const var1690!1 String)
(declare-const var3654!1 var3115)
 ; Statement: throw $r60 
(check-sat)
; {cast-from-var2918-to-var2104=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.RpcInvocation), var3311_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), cast-from-var1703-to-var863=([org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker], org.apache.dubbo.rpc.protocol.AbstractInvoker), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), setAttachment/548019834=([org.apache.dubbo.rpc.RpcInvocation, java.lang.String, java.lang.String], void), version/372342001=([org.apache.dubbo.rpc.protocol.AbstractInvoker], java.lang.String), clientsProvider/-221711885=([org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker], org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider), var3950_getClients/1571454421=([org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider], java.util.List), var465_size/-959786421=([java.util.List], int), index/-221711885=([org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker], org.apache.dubbo.common.utils.AtomicPositiveInteger), getAndIncrement/701561674=([org.apache.dubbo.common.utils.AtomicPositiveInteger], int), var465_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var961-to-var2342=([java.lang.Object], org.apache.dubbo.remoting.exchange.ExchangeClient), var1099_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), var2199_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var2342-to-var2199=([org.apache.dubbo.remoting.exchange.ExchangeClient], org.apache.dubbo.remoting.Endpoint), setLocalAddress/-1391674272=([org.apache.dubbo.rpc.RpcServiceContext, java.net.InetSocketAddress], org.apache.dubbo.rpc.RpcServiceContext), var2940-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var292-to-var961=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3115-to-var1152=([org.apache.dubbo.remoting.TimeoutException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/456387396=([org.apache.dubbo.rpc.RpcException, int, java.lang.String, java.lang.Throwable], void)}
; {var1703=org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker, var3738=r3, var2918=org.apache.dubbo.rpc.Invocation, var1117=r0, var2104=org.apache.dubbo.rpc.RpcInvocation, var3837=r1, var3311=org.apache.dubbo.rpc.support.RpcUtils, var1606=r2, var292=org.apache.dubbo.common.URL, var863=org.apache.dubbo.rpc.protocol.AbstractInvoker, var2806=$r4, var1943=$r5, var3802="path", var2124=$r6, var3368="version", var3950=org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider, var1976=$r7, var465=java.util.List, var197=r8, var2778=$i0, var3954=org.apache.dubbo.common.utils.AtomicPositiveInteger, var3531=$r9, var3745=$i2, var1385=$i1, var2261=$i3, var961=java.lang.Object, var456=$r10, var2342=org.apache.dubbo.remoting.exchange.ExchangeClient, var2560=r72, var297=org.apache.dubbo.rpc.RpcServiceContext, var1099=org.apache.dubbo.rpc.RpcContext, var3199=$r12, var936=java.net.InetSocketAddress, var2199=org.apache.dubbo.remoting.Endpoint, var271=$r11, var3115=org.apache.dubbo.remoting.TimeoutException, var3654=$r59, var2940=org.apache.dubbo.rpc.RpcException, var1205=$r60, var1359=$r61, var2867=$r63, var3543=$r62, var3381=$r64, var2743=$r66, var1238=$r65, var659=$r67, var157=$r69, var1152=java.lang.Throwable, var2894=$r68, var2732=$r70, var1690=$r71, var554=2}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker=var1703, r3=var3738, org.apache.dubbo.rpc.Invocation=var2918, r0=var1117, org.apache.dubbo.rpc.RpcInvocation=var2104, r1=var3837, org.apache.dubbo.rpc.support.RpcUtils=var3311, r2=var1606, org.apache.dubbo.common.URL=var292, org.apache.dubbo.rpc.protocol.AbstractInvoker=var863, $r4=var2806, $r5=var1943, "path"=var3802, $r6=var2124, "version"=var3368, org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider=var3950, $r7=var1976, java.util.List=var465, r8=var197, $i0=var2778, org.apache.dubbo.common.utils.AtomicPositiveInteger=var3954, $r9=var3531, $i2=var3745, $i1=var1385, $i3=var2261, java.lang.Object=var961, $r10=var456, org.apache.dubbo.remoting.exchange.ExchangeClient=var2342, r72=var2560, org.apache.dubbo.rpc.RpcServiceContext=var297, org.apache.dubbo.rpc.RpcContext=var1099, $r12=var3199, java.net.InetSocketAddress=var936, org.apache.dubbo.remoting.Endpoint=var2199, $r11=var271, org.apache.dubbo.remoting.TimeoutException=var3115, $r59=var3654, org.apache.dubbo.rpc.RpcException=var2940, $r60=var1205, $r61=var1359, $r63=var2867, $r62=var3543, $r64=var3381, $r66=var2743, $r65=var1238, $r67=var659, $r69=var157, java.lang.Throwable=var1152, $r68=var2894, $r70=var2732, $r71=var1690, 2=var554}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	r1 = (org.apache.dubbo.rpc.RpcInvocation) r0;	r2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r4 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	virtualinvoke r1.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>("path", $r5);	$r6 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: java.lang.String version>;	virtualinvoke r1.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>("version", $r6);	$r7 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider clientsProvider>;	r8 = interfaceinvoke $r7.<org.apache.dubbo.rpc.protocol.dubbo.ClientsProvider: java.util.List getClients()>();	$i0 = interfaceinvoke r8.<java.util.List: int size()>();	if $i0 != 1 goto $r9 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.utils.AtomicPositiveInteger index>;	$r9 = r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.utils.AtomicPositiveInteger index>;	$i2 = virtualinvoke $r9.<org.apache.dubbo.common.utils.AtomicPositiveInteger: int getAndIncrement()>();	$i1 = interfaceinvoke r8.<java.util.List: int size()>();	$i3 = $i2 % $i1;	$r10 = interfaceinvoke r8.<java.util.List: java.lang.Object get(int)>($i3);	r72 = (org.apache.dubbo.remoting.exchange.ExchangeClient) $r10;	$r12 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r11 = interfaceinvoke r72.<org.apache.dubbo.remoting.exchange.ExchangeClient: java.net.InetSocketAddress getLocalAddress()>();	virtualinvoke $r12.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setLocalAddress(java.net.InetSocketAddress)>($r11);	$r59 := @caughtexception;	$r60 = new org.apache.dubbo.rpc.RpcException;	$r61 = new java.lang.StringBuilder;	specialinvoke $r61.<java.lang.StringBuilder: void <init>()>();	$r63 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invoke remote method timeout. method: ");	$r62 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r64 = virtualinvoke $r63.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	$r66 = virtualinvoke $r64.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", provider: ");	$r65 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.dubbo.DubboInvoker: org.apache.dubbo.common.URL getUrl()>();	$r67 = virtualinvoke $r66.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r65);	$r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r68 = virtualinvoke $r59.<org.apache.dubbo.remoting.TimeoutException: java.lang.String getMessage()>();	$r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68);	$r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r60.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(2, $r71, $r59);	throw $r60
;block_num 4