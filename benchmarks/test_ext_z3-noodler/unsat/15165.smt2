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

(declare-sort var772 0)
(declare-sort var3813 0)
(declare-sort var3018 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocolServiceKey/574559726 (var772) String)
(declare-fun var3018_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getPath/-1439165946 (var3813) String)
(declare-const null-var772 var772)
(declare-const null-var3813 var3813)
(declare-const var2565 var772) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var2565 null-var772)))
(define-const var3627 var3813 null-var3813) ; Statement: r4 = null 
(assert true)
(define-const var980 String (getProtocolServiceKey/574559726 var2565)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var3806 Bool (var3018_isNotEmpty/-1251449450 var980)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3806 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r4 != null goto $r2 = virtualinvoke r4.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getPath()>() 
(assert (not (= var3627 null-var3813))) ; Cond: r4 != null 
(assert true)
(define-const var1759 String (getPath/-1439165946 var3627)) ; Statement: $r2 = virtualinvoke r4.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getPath()>() 
 ; Statement: return $r2 
(check-sat)
; {getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var3018_isNotEmpty/-1251449450=([java.lang.String], boolean), getPath/-1439165946=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String)}
; {var772=org.apache.dubbo.registry.client.InstanceAddressURL, var2565=r0, var3813=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var3627=r4, var980=r1, var3018=org.apache.dubbo.common.utils.StringUtils, var3806=$z0, var1759=$r2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var772, r0=var2565, org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var3813, r4=var3627, r1=var980, org.apache.dubbo.common.utils.StringUtils=var3018, $z0=var3806, $r2=var1759}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r4 = null;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto (branch);	if r4 != null goto $r2 = virtualinvoke r4.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getPath()>();	$r2 = virtualinvoke r4.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getPath()>();	return $r2
;block_num 3