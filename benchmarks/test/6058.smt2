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

(declare-sort var2932 0)
(declare-sort var211 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var211-init () var211)
(declare-fun <init>/613807010 (var211 Int) void)
(declare-const null-String String)
(declare-const var1990 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1990 null-String)))
(declare-const var759 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var759 null-String)))
; split operation: var1274 = var1990.split(var759) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1) 
(define-const var3695 var211 var211-init) ; Statement: $r3 = new java.util.HashMap 
(define-const var2466 Int (get_split_length var1990 var759 -1)) ; Statement: $i0 = lengthof r2 
(assert true)
;(assert (<init>/613807010 var3695 var2466)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>(int)>($i0) 

(declare-const var3695!1 var211)
(declare-const var2466!1 Int)
(define-const var1926 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var3993 Int (get_split_length var1990 var759 -1)) ; Statement: $i1 = lengthof r2 
 ; Statement: if i2 >= $i1 goto return $r3 
(assert (>= var1926 var3993)) ; Cond: i2 >= $i1 
 ; Statement: return $r3 
(check-sat)
; {var211-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void)}
; {var1990=r0, var2932=null_type, var759=r1, var1274=r2, var211=java.util.HashMap, var3695=$r3, var2466=$i0, var1926=i2, var3993=$i1}
; {r0=var1990, null_type=var2932, r1=var759, r2=var1274, java.util.HashMap=var211, $r3=var3695, $i0=var2466, i2=var1926, $i1=var3993}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1);	$r3 = new java.util.HashMap;	$i0 = lengthof r2;	specialinvoke $r3.<java.util.HashMap: void <init>(int)>($i0);	i2 = 0;	$i1 = lengthof r2;	if i2 >= $i1 goto return $r3;	return $r3
;block_num 3