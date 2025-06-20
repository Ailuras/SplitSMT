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

(declare-sort var216 0)
(declare-sort var2446 0)
(declare-sort var873 0)
(declare-sort var992 0)
(declare-sort var2019 0)
(declare-sort var865 0)
(declare-sort var1915 0)
(declare-sort var2681 0)
(declare-sort var3890 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var992_attribute/1471010634 (var992 String) var865)
(declare-fun cast-from-var865-to-var1915 (var865) var1915)
(declare-fun getValue/103104470 (var873) String)
(declare-fun var2681_isEmpty/-813097145 (String) Bool)
(declare-fun var1915_get/1088891777 (var1915 var865) var865)
(declare-fun cast-from-String-to-var865 (String) var865)
(declare-fun cast-from-var865-to-String (var865) String)
(declare-const null-var216 var216)
(declare-const null-var2446 var2446)
(declare-const null-var873 var873)
(declare-const null-var992 var992)
(declare-const null-var2019 var2019)
(declare-const null-var1915 var1915)
(declare-const null-String String)
(declare-const var1351 var216) ; Statement: r11 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver 
(assert (not (= var1351 null-var216)))
(declare-const var3617 var2446) ; Statement: r5 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var3617 null-var2446)))
(declare-const var3418 var873) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var3418 null-var873)))
(declare-const var3126 var992) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3126 null-var992)))
(declare-const var2937 var2019) ; Statement: r12 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var2937 null-var2019)))
(define-const var2598 var865 (var992_attribute/1471010634 var3126 "org.springframework.web.servlet.HandlerMapping.uriTemplateVariables")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables") 
(define-const var3200 var1915 (cast-from-var865-to-var1915 var2598)) ; Statement: r2 = (java.util.Map) $r1 
(assert true)
(define-const var1800 String (getValue/103104470 var3418)) ; Statement: r13 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>() 
(define-const var2474 Bool (var2681_isEmpty/-813097145 var1800)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r13) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var2474 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r13) 
(assert (not (= var3200 null-var1915))) ; Cond: r2 != null 
(define-const var3849 var865 (var1915_get/1088891777 var3200 (cast-from-String-to-var865 var1800))) ; Statement: $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r13) 
(define-const var2718 String (cast-from-var865-to-String var3849)) ; Statement: r14 = (java.lang.String) $r4 
 ; Statement: if r14 != null goto i0 = virtualinvoke r14.<java.lang.String: int indexOf(int)>(59) 
(assert (not (not (= var2718 null-String)))) ; Negate: Cond: r14 != null  
 ; Statement: return null 
(check-sat)
; {var992_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var865-to-var1915=([java.lang.Object], java.util.Map), getValue/103104470=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.String), var2681_isEmpty/-813097145=([java.lang.String], boolean), var1915_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var865=([java.lang.String], java.lang.Object), cast-from-var865-to-String=([java.lang.Object], java.lang.String)}
; {var216=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver, var1351=r11, var2446=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var3617=r5, var873=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var3418=r3, var992=org.apache.dubbo.remoting.http12.HttpRequest, var3126=r0, var2019=org.apache.dubbo.remoting.http12.HttpResponse, var2937=r12, var865=java.lang.Object, var2598=$r1, var1915=java.util.Map, var3200=r2, var1800=r13, var2681=org.apache.dubbo.common.utils.StringUtils, var2474=$z0, var3849=$r4, var2718=r14, var3890=null_type}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver=var216, r11=var1351, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var2446, r5=var3617, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var873, r3=var3418, org.apache.dubbo.remoting.http12.HttpRequest=var992, r0=var3126, org.apache.dubbo.remoting.http12.HttpResponse=var2019, r12=var2937, java.lang.Object=var865, $r1=var2598, java.util.Map=var1915, r2=var3200, r13=var1800, org.apache.dubbo.common.utils.StringUtils=var2681, $z0=var2474, $r4=var3849, r14=var2718, null_type=var3890}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r11 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver;	r5 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest;	r12 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables");	r2 = (java.util.Map) $r1;	r13 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r13);	if $z0 == 0 goto (branch);	if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r13);	$r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r13);	r14 = (java.lang.String) $r4;	if r14 != null goto i0 = virtualinvoke r14.<java.lang.String: int indexOf(int)>(59);	return null
;block_num 4