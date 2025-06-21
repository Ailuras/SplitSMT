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

(declare-sort var2181 0)
(declare-sort var575 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun path/453503808 (var2181) String)
(declare-fun compareTo/1684932850 (var2181 var2181) Int)
(declare-const null-var2181 var2181)
(declare-const null-String String)
(declare-const var2843 var2181) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var2843 null-var2181)))
(declare-const var3092 var2181) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var3092 null-var2181)))
(declare-const var2991 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2991 null-String)))
(define-const var888 String (path/453503808 var2843)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var3055 Bool (= var888 var2991)) ; Statement: z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
(define-const var632 String (path/453503808 var3092)) ; Statement: $r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var1910 Bool (= var632 var2991)) ; Statement: z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (= (ite var3055 1 0) 0)) ; Cond: z0 == 0 
 ; Statement: if z1 == 0 goto $i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression)>(r3) 
(assert (= (ite var1910 1 0) 0)) ; Cond: z1 == 0 
(assert true)
(define-const var3697 Int (compareTo/1684932850 var2843 var3092)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression)>(r3) 
 ; Statement: return $i0 
(check-sat)
; {path/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], java.lang.String), compareTo/1684932850=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], int)}
; {var2181=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var2843=r0, var3092=r3, var2991=r1, var575=null_type, var888=$r2, var3055=z0, var632=$r4, var1910=z1, var3697=$i0}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var2181, r0=var2843, r3=var3092, r1=var2991, null_type=var575, $r2=var888, z0=var3055, $r4=var632, z1=var1910, $i0=var3697}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r3 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r1 := @parameter1: java.lang.String;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	$r4 = r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if z0 == 0 goto (branch);	if z1 == 0 goto $i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression)>(r3);	$i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression)>(r3);	return $i0
;block_num 3