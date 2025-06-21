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

(declare-sort var2091 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2492 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2492 null-String)))
(declare-const var1626 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1626 null-Int)))
 ; Statement: if i0 != 0 goto $i1 = i0 - 1 
(assert (not (= var1626 0))) ; Cond: i0 != 0 
(define-const var617 Int (- var1626 1)) ; Statement: $i1 = i0 - 1 
(assert (and true (and (> (str.len var2492) var617) (<= 0 var617))))
(define-const var1013 Int (charAt/698050440 var2492 var617)) ; Statement: $c2 = virtualinvoke r0.<java.lang.String: char charAt(int)>($i1) 
(define-const var607 Int (cast-from-Int-to-Int var1013)) ; Statement: $i3 = (int) $c2 
 ; Statement: if $i3 != 92 goto $z0 = 0 
(assert (not (= var607 92))) ; Cond: $i3 != 92 
(define-const var227 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var2492=r0, var2091=null_type, var1626=i0, var617=$i1, var1013=$c2, var607=$i3, var227=$z0}
; {r0=var2492, null_type=var2091, i0=var1626, $i1=var617, $c2=var1013, $i3=var607, $z0=var227}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 := @parameter1: int;	if i0 != 0 goto $i1 = i0 - 1;	$i1 = i0 - 1;	$c2 = virtualinvoke r0.<java.lang.String: char charAt(int)>($i1);	$i3 = (int) $c2;	if $i3 != 92 goto $z0 = 0;	$z0 = 0;	return $z0
;block_num 4