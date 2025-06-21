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

(declare-sort var2069 0)
(declare-sort var3878 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3878-init () var3878)
(declare-fun <init>/613807010 (var3878 Int) void)
(declare-const null-String String)
(declare-const var2210 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2210 null-String)))
(declare-const var3945 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3945 null-String)))
; split operation: var506 = var2210.split(var3945) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1) 
(define-const var3714 var3878 var3878-init) ; Statement: $r3 = new java.util.HashMap 
(define-const var1389 Int (get_split_length var2210 var3945 -1)) ; Statement: $i0 = lengthof r2 
(assert true)
;(assert (<init>/613807010 var3714 var1389)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>(int)>($i0) 

(declare-const var3714!1 var3878)
(declare-const var1389!1 Int)
(define-const var1759 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var3226 Int (get_split_length var2210 var3945 -1)) ; Statement: $i1 = lengthof r2 
 ; Statement: if i2 >= $i1 goto return $r3 
(assert (>= var1759 var3226)) ; Cond: i2 >= $i1 
 ; Statement: return $r3 
(check-sat)
; {var3878-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void)}
; {var2210=r0, var2069=null_type, var3945=r1, var506=r2, var3878=java.util.HashMap, var3714=$r3, var1389=$i0, var1759=i2, var3226=$i1}
; {r0=var2210, null_type=var2069, r1=var3945, r2=var506, java.util.HashMap=var3878, $r3=var3714, $i0=var1389, i2=var1759, $i1=var3226}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1);	$r3 = new java.util.HashMap;	$i0 = lengthof r2;	specialinvoke $r3.<java.util.HashMap: void <init>(int)>($i0);	i2 = 0;	$i1 = lengthof r2;	if i2 >= $i1 goto return $r3;	return $r3
;block_num 3