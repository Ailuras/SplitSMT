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

(declare-sort var3541 0)
(declare-sort var2377 0)
(declare-sort var9 0)
(declare-sort var277 0)
(declare-sort var432 0)
(declare-sort var1257 0)
(declare-sort var1526 0)
(declare-sort var3586 0)
(declare-sort var1180 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var277_attribute/1471010634 (var277 String) var1257)
(declare-fun cast-from-var1257-to-var1526 (var1257) var1526)
(declare-fun getValue/103104470 (var9) String)
(declare-fun var3586_isEmpty/-813097145 (String) Bool)
(declare-fun var1180_isRequired/-724586201 (var9) Bool)
(declare-const null-var3541 var3541)
(declare-const null-var2377 var2377)
(declare-const null-var9 var9)
(declare-const null-var277 var277)
(declare-const null-var432 var432)
(declare-const null-var1526 var1526)
(declare-const var2500 var3541) ; Statement: r12 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver 
(assert (not (= var2500 null-var3541)))
(declare-const var3768 var2377) ; Statement: r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var3768 null-var2377)))
(declare-const var1530 var9) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var1530 null-var9)))
(declare-const var3419 var277) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3419 null-var277)))
(declare-const var1822 var432) ; Statement: r13 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var1822 null-var432)))
(define-const var1788 var1257 (var277_attribute/1471010634 var3419 "org.springframework.web.servlet.HandlerMapping.uriTemplateVariables")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables") 
(define-const var3755 var1526 (cast-from-var1257-to-var1526 var1788)) ; Statement: r2 = (java.util.Map) $r1 
(assert true)
(define-const var2381 String (getValue/103104470 var1530)) ; Statement: r14 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>() 
(define-const var2147 Bool (var3586_isEmpty/-813097145 var2381)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r14) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var2147 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r14) 
(assert (not (not (= var3755 null-var1526)))) ; Negate: Cond: r2 != null  
(define-const var3620 Bool (var1180_isRequired/-724586201 var1530)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Helper: boolean isRequired(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta)>(r3) 
 ; Statement: if $z1 == 0 goto return null 
(assert (= (ite var3620 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return null 
(check-sat)
; {var277_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var1257-to-var1526=([java.lang.Object], java.util.Map), getValue/103104470=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.String), var3586_isEmpty/-813097145=([java.lang.String], boolean), var1180_isRequired/-724586201=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], boolean)}
; {var3541=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver, var2500=r12, var2377=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var3768=r9, var9=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var1530=r3, var277=org.apache.dubbo.remoting.http12.HttpRequest, var3419=r0, var432=org.apache.dubbo.remoting.http12.HttpResponse, var1822=r13, var1257=java.lang.Object, var1788=$r1, var1526=java.util.Map, var3755=r2, var2381=r14, var3586=org.apache.dubbo.common.utils.StringUtils, var2147=$z0, var1180=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Helper, var3620=$z1}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver=var3541, r12=var2500, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var2377, r9=var3768, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var9, r3=var1530, org.apache.dubbo.remoting.http12.HttpRequest=var277, r0=var3419, org.apache.dubbo.remoting.http12.HttpResponse=var432, r13=var1822, java.lang.Object=var1257, $r1=var1788, java.util.Map=var1526, r2=var3755, r14=var2381, org.apache.dubbo.common.utils.StringUtils=var3586, $z0=var2147, org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Helper=var1180, $z1=var3620}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver;	r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest;	r13 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables");	r2 = (java.util.Map) $r1;	r14 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r14);	if $z0 == 0 goto (branch);	if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r14);	$z1 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Helper: boolean isRequired(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta)>(r3);	if $z1 == 0 goto return null;	return null
;block_num 4