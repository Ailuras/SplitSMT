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

(declare-sort var2781 0)
(declare-sort var3316 0)
(declare-sort var2058 0)
(declare-sort var2364 0)
(declare-sort var1627 0)
(declare-sort var3489 0)
(declare-sort var3065 0)
(declare-sort var2688 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var3489-init () (Array Int var3489))
(declare-fun cast-from-var2058-to-var3489 (var2058) var3489)
(declare-fun var1627_debug/494993835 (var1627 String (Array Int var3489)) void)
(declare-fun requestMappingRegistry/-60854353 (var2781) var3065)
(declare-fun var3065_lookup/-527651510 (var3065 var2058) var2688)
(declare-fun var2058_attribute/1471010634 (var2058 String) var3489)
(declare-fun cast-from-var3489-to-String (var3489) String)
(declare-const null-var2781 var2781)
(declare-const null-var3316 var3316)
(declare-const null-var2058 var2058)
(declare-const null-var2364 var2364)
(declare-const var2781-LOGGER var1627)
(declare-const null-__Array__Int__var3489__ (Array Int var3489))
(declare-const null-var2688 var2688)
(declare-const var615 var2781) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping 
(assert (not (= var615 null-var2781)))
(declare-const var3177 var3316) ; Statement: r11 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3177 null-var3316)))
(declare-const var3659 var2058) ; Statement: r1 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3659 null-var2058)))
(declare-const var1391 var2364) ; Statement: r10 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var1391 null-var2364)))
(define-const var3257 var1627 var2781-LOGGER) ; Statement: $r2 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(define-const var2709 (Array Int var3489) arr-var3489-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(declare-const var2709!1 (Array Int var3489))
(assert (not (= var2709!1 null-__Array__Int__var3489__)))
(assert (= (select var2709!1 0) (cast-from-var2058-to-var3489 var3659))) ; Statement: $r0[0] = r1 
;(assert (var1627_debug/494993835 var3257 "Received http request: {}" var2709!1)) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("Received http request: {}", $r0) 

(declare-const var3257!1 var1627)
(declare-const var829 String)
(declare-const var2709!2 (Array Int var3489))
(define-const var2519 var3065 (requestMappingRegistry/-60854353 var615)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry requestMappingRegistry> 
(define-const var3096 var2688 (var3065_lookup/-527651510 var2519 var3659)) ; Statement: r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta lookup(org.apache.dubbo.remoting.http12.HttpRequest)>(r1) 
 ; Statement: if r5 != null goto r25 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>() 
(assert (not (not (= var3096 null-var2688)))) ; Negate: Cond: r5 != null  
(define-const var2565 var3489 (var2058_attribute/1471010634 var3659 "org.springframework.web.util.UrlPathHelper.PATH")) ; Statement: $r17 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.util.UrlPathHelper.PATH") 
(define-const var2191 String (cast-from-var3489-to-String var2565)) ; Statement: r22 = (java.lang.String) $r17 
(define-const var1493 String "/") ; Statement: $r18 = "/" 
(assert true)
(define-const var2274 Bool (= var1493 var2191)) ; Statement: $z4 = virtualinvoke $r18.<java.lang.String: boolean equals(java.lang.Object)>(r22) 
 ; Statement: if $z4 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(assert (= (ite var2274 1 0) 0)) ; Cond: $z4 == 0 
(define-const var716 var1627 var2781-LOGGER) ; Statement: $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(define-const var1136 (Array Int var3489) arr-var3489-init) ; Statement: $r24 = newarray (java.lang.Object)[1] 
(declare-const var1136!1 (Array Int var3489))
(assert (not (= var1136!1 null-__Array__Int__var3489__)))
(assert (= (select var1136!1 0) (cast-from-var2058-to-var3489 var3659))) ; Statement: $r24[0] = r1 
;(assert (var1627_debug/494993835 var716 "No handler found for http request: {}" var1136!1)) ; Statement: interfaceinvoke $r23.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("No handler found for http request: {}", $r24) 

(declare-const var716!1 var1627)
(declare-const var721 String)
(declare-const var1136!2 (Array Int var3489))
 ; Statement: return null 
(check-sat)
; {arr-var3489-init=([], java.lang.Object[]), cast-from-var2058-to-var3489=([org.apache.dubbo.remoting.http12.HttpRequest], java.lang.Object), var1627_debug/494993835=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Object[]], void), requestMappingRegistry/-60854353=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var3065_lookup/-527651510=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, org.apache.dubbo.remoting.http12.HttpRequest], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta), var2058_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var3489-to-String=([java.lang.Object], java.lang.String)}
; {var2781=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping, var615=r3, var3316=org.apache.dubbo.common.URL, var3177=r11, var2058=org.apache.dubbo.remoting.http12.HttpRequest, var3659=r1, var2364=org.apache.dubbo.remoting.http12.HttpResponse, var1391=r10, var1627=org.apache.dubbo.common.logger.Logger, var3257=$r2, var3489=java.lang.Object, var2709=$r0, var829="Received http request: {}", var3065=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var2519=$r4, var2688=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta, var3096=r5, var2565=$r17, var2191=r22, var1493=$r18, var2274=$z4, var716=$r23, var1136=$r24, var721="No handler found for http request: {}"}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping=var2781, r3=var615, org.apache.dubbo.common.URL=var3316, r11=var3177, org.apache.dubbo.remoting.http12.HttpRequest=var2058, r1=var3659, org.apache.dubbo.remoting.http12.HttpResponse=var2364, r10=var1391, org.apache.dubbo.common.logger.Logger=var1627, $r2=var3257, java.lang.Object=var3489, $r0=var2709, "Received http request: {}"=var829, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var3065, $r4=var2519, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta=var2688, r5=var3096, $r17=var2565, r22=var2191, $r18=var1493, $z4=var2274, $r23=var716, $r24=var1136, "No handler found for http request: {}"=var721}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping;	r11 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest;	r10 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse;	$r2 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r0 = newarray (java.lang.Object)[1];	$r0[0] = r1;	interfaceinvoke $r2.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("Received http request: {}", $r0);	$r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry requestMappingRegistry>;	r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta lookup(org.apache.dubbo.remoting.http12.HttpRequest)>(r1);	if r5 != null goto r25 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>();	$r17 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.util.UrlPathHelper.PATH");	r22 = (java.lang.String) $r17;	$r18 = "/";	$z4 = virtualinvoke $r18.<java.lang.String: boolean equals(java.lang.Object)>(r22);	if $z4 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r24 = newarray (java.lang.Object)[1];	$r24[0] = r1;	interfaceinvoke $r23.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("No handler found for http request: {}", $r24);	return null
;block_num 3