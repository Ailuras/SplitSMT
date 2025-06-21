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

(declare-sort var2579 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun root/-95734468 (var2579) String)
(declare-const null-var2579 var2579)
(declare-const var1132 var2579) ; Statement: r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var1132 null-var2579)))
(define-const var1367 String (root/-95734468 var1132)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String root> 
(assert true)
(define-const var2939 Bool (= var1367 "/")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("/") 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (= (ite var2939 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var575 String (root/-95734468 var1132)) ; Statement: $r7 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String root> 
 ; Statement: return $r7 
(check-sat)
; {root/-95734468=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry], java.lang.String)}
; {var2579=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var1132=r0, var1367=$r1, var2939=$z0, var575=$r7}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var2579, r0=var1132, $r1=var1367, $z0=var2939, $r7=var575}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	$r1 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String root>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("/");	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r7 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String root>;	return $r7
;block_num 2