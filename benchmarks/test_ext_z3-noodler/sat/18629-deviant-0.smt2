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

(declare-sort var1885 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2644 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2644 null-String)))
(declare-const var1280 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1280 null-Int)))
 ; Statement: if i0 < 2 goto $z0 = 0 
(assert (not (< var1280 2))) ; Negate: Cond: i0 < 2  
(define-const var2081 Int (- var1280 2)) ; Statement: $i1 = i0 - 2 
(assert (not (and true (and (> (str.len var2644) var2081) (<= 0 var2081)))))
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var2644=r0, var1885=null_type, var1280=i0, var2081=$i1, var1540=$c2, var519=$i3, var3722=$z0}
; {r0=var2644, null_type=var1885, i0=var1280, $i1=var2081, $c2=var1540, $i3=var519, $z0=var3722}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 := @parameter1: int;	if i0 < 2 goto $z0 = 0;	$i1 = i0 - 2;	$c2 = virtualinvoke r0.<java.lang.String: char charAt(int)>($i1);	$i3 = (int) $c2;	if $i3 != 92 goto $z0 = 0;	$z0 = 1;	goto [?= return $z0];	return $z0
;block_num 4