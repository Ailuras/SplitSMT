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

(declare-sort var3473 0)
(declare-sort var568 0)
(declare-sort var2614 0)
(declare-sort var1312 0)
(declare-sort var2525 0)
(declare-sort var2443 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1312_getServiceContext/735675290 () var2614)
(declare-fun getConsumerUrl/-1021200294 (var2614) var2525)
(declare-fun getProtocolServiceKey/574559726 (var3473) String)
(declare-fun var2443_isEmpty/-813097145 (String) Bool)
(declare-fun hasServiceMethodParameter/645806140 (var3473 String String) Bool)
(declare-const null-var3473 var3473)
(declare-const null-String String)
(declare-const null-var2525 var2525)
(declare-const var461 var3473) ; Statement: r2 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var461 null-var3473)))
(declare-const var3427 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3427 null-String)))
(define-const var1557 var2614 var1312_getServiceContext/735675290) ; Statement: $r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var1404 var2525 (getConsumerUrl/-1021200294 var1557)) ; Statement: r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r1 == null goto $r4 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (= var1404 null-var2525)) ; Cond: r1 == null 
(assert true)
(define-const var3934 String (getProtocolServiceKey/574559726 var461)) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var781 Bool (var2443_isEmpty/-813097145 var3934)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String)>($r4, r3) 
(assert (= (ite var781 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var163 Bool (hasServiceMethodParameter/645806140 var461 var3934 var3427)) ; Statement: $z1 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String)>($r4, r3) 
 ; Statement: return $z1 
(check-sat)
; {var1312_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var2443_isEmpty/-813097145=([java.lang.String], boolean), hasServiceMethodParameter/645806140=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String, java.lang.String], boolean)}
; {var3473=org.apache.dubbo.registry.client.InstanceAddressURL, var461=r2, var3427=r3, var568=null_type, var2614=org.apache.dubbo.rpc.RpcServiceContext, var1312=org.apache.dubbo.rpc.RpcContext, var1557=$r0, var2525=org.apache.dubbo.common.URL, var1404=r1, var3934=$r4, var2443=org.apache.dubbo.common.utils.StringUtils, var781=$z0, var163=$z1}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var3473, r2=var461, r3=var3427, null_type=var568, org.apache.dubbo.rpc.RpcServiceContext=var2614, org.apache.dubbo.rpc.RpcContext=var1312, $r0=var1557, org.apache.dubbo.common.URL=var2525, r1=var1404, $r4=var3934, org.apache.dubbo.common.utils.StringUtils=var2443, $z0=var781, $z1=var163}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	$r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r1 == null goto $r4 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r4 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 == 0 goto $z1 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String)>($r4, r3);	$z1 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String)>($r4, r3);	return $z1
;block_num 3