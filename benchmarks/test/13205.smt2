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

(declare-sort var2151 0)
(declare-sort var435 0)
(declare-sort var1917 0)
(declare-sort var975 0)
(declare-sort var1152 0)
(declare-sort var2421 0)
(declare-sort var1849 0)
(declare-sort var3190 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var975_getContext/332271150 () var1917)
(declare-fun var1917_getAuthentication/-1885783651 (var1917) var1152)
(declare-fun mapper/-1767565137 (var2151) var2421)
(declare-fun serialize/1675344993 (var2421 var1849) String)
(declare-fun cast-from-var1152-to-var1849 (var1152) var1849)
(declare-fun var3190_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var435_setObjectAttachment/412015432 (var435 String var1849) void)
(declare-fun cast-from-String-to-var1849 (String) var1849)
(declare-const null-var2151 var2151)
(declare-const null-var435 var435)
(declare-const var1056 var2151) ; Statement: r2 := @this: org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter 
(assert (not (= var1056 null-var2151)))
(declare-const var3488 var435) ; Statement: r5 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3488 null-var435)))
(define-const var3267 var1917 var975_getContext/332271150) ; Statement: r0 = staticinvoke <org.springframework.security.core.context.SecurityContextHolder: org.springframework.security.core.context.SecurityContext getContext()>() 
(define-const var3290 var1152 (var1917_getAuthentication/-1885783651 var3267)) ; Statement: r1 = interfaceinvoke r0.<org.springframework.security.core.context.SecurityContext: org.springframework.security.core.Authentication getAuthentication()>() 
(define-const var2767 var2421 (mapper/-1767565137 var1056)) ; Statement: $r3 = r2.<org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec mapper> 
(assert true)
(define-const var2667 String (serialize/1675344993 var2767 (cast-from-var1152-to-var1849 var3290))) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.spring.security.jackson.ObjectMapperCodec: java.lang.String serialize(java.lang.Object)>(r1) 
(define-const var1160 Bool (var3190_isBlank/-523695098 (cast-from-String-to-String var2667))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r4) 
 ; Statement: if $z0 == 0 goto interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: void setObjectAttachment(java.lang.String,java.lang.Object)>("security_authentication_context", r4) 
(assert (= (ite var1160 1 0) 0)) ; Cond: $z0 == 0 
;(assert (var435_setObjectAttachment/412015432 var3488 "security_authentication_context" (cast-from-String-to-var1849 var2667))) ; Statement: interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: void setObjectAttachment(java.lang.String,java.lang.Object)>("security_authentication_context", r4) 

(declare-const var3488!1 var435)
(declare-const var1579 String)
(declare-const var2667!1 String)
 ; Statement: return 
(check-sat)
; {var975_getContext/332271150=([], org.springframework.security.core.context.SecurityContext), var1917_getAuthentication/-1885783651=([org.springframework.security.core.context.SecurityContext], org.springframework.security.core.Authentication), mapper/-1767565137=([org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter], org.apache.dubbo.spring.security.jackson.ObjectMapperCodec), serialize/1675344993=([org.apache.dubbo.spring.security.jackson.ObjectMapperCodec, java.lang.Object], java.lang.String), cast-from-var1152-to-var1849=([org.springframework.security.core.Authentication], java.lang.Object), var3190_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var435_setObjectAttachment/412015432=([org.apache.dubbo.rpc.Invocation, java.lang.String, java.lang.Object], void), cast-from-String-to-var1849=([java.lang.String], java.lang.Object)}
; {var2151=org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter, var1056=r2, var435=org.apache.dubbo.rpc.Invocation, var3488=r5, var1917=org.springframework.security.core.context.SecurityContext, var975=org.springframework.security.core.context.SecurityContextHolder, var3267=r0, var1152=org.springframework.security.core.Authentication, var3290=r1, var2421=org.apache.dubbo.spring.security.jackson.ObjectMapperCodec, var2767=$r3, var1849=java.lang.Object, var2667=r4, var3190=org.apache.dubbo.common.utils.StringUtils, var1160=$z0, var1579="security_authentication_context"}
; {org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter=var2151, r2=var1056, org.apache.dubbo.rpc.Invocation=var435, r5=var3488, org.springframework.security.core.context.SecurityContext=var1917, org.springframework.security.core.context.SecurityContextHolder=var975, r0=var3267, org.springframework.security.core.Authentication=var1152, r1=var3290, org.apache.dubbo.spring.security.jackson.ObjectMapperCodec=var2421, $r3=var2767, java.lang.Object=var1849, r4=var2667, org.apache.dubbo.common.utils.StringUtils=var3190, $z0=var1160, "security_authentication_context"=var1579}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r2 := @this: org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter;	r5 := @parameter0: org.apache.dubbo.rpc.Invocation;	r0 = staticinvoke <org.springframework.security.core.context.SecurityContextHolder: org.springframework.security.core.context.SecurityContext getContext()>();	r1 = interfaceinvoke r0.<org.springframework.security.core.context.SecurityContext: org.springframework.security.core.Authentication getAuthentication()>();	$r3 = r2.<org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec mapper>;	r4 = virtualinvoke $r3.<org.apache.dubbo.spring.security.jackson.ObjectMapperCodec: java.lang.String serialize(java.lang.Object)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r4);	if $z0 == 0 goto interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: void setObjectAttachment(java.lang.String,java.lang.Object)>("security_authentication_context", r4);	interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: void setObjectAttachment(java.lang.String,java.lang.Object)>("security_authentication_context", r4);	return
;block_num 2