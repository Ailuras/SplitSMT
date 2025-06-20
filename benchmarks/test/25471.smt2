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

(declare-sort var391 0)
(declare-sort var1330 0)
(declare-sort var513 0)
(declare-sort var2882 0)
(declare-sort var755 0)
(declare-sort var1154 0)
(declare-sort var3208 0)
(declare-sort var897 0)
(declare-sort var1906 0)
(declare-sort var3482 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1154-init () (Array Int var1154))
(declare-fun cast-from-var513-to-var1154 (var513) var1154)
(declare-fun var755_debug/494993835 (var755 String (Array Int var1154)) void)
(declare-fun requestMappingRegistry/-60854353 (var391) var3208)
(declare-fun var3208_lookup/-527651510 (var3208 var513) var897)
(declare-fun var513_attribute/1471010634 (var513 String) var1154)
(declare-fun cast-from-var1154-to-String (var1154) String)
(declare-fun name/1633728430 (var3482) String)
(declare-fun cast-from-var1906-to-var3482 (var1906) var3482)
(declare-fun var513_method/1452675274 (var513) String)
(declare-fun var391_handleOptionsRequest/2010063728 (var513) void)
(declare-const null-var391 var391)
(declare-const null-var1330 var1330)
(declare-const null-var513 var513)
(declare-const null-var2882 var2882)
(declare-const var391-LOGGER var755)
(declare-const null-__Array__Int__var1154__ (Array Int var1154))
(declare-const null-var897 var897)
(declare-const var1906-OPTIONS var1906)
(declare-const var2158 var391) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping 
(assert (not (= var2158 null-var391)))
(declare-const var14 var1330) ; Statement: r11 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var14 null-var1330)))
(declare-const var3910 var513) ; Statement: r1 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3910 null-var513)))
(declare-const var3636 var2882) ; Statement: r10 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var3636 null-var2882)))
(define-const var1107 var755 var391-LOGGER) ; Statement: $r2 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(define-const var826 (Array Int var1154) arr-var1154-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(declare-const var826!1 (Array Int var1154))
(assert (not (= var826!1 null-__Array__Int__var1154__)))
(assert (= (select var826!1 0) (cast-from-var513-to-var1154 var3910))) ; Statement: $r0[0] = r1 
;(assert (var755_debug/494993835 var1107 "Received http request: {}" var826!1)) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("Received http request: {}", $r0) 

(declare-const var1107!1 var755)
(declare-const var1860 String)
(declare-const var826!2 (Array Int var1154))
(define-const var1465 var3208 (requestMappingRegistry/-60854353 var2158)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry requestMappingRegistry> 
(define-const var131 var897 (var3208_lookup/-527651510 var1465 var3910)) ; Statement: r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta lookup(org.apache.dubbo.remoting.http12.HttpRequest)>(r1) 
 ; Statement: if r5 != null goto r25 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>() 
(assert (not (not (= var131 null-var897)))) ; Negate: Cond: r5 != null  
(define-const var1440 var1154 (var513_attribute/1471010634 var3910 "org.springframework.web.util.UrlPathHelper.PATH")) ; Statement: $r17 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.util.UrlPathHelper.PATH") 
(define-const var3381 String (cast-from-var1154-to-String var1440)) ; Statement: r22 = (java.lang.String) $r17 
(define-const var2062 String "/") ; Statement: $r18 = "/" 
(assert true)
(define-const var3106 Bool (= var2062 var3381)) ; Statement: $z4 = virtualinvoke $r18.<java.lang.String: boolean equals(java.lang.Object)>(r22) 
 ; Statement: if $z4 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(assert (not (= (ite var3106 1 0) 0))) ; Negate: Cond: $z4 == 0  
(define-const var770 var1906 var1906-OPTIONS) ; Statement: $r19 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods OPTIONS> 
(assert true)
(define-const var1719 String (name/1633728430 (cast-from-var1906-to-var3482 var770))) ; Statement: $r21 = virtualinvoke $r19.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>() 
(define-const var1383 String (var513_method/1452675274 var3910)) ; Statement: $r20 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>() 
(assert true)
(define-const var1405 Bool (= var1719 var1383)) ; Statement: $z5 = virtualinvoke $r21.<java.lang.String: boolean equals(java.lang.Object)>($r20) 
 ; Statement: if $z5 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(assert (not (= (ite var1405 1 0) 0))) ; Negate: Cond: $z5 == 0  
;(assert (var391_handleOptionsRequest/2010063728 var3910)) ; Statement: staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: void handleOptionsRequest(org.apache.dubbo.remoting.http12.HttpRequest)>(r1) 

(declare-const var3910!1 var513)
(assert true) ; Non Conditional
(define-const var1189 var755 var391-LOGGER) ; Statement: $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER> 
(define-const var2447 (Array Int var1154) arr-var1154-init) ; Statement: $r24 = newarray (java.lang.Object)[1] 
(declare-const var2447!1 (Array Int var1154))
(assert (not (= var2447!1 null-__Array__Int__var1154__)))
(assert (= (select var2447!1 0) (cast-from-var513-to-var1154 var3910!1))) ; Statement: $r24[0] = r1 
;(assert (var755_debug/494993835 var1189 "No handler found for http request: {}" var2447!1)) ; Statement: interfaceinvoke $r23.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("No handler found for http request: {}", $r24) 

(declare-const var1189!1 var755)
(declare-const var3266 String)
(declare-const var2447!2 (Array Int var1154))
 ; Statement: return null 
(check-sat)
; {arr-var1154-init=([], java.lang.Object[]), cast-from-var513-to-var1154=([org.apache.dubbo.remoting.http12.HttpRequest], java.lang.Object), var755_debug/494993835=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Object[]], void), requestMappingRegistry/-60854353=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var3208_lookup/-527651510=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, org.apache.dubbo.remoting.http12.HttpRequest], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta), var513_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var1154-to-String=([java.lang.Object], java.lang.String), name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var1906-to-var3482=([org.apache.dubbo.remoting.http12.HttpMethods], java.lang.Enum), var513_method/1452675274=([org.apache.dubbo.remoting.http12.HttpRequest], java.lang.String), var391_handleOptionsRequest/2010063728=([org.apache.dubbo.remoting.http12.HttpRequest], void)}
; {var391=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping, var2158=r3, var1330=org.apache.dubbo.common.URL, var14=r11, var513=org.apache.dubbo.remoting.http12.HttpRequest, var3910=r1, var2882=org.apache.dubbo.remoting.http12.HttpResponse, var3636=r10, var755=org.apache.dubbo.common.logger.Logger, var1107=$r2, var1154=java.lang.Object, var826=$r0, var1860="Received http request: {}", var3208=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var1465=$r4, var897=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta, var131=r5, var1440=$r17, var3381=r22, var2062=$r18, var3106=$z4, var1906=org.apache.dubbo.remoting.http12.HttpMethods, var770=$r19, var3482=java.lang.Enum, var1719=$r21, var1383=$r20, var1405=$z5, var1189=$r23, var2447=$r24, var3266="No handler found for http request: {}"}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping=var391, r3=var2158, org.apache.dubbo.common.URL=var1330, r11=var14, org.apache.dubbo.remoting.http12.HttpRequest=var513, r1=var3910, org.apache.dubbo.remoting.http12.HttpResponse=var2882, r10=var3636, org.apache.dubbo.common.logger.Logger=var755, $r2=var1107, java.lang.Object=var1154, $r0=var826, "Received http request: {}"=var1860, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var3208, $r4=var1465, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta=var897, r5=var131, $r17=var1440, r22=var3381, $r18=var2062, $z4=var3106, org.apache.dubbo.remoting.http12.HttpMethods=var1906, $r19=var770, java.lang.Enum=var3482, $r21=var1719, $r20=var1383, $z5=var1405, $r23=var1189, $r24=var2447, "No handler found for http request: {}"=var3266}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping;	r11 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest;	r10 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse;	$r2 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r0 = newarray (java.lang.Object)[1];	$r0[0] = r1;	interfaceinvoke $r2.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("Received http request: {}", $r0);	$r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry requestMappingRegistry>;	r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta lookup(org.apache.dubbo.remoting.http12.HttpRequest)>(r1);	if r5 != null goto r25 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>();	$r17 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.util.UrlPathHelper.PATH");	r22 = (java.lang.String) $r17;	$r18 = "/";	$z4 = virtualinvoke $r18.<java.lang.String: boolean equals(java.lang.Object)>(r22);	if $z4 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r19 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods OPTIONS>;	$r21 = virtualinvoke $r19.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>();	$r20 = interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>();	$z5 = virtualinvoke $r21.<java.lang.String: boolean equals(java.lang.Object)>($r20);	if $z5 == 0 goto $r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: void handleOptionsRequest(org.apache.dubbo.remoting.http12.HttpRequest)>(r1);	$r23 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.RestRequestHandlerMapping: org.apache.dubbo.common.logger.Logger LOGGER>;	$r24 = newarray (java.lang.Object)[1];	$r24[0] = r1;	interfaceinvoke $r23.<org.apache.dubbo.common.logger.Logger: void debug(java.lang.String,java.lang.Object[])>("No handler found for http request: {}", $r24);	return null
;block_num 5