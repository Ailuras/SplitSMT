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

(declare-sort var2967 0)
(declare-sort var3443 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceInterface/-1311863806 (var3443) String)
(declare-fun toRootPath/1363854598 (var2967) String)
(declare-const null-var2967 var2967)
(declare-const null-var3443 var3443)
(declare-const var1846 var2967) ; Statement: r4 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var1846 null-var2967)))
(declare-const var1937 var3443) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1937 null-var3443)))
(assert true)
(define-const var391 String (getServiceInterface/-1311863806 var1937)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var814 String "*") ; Statement: $r2 = "*" 
(assert true)
(define-const var3904 Bool (= var814 var391)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.StringBuilder 
(assert (not (= (ite var3904 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1093 String (toRootPath/1363854598 var1846)) ; Statement: $r10 = specialinvoke r4.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String toRootPath()>() 
 ; Statement: return $r10 
(check-sat)
; {getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), toRootPath/1363854598=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry], java.lang.String)}
; {var2967=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var1846=r4, var3443=org.apache.dubbo.common.URL, var1937=r0, var391=r1, var814=$r2, var3904=$z0, var1093=$r10}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var2967, r4=var1846, org.apache.dubbo.common.URL=var3443, r0=var1937, r1=var391, $r2=var814, $z0=var3904, $r10=var1093}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r2 = "*";	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 == 0 goto $r3 = new java.lang.StringBuilder;	$r10 = specialinvoke r4.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String toRootPath()>();	return $r10
;block_num 2