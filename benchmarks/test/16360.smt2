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

(declare-sort var2969 0)
(declare-sort var2387 0)
(declare-sort var900 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var900_isEmpty/-813097145 (String) Bool)
(declare-const null-var2969 var2969)
(declare-const null-String String)
(declare-const var3806 var2969) ; Statement: r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var3806 null-var2969)))
(declare-const var2966 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2966 null-String)))
(declare-const var3141 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3141 null-String)))
(declare-const var777 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var777 null-String)))
(define-const var640 Bool (var900_isEmpty/-813097145 var3141)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (not (= (ite var640 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2680 Bool (var900_isEmpty/-813097145 var777)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto r4 = specialinvoke r1.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r3) 
(assert (not (= (ite var2680 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return r1 
(check-sat)
; {var900_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2969=org.apache.dubbo.registry.client.InstanceAddressURL, var3806=r1, var2966=r3, var2387=null_type, var3141=r0, var777=r2, var900=org.apache.dubbo.common.utils.StringUtils, var640=$z0, var2680=$z1}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2969, r1=var3806, r3=var2966, null_type=var2387, r0=var3141, r2=var777, org.apache.dubbo.common.utils.StringUtils=var900, $z0=var640, $z1=var2680}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z1 == 0 goto r4 = specialinvoke r1.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r3);	return r1
;block_num 3