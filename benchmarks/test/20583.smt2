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

(declare-sort var907 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var2935 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2935 null-String)))
(declare-const var3934 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3934 null-String)))
(define-const var2012 String "$invoke") ; Statement: $r1 = "$invoke" 
(assert true)
(define-const var3267 Bool (= var2012 var3934)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 != 0 goto $r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;" 
(assert (not (= (ite var3267 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2947 String "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;") ; Statement: $r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;" 
(assert true)
(define-const var968 Bool (= var2947 var2935)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto $z3 = 0 
(assert (= (ite var968 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1782 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {}
; {var2935=r2, var907=null_type, var3934=r0, var2012=$r1, var3267=$z0, var2947=$r3, var968=$z1, var1782=$z3}
; {r2=var2935, null_type=var907, r0=var3934, $r1=var2012, $z0=var3267, $r3=var2947, $z1=var968, $z3=var1782}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = "$invoke";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 != 0 goto $r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;";	$r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;";	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 4