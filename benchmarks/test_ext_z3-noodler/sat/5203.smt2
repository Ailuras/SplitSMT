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

(declare-sort var633 0)
(declare-sort var2421 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2421_isNumber/1050655655 (String) Bool)
(declare-const null-String String)
(declare-const var917 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var917 null-String)))
(define-const var1589 Bool (var2421_isNumber/1050655655 var917)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $l0 = 0L 
(assert (= (ite var1589 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1186 Int 0) ; Statement: $l0 = 0L 
(assert true) ; Non Conditional
 ; Statement: return $l0 
(check-sat)
; {var2421_isNumber/1050655655=([java.lang.String], boolean)}
; {var917=r0, var633=null_type, var2421=org.apache.dubbo.common.utils.StringUtils, var1589=$z0, var1186=$l0}
; {r0=var917, null_type=var633, org.apache.dubbo.common.utils.StringUtils=var2421, $z0=var1589, $l0=var1186}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0);	if $z0 == 0 goto $l0 = 0L;	$l0 = 0L;	return $l0
;block_num 3