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

(declare-sort var2116 0)
(declare-sort var3673 0)
(declare-sort var1296 0)
(declare-sort var2032 0)
(declare-sort var1370 0)
(declare-sort var385 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2116 String) Bool)
(declare-fun var2032_getServiceContext/735675290 () var1296)
(declare-fun getConsumerUrl/-1021200294 (var1296) var1370)
(declare-fun getMethodParameter/2015795402 (var1370 String String) String)
(declare-fun var385_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2116 var2116)
(declare-const null-String String)
(declare-const null-var1370 var1370)
(declare-const var518 var2116) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var518 null-var2116)))
(declare-const var1508 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1508 null-String)))
(declare-const var768 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var768 null-String)))
(assert true)
(define-const var489 Bool (consumerParamFirst/5744255 var518 var768)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (not (= (ite var489 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3743 var1296 var2032_getServiceContext/735675290) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var3503 var1370 (getConsumerUrl/-1021200294 var3743)) ; Statement: r6 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r6 == null goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (not (= var3503 null-var1370))) ; Negate: Cond: r6 == null  
(assert true)
(define-const var786 String (getMethodParameter/2015795402 var3503 var1508 var768)) ; Statement: r5 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r2, r1) 
(define-const var1742 Bool (var385_isNotEmpty/-1251449450 var786)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z1 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (not (= (ite var1742 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return r5 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), var2032_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var385_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2116=org.apache.dubbo.registry.client.InstanceAddressURL, var518=r0, var1508=r2, var3673=null_type, var768=r1, var489=$z0, var1296=org.apache.dubbo.rpc.RpcServiceContext, var2032=org.apache.dubbo.rpc.RpcContext, var3743=$r4, var1370=org.apache.dubbo.common.URL, var3503=r6, var786=r5, var385=org.apache.dubbo.common.utils.StringUtils, var1742=$z1}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2116, r0=var518, r2=var1508, null_type=var3673, r1=var768, $z0=var489, org.apache.dubbo.rpc.RpcServiceContext=var1296, org.apache.dubbo.rpc.RpcContext=var2032, $r4=var3743, org.apache.dubbo.common.URL=var1370, r6=var3503, r5=var786, org.apache.dubbo.common.utils.StringUtils=var385, $z1=var1742}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r6 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r6 == null goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	r5 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r2, r1);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z1 == 0 goto $r7 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	return r5
;block_num 4