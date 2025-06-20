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

(declare-sort var1279 0)
(declare-sort var2398 0)
(declare-sort var1637 0)
(declare-sort var2439 0)
(declare-sort var295 0)
(declare-sort var781 0)
(declare-sort var2343 0)
(declare-sort var3356 0)
(declare-sort var1715 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2439_attribute/1471010634 (var2439 String) var781)
(declare-fun cast-from-var781-to-var2343 (var781) var2343)
(declare-fun getValue/103104470 (var1637) String)
(declare-fun var3356_isEmpty/-813097145 (String) Bool)
(declare-fun var1715_isRequired/-81497226 (var2398) Bool)
(declare-const null-var1279 var1279)
(declare-const null-var2398 var2398)
(declare-const null-var1637 var1637)
(declare-const null-var2439 var2439)
(declare-const null-var295 var295)
(declare-const null-var2343 var2343)
(declare-const var912 var1279) ; Statement: r11 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver 
(assert (not (= var912 null-var1279)))
(declare-const var2433 var2398) ; Statement: r5 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var2433 null-var2398)))
(declare-const var3285 var1637) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var3285 null-var1637)))
(declare-const var3128 var2439) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3128 null-var2439)))
(declare-const var3080 var295) ; Statement: r12 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var3080 null-var295)))
(define-const var714 var781 (var2439_attribute/1471010634 var3128 "org.springframework.web.servlet.HandlerMapping.uriTemplateVariables")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables") 
(define-const var3202 var2343 (cast-from-var781-to-var2343 var714)) ; Statement: r2 = (java.util.Map) $r1 
(assert true)
(define-const var1421 String (getValue/103104470 var3285)) ; Statement: r13 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>() 
(define-const var1996 Bool (var3356_isEmpty/-813097145 var1421)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r13) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var1996 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r13) 
(assert (not (not (= var3202 null-var2343)))) ; Negate: Cond: r2 != null  
(define-const var88 Bool (var1715_isRequired/-81497226 var2433)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Helper: boolean isRequired(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta)>(r5) 
 ; Statement: if $z2 == 0 goto return null 
(assert (= (ite var88 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return null 
(check-sat)
; {var2439_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var781-to-var2343=([java.lang.Object], java.util.Map), getValue/103104470=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.String), var3356_isEmpty/-813097145=([java.lang.String], boolean), var1715_isRequired/-81497226=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], boolean)}
; {var1279=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver, var912=r11, var2398=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var2433=r5, var1637=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var3285=r3, var2439=org.apache.dubbo.remoting.http12.HttpRequest, var3128=r0, var295=org.apache.dubbo.remoting.http12.HttpResponse, var3080=r12, var781=java.lang.Object, var714=$r1, var2343=java.util.Map, var3202=r2, var1421=r13, var3356=org.apache.dubbo.common.utils.StringUtils, var1996=$z0, var1715=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Helper, var88=$z2}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver=var1279, r11=var912, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var2398, r5=var2433, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var1637, r3=var3285, org.apache.dubbo.remoting.http12.HttpRequest=var2439, r0=var3128, org.apache.dubbo.remoting.http12.HttpResponse=var295, r12=var3080, java.lang.Object=var781, $r1=var714, java.util.Map=var2343, r2=var3202, r13=var1421, org.apache.dubbo.common.utils.StringUtils=var3356, $z0=var1996, org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Helper=var1715, $z2=var88}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r11 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver;	r5 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest;	r12 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables");	r2 = (java.util.Map) $r1;	r13 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r13);	if $z0 == 0 goto (branch);	if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r13);	$z2 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Helper: boolean isRequired(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta)>(r5);	if $z2 == 0 goto return null;	return null
;block_num 4