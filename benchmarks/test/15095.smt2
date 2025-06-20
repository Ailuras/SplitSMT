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

(declare-sort var920 0)
(declare-sort var2979 0)
(declare-sort var540 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun doUnregister/-1410810725 (var920 var2979) void)
(declare-fun serviceInstance/642990325 (var920) var2979)
(declare-fun var540_getExportedServicesRevision/-768249 (var2979) String)
(declare-const null-var920 var920)
(declare-const null-var2979 var2979)
(declare-const var387 var920) ; Statement: r0 := @this: org.apache.dubbo.registry.client.AbstractServiceDiscovery 
(assert (not (= var387 null-var920)))
(declare-const var1291 var2979) ; Statement: r1 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var1291 null-var2979)))
(declare-const var2550 var2979) ; Statement: r2 := @parameter1: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2550 null-var2979)))
(assert true)
;(assert (doUnregister/-1410810725 var387 var1291)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUnregister(org.apache.dubbo.registry.client.ServiceInstance)>(r1) 

(declare-const var387!1 var920)
(declare-const var1291!1 var2979)
(declare-const var387!2 var920)
(assert (not (= var387!2 null-var920)))
(assert (= (serviceInstance/642990325 var387!2) var2550)) ; Statement: r0.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: org.apache.dubbo.registry.client.ServiceInstance serviceInstance> = r2 
(define-const var2463 String "0") ; Statement: $r4 = "0" 
(define-const var660 String (var540_getExportedServicesRevision/-768249 var2550)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r2) 
(assert true)
(define-const var847 Bool (= var2463 var660)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var847 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {doUnregister/-1410810725=([org.apache.dubbo.registry.client.AbstractServiceDiscovery, org.apache.dubbo.registry.client.ServiceInstance], void), serviceInstance/642990325=([org.apache.dubbo.registry.client.AbstractServiceDiscovery], org.apache.dubbo.registry.client.ServiceInstance), var540_getExportedServicesRevision/-768249=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String)}
; {var920=org.apache.dubbo.registry.client.AbstractServiceDiscovery, var387=r0, var2979=org.apache.dubbo.registry.client.ServiceInstance, var1291=r1, var2550=r2, var2463=$r4, var540=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils, var660=$r3, var847=$z0}
; {org.apache.dubbo.registry.client.AbstractServiceDiscovery=var920, r0=var387, org.apache.dubbo.registry.client.ServiceInstance=var2979, r1=var1291, r2=var2550, $r4=var2463, org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils=var540, $r3=var660, $z0=var847}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.AbstractServiceDiscovery;	r1 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r2 := @parameter1: org.apache.dubbo.registry.client.ServiceInstance;	virtualinvoke r0.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: void doUnregister(org.apache.dubbo.registry.client.ServiceInstance)>(r1);	r0.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: org.apache.dubbo.registry.client.ServiceInstance serviceInstance> = r2;	$r4 = "0";	$r3 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r2);	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	if $z0 != 0 goto return;	return
;block_num 2