(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

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

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var2925 0)
(declare-sort var1657 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1657-init () var1657)
(declare-fun <init>/613807010 (var1657 Int) void)
(declare-const null-String String)
(declare-const var3566 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3566 null-String)))
(declare-const var3817 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3817 null-String)))
; split operation: var1868 = var3566.split(var3817) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1) 
(define-const var1609 var1657 var1657-init) ; Statement: $r3 = new java.util.HashMap 
(define-const var2618 Int (get_split_length var3566 var3817 (- 1))) ; Statement: $i0 = lengthof r2 
(assert true)
;(assert (<init>/613807010 var1609 var2618)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>(int)>($i0) 

(declare-const var1609!1 var1657)
(declare-const var2618!1 Int)
(define-const var3772 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var2393 Int (get_split_length var3566 var3817 (- 1))) ; Statement: $i1 = lengthof r2 
 ; Statement: if i2 >= $i1 goto return $r3 
(assert (>= var3772 var2393)) ; Cond: i2 >= $i1 
 ; Statement: return $r3 
(check-sat)
; {var1657-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void)}
; {var3566=r0, var2925=null_type, var3817=r1, var1868=r2, var1657=java.util.HashMap, var1609=$r3, var2618=$i0, var3772=i2, var2393=$i1}
; {r0=var3566, null_type=var2925, r1=var3817, r2=var1868, java.util.HashMap=var1657, $r3=var1609, $i0=var2618, i2=var3772, $i1=var2393}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1);	$r3 = new java.util.HashMap;	$i0 = lengthof r2;	specialinvoke $r3.<java.util.HashMap: void <init>(int)>($i0);	i2 = 0;	$i1 = lengthof r2;	if i2 >= $i1 goto return $r3;	return $r3
;block_num 3
(exit)
