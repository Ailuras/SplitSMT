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

(declare-sort var2488 0)
(declare-sort var1309 0)
(declare-sort var130 0)
(declare-sort var3652 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerProtocolServiceKey/1962874429 (var2488) var130)
(declare-fun getProtocol/-1423134967 (var130) String)
(declare-fun var3652_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getParameter/-1210489333 (var1309 String) String)
(declare-fun var3652_isEmpty/-813097145 (String) Bool)
(declare-const null-var2488 var2488)
(declare-const null-var1309 var1309)
(declare-const var913 var2488) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory 
(assert (not (= var913 null-var2488)))
(declare-const var2735 var1309) ; Statement: r3 := @parameter0: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo 
(assert (not (= var2735 null-var1309)))
(define-const var3980 var130 (consumerProtocolServiceKey/1962874429 var913)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.ProtocolServiceKey consumerProtocolServiceKey> 
(assert true)
(define-const var1121 String (getProtocol/-1423134967 var3980)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.ProtocolServiceKey: java.lang.String getProtocol()>() 
(define-const var2394 Bool (var3652_isNotEmpty/-1251449450 var1121)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getParameter(java.lang.String)>("isExtra") 
(assert (= (ite var2394 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2863 String (getParameter/-1210489333 var2735 "isExtra")) ; Statement: $r4 = virtualinvoke r3.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getParameter(java.lang.String)>("isExtra") 
(define-const var437 Bool (var3652_isEmpty/-813097145 var2863)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: return $z1 
(check-sat)
; {consumerProtocolServiceKey/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.common.ProtocolServiceKey), getProtocol/-1423134967=([org.apache.dubbo.common.ProtocolServiceKey], java.lang.String), var3652_isNotEmpty/-1251449450=([java.lang.String], boolean), getParameter/-1210489333=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, java.lang.String], java.lang.String), var3652_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2488=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory, var913=r0, var1309=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var2735=r3, var130=org.apache.dubbo.common.ProtocolServiceKey, var3980=$r1, var1121=$r2, var3652=org.apache.dubbo.common.utils.StringUtils, var2394=$z0, var2863=$r4, var437=$z1}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory=var2488, r0=var913, org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var1309, r3=var2735, org.apache.dubbo.common.ProtocolServiceKey=var130, $r1=var3980, $r2=var1121, org.apache.dubbo.common.utils.StringUtils=var3652, $z0=var2394, $r4=var2863, $z1=var437}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory;	r3 := @parameter0: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo;	$r1 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.ProtocolServiceKey consumerProtocolServiceKey>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.ProtocolServiceKey: java.lang.String getProtocol()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	if $z0 == 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getParameter(java.lang.String)>("isExtra");	$r4 = virtualinvoke r3.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getParameter(java.lang.String)>("isExtra");	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	return $z1
;block_num 2