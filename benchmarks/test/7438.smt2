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

(declare-sort var1653 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1653_isWord/-1022222217 (Int) Bool)
(declare-const null-Int Int)
(declare-const var1802 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1802 null-Int)))
(define-const var2848 Int (cast-from-Int-to-Int var1802)) ; Statement: $c1 = (char) i0 
(define-const var72 Bool (var1653_isWord/-1022222217 var2848)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(char)>($c1) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-Int-to-Int=([int], char), var1653_isWord/-1022222217=([char], boolean)}
; {var1802=i0, var2848=$c1, var1653=org.apache.dubbo.common.utils.StringUtils, var72=$z0}
; {i0=var1802, $c1=var2848, org.apache.dubbo.common.utils.StringUtils=var1653, $z0=var72}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isWord(char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isWord(char)>": 1}
;stmts i0 := @parameter0: int;	$c1 = (char) i0;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(char)>($c1);	return $z0
;block_num 1