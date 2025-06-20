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

(declare-sort var198 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun v/-2121359482 (var198) Int)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var198 var198)
(declare-const var1435 var198) ; Statement: r0 := @this: org.antlr.v4.misc.MutableInt 
(assert (not (= var1435 null-var198)))
(define-const var2822 Int (v/-2121359482 var1435)) ; Statement: $i0 = r0.<org.antlr.v4.misc.MutableInt: int v> 
(define-const var2727 String (String_valueOf/1240665136 var2822)) ; Statement: $r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0) 
 ; Statement: return $r1 
(check-sat)
; {v/-2121359482=([org.antlr.v4.misc.MutableInt], int), String_valueOf/1240665136=([int], java.lang.String)}
; {var198=org.antlr.v4.misc.MutableInt, var1435=r0, var2822=$i0, var2727=$r1}
; {org.antlr.v4.misc.MutableInt=var198, r0=var1435, $i0=var2822, $r1=var2727}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.antlr.v4.misc.MutableInt;	$i0 = r0.<org.antlr.v4.misc.MutableInt: int v>;	$r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0);	return $r1
;block_num 1