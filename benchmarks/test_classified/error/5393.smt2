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

(declare-sort var1700 0)
(declare-sort var1313 0)
(declare-sort var2170 0)
(declare-sort var1058 0)
(declare-sort var2360 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-Int-to-Real (Int) Real)
(declare-fun cast-from-Real-to-Int (Real) Int)
(declare-fun var1313-init () var1313)
(declare-fun <init>/643259939 (var1313 Int) void)
(declare-fun var2170-init () var2170)
(declare-fun <init>/613807010 (var2170 Int) void)
(declare-fun var1058-init () var1058)
(declare-fun <init>/-130489206 (var1058 var1313 var2360 var2360 var2360 String) void)
(declare-fun cast-from-var2170-to-var2360 (var2170) var2360)
(declare-const null-String String)
(declare-const var3206 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3206 null-String)))
; split operation: var3633 = var3206.split("&") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&") 
(define-const var168 Int (get_split_length var3206 "&" -1)) ; Statement: $i0 = lengthof r1 
(define-const var630 Real (cast-from-Int-to-Real var168)) ; Statement: $f0 = (float) $i0 
(define-const var3038 Real (/ round var630 ((_ to_fp 8 24) #x3f400000))) ; Statement: $f1 = $f0 / 0.75F 
(define-const var317 Int (cast-from-Real-to-Int var3038)) ; Statement: $i1 = (int) $f1 
(define-const var826 Int (+ var317 1)) ; Statement: i2 = $i1 + 1 
(define-const var3373 var1313 var1313-init) ; Statement: $r2 = new java.util.BitSet 
(assert true)
;(assert (<init>/643259939 var3373 var826)) ; Statement: specialinvoke $r2.<java.util.BitSet: void <init>(int)>(i2) 

(declare-const var3373!1 var1313)
(declare-const var826!1 Int)
(define-const var768 var2170 var2170-init) ; Statement: $r3 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var768 var826!1)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var768!1 var2170)
(declare-const var826!2 Int)
(define-const var3532 var2170 var2170-init) ; Statement: $r4 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var3532 var826!2)) ; Statement: specialinvoke $r4.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var3532!1 var2170)
(declare-const var826!3 Int)
(define-const var274 var2170 var2170-init) ; Statement: $r5 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var274 var826!3)) ; Statement: specialinvoke $r5.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var274!1 var2170)
(declare-const var826!4 Int)
(define-const var3381 Int (get_split_length var3206 "&" -1)) ; Statement: i3 = lengthof r1 
(define-const var1406 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i3 goto $r6 = new org.apache.dubbo.common.url.component.URLParam 
(assert (>= var1406 var3381)) ; Cond: i8 >= i3 
(define-const var661 var1058 var1058-init) ; Statement: $r6 = new org.apache.dubbo.common.url.component.URLParam 
(assert true)
;(assert (<init>/-130489206 var661 var3373!1 (cast-from-var2170-to-var2360 var768!1) (cast-from-var2170-to-var2360 var3532!1) (cast-from-var2170-to-var2360 var274!1) var3206)) ; Statement: specialinvoke $r6.<org.apache.dubbo.common.url.component.URLParam: void <init>(java.util.BitSet,java.util.Map,java.util.Map,java.util.Map,java.lang.String)>($r2, $r3, $r4, $r5, r0) 

(declare-const var661!1 var1058)
(declare-const var3373!2 var1313)
(declare-const var768!2 var2170)
(declare-const var3532!2 var2170)
(declare-const var274!2 var2170)
(declare-const var3206!1 String)
 ; Statement: return $r6 
(check-sat)
; {cast-from-Int-to-Real=([int], float), cast-from-Real-to-Int=([float], int), var1313-init=([], java.util.BitSet), <init>/643259939=([java.util.BitSet, int], void), var2170-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), var1058-init=([], org.apache.dubbo.common.url.component.URLParam), <init>/-130489206=([org.apache.dubbo.common.url.component.URLParam, java.util.BitSet, java.util.Map, java.util.Map, java.util.Map, java.lang.String], void), cast-from-var2170-to-var2360=([java.util.HashMap], java.util.Map)}
; {var3206=r0, var1700=null_type, var3633=r1, var168=$i0, var630=$f0, var3038=$f1, var317=$i1, var826=i2, var1313=java.util.BitSet, var3373=$r2, var2170=java.util.HashMap, var768=$r3, var3532=$r4, var274=$r5, var3381=i3, var1406=i8, var1058=org.apache.dubbo.common.url.component.URLParam, var661=$r6, var2360=java.util.Map}
; {r0=var3206, null_type=var1700, r1=var3633, $i0=var168, $f0=var630, $f1=var3038, $i1=var317, i2=var826, java.util.BitSet=var1313, $r2=var3373, java.util.HashMap=var2170, $r3=var768, $r4=var3532, $r5=var274, i3=var3381, i8=var1406, org.apache.dubbo.common.url.component.URLParam=var1058, $r6=var661, java.util.Map=var2360}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&");	$i0 = lengthof r1;	$f0 = (float) $i0;	$f1 = $f0 / 0.75F;	$i1 = (int) $f1;	i2 = $i1 + 1;	$r2 = new java.util.BitSet;	specialinvoke $r2.<java.util.BitSet: void <init>(int)>(i2);	$r3 = new java.util.HashMap;	specialinvoke $r3.<java.util.HashMap: void <init>(int)>(i2);	$r4 = new java.util.HashMap;	specialinvoke $r4.<java.util.HashMap: void <init>(int)>(i2);	$r5 = new java.util.HashMap;	specialinvoke $r5.<java.util.HashMap: void <init>(int)>(i2);	i3 = lengthof r1;	i8 = 0;	if i8 >= i3 goto $r6 = new org.apache.dubbo.common.url.component.URLParam;	$r6 = new org.apache.dubbo.common.url.component.URLParam;	specialinvoke $r6.<org.apache.dubbo.common.url.component.URLParam: void <init>(java.util.BitSet,java.util.Map,java.util.Map,java.util.Map,java.lang.String)>($r2, $r3, $r4, $r5, r0);	return $r6
;block_num 3