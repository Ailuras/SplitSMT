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

(declare-sort var1870 0)
(declare-sort var484 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var484_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3138 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3138 null-String)))
(declare-const var1543 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var1543 null-Int)))
(define-const var310 Bool (var484_isNotEmpty/-1251449450 var3138)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = 0 
(assert (= (ite var310 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3274 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var484_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3138=r0, var1870=null_type, var1543=c0, var484=org.apache.dubbo.common.utils.StringUtils, var310=$z0, var3274=$z1}
; {r0=var3138, null_type=var1870, c0=var1543, org.apache.dubbo.common.utils.StringUtils=var484, $z0=var310, $z1=var3274}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3