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

(declare-sort var3924 0)
(declare-sort var3051 0)
(declare-sort var2728 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2728_isEmpty/-813097145 (String) Bool)
(declare-const null-var3924 var3924)
(declare-const null-String String)
(declare-const var2681 var3924) ; Statement: r5 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter 
(assert (not (= var2681 null-var3924)))
(declare-const var1629 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1629 null-String)))
(define-const var2421 Bool (var2728_isEmpty/-813097145 var1629)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.StringBuilder 
(assert (not (= (ite var2421 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 
(check-sat)
; {var2728_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3924=org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter, var2681=r5, var1629=r0, var3051=null_type, var2728=org.apache.dubbo.common.utils.StringUtils, var2421=$z0}
; {org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter=var3924, r5=var2681, r0=var1629, null_type=var3051, org.apache.dubbo.common.utils.StringUtils=var2728, $z0=var2421}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = new java.lang.StringBuilder;	return
;block_num 2