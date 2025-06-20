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

(declare-sort var3539 0)
(declare-sort var1929 0)
(declare-sort var1267 0)
(declare-sort var2684 0)
(declare-sort var1192 0)
(declare-sort var1930 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1267_getExportedServicesRevision/-768249 (var1929) String)
(declare-fun var1929_getServiceMetadata/-1630150663 (var1929) var2684)
(declare-fun calAndGetRevision/-1645788104 (var2684) String)
(declare-fun var1929_getMetadata/1968437424 (var1929) var1192)
(declare-fun getRevision/1697979119 (var2684) String)
(declare-fun var1192_put/1464166817 (var1192 var1930 var1930) var1930)
(declare-fun cast-from-String-to-var1930 (String) var1930)
(declare-const null-var3539 var3539)
(declare-const null-var1929 var1929)
(declare-const var2399 var3539) ; Statement: r6 := @this: org.apache.dubbo.registry.client.AbstractServiceDiscovery 
(assert (not (= var2399 null-var3539)))
(declare-const var3909 var1929) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var3909 null-var1929)))
(define-const var213 String (var1267_getExportedServicesRevision/-768249 var3909)) ; Statement: r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(define-const var3505 var2684 (var1929_getServiceMetadata/-1630150663 var3909)) ; Statement: r2 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.metadata.MetadataInfo getServiceMetadata()>() 
(assert true)
(define-const var586 String (calAndGetRevision/-1645788104 var3505)) ; Statement: r3 = virtualinvoke r2.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String calAndGetRevision()>() 
(assert true)
(define-const var3338 Bool (= var586 var213)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto return 0 
(assert (not (not (= (ite var3338 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2435 var1192 (var1929_getMetadata/1968437424 var3909)) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(assert true)
(define-const var3441 String (getRevision/1697979119 var3505)) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getRevision()>() 
;(assert (var1192_put/1464166817 var2435 (cast-from-String-to-var1930 "dubbo.metadata.revision") (cast-from-String-to-var1930 var3441))) ; Statement: interfaceinvoke $r5.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("dubbo.metadata.revision", $r4) 

(declare-const var2435!1 var1192)
(declare-const var3958 String)
(declare-const var3441!1 String)
 ; Statement: return 1 
(check-sat)
; {var1267_getExportedServicesRevision/-768249=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), var1929_getServiceMetadata/-1630150663=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.metadata.MetadataInfo), calAndGetRevision/-1645788104=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String), var1929_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), getRevision/1697979119=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String), var1192_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var1930=([java.lang.String], java.lang.Object)}
; {var3539=org.apache.dubbo.registry.client.AbstractServiceDiscovery, var2399=r6, var1929=org.apache.dubbo.registry.client.ServiceInstance, var3909=r0, var1267=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils, var213=r1, var2684=org.apache.dubbo.metadata.MetadataInfo, var3505=r2, var586=r3, var3338=$z0, var1192=java.util.Map, var2435=$r5, var3441=$r4, var1930=java.lang.Object, var3958="dubbo.metadata.revision"}
; {org.apache.dubbo.registry.client.AbstractServiceDiscovery=var3539, r6=var2399, org.apache.dubbo.registry.client.ServiceInstance=var1929, r0=var3909, org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils=var1267, r1=var213, org.apache.dubbo.metadata.MetadataInfo=var2684, r2=var3505, r3=var586, $z0=var3338, java.util.Map=var1192, $r5=var2435, $r4=var3441, java.lang.Object=var1930, "dubbo.metadata.revision"=var3958}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.client.AbstractServiceDiscovery;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	r2 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.metadata.MetadataInfo getServiceMetadata()>();	r3 = virtualinvoke r2.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String calAndGetRevision()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto return 0;	$r5 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r4 = virtualinvoke r2.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getRevision()>();	interfaceinvoke $r5.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("dubbo.metadata.revision", $r4);	return 1
;block_num 2