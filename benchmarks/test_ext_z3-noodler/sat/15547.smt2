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

(declare-sort var1690 0)
(declare-sort var663 0)
(declare-sort var2416 0)
(declare-sort var2430 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2416_getExportedServicesRevision/-768249 (var663) String)
(declare-fun doUpdate/1923166842 (var2430 var663 var663) void)
(declare-fun cast-from-var1690-to-var2430 (var1690) var2430)
(declare-const null-var1690 var1690)
(declare-const null-var663 var663)
(declare-const var3772 var1690) ; Statement: r3 := @this: org.apache.dubbo.registry.nacos.NacosServiceDiscovery 
(assert (not (= var3772 null-var1690)))
(declare-const var2390 var663) ; Statement: r4 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2390 null-var663)))
(declare-const var1891 var663) ; Statement: r0 := @parameter1: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var1891 null-var663)))
(define-const var321 String "0") ; Statement: $r2 = "0" 
(define-const var3682 String (var2416_getExportedServicesRevision/-768249 var1891)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(assert true)
(define-const var234 Bool (= var321 var3682)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto specialinvoke r3.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUpdate(org.apache.dubbo.registry.client.ServiceInstance,org.apache.dubbo.registry.client.ServiceInstance)>(r4, r0) 
(assert (not (= (ite var234 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
;(assert (doUpdate/1923166842 (cast-from-var1690-to-var2430 var3772) var2390 var1891)) ; Statement: specialinvoke r3.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUpdate(org.apache.dubbo.registry.client.ServiceInstance,org.apache.dubbo.registry.client.ServiceInstance)>(r4, r0) 

(declare-const var3772!1 var1690)
(declare-const var2390!1 var663)
(declare-const var1891!1 var663)
 ; Statement: return 
(check-sat)
; {var2416_getExportedServicesRevision/-768249=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), doUpdate/1923166842=([org.apache.dubbo.registry.client.AbstractServiceDiscovery, org.apache.dubbo.registry.client.ServiceInstance, org.apache.dubbo.registry.client.ServiceInstance], void), cast-from-var1690-to-var2430=([org.apache.dubbo.registry.nacos.NacosServiceDiscovery], org.apache.dubbo.registry.client.AbstractServiceDiscovery)}
; {var1690=org.apache.dubbo.registry.nacos.NacosServiceDiscovery, var3772=r3, var663=org.apache.dubbo.registry.client.ServiceInstance, var2390=r4, var1891=r0, var321=$r2, var2416=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils, var3682=$r1, var234=$z0, var2430=org.apache.dubbo.registry.client.AbstractServiceDiscovery}
; {org.apache.dubbo.registry.nacos.NacosServiceDiscovery=var1690, r3=var3772, org.apache.dubbo.registry.client.ServiceInstance=var663, r4=var2390, r0=var1891, $r2=var321, org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils=var2416, $r1=var3682, $z0=var234, org.apache.dubbo.registry.client.AbstractServiceDiscovery=var2430}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.nacos.NacosServiceDiscovery;	r4 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r0 := @parameter1: org.apache.dubbo.registry.client.ServiceInstance;	$r2 = "0";	$r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto specialinvoke r3.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUpdate(org.apache.dubbo.registry.client.ServiceInstance,org.apache.dubbo.registry.client.ServiceInstance)>(r4, r0);	specialinvoke r3.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUpdate(org.apache.dubbo.registry.client.ServiceInstance,org.apache.dubbo.registry.client.ServiceInstance)>(r4, r0);	return
;block_num 2