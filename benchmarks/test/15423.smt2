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

(declare-sort var2489 0)
(declare-sort var1369 0)
(declare-sort var1714 0)
(declare-sort var2239 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2489 String) Bool)
(declare-fun getServiceInfo/1819121692 (var2489 String) var1714)
(declare-fun var2239_isEmpty/-813097145 (String) Bool)
(declare-const null-var2489 var2489)
(declare-const null-String String)
(declare-const null-var1714 var1714)
(declare-const var3456 var2489) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var3456 null-var2489)))
(declare-const var1425 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1425 null-String)))
(declare-const var71 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var71 null-String)))
(declare-const var3071 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var3071 null-String)))
(assert true)
(define-const var1236 Bool (consumerParamFirst/5744255 var3456 var3071)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2) 
(assert (= (ite var1236 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1420 var1714 (getServiceInfo/1819121692 var3456 var1425)) ; Statement: $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2) 
(define-const var1159 Bool (var2239_isEmpty/-813097145 var71)) ; Statement: $z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z8 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
(assert (= (ite var1159 1 0) 0)) ; Cond: $z8 == 0 
(define-const var2397 Bool (var2239_isEmpty/-813097145 var3071)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z1 == 0 goto (branch) 
(assert (= (ite var2397 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: if null != $r18 goto $z2 = virtualinvoke $r18.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: boolean hasMethodParameter(java.lang.String,java.lang.String)>(r3, r1) 
(assert (not (not (= null-var1714 var1420)))) ; Negate: Cond: null != $r18  
 ; Statement: return 0 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), getServiceInfo/1819121692=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], org.apache.dubbo.metadata.MetadataInfo$ServiceInfo), var2239_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2489=org.apache.dubbo.registry.client.InstanceAddressURL, var3456=r0, var1425=r2, var1369=null_type, var71=r3, var3071=r1, var1236=$z0, var1714=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var1420=$r18, var2239=org.apache.dubbo.common.utils.StringUtils, var1159=$z8, var2397=$z1}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2489, r0=var3456, r2=var1425, null_type=var1369, r3=var71, r1=var3071, $z0=var1236, org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var1714, $r18=var1420, org.apache.dubbo.common.utils.StringUtils=var2239, $z8=var1159, $z1=var2397}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2);	$r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2);	$z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z8 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z1 == 0 goto (branch);	if null != $r18 goto $z2 = virtualinvoke $r18.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: boolean hasMethodParameter(java.lang.String,java.lang.String)>(r3, r1);	return 0
;block_num 5