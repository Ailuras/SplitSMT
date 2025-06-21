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

(declare-sort var545 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1904 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1904 null-String)))
(declare-const var1714 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1714 null-Int)))
(define-const var3417 (Array Int String) arr-String-init) ; Statement: r4 = newarray (java.lang.String)[2] 
(define-const var3148 Int (+ var1714 3)) ; Statement: i1 = i0 + 3 
(define-const var511 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
 ; Statement: if i0 != $i3 goto (branch) 
(assert (not (= var1714 var511))) ; Cond: i0 != $i3 
 ; Statement: if i0 < 0 goto $r0 = newarray (java.lang.String)[1] 
(assert (< var1714 0)) ; Cond: i0 < 0 
(define-const var542 (Array Int String) arr-String-init) ; Statement: $r0 = newarray (java.lang.String)[1] 
(declare-const var542!1 (Array Int String))
(assert (not (= var542!1 null-__Array__Int__String__)))
(assert (= (select var542!1 0) var1904)) ; Statement: $r0[0] = r3 
(define-const var3417!1 (Array Int String) var542!1) ; Statement: r4 = $r0 
(assert true) ; Non Conditional
 ; Statement: return r4 
(check-sat)
; {arr-String-init=([], java.lang.String[]), cast-from-Int-to-Int=([int], int)}
; {var1904=r3, var545=null_type, var1714=i0, var3417=r4, var3148=i1, var511=$i3, var542=$r0}
; {r3=var1904, null_type=var545, i0=var1714, r4=var3417, i1=var3148, $i3=var511, $r0=var542}
;seq 
;cnt {}
;stmts r3 := @parameter0: java.lang.String;	i0 := @parameter1: int;	r4 = newarray (java.lang.String)[2];	i1 = i0 + 3;	$i3 = (int) -1;	if i0 != $i3 goto (branch);	if i0 < 0 goto $r0 = newarray (java.lang.String)[1];	$r0 = newarray (java.lang.String)[1];	$r0[0] = r3;	r4 = $r0;	return r4
;block_num 4