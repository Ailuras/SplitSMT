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

(declare-sort var906 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var2597 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2597 null-String)))
(declare-const var2520 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2520 null-String)))
(define-const var731 String "*") ; Statement: $r1 = "*" 
(assert true)
(define-const var2826 Bool (= var731 var2597)) ; Statement: z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
(define-const var1654 String "*") ; Statement: $r3 = "*" 
(assert true)
(define-const var251 Bool (= var1654 var2520)) ; Statement: z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (not (= (ite var2826 1 0) 0))) ; Negate: Cond: z0 == 0  
 ; Statement: if z1 != 0 goto (branch) 
(assert (not (not (= (ite var251 1 0) 0)))) ; Negate: Cond: z1 != 0  
 ; Statement: return 1 
(check-sat)
; {}
; {var2597=r0, var906=null_type, var2520=r2, var731=$r1, var2826=z0, var1654=$r3, var251=z1}
; {r0=var2597, null_type=var906, r2=var2520, $r1=var731, z0=var2826, $r3=var1654, z1=var251}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$r1 = "*";	z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	$r3 = "*";	z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if z0 == 0 goto (branch);	if z1 != 0 goto (branch);	return 1
;block_num 3