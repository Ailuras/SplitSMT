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

(declare-sort var3613 0)
(declare-sort var490 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun path/453503808 (var3613) String)
(declare-const null-var3613 var3613)
(declare-const null-String String)
(declare-const var2919 var3613) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var2919 null-var3613)))
(declare-const var2240 var3613) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var2240 null-var3613)))
(declare-const var2094 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2094 null-String)))
(define-const var1078 String (path/453503808 var2919)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var1607 Bool (= var1078 var2094)) ; Statement: z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
(define-const var3043 String (path/453503808 var2240)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var3832 Bool (= var3043 var2094)) ; Statement: z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (= (ite var1607 1 0) 0)) ; Cond: z0 == 0 
 ; Statement: if z1 == 0 goto $i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression)>(r3) 
(assert (not (= (ite var3832 1 0) 0))) ; Negate: Cond: z1 == 0  
 ; Statement: return 1 
(check-sat)
; {path/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], java.lang.String)}
; {var3613=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var2919=r0, var2240=r3, var2094=r1, var490=null_type, var1078=$r2, var1607=z0, var3043=$r4, var3832=z1}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var3613, r0=var2919, r3=var2240, r1=var2094, null_type=var490, $r2=var1078, z0=var1607, $r4=var3043, z1=var3832}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r3 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r1 := @parameter1: java.lang.String;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	$r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if z0 == 0 goto (branch);	if z1 == 0 goto $i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression)>(r3);	return 1
;block_num 3