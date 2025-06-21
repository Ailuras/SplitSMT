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

(declare-sort var1162 0)
(declare-sort var2321 0)
(declare-sort var1697 0)
(declare-sort var3242 0)
(declare-sort var3748 0)
(declare-sort var3956 0)
(declare-sort var3457 0)
(declare-sort var3678 0)
(declare-sort var63 0)
(declare-sort var2023 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/947770232 (var2321) String)
(declare-fun var3748_defaultIf/-142680948 (String String) String)
(declare-fun createBean/-475427926 (var1162 var2321 var1697 var3242) var3956)
(declare-fun var3678-init () var3678)
(declare-fun arr-var3956-init () (Array Int var3956))
(declare-fun cast-from-String-to-var3956 (String) var3956)
(declare-fun getType/1327638632 (var2321) ClassObject)
(declare-fun cast-from-ClassObject-to-var3956 (ClassObject) var3956)
(declare-fun <init>/18639505 (var3678 var2023 var63 (Array Int var3956)) void)
(declare-fun cast-from-var3457-to-var2023 (var3457) var2023)
(declare-const null-var1162 var1162)
(declare-const null-var2321 var2321)
(declare-const null-var1697 var1697)
(declare-const null-var3242 var3242)
(declare-const null-var3457 var3457)
(declare-const var63-ARGUMENT_BIND_ERROR var63)
(declare-const null-__Array__Int__var3956__ (Array Int var3956))
(declare-const var1278 var1162) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder 
(assert (not (= var1278 null-var1162)))
(declare-const var924 var2321) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var924 null-var2321)))
(declare-const var277 var1697) ; Statement: r4 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var277 null-var1697)))
(declare-const var199 var3242) ; Statement: r5 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var199 null-var3242)))
(assert true)
(define-const var1144 String (getName/947770232 var924)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.String getName()>() 
(define-const var3713 String (var3748_defaultIf/-142680948 var1144 "target")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>($r1, "target") 
(assert true) ; Non Conditional
(assert true)
(define-const var3988 var3956 (createBean/-475427926 var1278 var924 var277 var199)) ; Statement: r18 = specialinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder: java.lang.Object createBean(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta,org.apache.dubbo.remoting.http12.HttpRequest,org.apache.dubbo.remoting.http12.HttpResponse)>(r0, r4, r5) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var483 var3457) ; Statement: $r13 := @caughtexception 
(assert (not (= var483 null-var3457)))
(define-const var2912 var3678 var3678-init) ; Statement: $r22 = new org.apache.dubbo.rpc.protocol.tri.rest.RestException 
(define-const var2448 var63 var63-ARGUMENT_BIND_ERROR) ; Statement: $r16 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_BIND_ERROR> 
(define-const var406 (Array Int var3956) arr-var3956-init) ; Statement: $r15 = newarray (java.lang.Object)[2] 
(declare-const var406!1 (Array Int var3956))
(assert (not (= var406!1 null-__Array__Int__var3956__)))
(assert (= (select var406!1 0) (cast-from-String-to-var3956 var3713))) ; Statement: $r15[0] = r2 
(assert true)
(define-const var1593 ClassObject (getType/1327638632 var924)) ; Statement: $r17 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>() 
(declare-const var406!2 (Array Int var3956))
(assert (not (= var406!2 null-__Array__Int__var3956__)))
(assert (= (select var406!2 1) (cast-from-ClassObject-to-var3956 var1593))) ; Statement: $r15[1] = $r17 
(assert true)
;(assert (<init>/18639505 var2912 (cast-from-var3457-to-var2023 var483) var2448 var406!2)) ; Statement: specialinvoke $r22.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: void <init>(java.lang.Throwable,org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r13, $r16, $r15) 

(declare-const var2912!1 var3678)
(declare-const var483!1 var3457)
(declare-const var2448!1 var63)
(declare-const var406!3 (Array Int var3956))
 ; Statement: throw $r22 
(check-sat)
; {getName/947770232=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.String), var3748_defaultIf/-142680948=([java.lang.String, java.lang.String], java.lang.String), createBean/-475427926=([org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, org.apache.dubbo.remoting.http12.HttpRequest, org.apache.dubbo.remoting.http12.HttpResponse], java.lang.Object), var3678-init=([], org.apache.dubbo.rpc.protocol.tri.rest.RestException), arr-var3956-init=([], java.lang.Object[]), cast-from-String-to-var3956=([java.lang.String], java.lang.Object), getType/1327638632=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.Class), cast-from-ClassObject-to-var3956=([java.lang.Class], java.lang.Object), <init>/18639505=([org.apache.dubbo.rpc.protocol.tri.rest.RestException, java.lang.Throwable, org.apache.dubbo.rpc.protocol.tri.rest.Messages, java.lang.Object[]], void), cast-from-var3457-to-var2023=([java.lang.Exception], java.lang.Throwable)}
; {var1162=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder, var1278=r3, var2321=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var924=r0, var1697=org.apache.dubbo.remoting.http12.HttpRequest, var277=r4, var3242=org.apache.dubbo.remoting.http12.HttpResponse, var199=r5, var1144=$r1, var3748=org.apache.dubbo.common.utils.StringUtils, var3713=r2, var3956=java.lang.Object, var3988=r18, var3457=java.lang.Exception, var483=$r13, var3678=org.apache.dubbo.rpc.protocol.tri.rest.RestException, var2912=$r22, var63=org.apache.dubbo.rpc.protocol.tri.rest.Messages, var2448=$r16, var406=$r15, var1593=$r17, var2023=java.lang.Throwable}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder=var1162, r3=var1278, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var2321, r0=var924, org.apache.dubbo.remoting.http12.HttpRequest=var1697, r4=var277, org.apache.dubbo.remoting.http12.HttpResponse=var3242, r5=var199, $r1=var1144, org.apache.dubbo.common.utils.StringUtils=var3748, r2=var3713, java.lang.Object=var3956, r18=var3988, java.lang.Exception=var3457, $r13=var483, org.apache.dubbo.rpc.protocol.tri.rest.RestException=var3678, $r22=var2912, org.apache.dubbo.rpc.protocol.tri.rest.Messages=var63, $r16=var2448, $r15=var406, $r17=var1593, java.lang.Throwable=var2023}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder;	r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r4 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest;	r5 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.String getName()>();	r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>($r1, "target");	r18 = specialinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder: java.lang.Object createBean(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta,org.apache.dubbo.remoting.http12.HttpRequest,org.apache.dubbo.remoting.http12.HttpResponse)>(r0, r4, r5);	$r13 := @caughtexception;	$r22 = new org.apache.dubbo.rpc.protocol.tri.rest.RestException;	$r16 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_BIND_ERROR>;	$r15 = newarray (java.lang.Object)[2];	$r15[0] = r2;	$r17 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>();	$r15[1] = $r17;	specialinvoke $r22.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: void <init>(java.lang.Throwable,org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r13, $r16, $r15);	throw $r22
;block_num 3