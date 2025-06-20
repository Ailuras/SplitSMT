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

(declare-sort var298 0)
(declare-sort var300 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun segments/453503808 (var298) (Array Int var300))
(declare-fun getLength-Arr-var300-1 ((Array Int var300)) Int)
(declare-fun isDirect/-2016993560 (var298) Bool)
(declare-const null-var298 var298)
(declare-const var2980 var298) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var2980 null-var298)))
(declare-const var1922 var298) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var1922 null-var298)))
(define-const var2361 (Array Int var300) (segments/453503808 var2980)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments> 
(define-const var2172 Int (getLength-Arr-var300-1 var2361)) ; Statement: i0 = lengthof $r1 
(define-const var356 (Array Int var300) (segments/453503808 var1922)) ; Statement: $r3 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments> 
(define-const var1575 Int (getLength-Arr-var300-1 var356)) ; Statement: i1 = lengthof $r3 
(assert true)
(define-const var3015 Bool (isDirect/-2016993560 var2980)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>() 
 ; Statement: if $z0 == 0 goto i7 = 0 
(assert (= (ite var3015 1 0) 0)) ; Cond: $z0 == 0 
(define-const var165 Int 0) ; Statement: i7 = 0 
(assert true) ; Non Conditional
 ; Statement: if i7 >= i0 goto $i2 = i1 - i0 
(assert (not (>= var165 var2172))) ; Negate: Cond: i7 >= i0  
 ; Statement: if i7 >= i1 goto $i2 = i1 - i0 
(assert (>= var165 var1575)) ; Cond: i7 >= i1 
(define-const var2412 Int (- var1575 var2172)) ; Statement: $i2 = i1 - i0 
 ; Statement: return $i2 
(check-sat)
; {segments/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[]), getLength-Arr-var300-1=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[]], int), isDirect/-2016993560=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], boolean)}
; {var298=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var2980=r0, var1922=r2, var300=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, var2361=$r1, var2172=i0, var356=$r3, var1575=i1, var3015=$z0, var165=i7, var2412=$i2}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var298, r0=var2980, r2=var1922, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment=var300, $r1=var2361, i0=var2172, $r3=var356, i1=var1575, $z0=var3015, i7=var165, $i2=var2412}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments>;	i0 = lengthof $r1;	$r3 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments>;	i1 = lengthof $r3;	$z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>();	if $z0 == 0 goto i7 = 0;	i7 = 0;	if i7 >= i0 goto $i2 = i1 - i0;	if i7 >= i1 goto $i2 = i1 - i0;	$i2 = i1 - i0;	return $i2
;block_num 5