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

(declare-sort var2786 0)
(declare-sort var1314 0)
(declare-sort var2505 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun localAddress/840364368 (var2786) var1314)
(declare-fun getHostName/1327176861 (var1314) String)
(declare-fun var2505_isEmpty/-813097145 (String) Bool)
(declare-const null-var2786 var2786)
(declare-const null-var1314 var1314)
(declare-const var139 var2786) ; Statement: r0 := @this: org.apache.dubbo.rpc.RpcServiceContext 
(assert (not (= var139 null-var2786)))
(define-const var3414 var1314 (localAddress/840364368 var139)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
(assert (not (= var3414 null-var1314))) ; Cond: $r1 != null 
(define-const var1788 var1314 (localAddress/840364368 var139)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
(assert true)
(define-const var1317 String (getHostName/1327176861 var1788)) ; Statement: $r4 = virtualinvoke $r2.<java.net.InetSocketAddress: java.lang.String getHostName()>() 
(assert true) ; Non Conditional
(define-const var645 Bool (var2505_isEmpty/-813097145 var1317)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto return $r4 
(assert (= (ite var645 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return $r4 
(check-sat)
; {localAddress/840364368=([org.apache.dubbo.rpc.RpcServiceContext], java.net.InetSocketAddress), getHostName/1327176861=([java.net.InetSocketAddress], java.lang.String), var2505_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2786=org.apache.dubbo.rpc.RpcServiceContext, var139=r0, var1314=java.net.InetSocketAddress, var3414=$r1, var1788=$r2, var1317=$r4, var2505=org.apache.dubbo.common.utils.StringUtils, var645=$z0}
; {org.apache.dubbo.rpc.RpcServiceContext=var2786, r0=var139, java.net.InetSocketAddress=var1314, $r1=var3414, $r2=var1788, $r4=var1317, org.apache.dubbo.common.utils.StringUtils=var2505, $z0=var645}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.RpcServiceContext;	$r1 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	$r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	$r4 = virtualinvoke $r2.<java.net.InetSocketAddress: java.lang.String getHostName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 == 0 goto return $r4;	return $r4
;block_num 4