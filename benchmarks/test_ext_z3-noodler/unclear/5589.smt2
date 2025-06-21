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

(declare-sort var2670 0)
(declare-sort var2581 0)
(declare-sort var2298 0)
(declare-sort var2413 0)
(declare-sort var1047 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-Int-to-Float32 (Int) Float32)
(declare-fun cast-from-Float32-to-Int (Float32) Int)
(declare-fun var2581-init () var2581)
(declare-fun <init>/643259939 (var2581 Int) void)
(declare-fun var2298-init () var2298)
(declare-fun <init>/613807010 (var2298 Int) void)
(declare-fun var2413-init () var2413)
(declare-fun <init>/-130489206 (var2413 var2581 var1047 var1047 var1047 String) void)
(declare-fun cast-from-var2298-to-var1047 (var2298) var1047)
(declare-const null-String String)
(declare-const var28 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var28 null-String)))
; split operation: var3990 = var28.split("&") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&") 
(define-const var2430 Int (get_split_length var28 "&" -1)) ; Statement: $i0 = lengthof r1 
(define-const var1563 Float32 (cast-from-Int-to-Float32 var2430)) ; Statement: $f0 = (float) $i0 
(define-const var183 Float32 (fp.div roundNearestTiesToEven var1563 ((_ to_fp 8 24) #x3f400000))) ; Statement: $f1 = $f0 / 0.75F 
(define-const var3559 Int (cast-from-Float32-to-Int var183)) ; Statement: $i1 = (int) $f1 
(define-const var2594 Int (+ var3559 1)) ; Statement: i2 = $i1 + 1 
(define-const var44 var2581 var2581-init) ; Statement: $r2 = new java.util.BitSet 
(assert true)
;(assert (<init>/643259939 var44 var2594)) ; Statement: specialinvoke $r2.<java.util.BitSet: void <init>(int)>(i2) 

(declare-const var44!1 var2581)
(declare-const var2594!1 Int)
(define-const var120 var2298 var2298-init) ; Statement: $r3 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var120 var2594!1)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var120!1 var2298)
(declare-const var2594!2 Int)
(define-const var971 var2298 var2298-init) ; Statement: $r4 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var971 var2594!2)) ; Statement: specialinvoke $r4.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var971!1 var2298)
(declare-const var2594!3 Int)
(define-const var1588 var2298 var2298-init) ; Statement: $r5 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var1588 var2594!3)) ; Statement: specialinvoke $r5.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var1588!1 var2298)
(declare-const var2594!4 Int)
(define-const var303 Int (get_split_length var28 "&" -1)) ; Statement: i3 = lengthof r1 
(define-const var3157 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i3 goto $r6 = new org.apache.dubbo.common.url.component.URLParam 
(assert (>= var3157 var303)) ; Cond: i8 >= i3 
(define-const var874 var2413 var2413-init) ; Statement: $r6 = new org.apache.dubbo.common.url.component.URLParam 
(assert true)
;(assert (<init>/-130489206 var874 var44!1 (cast-from-var2298-to-var1047 var120!1) (cast-from-var2298-to-var1047 var971!1) (cast-from-var2298-to-var1047 var1588!1) var28)) ; Statement: specialinvoke $r6.<org.apache.dubbo.common.url.component.URLParam: void <init>(java.util.BitSet,java.util.Map,java.util.Map,java.util.Map,java.lang.String)>($r2, $r3, $r4, $r5, r0) 

(declare-const var874!1 var2413)
(declare-const var44!2 var2581)
(declare-const var120!2 var2298)
(declare-const var971!2 var2298)
(declare-const var1588!2 var2298)
(declare-const var28!1 String)
 ; Statement: return $r6 
(check-sat)
; {cast-from-Int-to-Float32=([int], float), cast-from-Float32-to-Int=([float], int), var2581-init=([], java.util.BitSet), <init>/643259939=([java.util.BitSet, int], void), var2298-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), var2413-init=([], org.apache.dubbo.common.url.component.URLParam), <init>/-130489206=([org.apache.dubbo.common.url.component.URLParam, java.util.BitSet, java.util.Map, java.util.Map, java.util.Map, java.lang.String], void), cast-from-var2298-to-var1047=([java.util.HashMap], java.util.Map)}
; {var28=r0, var2670=null_type, var3990=r1, var2430=$i0, var1563=$f0, var183=$f1, var3559=$i1, var2594=i2, var2581=java.util.BitSet, var44=$r2, var2298=java.util.HashMap, var120=$r3, var971=$r4, var1588=$r5, var303=i3, var3157=i8, var2413=org.apache.dubbo.common.url.component.URLParam, var874=$r6, var1047=java.util.Map}
; {r0=var28, null_type=var2670, r1=var3990, $i0=var2430, $f0=var1563, $f1=var183, $i1=var3559, i2=var2594, java.util.BitSet=var2581, $r2=var44, java.util.HashMap=var2298, $r3=var120, $r4=var971, $r5=var1588, i3=var303, i8=var3157, org.apache.dubbo.common.url.component.URLParam=var2413, $r6=var874, java.util.Map=var1047}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&");	$i0 = lengthof r1;	$f0 = (float) $i0;	$f1 = $f0 / 0.75F;	$i1 = (int) $f1;	i2 = $i1 + 1;	$r2 = new java.util.BitSet;	specialinvoke $r2.<java.util.BitSet: void <init>(int)>(i2);	$r3 = new java.util.HashMap;	specialinvoke $r3.<java.util.HashMap: void <init>(int)>(i2);	$r4 = new java.util.HashMap;	specialinvoke $r4.<java.util.HashMap: void <init>(int)>(i2);	$r5 = new java.util.HashMap;	specialinvoke $r5.<java.util.HashMap: void <init>(int)>(i2);	i3 = lengthof r1;	i8 = 0;	if i8 >= i3 goto $r6 = new org.apache.dubbo.common.url.component.URLParam;	$r6 = new org.apache.dubbo.common.url.component.URLParam;	specialinvoke $r6.<org.apache.dubbo.common.url.component.URLParam: void <init>(java.util.BitSet,java.util.Map,java.util.Map,java.util.Map,java.lang.String)>($r2, $r3, $r4, $r5, r0);	return $r6
;block_num 3