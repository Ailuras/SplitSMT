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

(declare-sort var362 0)
(declare-sort var977 0)
(declare-sort var3977 0)
(declare-sort var2485 0)
(declare-sort var651 0)
(declare-sort var2016 0)
(declare-sort var3683 0)
(declare-sort var1068 0)
(declare-sort var2352 0)
(declare-sort var1575 0)
(declare-sort var1399 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/947770232 (var977) String)
(declare-fun var651_defaultIf/-142680948 (String String) String)
(declare-fun createBean/-475427926 (var362 var977 var3977 var2485) var2016)
(declare-fun var3683-init () var3683)
(declare-fun var2352-init () var2352)
(declare-fun arr-var2016-init () (Array Int var2016))
(declare-fun cast-from-String-to-var2016 (String) var2016)
(declare-fun getType/1327638632 (var977) ClassObject)
(declare-fun cast-from-ClassObject-to-var2016 (ClassObject) var2016)
(declare-fun <init>/18639505 (var2352 var1399 var1575 (Array Int var2016)) void)
(declare-fun cast-from-var1068-to-var1399 (var1068) var1399)
(declare-const null-var362 var362)
(declare-const null-var977 var977)
(declare-const null-var3977 var3977)
(declare-const null-var2485 var2485)
(declare-const null-var1068 var1068)
(declare-const var1575-ARGUMENT_BIND_ERROR var1575)
(declare-const null-__Array__Int__var2016__ (Array Int var2016))
(declare-const var633 var362) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder 
(assert (not (= var633 null-var362)))
(declare-const var850 var977) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var850 null-var977)))
(declare-const var2685 var3977) ; Statement: r4 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var2685 null-var3977)))
(declare-const var832 var2485) ; Statement: r5 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var832 null-var2485)))
(assert true)
(define-const var1813 String (getName/947770232 var850)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.String getName()>() 
(define-const var649 String (var651_defaultIf/-142680948 var1813 "target")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>($r1, "target") 
(assert true) ; Non Conditional
(assert true)
(define-const var1384 var2016 (createBean/-475427926 var633 var850 var2685 var832)) ; Statement: r18 = specialinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder: java.lang.Object createBean(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta,org.apache.dubbo.remoting.http12.HttpRequest,org.apache.dubbo.remoting.http12.HttpResponse)>(r0, r4, r5) 
(assert true) ; Non Conditional
(define-const var828 var3683 var3683-init) ; Statement: $r19 = new org.springframework.web.bind.WebDataBinder 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var381 var1068) ; Statement: $r13 := @caughtexception 
(assert (not (= var381 null-var1068)))
(define-const var928 var2352 var2352-init) ; Statement: $r22 = new org.apache.dubbo.rpc.protocol.tri.rest.RestException 
(define-const var2207 var1575 var1575-ARGUMENT_BIND_ERROR) ; Statement: $r16 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_BIND_ERROR> 
(define-const var2773 (Array Int var2016) arr-var2016-init) ; Statement: $r15 = newarray (java.lang.Object)[2] 
(declare-const var2773!1 (Array Int var2016))
(assert (not (= var2773!1 null-__Array__Int__var2016__)))
(assert (= (select var2773!1 0) (cast-from-String-to-var2016 var649))) ; Statement: $r15[0] = r2 
(assert true)
(define-const var3490 ClassObject (getType/1327638632 var850)) ; Statement: $r17 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>() 
(declare-const var2773!2 (Array Int var2016))
(assert (not (= var2773!2 null-__Array__Int__var2016__)))
(assert (= (select var2773!2 1) (cast-from-ClassObject-to-var2016 var3490))) ; Statement: $r15[1] = $r17 
(assert true)
;(assert (<init>/18639505 var928 (cast-from-var1068-to-var1399 var381) var2207 var2773!2)) ; Statement: specialinvoke $r22.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: void <init>(java.lang.Throwable,org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r13, $r16, $r15) 

(declare-const var928!1 var2352)
(declare-const var381!1 var1068)
(declare-const var2207!1 var1575)
(declare-const var2773!3 (Array Int var2016))
 ; Statement: throw $r22 
(check-sat)
; {getName/947770232=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.String), var651_defaultIf/-142680948=([java.lang.String, java.lang.String], java.lang.String), createBean/-475427926=([org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, org.apache.dubbo.remoting.http12.HttpRequest, org.apache.dubbo.remoting.http12.HttpResponse], java.lang.Object), var3683-init=([], org.springframework.web.bind.WebDataBinder), var2352-init=([], org.apache.dubbo.rpc.protocol.tri.rest.RestException), arr-var2016-init=([], java.lang.Object[]), cast-from-String-to-var2016=([java.lang.String], java.lang.Object), getType/1327638632=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.Class), cast-from-ClassObject-to-var2016=([java.lang.Class], java.lang.Object), <init>/18639505=([org.apache.dubbo.rpc.protocol.tri.rest.RestException, java.lang.Throwable, org.apache.dubbo.rpc.protocol.tri.rest.Messages, java.lang.Object[]], void), cast-from-var1068-to-var1399=([java.lang.Exception], java.lang.Throwable)}
; {var362=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder, var633=r3, var977=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var850=r0, var3977=org.apache.dubbo.remoting.http12.HttpRequest, var2685=r4, var2485=org.apache.dubbo.remoting.http12.HttpResponse, var832=r5, var1813=$r1, var651=org.apache.dubbo.common.utils.StringUtils, var649=r2, var2016=java.lang.Object, var1384=r18, var3683=org.springframework.web.bind.WebDataBinder, var828=$r19, var1068=java.lang.Exception, var381=$r13, var2352=org.apache.dubbo.rpc.protocol.tri.rest.RestException, var928=$r22, var1575=org.apache.dubbo.rpc.protocol.tri.rest.Messages, var2207=$r16, var2773=$r15, var3490=$r17, var1399=java.lang.Throwable}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder=var362, r3=var633, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var977, r0=var850, org.apache.dubbo.remoting.http12.HttpRequest=var3977, r4=var2685, org.apache.dubbo.remoting.http12.HttpResponse=var2485, r5=var832, $r1=var1813, org.apache.dubbo.common.utils.StringUtils=var651, r2=var649, java.lang.Object=var2016, r18=var1384, org.springframework.web.bind.WebDataBinder=var3683, $r19=var828, java.lang.Exception=var1068, $r13=var381, org.apache.dubbo.rpc.protocol.tri.rest.RestException=var2352, $r22=var928, org.apache.dubbo.rpc.protocol.tri.rest.Messages=var1575, $r16=var2207, $r15=var2773, $r17=var3490, java.lang.Throwable=var1399}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder;	r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r4 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest;	r5 := @parameter2: org.apache.dubbo.remoting.http12.HttpResponse;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.String getName()>();	r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String defaultIf(java.lang.String,java.lang.String)>($r1, "target");	r18 = specialinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.support.spring.BeanArgumentBinder: java.lang.Object createBean(org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta,org.apache.dubbo.remoting.http12.HttpRequest,org.apache.dubbo.remoting.http12.HttpResponse)>(r0, r4, r5);	$r19 = new org.springframework.web.bind.WebDataBinder;	$r13 := @caughtexception;	$r22 = new org.apache.dubbo.rpc.protocol.tri.rest.RestException;	$r16 = <org.apache.dubbo.rpc.protocol.tri.rest.Messages: org.apache.dubbo.rpc.protocol.tri.rest.Messages ARGUMENT_BIND_ERROR>;	$r15 = newarray (java.lang.Object)[2];	$r15[0] = r2;	$r17 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.Class getType()>();	$r15[1] = $r17;	specialinvoke $r22.<org.apache.dubbo.rpc.protocol.tri.rest.RestException: void <init>(java.lang.Throwable,org.apache.dubbo.rpc.protocol.tri.rest.Messages,java.lang.Object[])>($r13, $r16, $r15);	throw $r22
;block_num 4