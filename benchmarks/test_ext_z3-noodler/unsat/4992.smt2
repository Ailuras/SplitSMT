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

(declare-sort var720 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var730 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var730 null-String)))
(declare-const var335 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var335 null-String)))
 ; Statement: if r0 == null goto $r2 = "providers" 
(assert (= var335 null-String)) ; Cond: r0 == null 
(define-const var2766 String "providers") ; Statement: $r2 = "providers" 
(assert true)
(define-const var1162 Bool (= var2766 var730)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: return $z0 
(check-sat)
; {}
; {var730=r1, var720=null_type, var335=r0, var2766=$r2, var1162=$z0}
; {r1=var730, null_type=var720, r0=var335, $r2=var2766, $z0=var1162}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	if r0 == null goto $r2 = "providers";	$r2 = "providers";	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	return $z0
;block_num 2