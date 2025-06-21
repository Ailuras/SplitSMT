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

(declare-sort var264 0)
(declare-sort var1131 0)
(declare-sort var2008 0)
(declare-sort var3205 0)
(declare-sort var3805 0)
(declare-sort var1960 0)
(declare-sort var2455 0)
(declare-sort var566 0)
(declare-sort var743 0)
(declare-sort var927 0)
(declare-sort var363 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3205_attribute/1471010634 (var3205 String) var1960)
(declare-fun cast-from-var1960-to-var2455 (var1960) var2455)
(declare-fun getValue/103104470 (var2008) String)
(declare-fun var566_isEmpty/-813097145 (String) Bool)
(declare-fun var743_isRequired/-81497226 (var1131) Bool)
(declare-fun var927-init () var927)
(declare-fun arr-var1960-init () (Array Int var1960))
(declare-fun cast-from-String-to-var1960 (String) var1960)
(declare-fun getType/1327638632 (var1131) ClassObject)
(declare-fun cast-from-ClassObject-to-var1960 (ClassObject) var1960)
(declare-fun <init>/-197578376 (var927 var363 (Array Int var1960)) void)
(declare-const null-var264 var264)
(declare-const null-var1131 var1131)
(declare-const null-var2008 var2008)
(declare-const null-var3205 var3205)
(declare-const null-var3805 var3805)
(declare-const null-var2455 var2455)
(declare-const var363-ARGUMENT_VALUE_MISSING var363)
(declare-const null-__Array__Int__var1960__ (Array Int var1960))
(declare-const var1310 var264) ; Statement: r11 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver 
(assert (not (= var1310 null-var264)))
(declare-const var3029 var1131) ; Statement: r5 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var3029 null-var1131)))
(declare-const var357 var2008) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var357 null-var2008)))
(declare-const var3358 var3205) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3358 null-var3205)))
(declare-const var1964 var3805) ; Statement: r12 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var1964 null-var3805)))
(define-const var1610 var1960 (var3205_attribute/1471010634 var3358 "org.springframework.web.servlet.HandlerMapping.uriTemplateVariables")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables") 
(define-const var3400 var2455 (cast-from-var1960-to-var2455 var1610)) ; Statement: r2 = (java.util.Map) $r1 
(assert true)
(define-const var3532 String (getValue/103104470 var357)) ; Statement: r13 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>() 
(define-const var741 Bool (var566_isEmpty/-813097145 var3532)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r13) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var741 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r13) 
(assert (not (not (= var3400 null-var2455)))) ; Negate: Cond: r2 != null  
(define-const var2884 Bool (var743_isRequired/-81497226 var3029)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Helper: boolean isRequired(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta)>(r5) 
 ; Statement: if $z2 == 0 goto return null 
(assert (not (= (ite var2884 1 0) 0))) ; Negate: Cond: $z2 == 0  
(define-const var1051 var927 var927-init) ; Statement: $r16 = new org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException 
(define-const var2124 var363 var363-ARGUMENT_VALUE_MISSING) ; Statement: $r9 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_VALUE_MISSING> 
(define-const var3750 (Array Int var1960) arr-var1960-init) ; Statement: $r8 = newarray (java.lang.Object)[2] 
(declare-const var3750!1 (Array Int var1960))
(assert (not (= var3750!1 null-__Array__Int__var1960__)))
(assert (= (select var3750!1 0) (cast-from-String-to-var1960 var3532))) ; Statement: $r8[0] = r13 
(assert true)
(define-const var3059 ClassObject (getType/1327638632 var3029)) ; Statement: $r10 = virtualinvoke r5.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>() 
(declare-const var3750!2 (Array Int var1960))
(assert (not (= var3750!2 null-__Array__Int__var1960__)))
(assert (= (select var3750!2 1) (cast-from-ClassObject-to-var1960 var3059))) ; Statement: $r8[1] = $r10 
(assert true)
;(assert (<init>/-197578376 var1051 var2124 var3750!2)) ; Statement: specialinvoke $r16.<org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r9, $r8) 

(declare-const var1051!1 var927)
(declare-const var2124!1 var363)
(declare-const var3750!3 (Array Int var1960))
 ; Statement: throw $r16 
(check-sat)
; {var3205_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var1960-to-var2455=([java.lang.Object], java.util.Map), getValue/103104470=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.String), var566_isEmpty/-813097145=([java.lang.String], boolean), var743_isRequired/-81497226=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], boolean), var927-init=([], org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException), arr-var1960-init=([], java.lang.Object[]), cast-from-String-to-var1960=([java.lang.String], java.lang.Object), getType/1327638632=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.Class), cast-from-ClassObject-to-var1960=([java.lang.Class], java.lang.Object), <init>/-197578376=([org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException, org.apache.dubbo.rpc.protocol.tri.rest.Messages, java.lang.Object[]], void)}
; {var264=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver, var1310=r11, var1131=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var3029=r5, var2008=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var357=r3, var3205=org.apache.dubbo.remoting.http12.HttpRequest, var3358=r0, var3805=org.apache.dubbo.remoting.http12.HttpResponse, var1964=r12, var1960=java.lang.Object, var1610=$r1, var2455=java.util.Map, var3400=r2, var3532=r13, var566=org.apache.dubbo.common.utils.StringUtils, var741=$z0, var743=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Helper, var2884=$z2, var927=org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException, var1051=$r16, var363=org.apache.dubbo.rpc.protocol.tri.rest.Messages, var2124=$r9, var3750=$r8, var3059=$r10}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver=var264, r11=var1310, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var1131, r5=var3029, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var2008, r3=var357, org.apache.dubbo.remoting.http12.HttpRequest=var3205, r0=var3358, org.apache.dubbo.remoting.http12.HttpResponse=var3805, r12=var1964, java.lang.Object=var1960, $r1=var1610, java.util.Map=var2455, r2=var3400, r13=var3532, org.apache.dubbo.common.utils.StringUtils=var566, $z0=var741, org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Helper=var743, $z2=var2884, org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException=var927, $r16=var1051, org.apache.dubbo.rpc.protocol.tri.rest.Messages=var363, $r9=var2124, $r8=var3750, $r10=var3059}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r11 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.PathParamArgumentResolver;	r5 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest;	r12 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables");	r2 = (java.util.Map) $r1;	r13 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r13);	if $z0 == 0 goto (branch);	if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r13);	$z2 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.Helper: boolean isRequired(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta)>(r5);	if $z2 == 0 goto return null;	$r16 = new org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException;	$r9 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_VALUE_MISSING>;	$r8 = newarray (java.lang.Object)[2];	$r8[0] = r13;	$r10 = virtualinvoke r5.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>();	$r8[1] = $r10;	specialinvoke $r16.<org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r9, $r8);	throw $r16
;block_num 4