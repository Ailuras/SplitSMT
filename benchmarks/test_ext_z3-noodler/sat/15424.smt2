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

(declare-sort var2570 0)
(declare-sort var2083 0)
(declare-sort var2700 0)
(declare-sort var1212 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2570 String) Bool)
(declare-fun getServiceInfo/1819121692 (var2570 String) var2700)
(declare-fun var1212_isEmpty/-813097145 (String) Bool)
(declare-fun hasMethodParameter/-608330634 (var2700 String String) Bool)
(declare-const null-var2570 var2570)
(declare-const null-String String)
(declare-const null-var2700 var2700)
(declare-const var525 var2570) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var525 null-var2570)))
(declare-const var720 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var720 null-String)))
(declare-const var2281 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2281 null-String)))
(declare-const var1205 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var1205 null-String)))
(assert true)
(define-const var1513 Bool (consumerParamFirst/5744255 var525 var1205)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2) 
(assert (= (ite var1513 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var628 var2700 (getServiceInfo/1819121692 var525 var720)) ; Statement: $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2) 
(define-const var3253 Bool (var1212_isEmpty/-813097145 var2281)) ; Statement: $z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z8 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
(assert (= (ite var3253 1 0) 0)) ; Cond: $z8 == 0 
(define-const var1095 Bool (var1212_isEmpty/-813097145 var1205)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z1 == 0 goto (branch) 
(assert (= (ite var1095 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: if null != $r18 goto $z2 = virtualinvoke $r18.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: boolean hasMethodParameter(java.lang.String,java.lang.String)>(r3, r1) 
(assert (not (= null-var2700 var628))) ; Cond: null != $r18 
(assert true)
(define-const var2794 Bool (hasMethodParameter/-608330634 var628 var2281 var1205)) ; Statement: $z2 = virtualinvoke $r18.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: boolean hasMethodParameter(java.lang.String,java.lang.String)>(r3, r1) 
 ; Statement: return $z2 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), getServiceInfo/1819121692=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], org.apache.dubbo.metadata.MetadataInfo$ServiceInfo), var1212_isEmpty/-813097145=([java.lang.String], boolean), hasMethodParameter/-608330634=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, java.lang.String, java.lang.String], boolean)}
; {var2570=org.apache.dubbo.registry.client.InstanceAddressURL, var525=r0, var720=r2, var2083=null_type, var2281=r3, var1205=r1, var1513=$z0, var2700=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var628=$r18, var1212=org.apache.dubbo.common.utils.StringUtils, var3253=$z8, var1095=$z1, var2794=$z2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2570, r0=var525, r2=var720, null_type=var2083, r3=var2281, r1=var1205, $z0=var1513, org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var2700, $r18=var628, org.apache.dubbo.common.utils.StringUtils=var1212, $z8=var3253, $z1=var1095, $z2=var2794}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2);	$r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2);	$z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z8 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z1 == 0 goto (branch);	if null != $r18 goto $z2 = virtualinvoke $r18.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: boolean hasMethodParameter(java.lang.String,java.lang.String)>(r3, r1);	$z2 = virtualinvoke $r18.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: boolean hasMethodParameter(java.lang.String,java.lang.String)>(r3, r1);	return $z2
;block_num 5