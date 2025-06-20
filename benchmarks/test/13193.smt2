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

(declare-sort var2874 0)
(declare-sort var850 0)
(declare-sort var3961 0)
(declare-sort var2354 0)
(declare-sort var2640 0)
(declare-sort var1306 0)
(declare-sort var1008 0)
(declare-sort var1077 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2354_getContext/332271150 () var3961)
(declare-fun var3961_getAuthentication/-1885783651 (var3961) var2640)
(declare-fun mapper/-1767565137 (var2874) var1306)
(declare-fun serialize/1675344993 (var1306 var1008) String)
(declare-fun cast-from-var2640-to-var1008 (var2640) var1008)
(declare-fun var1077_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2874 var2874)
(declare-const null-var850 var850)
(declare-const var2132 var2874) ; Statement: r2 := @this: org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter 
(assert (not (= var2132 null-var2874)))
(declare-const var3918 var850) ; Statement: r5 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3918 null-var850)))
(define-const var3487 var3961 var2354_getContext/332271150) ; Statement: r0 = staticinvoke <org.springframework.security.core.context.SecurityContextHolder: org.springframework.security.core.context.SecurityContext getContext()>() 
(define-const var28 var2640 (var3961_getAuthentication/-1885783651 var3487)) ; Statement: r1 = interfaceinvoke r0.<org.springframework.security.core.context.SecurityContext: org.springframework.security.core.Authentication getAuthentication()>() 
(define-const var1240 var1306 (mapper/-1767565137 var2132)) ; Statement: $r3 = r2.<org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec mapper> 
(assert true)
(define-const var2395 String (serialize/1675344993 var1240 (cast-from-var2640-to-var1008 var28))) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.spring.security.jackson.ObjectMapperCodec: java.lang.String serialize(java.lang.Object)>(r1) 
(define-const var1782 Bool (var1077_isBlank/-523695098 (cast-from-String-to-String var2395))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r4) 
 ; Statement: if $z0 == 0 goto interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: void setObjectAttachment(java.lang.String,java.lang.Object)>("security_authentication_context", r4) 
(assert (not (= (ite var1782 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 
(check-sat)
; {var2354_getContext/332271150=([], org.springframework.security.core.context.SecurityContext), var3961_getAuthentication/-1885783651=([org.springframework.security.core.context.SecurityContext], org.springframework.security.core.Authentication), mapper/-1767565137=([org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter], org.apache.dubbo.spring.security.jackson.ObjectMapperCodec), serialize/1675344993=([org.apache.dubbo.spring.security.jackson.ObjectMapperCodec, java.lang.Object], java.lang.String), cast-from-var2640-to-var1008=([org.springframework.security.core.Authentication], java.lang.Object), var1077_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2874=org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter, var2132=r2, var850=org.apache.dubbo.rpc.Invocation, var3918=r5, var3961=org.springframework.security.core.context.SecurityContext, var2354=org.springframework.security.core.context.SecurityContextHolder, var3487=r0, var2640=org.springframework.security.core.Authentication, var28=r1, var1306=org.apache.dubbo.spring.security.jackson.ObjectMapperCodec, var1240=$r3, var1008=java.lang.Object, var2395=r4, var1077=org.apache.dubbo.common.utils.StringUtils, var1782=$z0}
; {org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter=var2874, r2=var2132, org.apache.dubbo.rpc.Invocation=var850, r5=var3918, org.springframework.security.core.context.SecurityContext=var3961, org.springframework.security.core.context.SecurityContextHolder=var2354, r0=var3487, org.springframework.security.core.Authentication=var2640, r1=var28, org.apache.dubbo.spring.security.jackson.ObjectMapperCodec=var1306, $r3=var1240, java.lang.Object=var1008, r4=var2395, org.apache.dubbo.common.utils.StringUtils=var1077, $z0=var1782}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r2 := @this: org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter;	r5 := @parameter0: org.apache.dubbo.rpc.Invocation;	r0 = staticinvoke <org.springframework.security.core.context.SecurityContextHolder: org.springframework.security.core.context.SecurityContext getContext()>();	r1 = interfaceinvoke r0.<org.springframework.security.core.context.SecurityContext: org.springframework.security.core.Authentication getAuthentication()>();	$r3 = r2.<org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationPrepareFilter: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec mapper>;	r4 = virtualinvoke $r3.<org.apache.dubbo.spring.security.jackson.ObjectMapperCodec: java.lang.String serialize(java.lang.Object)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r4);	if $z0 == 0 goto interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: void setObjectAttachment(java.lang.String,java.lang.Object)>("security_authentication_context", r4);	return
;block_num 2