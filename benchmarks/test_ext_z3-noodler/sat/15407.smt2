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

(declare-sort var2447 0)
(declare-sort var2154 0)
(declare-sort var2029 0)
(declare-sort var2954 0)
(declare-sort var1199 0)
(declare-sort var2733 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2447 String) Bool)
(declare-fun var2954_getServiceContext/735675290 () var2029)
(declare-fun getConsumerUrl/-1021200294 (var2029) var1199)
(declare-fun getProtocolServiceKey/574559726 (var2447) String)
(declare-fun var2733_isEmpty/-813097145 (String) Bool)
(declare-fun getServiceMethodParameter/1908992162 (var2447 String String String) String)
(declare-const null-var2447 var2447)
(declare-const null-String String)
(declare-const null-var1199 var1199)
(declare-const var2162 var2447) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var2162 null-var2447)))
(declare-const var3700 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3700 null-String)))
(declare-const var3079 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3079 null-String)))
(assert true)
(define-const var50 Bool (consumerParamFirst/5744255 var2162 var3079)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (not (= (ite var50 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2727 var2029 var2954_getServiceContext/735675290) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var2765 var1199 (getConsumerUrl/-1021200294 var2727)) ; Statement: r6 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r6 == null goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (= var2765 null-var1199)) ; Cond: r6 == null 
(assert true)
(define-const var991 String (getProtocolServiceKey/574559726 var2162)) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var3283 Bool (var2733_isEmpty/-813097145 var991)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7) 
 ; Statement: if $z2 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1) 
(assert (= (ite var3283 1 0) 0)) ; Cond: $z2 == 0 
(assert true)
(define-const var1097 String (getServiceMethodParameter/1908992162 var2162 var991 var3700 var3079)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1) 
 ; Statement: return $r3 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), var2954_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var2733_isEmpty/-813097145=([java.lang.String], boolean), getServiceMethodParameter/1908992162=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var2447=org.apache.dubbo.registry.client.InstanceAddressURL, var2162=r0, var3700=r2, var2154=null_type, var3079=r1, var50=$z0, var2029=org.apache.dubbo.rpc.RpcServiceContext, var2954=org.apache.dubbo.rpc.RpcContext, var2727=$r4, var1199=org.apache.dubbo.common.URL, var2765=r6, var991=$r7, var2733=org.apache.dubbo.common.utils.StringUtils, var3283=$z2, var1097=$r3}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2447, r0=var2162, r2=var3700, null_type=var2154, r1=var3079, $z0=var50, org.apache.dubbo.rpc.RpcServiceContext=var2029, org.apache.dubbo.rpc.RpcContext=var2954, $r4=var2727, org.apache.dubbo.common.URL=var1199, r6=var2765, $r7=var991, org.apache.dubbo.common.utils.StringUtils=var2733, $z2=var3283, $r3=var1097}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r6 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r6 == null goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7);	if $z2 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1);	$r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r7, r2, r1);	return $r3
;block_num 4