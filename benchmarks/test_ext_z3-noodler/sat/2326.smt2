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

(declare-sort var1109 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1577871405 (var1109) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-const null-var1109 var1109)
(declare-const var533 var1109) ; Statement: r0 := @this: org.antlr.v4.tool.Rule 
(assert (not (= var533 null-var1109)))
(define-const var3027 String (name/1577871405 var533)) ; Statement: $r1 = r0.<org.antlr.v4.tool.Rule: java.lang.String name> 
(assert true)
(define-const var1773 Int (hashCode/-467973558 var3027)) ; Statement: $i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>() 
 ; Statement: return $i0 
(check-sat)
; {name/1577871405=([org.antlr.v4.tool.Rule], java.lang.String), hashCode/-467973558=([java.lang.String], int)}
; {var1109=org.antlr.v4.tool.Rule, var533=r0, var3027=$r1, var1773=$i0}
; {org.antlr.v4.tool.Rule=var1109, r0=var533, $r1=var3027, $i0=var1773}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.antlr.v4.tool.Rule;	$r1 = r0.<org.antlr.v4.tool.Rule: java.lang.String name>;	$i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>();	return $i0
;block_num 1