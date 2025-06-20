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

(declare-sort var62 0)
(declare-sort var2664 0)
(declare-sort var2756 0)
(declare-sort var1339 0)
(declare-sort var813 0)
(declare-sort var3470 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2756_getServiceContext/735675290 () var2664)
(declare-fun getConsumerUrl/-1021200294 (var2664) var1339)
(declare-fun var3470_isEquals/882237642 (String String) Bool)
(declare-fun getServiceKey/1514874342 (var2664) String)
(declare-const null-var62 var62)
(declare-const null-var1339 var1339)
(declare-const null-String String)
(declare-const var1210 var62) ; Statement: r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1210 null-var62)))
(define-const var1302 var2664 var2756_getServiceContext/735675290) ; Statement: $r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var1406 var1339 (getConsumerUrl/-1021200294 var1302)) ; Statement: r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r1 != null goto $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert (not (not (= var1406 null-var1339)))) ; Negate: Cond: r1 != null  
(define-const var713 String null-String) ; Statement: $r7 = null 
 ; Statement: goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer")] 
(assert true) ; Non Conditional
(define-const var1363 Bool (var3470_isEquals/882237642 var713 "consumer")) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer") 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (not (= (ite var1363 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3444 var2664 var2756_getServiceContext/735675290) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var3837 String (getServiceKey/1514874342 var3444)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getServiceKey()>() 
 ; Statement: return $r5 
(check-sat)
; {var2756_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), var3470_isEquals/882237642=([java.lang.String, java.lang.String], boolean), getServiceKey/1514874342=([org.apache.dubbo.rpc.RpcServiceContext], java.lang.String)}
; {var62=org.apache.dubbo.registry.client.InstanceAddressURL, var1210=r6, var2664=org.apache.dubbo.rpc.RpcServiceContext, var2756=org.apache.dubbo.rpc.RpcContext, var1302=$r0, var1339=org.apache.dubbo.common.URL, var1406=r1, var813=null_type, var713=$r7, var3470=org.apache.dubbo.common.utils.StringUtils, var1363=$z0, var3444=$r4, var3837=$r5}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var62, r6=var1210, org.apache.dubbo.rpc.RpcServiceContext=var2664, org.apache.dubbo.rpc.RpcContext=var2756, $r0=var1302, org.apache.dubbo.common.URL=var1339, r1=var1406, null_type=var813, $r7=var713, org.apache.dubbo.common.utils.StringUtils=var3470, $z0=var1363, $r4=var3444, $r5=var3837}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	$r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r1 != null goto $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r7 = null;	goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer")];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer");	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getServiceKey()>();	return $r5
;block_num 4