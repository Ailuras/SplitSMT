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

(declare-sort var3059 0)
(declare-sort var1358 0)
(declare-sort var2945 0)
(declare-sort var1989 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun localAddress/840364368 (var3059) var1358)
(declare-fun var1989_isEmpty/-813097145 (String) Bool)
(declare-const null-var3059 var3059)
(declare-const null-var1358 var1358)
(declare-const null-String String)
(declare-const var1789 var3059) ; Statement: r0 := @this: org.apache.dubbo.rpc.RpcServiceContext 
(assert (not (= var1789 null-var3059)))
(define-const var1984 var1358 (localAddress/840364368 var1789)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress> 
(assert (not (not (= var1984 null-var1358)))) ; Negate: Cond: $r1 != null  
(define-const var2726 String null-String) ; Statement: $r4 = null 
 ; Statement: goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4)] 
(assert true) ; Non Conditional
(define-const var2163 Bool (var1989_isEmpty/-813097145 var2726)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto return $r4 
(assert (= (ite var2163 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return $r4 
(check-sat)
; {localAddress/840364368=([org.apache.dubbo.rpc.RpcServiceContext], java.net.InetSocketAddress), var1989_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3059=org.apache.dubbo.rpc.RpcServiceContext, var1789=r0, var1358=java.net.InetSocketAddress, var1984=$r1, var2945=null_type, var2726=$r4, var1989=org.apache.dubbo.common.utils.StringUtils, var2163=$z0}
; {org.apache.dubbo.rpc.RpcServiceContext=var3059, r0=var1789, java.net.InetSocketAddress=var1358, $r1=var1984, null_type=var2945, $r4=var2726, org.apache.dubbo.common.utils.StringUtils=var1989, $z0=var2163}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.RpcServiceContext;	$r1 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.RpcServiceContext: java.net.InetSocketAddress localAddress>;	$r4 = null;	goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4)];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 == 0 goto return $r4;	return $r4
;block_num 4