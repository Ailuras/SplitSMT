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

(declare-sort var3893 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var2601 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2601 null-String)))
(declare-const var1021 String) ; Statement: r13 := @parameter1: java.lang.String 
(assert (not (= var1021 null-String)))
(define-const var2973 String "async") ; Statement: $r1 = "async" 
(assert true)
(define-const var3203 Bool (= var2973 var2601)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "timeout" 
(assert (not (= (ite var3203 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1332 String "false") ; Statement: $r12 = "false" 
(assert true)
(define-const var991 Bool (= var1332 var1021)) ; Statement: $z11 = virtualinvoke $r12.<java.lang.String: boolean equals(java.lang.Object)>(r13) 
 ; Statement: if $z11 != 0 goto r13 = null 
(assert (not (= (ite var991 1 0) 0))) ; Cond: $z11 != 0 
(define-const var1021!1 String null-String) ; Statement: r13 = null 
(assert true) ; Non Conditional
 ; Statement: return r13 
(check-sat)
; {}
; {var2601=r0, var3893=null_type, var1021=r13, var2973=$r1, var3203=$z0, var1332=$r12, var991=$z11}
; {r0=var2601, null_type=var3893, r13=var1021, $r1=var2973, $z0=var3203, $r12=var1332, $z11=var991}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @parameter0: java.lang.String;	r13 := @parameter1: java.lang.String;	$r1 = "async";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "timeout";	$r12 = "false";	$z11 = virtualinvoke $r12.<java.lang.String: boolean equals(java.lang.Object)>(r13);	if $z11 != 0 goto r13 = null;	r13 = null;	return r13
;block_num 4