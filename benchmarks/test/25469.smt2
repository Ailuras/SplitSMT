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

(declare-sort var3760 0)
(declare-sort var3602 0)
(declare-sort var621 0)
(declare-sort var3293 0)
(declare-sort var948 0)
(declare-sort var2891 0)
(declare-sort var1072 0)
(declare-sort var2068 0)
(declare-sort var1803 0)
(declare-sort var2817 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2891-init () (Array Int var2891))
(declare-fun cast-from-var621-to-var2891 (var621) var2891)
(declare-fun var948_debug/494993835 (var948 String (Array Int var2891)) void)
(declare-fun requestMappingRegistry/-60854353 (var3760) var1072)
(declare-fun var1072_lookup/-527651510 (var1072 var621) var2068)
(declare-fun var621_attribute/1471010634 (var621 String) var2891)
(declare-fun cast-from-var2891-to-String (var2891) String)
(declare-fun name/1633728430 (var2817) String)
(declare-fun cast-from-var1803-to-var2817 (var1803) var2817)
(declare-fun var621_method/1452675274 (var621) String)
(declare-const null-var3760 var3760)
(declare-const null-var3602 var3602)
(declare-const null-var621 var621)
(declare-const null-var3293 var3293)
(declare-const var3760-LOGGER var948)
(declare-const null-__Array__Int__var2891__ (Array Int var2891))
(declare-const null-var2068 var2068)
(declare-const var1803-OPTIONS var1803)
(declare-const var1270 var3760) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping 
(assert (not (= var1270 null-var3760)))
(declare-const var3807 var3602) ; Statement: r11 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3807 null-var3602)))
(declare-const var3065 var621) ; Statement: r1 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3065 null-var621)))
(declare-const var2040 var3293) ; Statement: r10 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var2040 null-var3293)))
(define-const var1545 var948 var3760-LOGGER) ; Statement: $r2 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(define-const var2991 (Array Int var2891) arr-var2891-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(declare-const var2991!1 (Array Int var2891))
(assert (not (= var2991!1 null-__Array__Int__var2891__)))
(assert (= (select var2991!1 0) (cast-from-var621-to-var2891 var3065))) ; Statement: $r0[0] = r1 
;(assert (var948_debug/494993835 var1545 "Received http request: {}" var2991!1)) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("Received http request: {}", $r0) 

(declare-const var1545!1 var948)
(declare-const var745 String)
(declare-const var2991!2 (Array Int var2891))
(define-const var2509 var1072 (requestMappingRegistry/-60854353 var1270)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry requestMappingRegistry> 
(define-const var990 var2068 (var1072_lookup/-527651510 var2509 var3065)) ; Statement: r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta lookup(org.apache.dubbo.remoting.http12.HttpRequest)>(r1) 
 ; Statement: if r5 != null goto r25 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>() 
(assert (not (not (= var990 null-var2068)))) ; Negate: Cond: r5 != null  
(define-const var559 var2891 (var621_attribute/1471010634 var3065 "org.springframework.web.util.UrlPathHelper.PATH")) ; Statement: $r17 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.util.UrlPathHelper.PATH") 
(define-const var1638 String (cast-from-var2891-to-String var559)) ; Statement: r22 = (java.lang.String) $r17 
(define-const var1039 String "/") ; Statement: $r18 = "/" 
(assert true)
(define-const var3014 Bool (= var1039 var1638)) ; Statement: $z4 = virtualinvoke $r18.<java.lang.String: boolean equals(java.lang.Object)>(r22) 
 ; Statement: if $z4 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(assert (not (= (ite var3014 1 0) 0))) ; Negate: Cond: $z4 == 0  
(define-const var474 var1803 var1803-OPTIONS) ; Statement: $r19 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods OPTIONS> 
(assert true)
(define-const var3786 String (name/1633728430 (cast-from-var1803-to-var2817 var474))) ; Statement: $r21 = virtualinvoke $r19.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>() 
(define-const var2464 String (var621_method/1452675274 var3065)) ; Statement: $r20 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>() 
(assert true)
(define-const var3835 Bool (= var3786 var2464)) ; Statement: $z5 = virtualinvoke $r21.<java.lang.String: boolean equals(java.lang.Object)>($r20) 
 ; Statement: if $z5 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(assert (= (ite var3835 1 0) 0)) ; Cond: $z5 == 0 
(define-const var1775 var948 var3760-LOGGER) ; Statement: $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(define-const var2054 (Array Int var2891) arr-var2891-init) ; Statement: $r24 = newarray (java.lang.Object)[1] 
(declare-const var2054!1 (Array Int var2891))
(assert (not (= var2054!1 null-__Array__Int__var2891__)))
(assert (= (select var2054!1 0) (cast-from-var621-to-var2891 var3065))) ; Statement: $r24[0] = r1 
;(assert (var948_debug/494993835 var1775 "No handler found for http request: {}" var2054!1)) ; Statement: interfaceinvoke $r23.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("No handler found for http request: {}", $r24) 

(declare-const var1775!1 var948)
(declare-const var1310 String)
(declare-const var2054!2 (Array Int var2891))
 ; Statement: return null 
(check-sat)
; {arr-var2891-init=([], java.lang.Object[]), cast-from-var621-to-var2891=([org.apache.dubbo.remoting.http12.HttpRequest], java.lang.Object), var948_debug/494993835=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Object[]], void), requestMappingRegistry/-60854353=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var1072_lookup/-527651510=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, org.apache.dubbo.remoting.http12.HttpRequest], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta), var621_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var2891-to-String=([java.lang.Object], java.lang.String), name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var1803-to-var2817=([org.apache.dubbo.remoting.http12.HttpMethods], java.lang.Enum), var621_method/1452675274=([org.apache.dubbo.remoting.http12.HttpRequest], java.lang.String)}
; {var3760=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping, var1270=r3, var3602=org.apache.dubbo.common.URL, var3807=r11, var621=org.apache.dubbo.remoting.http12.HttpRequest, var3065=r1, var3293=org.apache.dubbo.remoting.http12.HttpResponse, var2040=r10, var948=org.apache.dubbo.common.logger.Logger, var1545=$r2, var2891=java.lang.Object, var2991=$r0, var745="Received http request: {}", var1072=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var2509=$r4, var2068=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta, var990=r5, var559=$r17, var1638=r22, var1039=$r18, var3014=$z4, var1803=org.apache.dubbo.remoting.http12.HttpMethods, var474=$r19, var2817=java.lang.Enum, var3786=$r21, var2464=$r20, var3835=$z5, var1775=$r23, var2054=$r24, var1310="No handler found for http request: {}"}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping=var3760, r3=var1270, org.apache.dubbo.common.URL=var3602, r11=var3807, org.apache.dubbo.remoting.http12.HttpRequest=var621, r1=var3065, org.apache.dubbo.remoting.http12.HttpResponse=var3293, r10=var2040, org.apache.dubbo.common.logger.Logger=var948, $r2=var1545, java.lang.Object=var2891, $r0=var2991, "Received http request: {}"=var745, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var1072, $r4=var2509, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta=var2068, r5=var990, $r17=var559, r22=var1638, $r18=var1039, $z4=var3014, org.apache.dubbo.remoting.http12.HttpMethods=var1803, $r19=var474, java.lang.Enum=var2817, $r21=var3786, $r20=var2464, $z5=var3835, $r23=var1775, $r24=var2054, "No handler found for http request: {}"=var1310}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping;	r11 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest;	r10 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse;	$r2 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r0 = newarray (java.lang.Object)[1];	$r0[0] = r1;	interfaceinvoke $r2.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("Received http request: {}", $r0);	$r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry requestMappingRegistry>;	r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta lookup(org.apache.dubbo.remoting.http12.HttpRequest)>(r1);	if r5 != null goto r25 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>();	$r17 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.util.UrlPathHelper.PATH");	r22 = (java.lang.String) $r17;	$r18 = "/";	$z4 = virtualinvoke $r18.<java.lang.String: boolean equals(java.lang.Object)>(r22);	if $z4 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r19 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods OPTIONS>;	$r21 = virtualinvoke $r19.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>();	$r20 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>();	$z5 = virtualinvoke $r21.<java.lang.String: boolean equals(java.lang.Object)>($r20);	if $z5 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r24 = newarray (java.lang.Object)[1];	$r24[0] = r1;	interfaceinvoke $r23.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("No handler found for http request: {}", $r24);	return null
;block_num 4