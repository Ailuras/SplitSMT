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

(declare-sort var1713 0)
(declare-sort var2356 0)
(declare-sort var3668 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun localAddress/840364368 (var1713) var2356)
(declare-fun getHostName/1327176861 (var2356) String)
(declare-fun var3668_isEmpty/-813097145 (String) Bool)
(declare-fun getLocalHost/-902608329 (var1713) String)
(declare-const null-var1713 var1713)
(declare-const null-var2356 var2356)
(declare-const var1907 var1713) ; Statement: r0 := @this: org.apache.dubbo.rpc.RpcServiceContext 
(assert (not (= var1907 null-var1713)))
(define-const var3053 var2356 (localAddress/840364368 var1907)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
(assert (not (= var3053 null-var2356))) ; Cond: $r1 != null 
(define-const var3229 var2356 (localAddress/840364368 var1907)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
(assert true)
(define-const var3997 String (getHostName/1327176861 var3229)) ; Statement: $r4 = virtualinvoke $r2.<java.net.InetSocketAddress: java.lang.String getHostName()>() 
(assert true) ; Non Conditional
(define-const var3185 Bool (var3668_isEmpty/-813097145 var3997)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto return $r4 
(assert (not (= (ite var3185 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2119 String (getLocalHost/-902608329 var1907)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getLocalHost()>() 
 ; Statement: return $r3 
(check-sat)
; {localAddress/840364368=([org.apache.dubbo.rpc.RpcServiceContext], java.net.InetSocketAddress), getHostName/1327176861=([java.net.InetSocketAddress], java.lang.String), var3668_isEmpty/-813097145=([java.lang.String], boolean), getLocalHost/-902608329=([org.apache.dubbo.rpc.RpcServiceContext], java.lang.String)}
; {var1713=org.apache.dubbo.rpc.RpcServiceContext, var1907=r0, var2356=java.net.InetSocketAddress, var3053=$r1, var3229=$r2, var3997=$r4, var3668=org.apache.dubbo.common.utils.StringUtils, var3185=$z0, var2119=$r3}
; {org.apache.dubbo.rpc.RpcServiceContext=var1713, r0=var1907, java.net.InetSocketAddress=var2356, $r1=var3053, $r2=var3229, $r4=var3997, org.apache.dubbo.common.utils.StringUtils=var3668, $z0=var3185, $r3=var2119}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.RpcServiceContext;	$r1 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	$r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	$r4 = virtualinvoke $r2.<java.net.InetSocketAddress: java.lang.String getHostName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 == 0 goto return $r4;	$r3 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getLocalHost()>();	return $r3
;block_num 4