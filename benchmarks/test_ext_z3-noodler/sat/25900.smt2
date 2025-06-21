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

(declare-sort var3457 0)
(declare-sort var859 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun segments/453503808 (var3457) (Array Int var859))
(declare-fun getLength-Arr-var859-1 ((Array Int var859)) Int)
(declare-fun isDirect/-2016993560 (var3457) Bool)
(declare-const null-var3457 var3457)
(declare-const var2017 var3457) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var2017 null-var3457)))
(declare-const var3268 var3457) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var3268 null-var3457)))
(define-const var1008 (Array Int var859) (segments/453503808 var2017)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments> 
(define-const var2336 Int (getLength-Arr-var859-1 var1008)) ; Statement: i0 = lengthof $r1 
(define-const var3783 (Array Int var859) (segments/453503808 var3268)) ; Statement: $r3 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments> 
(define-const var550 Int (getLength-Arr-var859-1 var3783)) ; Statement: i1 = lengthof $r3 
(assert true)
(define-const var155 Bool (isDirect/-2016993560 var2017)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>() 
 ; Statement: if $z0 == 0 goto i7 = 0 
(assert (not (= (ite var155 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2859 Bool (isDirect/-2016993560 var3268)) ; Statement: $z1 = virtualinvoke r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>() 
 ; Statement: if $z1 == 0 goto i7 = 0 
(assert (= (ite var2859 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2955 Int 0) ; Statement: i7 = 0 
(assert true) ; Non Conditional
 ; Statement: if i7 >= i0 goto $i2 = i1 - i0 
(assert (>= var2955 var2336)) ; Cond: i7 >= i0 
(define-const var3370 Int (- var550 var2336)) ; Statement: $i2 = i1 - i0 
 ; Statement: return $i2 
(check-sat)
; {segments/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[]), getLength-Arr-var859-1=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[]], int), isDirect/-2016993560=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], boolean)}
; {var3457=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var2017=r0, var3268=r2, var859=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, var1008=$r1, var2336=i0, var3783=$r3, var550=i1, var155=$z0, var2859=$z1, var2955=i7, var3370=$i2}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var3457, r0=var2017, r2=var3268, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment=var859, $r1=var1008, i0=var2336, $r3=var3783, i1=var550, $z0=var155, $z1=var2859, i7=var2955, $i2=var3370}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments>;	i0 = lengthof $r1;	$r3 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments>;	i1 = lengthof $r3;	$z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>();	if $z0 == 0 goto i7 = 0;	$z1 = virtualinvoke r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>();	if $z1 == 0 goto i7 = 0;	i7 = 0;	if i7 >= i0 goto $i2 = i1 - i0;	$i2 = i1 - i0;	return $i2
;block_num 5