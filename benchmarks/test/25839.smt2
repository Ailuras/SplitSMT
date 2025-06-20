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

(declare-sort var3045 0)
(declare-sort var2375 0)
(declare-sort var214 0)
(declare-sort var983 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isDirect/-2016993560 (var3045) Bool)
(declare-fun path/453503808 (var3045) String)
(declare-fun var983_emptyMap/401053835 () var214)
(declare-const null-var3045 var3045)
(declare-const null-String String)
(declare-const var414 var3045) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var414 null-var3045)))
(declare-const var2900 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var2900 null-String)))
(assert true)
(define-const var417 Bool (isDirect/-2016993560 var414)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>() 
 ; Statement: if $z0 == 0 goto $r10 = new java.util.LinkedHashMap 
(assert (not (= (ite var417 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2263 String (path/453503808 var414)) ; Statement: $r7 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var3604 Bool (= var2263 var2900)) ; Statement: $z3 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r5) 
 ; Statement: if $z3 == 0 goto $r8 = null 
(assert (not (= (ite var3604 1 0) 0))) ; Negate: Cond: $z3 == 0  
(define-const var362 var214 var983_emptyMap/401053835) ; Statement: $r8 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>() 
 ; Statement: goto [?= return $r8] 
(assert true) ; Non Conditional
 ; Statement: return $r8 
(check-sat)
; {isDirect/-2016993560=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], boolean), path/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], java.lang.String), var983_emptyMap/401053835=([], java.util.Map)}
; {var3045=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var414=r0, var2900=r5, var2375=null_type, var417=$z0, var2263=$r7, var3604=$z3, var214=java.util.Map, var983=java.util.Collections, var362=$r8}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var3045, r0=var414, r5=var2900, null_type=var2375, $z0=var417, $r7=var2263, $z3=var3604, java.util.Map=var214, java.util.Collections=var983, $r8=var362}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	r5 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: boolean isDirect()>();	if $z0 == 0 goto $r10 = new java.util.LinkedHashMap;	$r7 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	$z3 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r5);	if $z3 == 0 goto $r8 = null;	$r8 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>();	goto [?= return $r8];	return $r8
;block_num 4