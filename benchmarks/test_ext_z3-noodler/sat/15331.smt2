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

(declare-sort var1955 0)
(declare-sort var162 0)
(declare-sort var1015 0)
(declare-sort var1949 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var1955 String) Bool)
(declare-fun metadataInfo/507655048 (var1955) var1015)
(declare-fun getParameter/-1925727985 (var1015 String String) String)
(declare-fun var1949_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1955 var1955)
(declare-const null-String String)
(declare-const null-var1015 var1015)
(declare-const var1403 var1955) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1403 null-var1955)))
(declare-const var2765 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2765 null-String)))
(declare-const var1572 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1572 null-String)))
(assert true)
(define-const var1022 Bool (consumerParamFirst/5744255 var1403 var1572)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert (= (ite var1022 1 0) 0)) ; Cond: $z0 == 0 
(define-const var84 var1015 (metadataInfo/507655048 var1403)) ; Statement: $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
 ; Statement: if $r8 == null goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1) 
(assert (not (= var84 null-var1015))) ; Negate: Cond: $r8 == null  
(define-const var1810 var1015 (metadataInfo/507655048 var1403)) ; Statement: $r4 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert true)
(define-const var2290 String (getParameter/-1925727985 var1810 var1572 var2765)) ; Statement: r9 = virtualinvoke $r4.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getParameter(java.lang.String,java.lang.String)>(r1, r3) 
(define-const var1311 Bool (var1949_isNotEmpty/-1251449450 var2290)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r9) 
 ; Statement: if $z1 == 0 goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1) 
(assert (not (= (ite var1311 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return r9 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), metadataInfo/507655048=([org.apache.dubbo.registry.client.InstanceAddressURL], org.apache.dubbo.metadata.MetadataInfo), getParameter/-1925727985=([org.apache.dubbo.metadata.MetadataInfo, java.lang.String, java.lang.String], java.lang.String), var1949_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1955=org.apache.dubbo.registry.client.InstanceAddressURL, var1403=r0, var2765=r3, var162=null_type, var1572=r1, var1022=$z0, var1015=org.apache.dubbo.metadata.MetadataInfo, var84=$r8, var1810=$r4, var2290=r9, var1949=org.apache.dubbo.common.utils.StringUtils, var1311=$z1}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1955, r0=var1403, r3=var2765, null_type=var162, r1=var1572, $z0=var1022, org.apache.dubbo.metadata.MetadataInfo=var1015, $r8=var84, $r4=var1810, r9=var2290, org.apache.dubbo.common.utils.StringUtils=var1949, $z1=var1311}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	$r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	if $r8 == null goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1);	$r4 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	r9 = virtualinvoke $r4.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getParameter(java.lang.String,java.lang.String)>(r1, r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r9);	if $z1 == 0 goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1);	return r9
;block_num 4