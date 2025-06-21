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

(declare-sort var2665 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-String String)
(declare-const var1712 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1712 null-String)))
(declare-const var3940 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3940 null-String)))
 ; Statement: if r0 == null goto return 0 
(assert (not (= var1712 null-String))) ; Negate: Cond: r0 == null  
 ; Statement: if r1 == null goto return 0 
(assert (not (= var3940 null-String))) ; Negate: Cond: r1 == null  
(assert true)
(define-const var1891 Int (length/-134980193 var1712)) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true)
(define-const var2141 Int (length/-134980193 var3940)) ; Statement: $i0 = virtualinvoke r1.<java.lang.String: int length()>() 
 ; Statement: if $i1 >= $i0 goto $i2 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (not (>= var1891 var2141))) ; Negate: Cond: $i1 >= $i0  
 ; Statement: return 0 
(check-sat)
; {length/-134980193=([java.lang.String], int)}
; {var1712=r0, var2665=null_type, var3940=r1, var1891=$i1, var2141=$i0}
; {r0=var1712, null_type=var2665, r1=var3940, $i1=var1891, $i0=var2141}
;seq <java.lang.String: int length()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 2}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	if r0 == null goto return 0;	if r1 == null goto return 0;	$i1 = virtualinvoke r0.<java.lang.String: int length()>();	$i0 = virtualinvoke r1.<java.lang.String: int length()>();	if $i1 >= $i0 goto $i2 = virtualinvoke r1.<java.lang.String: int length()>();	return 0
;block_num 4