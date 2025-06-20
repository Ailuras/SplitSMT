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

(declare-sort var1212 0)
(declare-sort var629 0)
(declare-sort var2467 0)
(declare-sort var19 0)
(declare-sort var3036 0)
(declare-sort var1639 0)
(declare-sort var434 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRevision/973979446 (var629) String)
(declare-fun var2467_isEmpty/-813097145 (String) Bool)
(declare-fun registryManager/1323835683 (var1212) var19)
(declare-fun getServiceDiscoveries/1358162304 (var19) var3036)
(declare-fun var3036_iterator/-912451715 (var3036) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun logger/1323835683 (var1212) var1639)
(declare-fun var434_isWarnEnabled/-569478753 (var434) Bool)
(declare-fun cast-from-var1639-to-var434 (var1639) var434)
(declare-const null-var1212 var1212)
(declare-const null-var629 var629)
(declare-const var1676 var1212) ; Statement: r2 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2 
(assert (not (= var1676 null-var1212)))
(declare-const var187 var629) ; Statement: r0 := @parameter0: org.apache.dubbo.metadata.MetadataRequest 
(assert (not (= var187 null-var629)))
(assert true)
(define-const var2478 String (getRevision/973979446 var187)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataRequest: java.lang.String getRevision()>() 
(define-const var2305 Bool (var2467_isEmpty/-813097145 var2478)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.registry.support.RegistryManager registryManager> 
(assert (= (ite var2305 1 0) 0)) ; Cond: $z0 == 0 
(define-const var286 var19 (registryManager/1323835683 var1676)) ; Statement: $r3 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.registry.support.RegistryManager registryManager> 
(assert true)
(define-const var247 var3036 (getServiceDiscoveries/1358162304 var286)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.registry.support.RegistryManager: java.util.List getServiceDiscoveries()>() 
(define-const var1955 Iterator (var3036_iterator/-912451715 var247)) ; Statement: r5 = interfaceinvoke $r4.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var604 Bool (Iterator_hasNext/-1669924200 var1955)) ; Statement: $z1 = interfaceinvoke r5.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z1 == 0 goto $r6 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= (ite var604 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1948 var1639 (logger/1323835683 var1676)) ; Statement: $r6 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2859 Bool (var434_isWarnEnabled/-569478753 (cast-from-var1639-to-var434 var1948))) ; Statement: $z2 = interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isWarnEnabled()>() 
 ; Statement: if $z2 == 0 goto return null 
(assert (= (ite var2859 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return null 
(check-sat)
; {getRevision/973979446=([org.apache.dubbo.metadata.MetadataRequest], java.lang.String), var2467_isEmpty/-813097145=([java.lang.String], boolean), registryManager/1323835683=([org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2], org.apache.dubbo.registry.support.RegistryManager), getServiceDiscoveries/1358162304=([org.apache.dubbo.registry.support.RegistryManager], java.util.List), var3036_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), logger/1323835683=([org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var434_isWarnEnabled/-569478753=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1639-to-var434=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var1212=org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2, var1676=r2, var629=org.apache.dubbo.metadata.MetadataRequest, var187=r0, var2478=r1, var2467=org.apache.dubbo.common.utils.StringUtils, var2305=$z0, var19=org.apache.dubbo.registry.support.RegistryManager, var286=$r3, var3036=java.util.List, var247=$r4, var1955=r5, var604=$z1, var1639=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1948=$r6, var434=org.apache.dubbo.common.logger.Logger, var2859=$z2}
; {org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2=var1212, r2=var1676, org.apache.dubbo.metadata.MetadataRequest=var629, r0=var187, r1=var2478, org.apache.dubbo.common.utils.StringUtils=var2467, $z0=var2305, org.apache.dubbo.registry.support.RegistryManager=var19, $r3=var286, java.util.List=var3036, $r4=var247, r5=var1955, $z1=var604, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1639, $r6=var1948, org.apache.dubbo.common.logger.Logger=var434, $z2=var2859}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2;	r0 := @parameter0: org.apache.dubbo.metadata.MetadataRequest;	r1 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataRequest: java.lang.String getRevision()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.registry.support.RegistryManager registryManager>;	$r3 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.registry.support.RegistryManager registryManager>;	$r4 = virtualinvoke $r3.<org.apache.dubbo.registry.support.RegistryManager: java.util.List getServiceDiscoveries()>();	r5 = interfaceinvoke $r4.<java.util.List: java.util.Iterator iterator()>();	$z1 = interfaceinvoke r5.<java.util.Iterator: boolean hasNext()>();	if $z1 == 0 goto $r6 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z2 = interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isWarnEnabled()>();	if $z2 == 0 goto return null;	return null
;block_num 5