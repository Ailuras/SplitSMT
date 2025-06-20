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

(declare-sort var1204 0)
(declare-sort var1200 0)
(declare-sort var2734 0)
(declare-sort var3786 0)
(declare-sort var3241 0)
(declare-sort var2757 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2734_getServiceContext/735675290 () var1200)
(declare-fun getConsumerUrl/-1021200294 (var1200) var3786)
(declare-fun var2757_isEquals/882237642 (String String) Bool)
(declare-fun getProtocolServiceKey/-981050578 (var1200) String)
(declare-const null-var1204 var1204)
(declare-const null-var3786 var3786)
(declare-const null-String String)
(declare-const var1203 var1204) ; Statement: r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1203 null-var1204)))
(define-const var758 var1200 var2734_getServiceContext/735675290) ; Statement: $r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var628 var3786 (getConsumerUrl/-1021200294 var758)) ; Statement: r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r1 != null goto $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert (not (not (= var628 null-var3786)))) ; Negate: Cond: r1 != null  
(define-const var3730 String null-String) ; Statement: $r7 = null 
 ; Statement: goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer")] 
(assert true) ; Non Conditional
(define-const var3065 Bool (var2757_isEquals/882237642 var3730 "consumer")) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer") 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (= (ite var3065 1 0) 0)) ; Cond: $z0 == 0 
(define-const var940 var1200 var2734_getServiceContext/735675290) ; Statement: $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var1232 String (getProtocolServiceKey/-981050578 var940)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getProtocolServiceKey()>() 
 ; Statement: return $r3 
(check-sat)
; {var2734_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), var2757_isEquals/882237642=([java.lang.String, java.lang.String], boolean), getProtocolServiceKey/-981050578=([org.apache.dubbo.rpc.RpcServiceContext], java.lang.String)}
; {var1204=org.apache.dubbo.registry.client.InstanceAddressURL, var1203=r6, var1200=org.apache.dubbo.rpc.RpcServiceContext, var2734=org.apache.dubbo.rpc.RpcContext, var758=$r0, var3786=org.apache.dubbo.common.URL, var628=r1, var3241=null_type, var3730=$r7, var2757=org.apache.dubbo.common.utils.StringUtils, var3065=$z0, var940=$r2, var1232=$r3}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1204, r6=var1203, org.apache.dubbo.rpc.RpcServiceContext=var1200, org.apache.dubbo.rpc.RpcContext=var2734, $r0=var758, org.apache.dubbo.common.URL=var3786, r1=var628, null_type=var3241, $r7=var3730, org.apache.dubbo.common.utils.StringUtils=var2757, $z0=var3065, $r2=var940, $r3=var1232}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	$r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r1 != null goto $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r7 = null;	goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer")];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer");	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getProtocolServiceKey()>();	return $r3
;block_num 4