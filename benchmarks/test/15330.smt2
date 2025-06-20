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

(declare-sort var2065 0)
(declare-sort var1397 0)
(declare-sort var3469 0)
(declare-sort var2409 0)
(declare-sort var2308 0)
(declare-sort var239 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2065 String) Bool)
(declare-fun var2409_getServiceContext/735675290 () var3469)
(declare-fun getConsumerUrl/-1021200294 (var3469) var2308)
(declare-fun metadataInfo/507655048 (var2065) var239)
(declare-fun getInstanceParameter/1439176475 (var2065 String) String)
(declare-const null-var2065 var2065)
(declare-const null-String String)
(declare-const null-var2308 var2308)
(declare-const null-var239 var239)
(declare-const var3191 var2065) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var3191 null-var2065)))
(declare-const var2233 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2233 null-String)))
(declare-const var2314 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2314 null-String)))
(assert true)
(define-const var1697 Bool (consumerParamFirst/5744255 var3191 var2314)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert (not (= (ite var1697 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3754 var3469 var2409_getServiceContext/735675290) ; Statement: $r5 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var1483 var2308 (getConsumerUrl/-1021200294 var3754)) ; Statement: r7 = virtualinvoke $r5.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r7 == null goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert (= var1483 null-var2308)) ; Cond: r7 == null 
(define-const var2384 var239 (metadataInfo/507655048 var3191)) ; Statement: $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
 ; Statement: if $r8 == null goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1) 
(assert (= var2384 null-var239)) ; Cond: $r8 == null 
(assert true)
(define-const var2549 String (getInstanceParameter/1439176475 var3191 var2314)) ; Statement: $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1) 
 ; Statement: return $r2 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), var2409_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), metadataInfo/507655048=([org.apache.dubbo.registry.client.InstanceAddressURL], org.apache.dubbo.metadata.MetadataInfo), getInstanceParameter/1439176475=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], java.lang.String)}
; {var2065=org.apache.dubbo.registry.client.InstanceAddressURL, var3191=r0, var2233=r3, var1397=null_type, var2314=r1, var1697=$z0, var3469=org.apache.dubbo.rpc.RpcServiceContext, var2409=org.apache.dubbo.rpc.RpcContext, var3754=$r5, var2308=org.apache.dubbo.common.URL, var1483=r7, var239=org.apache.dubbo.metadata.MetadataInfo, var2384=$r8, var2549=$r2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2065, r0=var3191, r3=var2233, null_type=var1397, r1=var2314, $z0=var1697, org.apache.dubbo.rpc.RpcServiceContext=var3469, org.apache.dubbo.rpc.RpcContext=var2409, $r5=var3754, org.apache.dubbo.common.URL=var2308, r7=var1483, org.apache.dubbo.metadata.MetadataInfo=var239, $r8=var2384, $r2=var2549}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	$r5 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r7 = virtualinvoke $r5.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r7 == null goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	$r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	if $r8 == null goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1);	$r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1);	return $r2
;block_num 4