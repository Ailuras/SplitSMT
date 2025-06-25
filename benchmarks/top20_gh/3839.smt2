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

(declare-sort var2829 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var2014 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2014 null-String)))
(define-const var2732 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
; split operation: var1674 = var2014.split("\u005c.", var2732) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i3) 
(define-const var1382 Int (get_split_length var2014 "\u005c." var2732)) ; Statement: i0 = lengthof r1 
(define-const var2421 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return 1 
(assert (>= var2421 var1382)) ; Cond: i1 >= i0 
 ; Statement: return 1 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var2014=r0, var2829=null_type, var2732=$i3, var1674=r1, var1382=i0, var2421=i1}
; {r0=var2014, null_type=var2829, $i3=var2732, r1=var1674, i0=var1382, i1=var2421}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i3 = (int) -1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i3);	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto return 1;	return 1
;block_num 3