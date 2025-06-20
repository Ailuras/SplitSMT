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

(declare-sort var462 0)
(declare-sort var1482 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun path/453503808 (var462) String)
(declare-const null-var462 var462)
(declare-const null-String String)
(declare-const var2843 var462) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var2843 null-var462)))
(declare-const var1875 var462) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var1875 null-var462)))
(declare-const var3289 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3289 null-String)))
(define-const var400 String (path/453503808 var2843)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var806 Bool (= var400 var3289)) ; Statement: z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
(define-const var2586 String (path/453503808 var1875)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var1582 Bool (= var2586 var3289)) ; Statement: z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (not (= (ite var806 1 0) 0))) ; Negate: Cond: z0 == 0  
 ; Statement: if z1 == 0 goto $b1 = -1 
(assert (not (= (ite var1582 1 0) 0))) ; Negate: Cond: z1 == 0  
(define-const var3466 Int 0) ; Statement: $b1 = 0 
 ; Statement: goto [?= return $b1] 
(assert true) ; Non Conditional
 ; Statement: return $b1 
(check-sat)
; {path/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], java.lang.String)}
; {var462=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var2843=r0, var1875=r3, var3289=r1, var1482=null_type, var400=$r2, var806=z0, var2586=$r4, var1582=z1, var3466=$b1}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var462, r0=var2843, r3=var1875, r1=var3289, null_type=var1482, $r2=var400, z0=var806, $r4=var2586, z1=var1582, $b1=var3466}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r3 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r1 := @parameter1: java.lang.String;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	$r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if z0 == 0 goto (branch);	if z1 == 0 goto $b1 = -1;	$b1 = 0;	goto [?= return $b1];	return $b1
;block_num 4