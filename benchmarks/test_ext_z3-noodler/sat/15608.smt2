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

(declare-sort var1495 0)
(declare-sort var67 0)
(declare-sort var1300 0)
(declare-sort var1079 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1300_getExportedServicesRevision/-768249 (var67) String)
(declare-fun doUpdate/1923166842 (var1079 var67 var67) void)
(declare-fun cast-from-var1495-to-var1079 (var1495) var1079)
(declare-const null-var1495 var1495)
(declare-const null-var67 var67)
(declare-const var1463 var1495) ; Statement: r3 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery 
(assert (not (= var1463 null-var1495)))
(declare-const var2586 var67) ; Statement: r4 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2586 null-var67)))
(declare-const var542 var67) ; Statement: r0 := @parameter1: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var542 null-var67)))
(define-const var3547 String "0") ; Statement: $r2 = "0" 
(define-const var3929 String (var1300_getExportedServicesRevision/-768249 var542)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(assert true)
(define-const var317 Bool (= var3547 var3929)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto specialinvoke r3.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUpdate(org.apache.dubbo.registry.client.ServiceInstance,org.apache.dubbo.registry.client.ServiceInstance)>(r4, r0) 
(assert (not (= (ite var317 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
;(assert (doUpdate/1923166842 (cast-from-var1495-to-var1079 var1463) var2586 var542)) ; Statement: specialinvoke r3.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUpdate(org.apache.dubbo.registry.client.ServiceInstance,org.apache.dubbo.registry.client.ServiceInstance)>(r4, r0) 

(declare-const var1463!1 var1495)
(declare-const var2586!1 var67)
(declare-const var542!1 var67)
 ; Statement: return 
(check-sat)
; {var1300_getExportedServicesRevision/-768249=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), doUpdate/1923166842=([org.apache.dubbo.registry.client.AbstractServiceDiscovery, org.apache.dubbo.registry.client.ServiceInstance, org.apache.dubbo.registry.client.ServiceInstance], void), cast-from-var1495-to-var1079=([org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery], org.apache.dubbo.registry.client.AbstractServiceDiscovery)}
; {var1495=org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery, var1463=r3, var67=org.apache.dubbo.registry.client.ServiceInstance, var2586=r4, var542=r0, var3547=$r2, var1300=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils, var3929=$r1, var317=$z0, var1079=org.apache.dubbo.registry.client.AbstractServiceDiscovery}
; {org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery=var1495, r3=var1463, org.apache.dubbo.registry.client.ServiceInstance=var67, r4=var2586, r0=var542, $r2=var3547, org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils=var1300, $r1=var3929, $z0=var317, org.apache.dubbo.registry.client.AbstractServiceDiscovery=var1079}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery;	r4 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r0 := @parameter1: org.apache.dubbo.registry.client.ServiceInstance;	$r2 = "0";	$r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto specialinvoke r3.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUpdate(org.apache.dubbo.registry.client.ServiceInstance,org.apache.dubbo.registry.client.ServiceInstance)>(r4, r0);	specialinvoke r3.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUpdate(org.apache.dubbo.registry.client.ServiceInstance,org.apache.dubbo.registry.client.ServiceInstance)>(r4, r0);	return
;block_num 2