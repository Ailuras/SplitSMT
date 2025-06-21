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

(declare-sort var727 0)
(declare-sort var764 0)
(declare-sort var2740 0)
(declare-sort var1843 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2740_getExportedServicesRevision/-768249 (var764) String)
(declare-fun var764_getServiceMetadata/-1630150663 (var764) var1843)
(declare-fun calAndGetRevision/-1645788104 (var1843) String)
(declare-const null-var727 var727)
(declare-const null-var764 var764)
(declare-const var2897 var727) ; Statement: r6 := @this: org.apache.dubbo.registry.client.AbstractServiceDiscovery 
(assert (not (= var2897 null-var727)))
(declare-const var1779 var764) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var1779 null-var764)))
(define-const var1941 String (var2740_getExportedServicesRevision/-768249 var1779)) ; Statement: r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(define-const var24 var1843 (var764_getServiceMetadata/-1630150663 var1779)) ; Statement: r2 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.metadata.MetadataInfo getServiceMetadata()>() 
(assert true)
(define-const var2113 String (calAndGetRevision/-1645788104 var24)) ; Statement: r3 = virtualinvoke r2.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String calAndGetRevision()>() 
(assert true)
(define-const var2032 Bool (= var2113 var1941)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto return 0 
(assert (not (= (ite var2032 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 0 
(check-sat)
; {var2740_getExportedServicesRevision/-768249=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), var764_getServiceMetadata/-1630150663=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.metadata.MetadataInfo), calAndGetRevision/-1645788104=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String)}
; {var727=org.apache.dubbo.registry.client.AbstractServiceDiscovery, var2897=r6, var764=org.apache.dubbo.registry.client.ServiceInstance, var1779=r0, var2740=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils, var1941=r1, var1843=org.apache.dubbo.metadata.MetadataInfo, var24=r2, var2113=r3, var2032=$z0}
; {org.apache.dubbo.registry.client.AbstractServiceDiscovery=var727, r6=var2897, org.apache.dubbo.registry.client.ServiceInstance=var764, r0=var1779, org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils=var2740, r1=var1941, org.apache.dubbo.metadata.MetadataInfo=var1843, r2=var24, r3=var2113, $z0=var2032}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.client.AbstractServiceDiscovery;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	r2 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.metadata.MetadataInfo getServiceMetadata()>();	r3 = virtualinvoke r2.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String calAndGetRevision()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto return 0;	return 0
;block_num 2