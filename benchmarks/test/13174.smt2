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

(declare-sort var3130 0)
(declare-sort var2999 0)
(declare-sort var2327 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2999_getAttachment/-2134772037 (var2999 String) String)
(declare-fun var2327_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3130 var3130)
(declare-const null-var2999 var2999)
(declare-const var3614 var3130) ; Statement: r2 := @this: org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationResolverFilter 
(assert (not (= var3614 null-var3130)))
(declare-const var3739 var2999) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3739 null-var2999)))
(define-const var2900 String (var2999_getAttachment/-2134772037 var3739 "security_authentication_context")) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("security_authentication_context") 
(define-const var3303 Bool (var2327_isBlank/-523695098 (cast-from-String-to-String var2900))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r2.<org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationResolverFilter: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec mapper> 
(assert (not (= (ite var3303 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 
(check-sat)
; {var2999_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var2327_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3130=org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationResolverFilter, var3614=r2, var2999=org.apache.dubbo.rpc.Invocation, var3739=r0, var2900=r1, var2327=org.apache.dubbo.common.utils.StringUtils, var3303=$z0}
; {org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationResolverFilter=var3130, r2=var3614, org.apache.dubbo.rpc.Invocation=var2999, r0=var3739, r1=var2900, org.apache.dubbo.common.utils.StringUtils=var2327, $z0=var3303}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r2 := @this: org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationResolverFilter;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("security_authentication_context");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r3 = r2.<org.apache.dubbo.spring.security.filter.ContextHolderAuthenticationResolverFilter: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec mapper>;	return
;block_num 2