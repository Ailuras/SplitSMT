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

(declare-sort var1626 0)
(declare-sort var2925 0)
(declare-sort var3837 0)
(declare-sort var3667 0)
(declare-sort var2511 0)
(declare-sort var3654 0)
(declare-sort var2748 0)
(declare-sort var886 0)
(declare-sort var2938 0)
(declare-sort var605 0)
(declare-sort var1306 0)
(declare-sort var2894 0)
(declare-sort var3638 0)
(declare-sort var3577 0)
(declare-sort var1705 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2511_getLocalAddress/2019899378 (var2511) var3667)
(declare-fun cast-from-var2925-to-var2511 (var2925) var2511)
(declare-fun getPort/-1397617271 (var3667) Int)
(declare-fun var3837_getObjectAttachmentWithoutConvert/-2125165309 (var3837 String) var3654)
(declare-fun cast-from-var3654-to-String (var3654) String)
(declare-fun toString/1090915316 (var2748) String)
(declare-fun isClientSide/776072184 (var1626 var2925) Bool)
(declare-fun var886_serviceKey/-263494211 (Int String String String) String)
(declare-fun exporterMap/1326816129 (var886) var2938)
(declare-fun cast-from-var1626-to-var886 (var1626) var886)
(declare-fun var2938_get/1088891777 (var2938 var3654) var3654)
(declare-fun cast-from-String-to-var3654 (String) var3654)
(declare-fun cast-from-var3654-to-var605 (var3654) var605)
(declare-fun getInvoker/401378288 (var2894) var1306)
(declare-fun cast-from-var605-to-var2894 (var605) var2894)
(declare-fun var3577_getUrl/-275947851 (var3577) var3638)
(declare-fun cast-from-var1306-to-var3577 (var1306) var3577)
(declare-fun getServiceModel/-1482396633 (var3638) var1705)
(declare-fun var3837_setServiceModel/504998696 (var3837 var1705) void)
(declare-const null-var1626 var1626)
(declare-const null-var2925 var2925)
(declare-const null-var3837 var3837)
(declare-const var2748-TRUE var2748)
(declare-const null-var605 var605)
(declare-const var994 var1626) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol 
(assert (not (= var994 null-var1626)))
(declare-const var779 var2925) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var779 null-var2925)))
(declare-const var222 var3837) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var222 null-var3837)))
(define-const var2951 var3667 (var2511_getLocalAddress/2019899378 (cast-from-var2925-to-var2511 var779))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var238 Int (getPort/-1397617271 var2951)) ; Statement: i0 = virtualinvoke $r1.<java.net.InetSocketAddress: int getPort()>() 
(define-const var3424 var3654 (var3837_getObjectAttachmentWithoutConvert/-2125165309 var222 "path")) ; Statement: $r3 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("path") 
(define-const var1198 String (cast-from-var3654-to-String var3424)) ; Statement: r44 = (java.lang.String) $r3 
(define-const var1990 var2748 var2748-TRUE) ; Statement: $r4 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var1446 String (toString/1090915316 var1990)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>() 
(define-const var2574 var3654 (var3837_getObjectAttachmentWithoutConvert/-2125165309 var222 "dubbo.stub.event")) ; Statement: $r5 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("dubbo.stub.event") 
(assert true)
(define-const var3542 Bool false) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $z1 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: boolean isClientSide(org.apache.dubbo.remoting.Channel)>(r0) 
(assert (= (ite var3542 1 0) 0)) ; Cond: z0 == 0 
(assert true)
(define-const var3101 Bool (isClientSide/776072184 var994 var779)) ; Statement: $z1 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: boolean isClientSide(org.apache.dubbo.remoting.Channel)>(r0) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var3101 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1082 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: if $z2 == 0 goto $r8 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version") 
(assert (= (ite var1082 1 0) 0)) ; Cond: $z2 == 0 
(define-const var3313 var3654 (var3837_getObjectAttachmentWithoutConvert/-2125165309 var222 "version")) ; Statement: $r8 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version") 
(define-const var2006 String (cast-from-var3654-to-String var3313)) ; Statement: $r11 = (java.lang.String) $r8 
(define-const var1107 var3654 (var3837_getObjectAttachmentWithoutConvert/-2125165309 var222 "group")) ; Statement: $r9 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(define-const var1146 String (cast-from-var3654-to-String var1107)) ; Statement: $r10 = (java.lang.String) $r9 
(define-const var1792 String (var886_serviceKey/-263494211 var238 var1198 var2006 var1146)) ; Statement: $r42 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.lang.String serviceKey(int,java.lang.String,java.lang.String,java.lang.String)>(i0, r44, $r11, $r10) 
(define-const var3507 var2938 (exporterMap/1326816129 (cast-from-var1626-to-var886 var994))) ; Statement: $r12 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.Map exporterMap> 
(define-const var3078 var3654 (var2938_get/1088891777 var3507 (cast-from-String-to-var3654 var1792))) ; Statement: $r13 = interfaceinvoke $r12.<java.util.Map: java.lang.Object get(java.lang.Object)>($r42) 
(define-const var1331 var605 (cast-from-var3654-to-var605 var3078)) ; Statement: $r43 = (org.apache.dubbo.rpc.protocol.dubbo.DubboExporter) $r13 
 ; Statement: if $r43 != null goto r14 = virtualinvoke $r43.<org.apache.dubbo.rpc.protocol.dubbo.DubboExporter: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(assert (not (= var1331 null-var605))) ; Cond: $r43 != null 
