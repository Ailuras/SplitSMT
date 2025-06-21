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

(declare-sort var1580 0)
(declare-sort var1306 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getExact/-1874259691 (var1580) String)
(declare-const null-var1580 var1580)
(declare-const null-String String)
(declare-const var3216 var1580) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch 
(assert (not (= var3216 null-var1580)))
(declare-const var3408 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var3408 null-String)))
(assert true)
(define-const var2409 String (getExact/-1874259691 var3216)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String getExact()>() 
 ; Statement: if $r1 == null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String getPrefix()>() 
(assert (not (= var2409 null-String))) ; Negate: Cond: $r1 == null  
 ; Statement: if r7 == null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String getPrefix()>() 
(assert (not (= var3408 null-String))) ; Negate: Cond: r7 == null  
(assert true)
(define-const var1427 String (getExact/-1874259691 var3216)) ; Statement: $r14 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String getExact()>() 
(assert true)
(define-const var3918 Bool (= var3408 var1427)) ; Statement: $z5 = virtualinvoke r7.<java.lang.String: boolean equals(java.lang.Object)>($r14) 
 ; Statement: return $z5 
(check-sat)
; {getExact/-1874259691=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch], java.lang.String)}
; {var1580=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch, var3216=r0, var3408=r7, var1306=null_type, var2409=$r1, var1427=$r14, var3918=$z5}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch=var1580, r0=var3216, r7=var3408, null_type=var1306, $r1=var2409, $r14=var1427, $z5=var3918}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch;	r7 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String getExact()>();	if $r1 == null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String getPrefix()>();	if r7 == null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String getPrefix()>();	$r14 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String getExact()>();	$z5 = virtualinvoke r7.<java.lang.String: boolean equals(java.lang.Object)>($r14);	return $z5
;block_num 3