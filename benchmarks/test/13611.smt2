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

(declare-sort var3584 0)
(declare-sort var1048 0)
(declare-sort var2616 0)
(declare-sort var700 0)
(declare-sort var650 0)
(declare-sort var1744 0)
(declare-sort var353 0)
(declare-sort var2561 0)
(declare-sort var1459 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var700_attribute/1471010634 (var700 String) var1744)
(declare-fun cast-from-var1744-to-var353 (var1744) var353)
(declare-fun getValue/103104470 (var2616) String)
(declare-fun var2561_isEmpty/-813097145 (String) Bool)
(declare-fun var353_get/1088891777 (var353 var1744) var1744)
(declare-fun cast-from-String-to-var1744 (String) var1744)
(declare-fun cast-from-var1744-to-String (var1744) String)
(declare-const null-var3584 var3584)
(declare-const null-var1048 var1048)
(declare-const null-var2616 var2616)
(declare-const null-var700 var700)
(declare-const null-var650 var650)
(declare-const null-var353 var353)
(declare-const null-String String)
(declare-const var3405 var3584) ; Statement: r12 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver 
(assert (not (= var3405 null-var3584)))
(declare-const var2030 var1048) ; Statement: r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var2030 null-var1048)))
(declare-const var2369 var2616) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var2369 null-var2616)))
(declare-const var1047 var700) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var1047 null-var700)))
(declare-const var3648 var650) ; Statement: r13 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var3648 null-var650)))
(define-const var3999 var1744 (var700_attribute/1471010634 var1047 "org.springframework.web.servlet.HandlerMapping.uriTemplateVariables")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables") 
(define-const var3008 var353 (cast-from-var1744-to-var353 var3999)) ; Statement: r2 = (java.util.Map) $r1 
(assert true)
(define-const var2377 String (getValue/103104470 var2369)) ; Statement: r14 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>() 
(define-const var2439 Bool (var2561_isEmpty/-813097145 var2377)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r14) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var2439 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r14) 
(assert (not (= var3008 null-var353))) ; Cond: r2 != null 
(define-const var1617 var1744 (var353_get/1088891777 var3008 (cast-from-String-to-var1744 var2377))) ; Statement: $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r14) 
(define-const var1185 String (cast-from-var1744-to-String var1617)) ; Statement: r5 = (java.lang.String) $r4 
 ; Statement: if r5 != null goto i0 = virtualinvoke r5.<java.lang.String: int indexOf(int)>(59) 
(assert (not (not (= var1185 null-String)))) ; Negate: Cond: r5 != null  
 ; Statement: return null 
(check-sat)
; {var700_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var1744-to-var353=([java.lang.Object], java.util.Map), getValue/103104470=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.String), var2561_isEmpty/-813097145=([java.lang.String], boolean), var353_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1744=([java.lang.String], java.lang.Object), cast-from-var1744-to-String=([java.lang.Object], java.lang.String)}
; {var3584=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver, var3405=r12, var1048=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var2030=r9, var2616=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var2369=r3, var700=org.apache.dubbo.remoting.http12.HttpRequest, var1047=r0, var650=org.apache.dubbo.remoting.http12.HttpResponse, var3648=r13, var1744=java.lang.Object, var3999=$r1, var353=java.util.Map, var3008=r2, var2377=r14, var2561=org.apache.dubbo.common.utils.StringUtils, var2439=$z0, var1617=$r4, var1185=r5, var1459=null_type}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver=var3584, r12=var3405, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var1048, r9=var2030, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var2616, r3=var2369, org.apache.dubbo.remoting.http12.HttpRequest=var700, r0=var1047, org.apache.dubbo.remoting.http12.HttpResponse=var650, r13=var3648, java.lang.Object=var1744, $r1=var3999, java.util.Map=var353, r2=var3008, r14=var2377, org.apache.dubbo.common.utils.StringUtils=var2561, $z0=var2439, $r4=var1617, r5=var1185, null_type=var1459}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver;	r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest;	r13 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables");	r2 = (java.util.Map) $r1;	r14 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r14);	if $z0 == 0 goto (branch);	if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r14);	$r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r14);	r5 = (java.lang.String) $r4;	if r5 != null goto i0 = virtualinvoke r5.<java.lang.String: int indexOf(int)>(59);	return null
;block_num 4