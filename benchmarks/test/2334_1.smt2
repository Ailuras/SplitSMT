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

(declare-sort var1994 0)
(declare-sort var2345 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2345_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2854 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2854 null-String)))
(declare-const var2804 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2804 null-Int)))
(define-const var1628 Bool (var2345_isNotEmpty/-1251449450 var2854)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return r0 
(assert (= (ite var1628 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r0 
(check-sat)
; {var2345_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2854=r0, var1994=null_type, var2804=i0, var2345=org.apache.dubbo.common.utils.StringUtils, var1628=$z0}
; {r0=var2854, null_type=var1994, i0=var2804, org.apache.dubbo.common.utils.StringUtils=var2345, $z0=var1628}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return r0;	return r0
;block_num 2