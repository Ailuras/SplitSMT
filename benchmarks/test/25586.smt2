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

(declare-sort var3005 0)
(declare-sort var2934 0)
(declare-sort var2810 0)
(declare-sort var1164 0)
(declare-sort var1084 0)
(declare-sort var3964 0)
(declare-sort var601 0)
(declare-sort var3718 0)
(declare-sort var2626 0)
(declare-sort var85 0)
(declare-sort var566 0)
(declare-sort var1269 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getHttpMetadata/-648394241 (var1164) var2810)
(declare-fun cast-from-var3005-to-var1164 (var3005) var1164)
(declare-fun cast-from-var2810-to-var1084 (var2810) var1084)
(declare-fun getName/-596499143 (var3964) String)
(declare-fun var601_header/-124358303 (var601 String) String)
(declare-fun cast-from-var1084-to-var601 (var1084) var601)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun arr-var85-init () (Array Int var85))
(declare-fun cast-from-String-to-var85 (String) var85)
(declare-fun getContext/1040033821 (var1164) var566)
(declare-fun var566_getServiceDescriptor/-422608715 (var566) var1269)
(declare-fun var1269_getInterfaceName/228305574 (var1269) String)
(declare-fun var566_getMethodName/-338853824 (var566) String)
(declare-fun String_format/1339386452 (String (Array Int var85)) String)
(declare-fun var2626_warn/1431914100 (var2626 String String String String) void)
(declare-const null-var3005 var3005)
(declare-const null-var2934 var2934)
(declare-const var3964-GRPC_TIMEOUT var3964)
(declare-const null-var3718 var3718)
(declare-const var3005-LOGGER var2626)
(declare-const null-__Array__Int__var85__ (Array Int var85))
(declare-const var1415 var3005) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener 
(assert (not (= var1415 null-var3005)))
(declare-const var3383 var2934) ; Statement: r6 := @parameter0: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var3383 null-var2934)))
(assert true)
(define-const var3162 var2810 (getHttpMetadata/-648394241 (cast-from-var3005-to-var1164 var1415))) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener: org.apache.dubbo.remoting.http12.RequestMetadata getHttpMetadata()>() 
(define-const var3628 var1084 (cast-from-var2810-to-var1084 var3162)) ; Statement: $r4 = (org.apache.dubbo.remoting.http12.h2.Http2Header) $r1 
(define-const var1627 var3964 var3964-GRPC_TIMEOUT) ; Statement: $r2 = <org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames: org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames GRPC_TIMEOUT> 
(assert true)
(define-const var2823 String (getName/-596499143 var1627)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames: java.lang.String getName()>() 
(define-const var3457 String (var601_header/-124358303 (cast-from-var1084-to-var601 var3628) (cast-from-String-to-String var2823))) ; Statement: r5 = interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.h2.Http2Header: java.lang.String header(java.lang.CharSequence)>($r3) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2014 var3718) ; Statement: $r7 := @caughtexception 
(assert (not (= var2014 null-var3718)))
(define-const var3448 var2626 var3005-LOGGER) ; Statement: $r9 = <org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var2427 (Array Int var85) arr-var85-init) ; Statement: $r8 = newarray (java.lang.Object)[3] 
(declare-const var2427!1 (Array Int var85))
(assert (not (= var2427!1 null-__Array__Int__var85__)))
(assert (= (select var2427!1 0) (cast-from-String-to-var85 var3457))) ; Statement: $r8[0] = r5 
(assert true)
(define-const var3495 var566 (getContext/1040033821 (cast-from-var3005-to-var1164 var1415))) ; Statement: $r10 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener: org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext getContext()>() 
(define-const var774 var1269 (var566_getServiceDescriptor/-422608715 var3495)) ; Statement: $r11 = interfaceinvoke $r10.<org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceDescriptor()>() 
(define-const var2018 String (var1269_getInterfaceName/228305574 var774)) ; Statement: $r12 = interfaceinvoke $r11.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.String getInterfaceName()>() 
(declare-const var2427!2 (Array Int var85))
(assert (not (= var2427!2 null-__Array__Int__var85__)))
(assert (= (select var2427!2 1) (cast-from-String-to-var85 var2018))) ; Statement: $r8[1] = $r12 
(assert true)
(define-const var1934 var566 (getContext/1040033821 (cast-from-var3005-to-var1164 var1415))) ; Statement: $r13 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener: org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext getContext()>() 
(define-const var3366 String (var566_getMethodName/-338853824 var1934)) ; Statement: $r14 = interfaceinvoke $r13.<org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext: java.lang.String getMethodName()>() 
(declare-const var2427!3 (Array Int var85))
(assert (not (= var2427!3 null-__Array__Int__var85__)))
(assert (= (select var2427!3 2) (cast-from-String-to-var85 var3366))) ; Statement: $r8[2] = $r14 
(define-const var2472 String (String_format/1339386452 "Failed to parse request timeout set from:%s, service=%s method=%s" var2427!3)) ; Statement: $r15 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Failed to parse request timeout set from:%s, service=%s method=%s", $r8) 
;(assert (var2626_warn/1431914100 var3448 "4-9" "" "" var2472)) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("4-9", "", "", $r15) 

