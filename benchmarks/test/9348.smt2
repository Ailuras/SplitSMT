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

(declare-sort var2576 0)
(declare-sort var3607 0)
(declare-sort var2954 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2954_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2576 var2576)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const var2414 var2576) ; Statement: r1 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer 
(assert (not (= var2414 null-var2576)))
(declare-const var2657 ClassObject) ; Statement: r2 := @parameter0: java.lang.Class 
(assert (not (= var2657 null-ClassObject)))
(declare-const var3521 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3521 null-String)))
(define-const var3055 Bool (var2954_isNotEmpty/-1251449450 var3521)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return 0 
(assert (= (ite var3055 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 0 
(check-sat)
; {var2954_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2576=org.apache.dubbo.config.deploy.DefaultApplicationDeployer, var2414=r1, var2657=r2, var3521=r0, var3607=null_type, var2954=org.apache.dubbo.common.utils.StringUtils, var3055=$z0}
; {org.apache.dubbo.config.deploy.DefaultApplicationDeployer=var2576, r1=var2414, r2=var2657, r0=var3521, null_type=var3607, org.apache.dubbo.common.utils.StringUtils=var2954, $z0=var3055}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer;	r2 := @parameter0: java.lang.Class;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return 0;	return 0
;block_num 2