(assert true)
(define-const var383 var1306 (getInvoker/401378288 (cast-from-var605-to-var2894 var1331))) ; Statement: r14 = virtualinvoke $r43.<org.apache.dubbo.rpc.protocol.dubbo.DubboExporter: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(define-const var3405 var3638 (var3577_getUrl/-275947851 (cast-from-var1306-to-var3577 var383))) ; Statement: $r15 = interfaceinvoke r14.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1268 var1705 (getServiceModel/-1482396633 var3405)) ; Statement: $r16 = virtualinvoke $r15.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
;(assert (var3837_setServiceModel/504998696 var222 var1268)) ; Statement: interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r16) 

(declare-const var222!1 var3837)
(declare-const var1268!1 var1705)
 ; Statement: return r14 
(check-sat)
; {var2511_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var2925-to-var2511=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getPort/-1397617271=([java.net.InetSocketAddress], int), var3837_getObjectAttachmentWithoutConvert/-2125165309=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.Object), cast-from-var3654-to-String=([java.lang.Object], java.lang.String), toString/1090915316=([java.lang.Boolean], java.lang.String), isClientSide/776072184=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, org.apache.dubbo.remoting.Channel], boolean), var886_serviceKey/-263494211=([int, java.lang.String, java.lang.String, java.lang.String], java.lang.String), exporterMap/1326816129=([org.apache.dubbo.rpc.protocol.AbstractProtocol], java.util.Map), cast-from-var1626-to-var886=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], org.apache.dubbo.rpc.protocol.AbstractProtocol), var2938_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3654=([java.lang.String], java.lang.Object), cast-from-var3654-to-var605=([java.lang.Object], org.apache.dubbo.rpc.protocol.dubbo.DubboExporter), getInvoker/401378288=([org.apache.dubbo.rpc.protocol.AbstractExporter], org.apache.dubbo.rpc.Invoker), cast-from-var605-to-var2894=([org.apache.dubbo.rpc.protocol.dubbo.DubboExporter], org.apache.dubbo.rpc.protocol.AbstractExporter), var3577_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1306-to-var3577=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceModel/-1482396633=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ServiceModel), var3837_setServiceModel/504998696=([org.apache.dubbo.rpc.Invocation, org.apache.dubbo.rpc.model.ServiceModel], void)}
; {var1626=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var994=r7, var2925=org.apache.dubbo.remoting.Channel, var779=r0, var3837=org.apache.dubbo.rpc.Invocation, var222=r2, var3667=java.net.InetSocketAddress, var2511=org.apache.dubbo.remoting.Endpoint, var2951=$r1, var238=i0, var3654=java.lang.Object, var3424=$r3, var1198=r44, var2748=java.lang.Boolean, var1990=$r4, var1446=$r6, var2574=$r5, var3542=z0, var3101=$z1, var1082=$z2, var3313=$r8, var2006=$r11, var1107=$r9, var1146=$r10, var886=org.apache.dubbo.rpc.protocol.AbstractProtocol, var1792=$r42, var2938=java.util.Map, var3507=$r12, var3078=$r13, var605=org.apache.dubbo.rpc.protocol.dubbo.DubboExporter, var1331=$r43, var1306=org.apache.dubbo.rpc.Invoker, var2894=org.apache.dubbo.rpc.protocol.AbstractExporter, var383=r14, var3638=org.apache.dubbo.common.URL, var3577=org.apache.dubbo.common.Node, var3405=$r15, var1705=org.apache.dubbo.rpc.model.ServiceModel, var1268=$r16}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var1626, r7=var994, org.apache.dubbo.remoting.Channel=var2925, r0=var779, org.apache.dubbo.rpc.Invocation=var3837, r2=var222, java.net.InetSocketAddress=var3667, org.apache.dubbo.remoting.Endpoint=var2511, $r1=var2951, i0=var238, java.lang.Object=var3654, $r3=var3424, r44=var1198, java.lang.Boolean=var2748, $r4=var1990, $r6=var1446, $r5=var2574, z0=var3542, $z1=var3101, $z2=var1082, $r8=var3313, $r11=var2006, $r9=var1107, $r10=var1146, org.apache.dubbo.rpc.protocol.AbstractProtocol=var886, $r42=var1792, java.util.Map=var2938, $r12=var3507, $r13=var3078, org.apache.dubbo.rpc.protocol.dubbo.DubboExporter=var605, $r43=var1331, org.apache.dubbo.rpc.Invoker=var1306, org.apache.dubbo.rpc.protocol.AbstractExporter=var2894, r14=var383, org.apache.dubbo.common.URL=var3638, org.apache.dubbo.common.Node=var3577, $r15=var3405, org.apache.dubbo.rpc.model.ServiceModel=var1705, $r16=var1268}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	i0 = virtualinvoke $r1.<java.net.InetSocketAddress: int getPort()>();	$r3 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("path");	r44 = (java.lang.String) $r3;	$r4 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r6 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>();	$r5 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("dubbo.stub.event");	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $z1 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: boolean isClientSide(org.apache.dubbo.remoting.Channel)>(r0);	$z1 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: boolean isClientSide(org.apache.dubbo.remoting.Channel)>(r0);	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	if $z2 == 0 goto $r8 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version");	$r8 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version");	$r11 = (java.lang.String) $r8;	$r9 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r10 = (java.lang.String) $r9;	$r42 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.lang.String serviceKey(int,java.lang.String,java.lang.String,java.lang.String)>(i0, r44, $r11, $r10);	$r12 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.Map exporterMap>;	$r13 = interfaceinvoke $r12.<java.util.Map: java.lang.Object get(java.lang.Object)>($r42);	$r43 = (org.apache.dubbo.rpc.protocol.dubbo.DubboExporter) $r13;	if $r43 != null goto r14 = virtualinvoke $r43.<org.apache.dubbo.rpc.protocol.dubbo.DubboExporter: org.apache.dubbo.rpc.Invoker getInvoker()>();	r14 = virtualinvoke $r43.<org.apache.dubbo.rpc.protocol.dubbo.DubboExporter: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r15 = interfaceinvoke r14.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r16 = virtualinvoke $r15.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: void setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r16);	return r14
;block_num 6