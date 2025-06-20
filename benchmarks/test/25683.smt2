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

(declare-sort var1217 0)
(declare-sort var2415 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun buf/617490631 (var1217) String)
(declare-fun length/-171891354 (String) Int)
(declare-const null-var1217 var1217)
(declare-const null-String String)
(declare-const var1757 var1217) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser 
(assert (not (= var1757 null-var1217)))
(declare-const var422 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var422 null-String)))
(define-const var2240 Int 0) ; Statement: b19 = 0 
(define-const var1976 Int 0) ; Statement: b32 = 0 
(define-const var3933 Int 0) ; Statement: b31 = 0 
(define-const var2367 Int 0) ; Statement: b30 = 0 
(define-const var2168 Int 0) ; Statement: b29 = 0 
(define-const var570 Int 0) ; Statement: b28 = 0 
(define-const var750 Int 0) ; Statement: b27 = 0 
(define-const var2667 Int 0) ; Statement: b26 = 0 
(define-const var1778 Int 0) ; Statement: b25 = 0 
(define-const var2023 Int 0) ; Statement: b24 = 0 
(define-const var2553 Int 0) ; Statement: b23 = 0 
(define-const var3220 Int 0) ; Statement: b22 = 0 
(define-const var132 Int 0) ; Statement: b21 = 0 
(define-const var3585 Bool (ite (= 1 0) true false)) ; Statement: z0 = 0 
(define-const var1543 Bool (ite (= 1 0) true false)) ; Statement: z1 = 0 
(define-const var1165 String null-String) ; Statement: r43 = null 
(assert true)
(define-const var495 Int (length/-134980193 var422)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var1921 Int 0) ; Statement: i20 = 0 
(assert true) ; Non Conditional
 ; Statement: if i20 >= i0 goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf> 
(assert (>= var1921 var495)) ; Cond: i20 >= i0 
(define-const var3168 String (buf/617490631 var1757)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf> 
(assert true)
(define-const var2363 Int (length/-171891354 var3168)) ; Statement: $i1 = virtualinvoke $r2.<java.lang.StringBuilder: int length()>() 
 ; Statement: if $i1 <= 0 goto return 
(assert (<= var2363 0)) ; Cond: $i1 <= 0 
 ; Statement: return 
(check-sat)
; {length/-134980193=([java.lang.String], int), buf/617490631=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser], java.lang.StringBuilder), length/-171891354=([java.lang.StringBuilder], int)}
; {var1217=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser, var1757=r1, var422=r0, var2415=null_type, var2240=b19, var1976=b32, var3933=b31, var2367=b30, var2168=b29, var570=b28, var750=b27, var2667=b26, var1778=b25, var2023=b24, var2553=b23, var3220=b22, var132=b21, var3585=z0, var1543=z1, var1165=r43, var495=i0, var1921=i20, var3168=$r2, var2363=$i1}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser=var1217, r1=var1757, r0=var422, null_type=var2415, b19=var2240, b32=var1976, b31=var3933, b30=var2367, b29=var2168, b28=var570, b27=var750, b26=var2667, b25=var1778, b24=var2023, b23=var2553, b22=var3220, b21=var132, z0=var3585, z1=var1543, r43=var1165, i0=var495, i20=var1921, $r2=var3168, $i1=var2363}
;seq <java.lang.String: int length()>;	<java.lang.StringBuilder: int length()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: int length()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser;	r0 := @parameter0: java.lang.String;	b19 = 0;	b32 = 0;	b31 = 0;	b30 = 0;	b29 = 0;	b28 = 0;	b27 = 0;	b26 = 0;	b25 = 0;	b24 = 0;	b23 = 0;	b22 = 0;	b21 = 0;	z0 = 0;	z1 = 0;	r43 = null;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	i20 = 0;	if i20 >= i0 goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf>;	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf>;	$i1 = virtualinvoke $r2.<java.lang.StringBuilder: int length()>();	if $i1 <= 0 goto return;	return
;block_num 4