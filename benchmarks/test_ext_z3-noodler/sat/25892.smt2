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

(declare-sort var1077 0)
(declare-sort var2996 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun segments/453503808 (var1077) (Array Int var2996))
(declare-fun getLength-Arr-var2996-1 ((Array Int var2996)) Int)
(declare-fun isDirect/-2016993560 (var1077) Bool)
(declare-fun path/453503808 (var1077) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var1077 var1077)
(declare-const var3833 var1077) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var3833 null-var1077)))
(declare-const var2346 var1077) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var2346 null-var1077)))
(define-const var3951 (Array Int var2996) (segments/453503808 var3833)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments> 
(define-const var2308 Int (getLength-Arr-var2996-1 var3951)) ; Statement: i0 = lengthof $r1 
(define-const var2327 (Array Int var2996) (segments/453503808 var2346)) ; Statement: $r3 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments> 
(define-const var2565 Int (getLength-Arr-var2996-1 var2327)) ; Statement: i1 = lengthof $r3 
(assert true)
(define-const var609 Bool (isDirect/-2016993560 var3833)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>() 
 ; Statement: if $z0 == 0 goto i7 = 0 
(assert (not (= (ite var609 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3834 Bool (isDirect/-2016993560 var2346)) ; Statement: $z1 = virtualinvoke r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>() 
 ; Statement: if $z1 == 0 goto i7 = 0 
(assert (not (= (ite var3834 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var531 String (path/453503808 var2346)) ; Statement: $r8 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var1632 Int (length/-134980193 var531)) ; Statement: $i5 = virtualinvoke $r8.<java.lang.String: int length()>() 
(define-const var3217 String (path/453503808 var3833)) ; Statement: $r9 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var2025 Int (length/-134980193 var3217)) ; Statement: $i4 = virtualinvoke $r9.<java.lang.String: int length()>() 
(define-const var194 Int (- var1632 var2025)) ; Statement: $i6 = $i5 - $i4 
 ; Statement: return $i6 
(check-sat)
; {segments/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[]), getLength-Arr-var2996-1=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[]], int), isDirect/-2016993560=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], boolean), path/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var1077=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var3833=r0, var2346=r2, var2996=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, var3951=$r1, var2308=i0, var2327=$r3, var2565=i1, var609=$z0, var3834=$z1, var531=$r8, var1632=$i5, var3217=$r9, var2025=$i4, var194=$i6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var1077, r0=var3833, r2=var2346, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment=var2996, $r1=var3951, i0=var2308, $r3=var2327, i1=var2565, $z0=var609, $z1=var3834, $r8=var531, $i5=var1632, $r9=var3217, $i4=var2025, $i6=var194}
;seq <java.lang.String: int length()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 2}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments>;	i0 = lengthof $r1;	$r3 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments>;	i1 = lengthof $r3;	$z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>();	if $z0 == 0 goto i7 = 0;	$z1 = virtualinvoke r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>();	if $z1 == 0 goto i7 = 0;	$r8 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	$i5 = virtualinvoke $r8.<java.lang.String: int length()>();	$r9 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	$i4 = virtualinvoke $r9.<java.lang.String: int length()>();	$i6 = $i5 - $i4;	return $i6
;block_num 3