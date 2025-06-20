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

(declare-sort var3489 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-String String)
(declare-const var389 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var389 null-String)))
(assert true)
(define-const var3437 Int (length/-134980193 var389)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 >= 3 goto $i1 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(45) 
(assert (not (>= var3437 3))) ; Negate: Cond: $i0 >= 3  
 ; Statement: return 0 
(check-sat)
; {length/-134980193=([java.lang.String], int)}
; {var389=r0, var3489=null_type, var3437=$i0}
; {r0=var389, null_type=var3489, $i0=var3437}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 >= 3 goto $i1 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(45);	return 0
;block_num 2