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

(declare-sort var1008 0)
(declare-sort var1272 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1272_isNumeric/1760308867 (String Bool) Bool)
(declare-const null-String String)
(declare-const var2162 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2162 null-String)))
(define-const var3246 Bool (var1272_isNumeric/1760308867 var2162 (ite (= 1 0) true false))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumeric(java.lang.String,boolean)>(r0, 0) 
 ; Statement: return $z0 
(check-sat)
; {var1272_isNumeric/1760308867=([java.lang.String, boolean], boolean)}
; {var2162=r0, var1008=null_type, var1272=org.apache.dubbo.common.utils.StringUtils, var3246=$z0}
; {r0=var2162, null_type=var1008, org.apache.dubbo.common.utils.StringUtils=var1272, $z0=var3246}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNumeric(java.lang.String,boolean)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNumeric(java.lang.String,boolean)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumeric(java.lang.String,boolean)>(r0, 0);	return $z0
;block_num 1