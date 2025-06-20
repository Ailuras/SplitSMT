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

(declare-sort var3263 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var1345 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1345 null-String)))
(declare-const var73 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var73 null-String)))
(define-const var1645 String "$echo") ; Statement: $r1 = "$echo" 
(assert true)
(define-const var454 Bool (= var1645 var73)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var454 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2028 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {}
; {var1345=r2, var3263=null_type, var73=r0, var1645=$r1, var454=$z0, var2028=$z2}
; {r2=var1345, null_type=var3263, r0=var73, $r1=var1645, $z0=var454, $z2=var2028}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = "$echo";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3