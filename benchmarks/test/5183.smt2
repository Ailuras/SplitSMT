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

(declare-sort var1813 0)
(declare-sort var2827 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2827_isNumber/1050655655 (String) Bool)
(declare-const null-String String)
(declare-const var2684 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2684 null-String)))
(define-const var3729 Bool (var2827_isNumber/1050655655 var2684)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i0 = 0 
(assert (= (ite var3729 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3990 Int 0) ; Statement: $i0 = 0 
(assert true) ; Non Conditional
 ; Statement: return $i0 
(check-sat)
; {var2827_isNumber/1050655655=([java.lang.String], boolean)}
; {var2684=r0, var1813=null_type, var2827=org.apache.dubbo.common.utils.StringUtils, var3729=$z0, var3990=$i0}
; {r0=var2684, null_type=var1813, org.apache.dubbo.common.utils.StringUtils=var2827, $z0=var3729, $i0=var3990}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0);	if $z0 == 0 goto $i0 = 0;	$i0 = 0;	return $i0
;block_num 3