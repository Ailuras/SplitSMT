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

(declare-sort var1105 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var1504 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1504 null-String)))
(declare-const var580 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var580 null-String)))
(define-const var1428 String "$invoke") ; Statement: $r1 = "$invoke" 
(assert true)
(define-const var1536 Bool (= var1428 var580)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 != 0 goto $r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;" 
(assert (not (= (ite var1536 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3107 String "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;") ; Statement: $r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;" 
(assert true)
(define-const var2995 Bool (= var3107 var1504)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto $z3 = 0 
(assert (not (= (ite var2995 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var1916 Bool (ite (= 1 1) true false)) ; Statement: $z3 = 1 
 ; Statement: goto [?= return $z3] 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {}
; {var1504=r2, var1105=null_type, var580=r0, var1428=$r1, var1536=$z0, var3107=$r3, var2995=$z1, var1916=$z3}
; {r2=var1504, null_type=var1105, r0=var580, $r1=var1428, $z0=var1536, $r3=var3107, $z1=var2995, $z3=var1916}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = "$invoke";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 != 0 goto $r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;";	$r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;";	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto $z3 = 0;	$z3 = 1;	goto [?= return $z3];	return $z3
;block_num 4