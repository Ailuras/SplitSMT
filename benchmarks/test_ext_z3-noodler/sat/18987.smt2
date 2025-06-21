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

(declare-sort var2328 0)
(declare-sort var2190 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2190_isNumeric/1760308867 (String Bool) Bool)
(declare-const null-String String)
(declare-const var671 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var671 null-String)))
(define-const var3175 Bool (var2190_isNumeric/1760308867 var671 (ite (= 1 0) true false))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumeric(java.lang.String,boolean)>(r0, 0) 
 ; Statement: return $z0 
(check-sat)
; {var2190_isNumeric/1760308867=([java.lang.String, boolean], boolean)}
; {var671=r0, var2328=null_type, var2190=org.apache.dubbo.common.utils.StringUtils, var3175=$z0}
; {r0=var671, null_type=var2328, org.apache.dubbo.common.utils.StringUtils=var2190, $z0=var3175}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNumeric(java.lang.String,boolean)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNumeric(java.lang.String,boolean)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumeric(java.lang.String,boolean)>(r0, 0);	return $z0
;block_num 1