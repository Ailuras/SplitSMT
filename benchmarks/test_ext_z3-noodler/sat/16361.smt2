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

(declare-sort var835 0)
(declare-sort var1256 0)
(declare-sort var1006 0)
(declare-sort var1680 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1006_isEmpty/-813097145 (String) Bool)
(declare-fun getServiceInfo/1819121692 (var835 String) var1680)
(declare-const null-var835 var835)
(declare-const null-String String)
(declare-const null-var1680 var1680)
(declare-const var2852 var835) ; Statement: r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var2852 null-var835)))
(declare-const var2951 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2951 null-String)))
(declare-const var3065 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3065 null-String)))
(declare-const var3824 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var3824 null-String)))
(define-const var1159 Bool (var1006_isEmpty/-813097145 var3065)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (not (= (ite var1159 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3481 Bool (var1006_isEmpty/-813097145 var3824)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto r4 = specialinvoke r1.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r3) 
(assert (= (ite var3481 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var1237 var1680 (getServiceInfo/1819121692 var2852 var2951)) ; Statement: r4 = specialinvoke r1.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r3) 
 ; Statement: if null == r4 goto return r1 
(assert (= null-var1680 var1237)) ; Cond: null == r4 
 ; Statement: return r1 
(check-sat)
; {var1006_isEmpty/-813097145=([java.lang.String], boolean), getServiceInfo/1819121692=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], org.apache.dubbo.metadata.MetadataInfo$ServiceInfo)}
; {var835=org.apache.dubbo.registry.client.InstanceAddressURL, var2852=r1, var2951=r3, var1256=null_type, var3065=r0, var3824=r2, var1006=org.apache.dubbo.common.utils.StringUtils, var1159=$z0, var3481=$z1, var1680=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var1237=r4}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var835, r1=var2852, r3=var2951, null_type=var1256, r0=var3065, r2=var3824, org.apache.dubbo.common.utils.StringUtils=var1006, $z0=var1159, $z1=var3481, org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var1680, r4=var1237}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z1 == 0 goto r4 = specialinvoke r1.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r3);	r4 = specialinvoke r1.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r3);	if null == r4 goto return r1;	return r1
;block_num 4