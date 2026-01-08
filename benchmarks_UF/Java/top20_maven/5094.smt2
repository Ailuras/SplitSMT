(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(declare-sort var2643 0)
(declare-sort var3603 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-512974245 (var2643) String)
(declare-const null-var2643 var2643)
(declare-const null-var3603 var3603)
(declare-const var3139 var2643) ; Statement: r0 := @parameter0: java.net.InetAddress 
(assert (not (= var3139 null-var2643)))
(declare-const var1381 var3603) ; Statement: r4 := @parameter1: java.util.List 
(assert (not (= var1381 null-var3603)))
(assert true)
(define-const var1073 String (toString/-512974245 var3139)) ; Statement: $r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>() 
; split operation: var3035 = var1073.split("\u005cs*/\u005cs*") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*") 
(define-const var3343 Int (get_split_length var1073 "\u005cs*/\u005cs*" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 0 goto return 
(assert (not (<= var3343 0))) ; Negate: Cond: $i0 <= 0  
(define-const var1863 Int (get_split_length var1073 "\u005cs*/\u005cs*" -1)) ; Statement: i1 = lengthof r2 
(define-const var3932 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (>= var3932 var1863)) ; Cond: i2 >= i1 
 ; Statement: return 
(check-sat)
; {toString/-512974245=([java.net.InetAddress], java.lang.String)}
; {var2643=java.net.InetAddress, var3139=r0, var3603=java.util.List, var1381=r4, var1073=$r1, var3035=r2, var3343=$i0, var1863=i1, var3932=i2}
; {java.net.InetAddress=var2643, r0=var3139, java.util.List=var3603, r4=var1381, $r1=var1073, r2=var3035, $i0=var3343, i1=var1863, i2=var3932}
;seq <java.net.InetAddress: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.InetAddress;	r4 := @parameter1: java.util.List;	$r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*");	$i0 = lengthof r2;	if $i0 <= 0 goto return;	i1 = lengthof r2;	i2 = 0;	if i2 >= i1 goto return;	return
;block_num 4
(exit)
