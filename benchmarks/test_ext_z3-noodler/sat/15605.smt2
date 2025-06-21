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

(declare-sort var2784 0)
(declare-sort var2942 0)
(declare-sort var3657 0)
(declare-sort var199 0)
(declare-sort var445 0)
(declare-sort var3857 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var199_getServiceContext/735675290 () var3657)
(declare-fun getConsumerUrl/-1021200294 (var3657) var445)
(declare-fun getProtocolServiceKey/574559726 (var2784) String)
(declare-fun var3857_isEmpty/-813097145 (String) Bool)
(declare-const null-var2784 var2784)
(declare-const null-String String)
(declare-const null-var445 var445)
(declare-const var3445 var2784) ; Statement: r2 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var3445 null-var2784)))
(declare-const var1431 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1431 null-String)))
(define-const var2680 var3657 var199_getServiceContext/735675290) ; Statement: $r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var1592 var445 (getConsumerUrl/-1021200294 var2680)) ; Statement: r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r1 == null goto $r4 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (= var1592 null-var445)) ; Cond: r1 == null 
(assert true)
(define-const var2332 String (getProtocolServiceKey/574559726 var3445)) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var2200 Bool (var3857_isEmpty/-813097145 var2332)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String)>($r4, r3) 
(assert (not (= (ite var2200 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {var199_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var3857_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2784=org.apache.dubbo.registry.client.InstanceAddressURL, var3445=r2, var1431=r3, var2942=null_type, var3657=org.apache.dubbo.rpc.RpcServiceContext, var199=org.apache.dubbo.rpc.RpcContext, var2680=$r0, var445=org.apache.dubbo.common.URL, var1592=r1, var2332=$r4, var3857=org.apache.dubbo.common.utils.StringUtils, var2200=$z0}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2784, r2=var3445, r3=var1431, null_type=var2942, org.apache.dubbo.rpc.RpcServiceContext=var3657, org.apache.dubbo.rpc.RpcContext=var199, $r0=var2680, org.apache.dubbo.common.URL=var445, r1=var1592, $r4=var2332, org.apache.dubbo.common.utils.StringUtils=var3857, $z0=var2200}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	$r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r1 == null goto $r4 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r4 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 == 0 goto $z1 = virtualinvoke r2.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String)>($r4, r3);	return 0
;block_num 3