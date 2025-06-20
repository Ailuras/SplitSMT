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

(declare-sort var1572 0)
(declare-sort var2470 0)
(declare-sort var282 0)
(declare-sort var3539 0)
(declare-sort var3700 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var282_getServiceContext/735675290 () var2470)
(declare-fun getConsumerUrl/-1021200294 (var2470) var3539)
(declare-fun getProtocol/491749358 (var3539) String)
(declare-fun var3700_isEquals/882237642 (String String) Bool)
(declare-fun getProtocolServiceKey/-981050578 (var2470) String)
(declare-const null-var1572 var1572)
(declare-const null-var3539 var3539)
(declare-const var1555 var1572) ; Statement: r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1555 null-var1572)))
(define-const var2388 var2470 var282_getServiceContext/735675290) ; Statement: $r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var847 var3539 (getConsumerUrl/-1021200294 var2388)) ; Statement: r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r1 != null goto $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert (not (= var847 null-var3539))) ; Cond: r1 != null 
(assert true)
(define-const var3662 String (getProtocol/491749358 var847)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true) ; Non Conditional
(define-const var2968 Bool (var3700_isEquals/882237642 var3662 "consumer")) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer") 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (= (ite var2968 1 0) 0)) ; Cond: $z0 == 0 
(define-const var881 var2470 var282_getServiceContext/735675290) ; Statement: $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var499 String (getProtocolServiceKey/-981050578 var881)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getProtocolServiceKey()>() 
 ; Statement: return $r3 
(check-sat)
; {var282_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), var3700_isEquals/882237642=([java.lang.String, java.lang.String], boolean), getProtocolServiceKey/-981050578=([org.apache.dubbo.rpc.RpcServiceContext], java.lang.String)}
; {var1572=org.apache.dubbo.registry.client.InstanceAddressURL, var1555=r6, var2470=org.apache.dubbo.rpc.RpcServiceContext, var282=org.apache.dubbo.rpc.RpcContext, var2388=$r0, var3539=org.apache.dubbo.common.URL, var847=r1, var3662=$r7, var3700=org.apache.dubbo.common.utils.StringUtils, var2968=$z0, var881=$r2, var499=$r3}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1572, r6=var1555, org.apache.dubbo.rpc.RpcServiceContext=var2470, org.apache.dubbo.rpc.RpcContext=var282, $r0=var2388, org.apache.dubbo.common.URL=var3539, r1=var847, $r7=var3662, org.apache.dubbo.common.utils.StringUtils=var3700, $z0=var2968, $r2=var881, $r3=var499}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	$r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r1 != null goto $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer");	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getProtocolServiceKey()>();	return $r3
;block_num 4