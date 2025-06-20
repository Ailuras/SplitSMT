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

(declare-sort var2742 0)
(declare-sort var2615 0)
(declare-sort var1079 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isDirect/-2016993560 (var2742) Bool)
(declare-fun path/453503808 (var2742) String)
(declare-const null-var2742 var2742)
(declare-const null-String String)
(declare-const null-var1079 var1079)
(declare-const var46 var2742) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var46 null-var2742)))
(declare-const var3325 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var3325 null-String)))
(assert true)
(define-const var1334 Bool (isDirect/-2016993560 var46)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>() 
 ; Statement: if $z0 == 0 goto $r10 = new java.util.LinkedHashMap 
(assert (not (= (ite var1334 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2761 String (path/453503808 var46)) ; Statement: $r7 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var2447 Bool (= var2761 var3325)) ; Statement: $z3 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r5) 
 ; Statement: if $z3 == 0 goto $r8 = null 
(assert (= (ite var2447 1 0) 0)) ; Cond: $z3 == 0 
(define-const var2195 var1079 null-var1079) ; Statement: $r8 = null 
(assert true) ; Non Conditional
 ; Statement: return $r8 
(check-sat)
; {isDirect/-2016993560=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], boolean), path/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], java.lang.String)}
; {var2742=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var46=r0, var3325=r5, var2615=null_type, var1334=$z0, var2761=$r7, var2447=$z3, var1079=java.util.Map, var2195=$r8}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var2742, r0=var46, r5=var3325, null_type=var2615, $z0=var1334, $r7=var2761, $z3=var2447, java.util.Map=var1079, $r8=var2195}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r5 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>();	if $z0 == 0 goto $r10 = new java.util.LinkedHashMap;	$r7 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	$z3 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r5);	if $z3 == 0 goto $r8 = null;	$r8 = null;	return $r8
;block_num 4