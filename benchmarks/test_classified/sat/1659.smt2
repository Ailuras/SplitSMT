(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var474 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var2377 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2377 null-String)))
(define-const var2903 Int 0) ; Statement: i5 = 0 
; split operation: var3835 = var2377.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var2570 Int (get_split_length var2377 "\u005c." -1)) ; Statement: i0 = lengthof r1 
(define-const var820 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
 ; Statement: if i6 >= i0 goto return i5 
(assert (>= var820 var2570)) ; Cond: i6 >= i0 
 ; Statement: return i5 
(check-sat)
; {}
; {var2377=r0, var474=null_type, var2903=i5, var3835=r1, var2570=i0, var820=i6}
; {r0=var2377, null_type=var474, i5=var2903, r1=var3835, i0=var2570, i6=var820}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i5 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	i0 = lengthof r1;	i6 = 0;	if i6 >= i0 goto return i5;	return i5
;block_num 3