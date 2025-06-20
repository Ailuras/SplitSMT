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

(declare-sort var2568 0)
(declare-sort var2166 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2166_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-String String)
(declare-const var196 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var196 null-String)))
(declare-const var2356 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2356 null-String)))
(define-const var2566 Bool (var2166_isNotEmpty/-1251449450 var196)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var2566 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1407 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {var2166_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var196=r0, var2568=null_type, var2356=r2, var2166=org.apache.dubbo.common.utils.StringUtils, var2566=$z0, var1407=$z2}
; {r0=var196, null_type=var2568, r2=var2356, org.apache.dubbo.common.utils.StringUtils=var2166, $z0=var2566, $z2=var1407}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3