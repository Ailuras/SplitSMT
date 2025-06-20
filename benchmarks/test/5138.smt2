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

(declare-sort var1342 0)
(declare-sort var217 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var217_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-String String)
(declare-const var2741 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2741 null-String)))
(define-const var3566 Bool (var217_isNotEmpty/-1251449450 var2741)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var3566 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2981 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {var217_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2741=r0, var1342=null_type, var217=org.apache.dubbo.common.utils.StringUtils, var3566=$z0, var2981=$z2}
; {r0=var2741, null_type=var1342, org.apache.dubbo.common.utils.StringUtils=var217, $z0=var3566, $z2=var2981}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3