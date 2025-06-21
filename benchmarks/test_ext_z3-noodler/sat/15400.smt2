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

(declare-sort var213 0)
(declare-sort var2006 0)
(declare-sort var404 0)
(declare-sort var3721 0)
(declare-sort var2076 0)
(declare-sort var1989 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var213 String) Bool)
(declare-fun var3721_getServiceContext/735675290 () var404)
(declare-fun getConsumerUrl/-1021200294 (var404) var2076)
(declare-fun getProtocolServiceKey/574559726 (var213) String)
(declare-fun var1989_isEmpty/-813097145 (String) Bool)
(declare-const null-var213 var213)
(declare-const null-String String)
(declare-const null-var2076 var2076)
(declare-const var384 var213) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var384 null-var213)))
(declare-const var3066 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3066 null-String)))
(declare-const var3428 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3428 null-String)))
(assert true)
(define-const var2192 Bool (consumerParamFirst/5744255 var384 var3428)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (not (= (ite var2192 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1567 var404 var3721_getServiceContext/735675290) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var2690 var2076 (getConsumerUrl/-1021200294 var1567)) ; Statement: r6 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r6 == null goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (= var2690 null-var2076)) ; Cond: r6 == null 
(assert true)
(define-const var2982 String (getProtocolServiceKey/574559726 var384)) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var3390 Bool (var1989_isEmpty/-813097145 var2982)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7) 
 ; Statement: if $z2 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1) 
(assert (not (= (ite var3390 1 0) 0))) ; Negate: Cond: $z2 == 0  
 ; Statement: return null 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), var3721_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var1989_isEmpty/-813097145=([java.lang.String], boolean)}
; {var213=org.apache.dubbo.registry.client.InstanceAddressURL, var384=r0, var3066=r2, var2006=null_type, var3428=r1, var2192=$z0, var404=org.apache.dubbo.rpc.RpcServiceContext, var3721=org.apache.dubbo.rpc.RpcContext, var1567=$r4, var2076=org.apache.dubbo.common.URL, var2690=r6, var2982=$r7, var1989=org.apache.dubbo.common.utils.StringUtils, var3390=$z2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var213, r0=var384, r2=var3066, null_type=var2006, r1=var3428, $z0=var2192, org.apache.dubbo.rpc.RpcServiceContext=var404, org.apache.dubbo.rpc.RpcContext=var3721, $r4=var1567, org.apache.dubbo.common.URL=var2076, r6=var2690, $r7=var2982, org.apache.dubbo.common.utils.StringUtils=var1989, $z2=var3390}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r6 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r6 == null goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7);	if $z2 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1);	return null
;block_num 4