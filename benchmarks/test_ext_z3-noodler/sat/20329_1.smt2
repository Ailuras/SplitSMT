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

(declare-sort var3670 0)
(declare-sort var1677 0)
(declare-sort var467 0)
(declare-sort var2920 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun localAddress/840364368 (var3670) var1677)
(declare-fun var2920_isEmpty/-813097145 (String) Bool)
(declare-fun getLocalHost/-902608329 (var3670) String)
(declare-const null-var3670 var3670)
(declare-const null-var1677 var1677)
(declare-const null-String String)
(declare-const var1160 var3670) ; Statement: r0 := @this: org.apache.dubbo.rpc.RpcServiceContext 
(assert (not (= var1160 null-var3670)))
(define-const var2125 var1677 (localAddress/840364368 var1160)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
(assert (not (not (= var2125 null-var1677)))) ; Negate: Cond: $r1 != null  
(define-const var977 String null-String) ; Statement: $r4 = null 
 ; Statement: goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4)] 
(assert true) ; Non Conditional
(define-const var1601 Bool (var2920_isEmpty/-813097145 var977)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto return $r4 
(assert (not (= (ite var1601 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3926 String (getLocalHost/-902608329 var1160)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getLocalHost()>() 
 ; Statement: return $r3 
(check-sat)
; {localAddress/840364368=([org.apache.dubbo.rpc.RpcServiceContext], java.net.InetSocketAddress), var2920_isEmpty/-813097145=([java.lang.String], boolean), getLocalHost/-902608329=([org.apache.dubbo.rpc.RpcServiceContext], java.lang.String)}
; {var3670=org.apache.dubbo.rpc.RpcServiceContext, var1160=r0, var1677=java.net.InetSocketAddress, var2125=$r1, var467=null_type, var977=$r4, var2920=org.apache.dubbo.common.utils.StringUtils, var1601=$z0, var3926=$r3}
; {org.apache.dubbo.rpc.RpcServiceContext=var3670, r0=var1160, java.net.InetSocketAddress=var1677, $r1=var2125, null_type=var467, $r4=var977, org.apache.dubbo.common.utils.StringUtils=var2920, $z0=var1601, $r3=var3926}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.RpcServiceContext;	$r1 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	$r4 = null;	goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4)];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 == 0 goto return $r4;	$r3 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getLocalHost()>();	return $r3
;block_num 4