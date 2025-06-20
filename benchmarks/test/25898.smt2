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

(declare-sort var3787 0)
(declare-sort var1665 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun segments/453503808 (var3787) (Array Int var1665))
(declare-fun getLength-Arr-var1665-1 ((Array Int var1665)) Int)
(declare-fun isDirect/-2016993560 (var3787) Bool)
(declare-const null-var3787 var3787)
(declare-const var3098 var3787) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var3098 null-var3787)))
(declare-const var759 var3787) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var759 null-var3787)))
(define-const var3027 (Array Int var1665) (segments/453503808 var3098)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments> 
(define-const var3641 Int (getLength-Arr-var1665-1 var3027)) ; Statement: i0 = lengthof $r1 
(define-const var1090 (Array Int var1665) (segments/453503808 var759)) ; Statement: $r3 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments> 
(define-const var2034 Int (getLength-Arr-var1665-1 var1090)) ; Statement: i1 = lengthof $r3 
(assert true)
(define-const var1160 Bool (isDirect/-2016993560 var3098)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>() 
 ; Statement: if $z0 == 0 goto i7 = 0 
(assert (= (ite var1160 1 0) 0)) ; Cond: $z0 == 0 
(define-const var578 Int 0) ; Statement: i7 = 0 
(assert true) ; Non Conditional
 ; Statement: if i7 >= i0 goto $i2 = i1 - i0 
(assert (>= var578 var3641)) ; Cond: i7 >= i0 
(define-const var3927 Int (- var2034 var3641)) ; Statement: $i2 = i1 - i0 
 ; Statement: return $i2 
(check-sat)
; {segments/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[]), getLength-Arr-var1665-1=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[]], int), isDirect/-2016993560=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], boolean)}
; {var3787=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var3098=r0, var759=r2, var1665=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, var3027=$r1, var3641=i0, var1090=$r3, var2034=i1, var1160=$z0, var578=i7, var3927=$i2}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var3787, r0=var3098, r2=var759, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment=var1665, $r1=var3027, i0=var3641, $r3=var1090, i1=var2034, $z0=var1160, i7=var578, $i2=var3927}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments>;	i0 = lengthof $r1;	$r3 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment[] segments>;	i1 = lengthof $r3;	$z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>();	if $z0 == 0 goto i7 = 0;	i7 = 0;	if i7 >= i0 goto $i2 = i1 - i0;	$i2 = i1 - i0;	return $i2
;block_num 4