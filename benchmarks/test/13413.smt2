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

(declare-sort var1315 0)
(declare-sort var2583 0)
(declare-sort var54 0)
(declare-sort var2618 0)
(declare-sort var3357 0)
(declare-sort var395 0)
(declare-sort var1938 0)
(declare-sort var3132 0)
(declare-sort var1401 0)
(declare-sort var3364 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/947770232 (var2583) String)
(declare-fun var3357_defaultIf/-142680948 (String String) String)
(declare-fun var1938-init () var1938)
(declare-fun arr-var1401-init () (Array Int var1401))
(declare-fun cast-from-String-to-var1401 (String) var1401)
(declare-fun getType/1327638632 (var2583) ClassObject)
(declare-fun cast-from-ClassObject-to-var1401 (ClassObject) var1401)
(declare-fun <init>/18639505 (var1938 var3364 var3132 (Array Int var1401)) void)
(declare-fun cast-from-var395-to-var3364 (var395) var3364)
(declare-const null-var1315 var1315)
(declare-const null-var2583 var2583)
(declare-const null-var54 var54)
(declare-const null-var2618 var2618)
(declare-const null-var395 var395)
(declare-const var3132-ARGUMENT_BIND_ERROR var3132)
(declare-const null-__Array__Int__var1401__ (Array Int var1401))
(declare-const var3259 var1315) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder 
(assert (not (= var3259 null-var1315)))
(declare-const var661 var2583) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var661 null-var2583)))
(declare-const var204 var54) ; Statement: r4 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var204 null-var54)))
(declare-const var1235 var2618) ; Statement: r5 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var1235 null-var2618)))
(assert true)
(define-const var3488 String (getName/947770232 var661)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.String getName()>() 
(define-const var1110 String (var3357_defaultIf/-142680948 var3488 "target")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>($r1, "target") 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var110 var395) ; Statement: $r13 := @caughtexception 
(assert (not (= var110 null-var395)))
(define-const var1255 var1938 var1938-init) ; Statement: $r22 = new org.apache.dubbo.rpc.protocol.tri.rest.RestException 
(define-const var739 var3132 var3132-ARGUMENT_BIND_ERROR) ; Statement: $r16 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_BIND_ERROR> 
(define-const var2786 (Array Int var1401) arr-var1401-init) ; Statement: $r15 = newarray (java.lang.Object)[2] 
(declare-const var2786!1 (Array Int var1401))
(assert (not (= var2786!1 null-__Array__Int__var1401__)))
(assert (= (select var2786!1 0) (cast-from-String-to-var1401 var1110))) ; Statement: $r15[0] = r2 
(assert true)
(define-const var3343 ClassObject (getType/1327638632 var661)) ; Statement: $r17 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>() 
(declare-const var2786!2 (Array Int var1401))
(assert (not (= var2786!2 null-__Array__Int__var1401__)))
(assert (= (select var2786!2 1) (cast-from-ClassObject-to-var1401 var3343))) ; Statement: $r15[1] = $r17 
(assert true)
;(assert (<init>/18639505 var1255 (cast-from-var395-to-var3364 var110) var739 var2786!2)) ; Statement: specialinvoke $r22.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: void <init>(java.lang.Throwable,org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r13, $r16, $r15) 

(declare-const var1255!1 var1938)
(declare-const var110!1 var395)
(declare-const var739!1 var3132)
(declare-const var2786!3 (Array Int var1401))
 ; Statement: throw $r22 
(check-sat)
; {getName/947770232=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.String), var3357_defaultIf/-142680948=([java.lang.String, java.lang.String], java.lang.String), var1938-init=([], org.apache.dubbo.rpc.protocol.tri.rest.RestException), arr-var1401-init=([], java.lang.Object[]), cast-from-String-to-var1401=([java.lang.String], java.lang.Object), getType/1327638632=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.Class), cast-from-ClassObject-to-var1401=([java.lang.Class], java.lang.Object), <init>/18639505=([org.apache.dubbo.rpc.protocol.tri.rest.RestException, java.lang.Throwable, org.apache.dubbo.rpc.protocol.tri.rest.Messages, java.lang.Object[]], void), cast-from-var395-to-var3364=([java.lang.Exception], java.lang.Throwable)}
; {var1315=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder, var3259=r3, var2583=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var661=r0, var54=org.apache.dubbo.remoting.http12.HttpRequest, var204=r4, var2618=org.apache.dubbo.remoting.http12.HttpResponse, var1235=r5, var3488=$r1, var3357=org.apache.dubbo.common.utils.StringUtils, var1110=r2, var395=java.lang.Exception, var110=$r13, var1938=org.apache.dubbo.rpc.protocol.tri.rest.RestException, var1255=$r22, var3132=org.apache.dubbo.rpc.protocol.tri.rest.Messages, var739=$r16, var1401=java.lang.Object, var2786=$r15, var3343=$r17, var3364=java.lang.Throwable}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder=var1315, r3=var3259, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var2583, r0=var661, org.apache.dubbo.remoting.http12.HttpRequest=var54, r4=var204, org.apache.dubbo.remoting.http12.HttpResponse=var2618, r5=var1235, $r1=var3488, org.apache.dubbo.common.utils.StringUtils=var3357, r2=var1110, java.lang.Exception=var395, $r13=var110, org.apache.dubbo.rpc.protocol.tri.rest.RestException=var1938, $r22=var1255, org.apache.dubbo.rpc.protocol.tri.rest.Messages=var3132, $r16=var739, java.lang.Object=var1401, $r15=var2786, $r17=var3343, java.lang.Throwable=var3364}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder;	r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r4 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest;	r5 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.String getName()>();	r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>($r1, "target");	$r13 := @caughtexception;	$r22 = new org.apache.dubbo.rpc.protocol.tri.rest.RestException;	$r16 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_BIND_ERROR>;	$r15 = newarray (java.lang.Object)[2];	$r15[0] = r2;	$r17 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>();	$r15[1] = $r17;	specialinvoke $r22.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: void <init>(java.lang.Throwable,org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r13, $r16, $r15);	throw $r22
;block_num 2