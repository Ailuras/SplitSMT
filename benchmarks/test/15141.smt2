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

(declare-sort var2641 0)
(declare-sort var653 0)
(declare-sort var3608 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocolServiceKey/574559726 (var2641) String)
(declare-fun var3608_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getServiceInterface/1383728524 (var2641) String)
(declare-const null-var2641 var2641)
(declare-const null-var653 var653)
(declare-const var392 var2641) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var392 null-var2641)))
(define-const var1580 var653 null-var653) ; Statement: r4 = null 
(assert true)
(define-const var1990 String (getProtocolServiceKey/574559726 var392)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var3422 Bool (var3608_isNotEmpty/-1251449450 var1990)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3422 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r4 != null goto $r2 = virtualinvoke r4.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getPath()>() 
(assert (not (not (= var1580 null-var653)))) ; Negate: Cond: r4 != null  
(assert true)
(define-const var3677 String (getServiceInterface/1383728524 var392)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceInterface()>() 
 ; Statement: return $r3 
(check-sat)
; {getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var3608_isNotEmpty/-1251449450=([java.lang.String], boolean), getServiceInterface/1383728524=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String)}
; {var2641=org.apache.dubbo.registry.client.InstanceAddressURL, var392=r0, var653=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var1580=r4, var1990=r1, var3608=org.apache.dubbo.common.utils.StringUtils, var3422=$z0, var3677=$r3}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2641, r0=var392, org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var653, r4=var1580, r1=var1990, org.apache.dubbo.common.utils.StringUtils=var3608, $z0=var3422, $r3=var3677}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r4 = null;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto (branch);	if r4 != null goto $r2 = virtualinvoke r4.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getPath()>();	$r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceInterface()>();	return $r3
;block_num 3