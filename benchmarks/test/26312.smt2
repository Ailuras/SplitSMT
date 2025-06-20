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

(declare-sort var2904 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun subType/1926907315 (var2904) String)
(declare-const null-var2904 var2904)
(declare-const var1629 var2904) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression 
(assert (not (= var1629 null-var2904)))
(define-const var2048 String "*") ; Statement: $r2 = "*" 
(define-const var2665 String (subType/1926907315 var1629)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType> 
(assert true)
(define-const var2877 Bool (= var2048 var2665)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var2877 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3590 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {subType/1926907315=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression], java.lang.String)}
; {var2904=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression, var1629=r0, var2048=$r2, var2665=$r1, var2877=$z0, var3590=$z2}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression=var2904, r0=var1629, $r2=var2048, $r1=var2665, $z0=var2877, $z2=var3590}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression;	$r2 = "*";	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3