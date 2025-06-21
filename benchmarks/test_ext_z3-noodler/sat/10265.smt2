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

(declare-sort var682 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun root/1812918887 (var682) String)
(declare-const null-var682 var682)
(declare-const var1612 var682) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport 
(assert (not (= var1612 null-var682)))
(define-const var2105 String (root/1812918887 var1612)) ; Statement: $r1 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String root> 
(assert true)
(define-const var3081 Bool (= var2105 "/")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("/") 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (= (ite var3081 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2178 String (root/1812918887 var1612)) ; Statement: $r7 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String root> 
 ; Statement: return $r7 
(check-sat)
; {root/1812918887=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport], java.lang.String)}
; {var682=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, var1612=r0, var2105=$r1, var3081=$z0, var2178=$r7}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport=var682, r0=var1612, $r1=var2105, $z0=var3081, $r7=var2178}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport;	$r1 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String root>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("/");	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r7 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String root>;	return $r7
;block_num 2