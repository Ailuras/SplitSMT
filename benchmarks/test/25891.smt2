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

(declare-sort var337 0)
(declare-sort var251 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun path/453503808 (var337) String)
(declare-const null-var337 var337)
(declare-const null-String String)
(declare-const var204 var337) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var204 null-var337)))
(declare-const var470 var337) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var470 null-var337)))
(declare-const var1802 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1802 null-String)))
(define-const var1758 String (path/453503808 var204)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var3890 Bool (= var1758 var1802)) ; Statement: z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
(define-const var2562 String (path/453503808 var470)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var844 Bool (= var2562 var1802)) ; Statement: z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (not (= (ite var3890 1 0) 0))) ; Negate: Cond: z0 == 0  
 ; Statement: if z1 == 0 goto $b1 = -1 
(assert (= (ite var844 1 0) 0)) ; Cond: z1 == 0 
(define-const var777 Int -1) ; Statement: $b1 = -1 
(assert true) ; Non Conditional
 ; Statement: return $b1 
(check-sat)
; {path/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], java.lang.String)}
; {var337=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var204=r0, var470=r3, var1802=r1, var251=null_type, var1758=$r2, var3890=z0, var2562=$r4, var844=z1, var777=$b1}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var337, r0=var204, r3=var470, r1=var1802, null_type=var251, $r2=var1758, z0=var3890, $r4=var2562, z1=var844, $b1=var777}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r3 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r1 := @parameter1: java.lang.String;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	$r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if z0 == 0 goto (branch);	if z1 == 0 goto $b1 = -1;	$b1 = -1;	return $b1
;block_num 4