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

(declare-sort var2077 0)
(declare-sort var3352 0)
(declare-sort var844 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2077 String) Bool)
(declare-fun getProtocolServiceKey/574559726 (var2077) String)
(declare-fun var844_isEmpty/-813097145 (String) Bool)
(declare-fun hasServiceMethodParameter/522084191 (var2077 String String String) Bool)
(declare-const null-var2077 var2077)
(declare-const null-String String)
(declare-const var1670 var2077) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1670 null-var2077)))
(declare-const var1400 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1400 null-String)))
(declare-const var1456 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1456 null-String)))
(assert true)
(define-const var3298 Bool (consumerParamFirst/5744255 var1670 var1456)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (= (ite var3298 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1075 String (getProtocolServiceKey/574559726 var1670)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var351 Bool (var844_isEmpty/-813097145 var1075)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r5) 
 ; Statement: if $z3 == 0 goto $z1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r5, r2, r1) 
(assert (= (ite var351 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var684 Bool (hasServiceMethodParameter/522084191 var1670 var1075 var1400 var1456)) ; Statement: $z1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r5, r2, r1) 
 ; Statement: return $z1 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var844_isEmpty/-813097145=([java.lang.String], boolean), hasServiceMethodParameter/522084191=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String, java.lang.String, java.lang.String], boolean)}
; {var2077=org.apache.dubbo.registry.client.InstanceAddressURL, var1670=r0, var1400=r2, var3352=null_type, var1456=r1, var3298=$z0, var1075=$r5, var844=org.apache.dubbo.common.utils.StringUtils, var351=$z3, var684=$z1}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2077, r0=var1670, r2=var1400, null_type=var3352, r1=var1456, $z0=var3298, $r5=var1075, org.apache.dubbo.common.utils.StringUtils=var844, $z3=var351, $z1=var684}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r5 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r5);	if $z3 == 0 goto $z1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r5, r2, r1);	$z1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r5, r2, r1);	return $z1
;block_num 3