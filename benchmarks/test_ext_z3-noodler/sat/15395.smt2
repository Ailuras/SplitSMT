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

(declare-sort var1099 0)
(declare-sort var3695 0)
(declare-sort var1638 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var1099 String) Bool)
(declare-fun getProtocolServiceKey/574559726 (var1099) String)
(declare-fun var1638_isEmpty/-813097145 (String) Bool)
(declare-fun getServiceMethodParameter/1908992162 (var1099 String String String) String)
(declare-const null-var1099 var1099)
(declare-const null-String String)
(declare-const var1320 var1099) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1320 null-var1099)))
(declare-const var3317 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3317 null-String)))
(declare-const var3237 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3237 null-String)))
(assert true)
(define-const var3572 Bool (consumerParamFirst/5744255 var1320 var3237)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (= (ite var3572 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3438 String (getProtocolServiceKey/574559726 var1320)) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var777 Bool (var1638_isEmpty/-813097145 var3438)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7) 
 ; Statement: if $z2 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1) 
(assert (= (ite var777 1 0) 0)) ; Cond: $z2 == 0 
(assert true)
(define-const var1851 String (getServiceMethodParameter/1908992162 var1320 var3438 var3317 var3237)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1) 
 ; Statement: return $r3 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var1638_isEmpty/-813097145=([java.lang.String], boolean), getServiceMethodParameter/1908992162=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var1099=org.apache.dubbo.registry.client.InstanceAddressURL, var1320=r0, var3317=r2, var3695=null_type, var3237=r1, var3572=$z0, var3438=$r7, var1638=org.apache.dubbo.common.utils.StringUtils, var777=$z2, var1851=$r3}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1099, r0=var1320, r2=var3317, null_type=var3695, r1=var3237, $z0=var3572, $r7=var3438, org.apache.dubbo.common.utils.StringUtils=var1638, $z2=var777, $r3=var1851}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7);	if $z2 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1);	$r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1);	return $r3
;block_num 3