(declare-const var3448!1 var2626)
(declare-const var603 String)
(declare-const var2244 String)
(declare-const var2244!1 String)
(declare-const var2472!1 String)
(assert true) ; Non Conditional
 ; Statement: return r6 
(check-sat)
; {getHttpMetadata/-648394241=([org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener], org.apache.dubbo.remoting.http12.RequestMetadata), cast-from-var3005-to-var1164=([org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener], org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener), cast-from-var2810-to-var1084=([org.apache.dubbo.remoting.http12.RequestMetadata], org.apache.dubbo.remoting.http12.h2.Http2Header), getName/-596499143=([org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames], java.lang.String), var601_header/-124358303=([org.apache.dubbo.remoting.http12.HttpMetadata, java.lang.CharSequence], java.lang.String), cast-from-var1084-to-var601=([org.apache.dubbo.remoting.http12.h2.Http2Header], org.apache.dubbo.remoting.http12.HttpMetadata), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), arr-var85-init=([], java.lang.Object[]), cast-from-String-to-var85=([java.lang.String], java.lang.Object), getContext/1040033821=([org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener], org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext), var566_getServiceDescriptor/-422608715=([org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext], org.apache.dubbo.rpc.model.ServiceDescriptor), var1269_getInterfaceName/228305574=([org.apache.dubbo.rpc.model.ServiceDescriptor], java.lang.String), var566_getMethodName/-338853824=([org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext], java.lang.String), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var2626_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var3005=org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener, var1415=r0, var2934=org.apache.dubbo.rpc.RpcInvocation, var3383=r6, var2810=org.apache.dubbo.remoting.http12.RequestMetadata, var1164=org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener, var3162=$r1, var1084=org.apache.dubbo.remoting.http12.h2.Http2Header, var3628=$r4, var3964=org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames, var1627=$r2, var2823=$r3, var601=org.apache.dubbo.remoting.http12.HttpMetadata, var3457=r5, var3718=java.lang.Throwable, var2014=$r7, var2626=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3448=$r9, var85=java.lang.Object, var2427=$r8, var566=org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext, var3495=$r10, var1269=org.apache.dubbo.rpc.model.ServiceDescriptor, var774=$r11, var2018=$r12, var1934=$r13, var3366=$r14, var2472=$r15, var603="4-9", var2244=""}
; {org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener=var3005, r0=var1415, org.apache.dubbo.rpc.RpcInvocation=var2934, r6=var3383, org.apache.dubbo.remoting.http12.RequestMetadata=var2810, org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener=var1164, $r1=var3162, org.apache.dubbo.remoting.http12.h2.Http2Header=var1084, $r4=var3628, org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames=var3964, $r2=var1627, $r3=var2823, org.apache.dubbo.remoting.http12.HttpMetadata=var601, r5=var3457, java.lang.Throwable=var3718, $r7=var2014, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2626, $r9=var3448, java.lang.Object=var85, $r8=var2427, org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext=var566, $r10=var3495, org.apache.dubbo.rpc.model.ServiceDescriptor=var1269, $r11=var774, $r12=var2018, $r13=var1934, $r14=var3366, $r15=var2472, "4-9"=var603, ""=var2244}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener;	r6 := @parameter0: org.apache.dubbo.rpc.RpcInvocation;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener: org.apache.dubbo.remoting.http12.RequestMetadata getHttpMetadata()>();	$r4 = (org.apache.dubbo.remoting.http12.h2.Http2Header) $r1;	$r2 = <org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames: org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames GRPC_TIMEOUT>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHeaderNames: java.lang.String getName()>();	r5 = interfaceinvoke $r4.<org.apache.dubbo.remoting.http12.h2.Http2Header: java.lang.String header(java.lang.CharSequence)>($r3);	$r7 := @caughtexception;	$r9 = <org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r8 = newarray (java.lang.Object)[3];	$r8[0] = r5;	$r10 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener: org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext getContext()>();	$r11 = interfaceinvoke $r10.<org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceDescriptor()>();	$r12 = interfaceinvoke $r11.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.String getInterfaceName()>();	$r8[1] = $r12;	$r13 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h12.grpc.GrpcHttp2ServerTransportListener: org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext getContext()>();	$r14 = interfaceinvoke $r13.<org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext: java.lang.String getMethodName()>();	$r8[2] = $r14;	$r15 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Failed to parse request timeout set from:%s, service=%s method=%s", $r8);	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("4-9", "", "", $r15);	return r6
;block_num 3