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

(declare-sort var489 0)
(declare-sort var850 0)
(declare-sort var1888 0)
(declare-sort var129 0)
(declare-sort var525 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1888_getServiceContext/735675290 () var850)
(declare-fun getConsumerUrl/-1021200294 (var850) var129)
(declare-fun getProtocol/491749358 (var129) String)
(declare-fun var525_isEquals/882237642 (String String) Bool)
(declare-fun getServiceKey/1514874342 (var850) String)
(declare-const null-var489 var489)
(declare-const null-var129 var129)
(declare-const var2121 var489) ; Statement: r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var2121 null-var489)))
(define-const var1225 var850 var1888_getServiceContext/735675290) ; Statement: $r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var2540 var129 (getConsumerUrl/-1021200294 var1225)) ; Statement: r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
 ; Statement: if r1 != null goto $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert (not (= var2540 null-var129))) ; Cond: r1 != null 
(assert true)
(define-const var101 String (getProtocol/491749358 var2540)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true) ; Non Conditional
(define-const var823 Bool (var525_isEquals/882237642 var101 "consumer")) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer") 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (not (= (ite var823 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1239 var850 var1888_getServiceContext/735675290) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var1955 String (getServiceKey/1514874342 var1239)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getServiceKey()>() 
 ; Statement: return $r5 
(check-sat)
; {var1888_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), var525_isEquals/882237642=([java.lang.String, java.lang.String], boolean), getServiceKey/1514874342=([org.apache.dubbo.rpc.RpcServiceContext], java.lang.String)}
; {var489=org.apache.dubbo.registry.client.InstanceAddressURL, var2121=r6, var850=org.apache.dubbo.rpc.RpcServiceContext, var1888=org.apache.dubbo.rpc.RpcContext, var1225=$r0, var129=org.apache.dubbo.common.URL, var2540=r1, var101=$r7, var525=org.apache.dubbo.common.utils.StringUtils, var823=$z0, var1239=$r4, var1955=$r5}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var489, r6=var2121, org.apache.dubbo.rpc.RpcServiceContext=var850, org.apache.dubbo.rpc.RpcContext=var1888, $r0=var1225, org.apache.dubbo.common.URL=var129, r1=var2540, $r7=var101, org.apache.dubbo.common.utils.StringUtils=var525, $z0=var823, $r4=var1239, $r5=var1955}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	$r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	if r1 != null goto $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r7, "consumer");	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r4 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getServiceKey()>();	return $r5
;block_num 4