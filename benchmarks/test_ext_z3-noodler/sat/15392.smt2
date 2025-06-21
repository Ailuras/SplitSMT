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

(declare-sort var2265 0)
(declare-sort var86 0)
(declare-sort var3599 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2265 String) Bool)
(declare-fun getProtocolServiceKey/574559726 (var2265) String)
(declare-fun var3599_isEmpty/-813097145 (String) Bool)
(declare-const null-var2265 var2265)
(declare-const null-String String)
(declare-const var3274 var2265) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var3274 null-var2265)))
(declare-const var2171 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2171 null-String)))
(declare-const var639 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var639 null-String)))
(assert true)
(define-const var2033 Bool (consumerParamFirst/5744255 var3274 var639)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (= (ite var2033 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2974 String (getProtocolServiceKey/574559726 var3274)) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var3061 Bool (var3599_isEmpty/-813097145 var2974)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7) 
 ; Statement: if $z2 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1) 
(assert (not (= (ite var3061 1 0) 0))) ; Negate: Cond: $z2 == 0  
 ; Statement: return null 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var3599_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2265=org.apache.dubbo.registry.client.InstanceAddressURL, var3274=r0, var2171=r2, var86=null_type, var639=r1, var2033=$z0, var2974=$r7, var3599=org.apache.dubbo.common.utils.StringUtils, var3061=$z2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2265, r0=var3274, r2=var2171, null_type=var86, r1=var639, $z0=var2033, $r7=var2974, org.apache.dubbo.common.utils.StringUtils=var3599, $z2=var3061}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7);	if $z2 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1);	return null
;block_num 3