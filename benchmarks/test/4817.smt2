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

(declare-sort var596 0)
(declare-sort var898 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const var898-TYPE ClassObject)
(declare-const var764 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var764 null-ClassObject)))
(declare-const var1009 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1009 null-String)))
(define-const var3125 ClassObject var898-TYPE) ; Statement: $r1 = <java.lang.Boolean: java.lang.Class TYPE> 
 ; Statement: if r0 == $r1 goto $r3 = "true" 
(assert (= var764 var3125)) ; Cond: r0 == $r1 
(define-const var617 String "true") ; Statement: $r3 = "true" 
(assert true)
(define-const var1448 Bool (= var617 var1009)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 != 0 goto return 1 
(assert (not (= (ite var1448 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 1 
(check-sat)
; {}
; {var764=r0, var1009=r2, var596=null_type, var898=java.lang.Boolean, var3125=$r1, var617=$r3, var1448=$z0}
; {r0=var764, r2=var1009, null_type=var596, java.lang.Boolean=var898, $r1=var3125, $r3=var617, $z0=var1448}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r2 := @parameter1: java.lang.String;	$r1 = <java.lang.Boolean: java.lang.Class TYPE>;	if r0 == $r1 goto $r3 = "true";	$r3 = "true";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 != 0 goto return 1;	return 1
;block_num 3