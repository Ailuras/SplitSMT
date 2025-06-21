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

(declare-sort var1376 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2487 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2487 null-String)))
(declare-const var1026 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1026 null-Int)))
 ; Statement: if i0 != 0 goto $i1 = i0 - 1 
(assert (not (= var1026 0))) ; Cond: i0 != 0 
(define-const var3815 Int (- var1026 1)) ; Statement: $i1 = i0 - 1 
(assert (and true (and (> (str.len var2487) var3815) (<= 0 var3815))))
(define-const var2105 Int (charAt/698050440 var2487 var3815)) ; Statement: $c2 = virtualinvoke r0.<java.lang.String: char charAt(int)>($i1) 
(define-const var3009 Int (cast-from-Int-to-Int var2105)) ; Statement: $i3 = (int) $c2 
 ; Statement: if $i3 != 92 goto $z0 = 0 
(assert (not (not (= var3009 92)))) ; Negate: Cond: $i3 != 92  
(define-const var2677 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= return $z0] 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var2487=r0, var1376=null_type, var1026=i0, var3815=$i1, var2105=$c2, var3009=$i3, var2677=$z0}
; {r0=var2487, null_type=var1376, i0=var1026, $i1=var3815, $c2=var2105, $i3=var3009, $z0=var2677}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 := @parameter1: int;	if i0 != 0 goto $i1 = i0 - 1;	$i1 = i0 - 1;	$c2 = virtualinvoke r0.<java.lang.String: char charAt(int)>($i1);	$i3 = (int) $c2;	if $i3 != 92 goto $z0 = 0;	$z0 = 1;	goto [?= return $z0];	return $z0
;block_num 4