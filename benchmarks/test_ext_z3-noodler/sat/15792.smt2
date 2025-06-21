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

(declare-sort var2422 0)
(declare-sort var550 0)
(declare-sort var2038 0)
(declare-sort var1231 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerProtocolServiceKey/1962874429 (var2422) var2038)
(declare-fun getProtocol/-1423134967 (var2038) String)
(declare-fun var1231_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2422 var2422)
(declare-const null-var550 var550)
(declare-const var1462 var2422) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory 
(assert (not (= var1462 null-var2422)))
(declare-const var296 var550) ; Statement: r3 := @parameter0: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo 
(assert (not (= var296 null-var550)))
(define-const var1536 var2038 (consumerProtocolServiceKey/1962874429 var1462)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.ProtocolServiceKey consumerProtocolServiceKey> 
(assert true)
(define-const var776 String (getProtocol/-1423134967 var1536)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.ProtocolServiceKey: java.lang.String getProtocol()>() 
(define-const var3769 Bool (var1231_isNotEmpty/-1251449450 var776)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getParameter(java.lang.String)>("isExtra") 
(assert (not (= (ite var3769 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 1 
(check-sat)
; {consumerProtocolServiceKey/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.common.ProtocolServiceKey), getProtocol/-1423134967=([org.apache.dubbo.common.ProtocolServiceKey], java.lang.String), var1231_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2422=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory, var1462=r0, var550=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var296=r3, var2038=org.apache.dubbo.common.ProtocolServiceKey, var1536=$r1, var776=$r2, var1231=org.apache.dubbo.common.utils.StringUtils, var3769=$z0}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory=var2422, r0=var1462, org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var550, r3=var296, org.apache.dubbo.common.ProtocolServiceKey=var2038, $r1=var1536, $r2=var776, org.apache.dubbo.common.utils.StringUtils=var1231, $z0=var3769}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory;	r3 := @parameter0: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo;	$r1 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.ProtocolServiceKey consumerProtocolServiceKey>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.ProtocolServiceKey: java.lang.String getProtocol()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	if $z0 == 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getParameter(java.lang.String)>("isExtra");	return 1
;block_num 2