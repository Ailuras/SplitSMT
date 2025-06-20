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

(declare-sort var2914 0)
(declare-sort var1933 0)
(declare-sort var2792 0)
(declare-sort var1296 0)
(declare-sort var1680 0)
(declare-sort var2585 0)
(declare-sort var382 0)
(declare-sort var1365 0)
(declare-sort var1529 0)
(declare-sort var2490 0)
(declare-sort var777 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1296_attribute/1471010634 (var1296 String) var2585)
(declare-fun cast-from-var2585-to-var382 (var2585) var382)
(declare-fun getValue/103104470 (var2792) String)
(declare-fun var1365_isEmpty/-813097145 (String) Bool)
(declare-fun var1529_isRequired/-724586201 (var2792) Bool)
(declare-fun var2490-init () var2490)
(declare-fun arr-var2585-init () (Array Int var2585))
(declare-fun cast-from-String-to-var2585 (String) var2585)
(declare-fun getType/1327638632 (var1933) ClassObject)
(declare-fun cast-from-ClassObject-to-var2585 (ClassObject) var2585)
(declare-fun <init>/-197578376 (var2490 var777 (Array Int var2585)) void)
(declare-const null-var2914 var2914)
(declare-const null-var1933 var1933)
(declare-const null-var2792 var2792)
(declare-const null-var1296 var1296)
(declare-const null-var1680 var1680)
(declare-const null-var382 var382)
(declare-const var777-ARGUMENT_VALUE_MISSING var777)
(declare-const null-__Array__Int__var2585__ (Array Int var2585))
(declare-const var2182 var2914) ; Statement: r12 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver 
(assert (not (= var2182 null-var2914)))
(declare-const var779 var1933) ; Statement: r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var779 null-var1933)))
(declare-const var3086 var2792) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var3086 null-var2792)))
(declare-const var3012 var1296) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var3012 null-var1296)))
(declare-const var577 var1680) ; Statement: r13 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var577 null-var1680)))
(define-const var2458 var2585 (var1296_attribute/1471010634 var3012 "org.springframework.web.servlet.HandlerMapping.uriTemplateVariables")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables") 
(define-const var1534 var382 (cast-from-var2585-to-var382 var2458)) ; Statement: r2 = (java.util.Map) $r1 
(assert true)
(define-const var3250 String (getValue/103104470 var3086)) ; Statement: r14 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>() 
(define-const var3858 Bool (var1365_isEmpty/-813097145 var3250)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r14) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3858 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r14) 
(assert (not (not (= var1534 null-var382)))) ; Negate: Cond: r2 != null  
(define-const var1885 Bool (var1529_isRequired/-724586201 var3086)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Helper: boolean isRequired(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta)>(r3) 
 ; Statement: if $z1 == 0 goto return null 
(assert (not (= (ite var1885 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2001 var2490 var2490-init) ; Statement: $r16 = new org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException 
(define-const var3069 var777 var777-ARGUMENT_VALUE_MISSING) ; Statement: $r10 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_VALUE_MISSING> 
(define-const var2968 (Array Int var2585) arr-var2585-init) ; Statement: $r8 = newarray (java.lang.Object)[2] 
(declare-const var2968!1 (Array Int var2585))
(assert (not (= var2968!1 null-__Array__Int__var2585__)))
(assert (= (select var2968!1 0) (cast-from-String-to-var2585 var3250))) ; Statement: $r8[0] = r14 
(assert true)
(define-const var1448 ClassObject (getType/1327638632 var779)) ; Statement: $r11 = virtualinvoke r9.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>() 
(declare-const var2968!2 (Array Int var2585))
(assert (not (= var2968!2 null-__Array__Int__var2585__)))
(assert (= (select var2968!2 1) (cast-from-ClassObject-to-var2585 var1448))) ; Statement: $r8[1] = $r11 
(assert true)
;(assert (<init>/-197578376 var2001 var3069 var2968!2)) ; Statement: specialinvoke $r16.<org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r10, $r8) 

(declare-const var2001!1 var2490)
(declare-const var3069!1 var777)
(declare-const var2968!3 (Array Int var2585))
 ; Statement: throw $r16 
(check-sat)
; {var1296_attribute/1471010634=([org.apache.dubbo.remoting.http12.HttpRequest, java.lang.String], java.lang.Object), cast-from-var2585-to-var382=([java.lang.Object], java.util.Map), getValue/103104470=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.String), var1365_isEmpty/-813097145=([java.lang.String], boolean), var1529_isRequired/-724586201=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], boolean), var2490-init=([], org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException), arr-var2585-init=([], java.lang.Object[]), cast-from-String-to-var2585=([java.lang.String], java.lang.Object), getType/1327638632=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.Class), cast-from-ClassObject-to-var2585=([java.lang.Class], java.lang.Object), <init>/-197578376=([org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException, org.apache.dubbo.rpc.protocol.tri.rest.Messages, java.lang.Object[]], void)}
; {var2914=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver, var2182=r12, var1933=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var779=r9, var2792=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var3086=r3, var1296=org.apache.dubbo.remoting.http12.HttpRequest, var3012=r0, var1680=org.apache.dubbo.remoting.http12.HttpResponse, var577=r13, var2585=java.lang.Object, var2458=$r1, var382=java.util.Map, var1534=r2, var3250=r14, var1365=org.apache.dubbo.common.utils.StringUtils, var3858=$z0, var1529=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Helper, var1885=$z1, var2490=org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException, var2001=$r16, var777=org.apache.dubbo.rpc.protocol.tri.rest.Messages, var3069=$r10, var2968=$r8, var1448=$r11}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver=var2914, r12=var2182, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var1933, r9=var779, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var2792, r3=var3086, org.apache.dubbo.remoting.http12.HttpRequest=var1296, r0=var3012, org.apache.dubbo.remoting.http12.HttpResponse=var1680, r13=var577, java.lang.Object=var2585, $r1=var2458, java.util.Map=var382, r2=var1534, r14=var3250, org.apache.dubbo.common.utils.StringUtils=var1365, $z0=var3858, org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Helper=var1529, $z1=var1885, org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException=var2490, $r16=var2001, org.apache.dubbo.rpc.protocol.tri.rest.Messages=var777, $r10=var3069, $r8=var2968, $r11=var1448}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.PathVariableArgumentResolver;	r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r3 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	r0 := @parameter2: org.apache.dubbo.remoting.http12.HttpRequest;	r13 := @parameter3: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.Object attribute(java.lang.String)>("org.springframework.web.servlet.HandlerMapping.uriTemplateVariables");	r2 = (java.util.Map) $r1;	r14 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r14);	if $z0 == 0 goto (branch);	if r2 != null goto $r4 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r14);	$z1 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.support.spring.Helper: boolean isRequired(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta)>(r3);	if $z1 == 0 goto return null;	$r16 = new org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException;	$r10 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_VALUE_MISSING>;	$r8 = newarray (java.lang.Object)[2];	$r8[0] = r14;	$r11 = virtualinvoke r9.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>();	$r8[1] = $r11;	specialinvoke $r16.<org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r10, $r8);	throw $r16
;block_num 4