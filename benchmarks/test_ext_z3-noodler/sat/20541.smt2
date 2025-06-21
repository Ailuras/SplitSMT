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

(declare-sort var3793 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var563 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var563 null-String)))
(declare-const var3654 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3654 null-String)))
(define-const var2354 String "$invoke") ; Statement: $r1 = "$invoke" 
(assert true)
(define-const var1357 Bool (= var2354 var3654)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 != 0 goto $r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;" 
(assert (not (not (= (ite var1357 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3943 String "$invokeAsync") ; Statement: $r4 = "$invokeAsync" 
(assert true)
(define-const var1061 Bool (= var3943 var3654)) ; Statement: $z2 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z2 == 0 goto $z3 = 0 
(assert (= (ite var1061 1 0) 0)) ; Cond: $z2 == 0 
(define-const var3556 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {}
; {var563=r2, var3793=null_type, var3654=r0, var2354=$r1, var1357=$z0, var3943=$r4, var1061=$z2, var3556=$z3}
; {r2=var563, null_type=var3793, r0=var3654, $r1=var2354, $z0=var1357, $r4=var3943, $z2=var1061, $z3=var3556}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = "$invoke";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 != 0 goto $r3 = "Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/Object;";	$r4 = "$invokeAsync";	$z2 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z2 == 0 goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 4