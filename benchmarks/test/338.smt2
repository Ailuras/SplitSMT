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

(declare-sort var620 0)
(declare-sort var2889 0)
(declare-sort var2343 0)
(declare-sort var1082 0)
(declare-sort var3472 0)
(declare-sort var2317 0)
(declare-sort var2600 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3472_getUrl/-275947851 (var3472) var1082)
(declare-fun cast-from-var2889-to-var3472 (var2889) var3472)
(declare-fun getServiceInterface/-1311863806 (var1082) String)
(declare-fun var2317_getMethodName/-516674313 (var2343) String)
(declare-fun getMethodParameter/-364685573 (var1082 String String Int) Int)
(declare-fun var2600_max/1360571700 (Int Int) Int)
(declare-const null-var620 var620)
(declare-const null-var2889 var2889)
(declare-const null-var2343 var2343)
(declare-const var563 var620) ; Statement: r8 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AbstractLoadBalance 
(assert (not (= var563 null-var620)))
(declare-const var2681 var2889) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2681 null-var2889)))
(declare-const var1879 var2343) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1879 null-var2343)))
(define-const var2926 var1082 (var3472_getUrl/-275947851 (cast-from-var2889-to-var3472 var2681))) ; Statement: r9 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2590 Bool true) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.cluster.ClusterInvoker 
 ; Statement: if $z0 == 0 goto $r2 = "org.apache.dubbo.registry.RegistryService" 
(assert (= (ite var2590 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2508 String "org.apache.dubbo.registry.RegistryService") ; Statement: $r2 = "org.apache.dubbo.registry.RegistryService" 
(assert true)
(define-const var81 String (getServiceInterface/-1311863806 var2926)) ; Statement: $r1 = virtualinvoke r9.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var2199 Bool (= var2508 var81)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3) 
(assert (= (ite var2199 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2655 String (var2317_getMethodName/-516674313 var1879)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3) 
(assert true)
(define-const var1209 Int (getMethodParameter/-364685573 var2926 var2655 "weight" 100)) ; Statement: i10 = virtualinvoke r9.<org.apache.dubbo.common.URL: int getMethodParameter(java.lang.String,java.lang.String,int)>($r4, "weight", 100) 
 ; Statement: if i10 <= 0 goto $i11 = staticinvoke <java.lang.Math: int max(int,int)>(i10, 0) 
(assert (<= var1209 0)) ; Cond: i10 <= 0 
(define-const var2575 Int (var2600_max/1360571700 var1209 0)) ; Statement: $i11 = staticinvoke <java.lang.Math: int max(int,int)>(i10, 0) 
 ; Statement: return $i11 
(check-sat)
; {var3472_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2889-to-var3472=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var2317_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getMethodParameter/-364685573=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, int], int), var2600_max/1360571700=([int, int], int)}
; {var620=org.apache.dubbo.rpc.cluster.loadbalance.AbstractLoadBalance, var563=r8, var2889=org.apache.dubbo.rpc.Invoker, var2681=r0, var2343=org.apache.dubbo.rpc.Invocation, var1879=r3, var1082=org.apache.dubbo.common.URL, var3472=org.apache.dubbo.common.Node, var2926=r9, var2590=$z0, var2508=$r2, var81=$r1, var2199=$z1, var2317=org.apache.dubbo.rpc.support.RpcUtils, var2655=$r4, var1209=i10, var2600=java.lang.Math, var2575=$i11}
; {org.apache.dubbo.rpc.cluster.loadbalance.AbstractLoadBalance=var620, r8=var563, org.apache.dubbo.rpc.Invoker=var2889, r0=var2681, org.apache.dubbo.rpc.Invocation=var2343, r3=var1879, org.apache.dubbo.common.URL=var1082, org.apache.dubbo.common.Node=var3472, r9=var2926, $z0=var2590, $r2=var2508, $r1=var81, $z1=var2199, org.apache.dubbo.rpc.support.RpcUtils=var2317, $r4=var2655, i10=var1209, java.lang.Math=var2600, $i11=var2575}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AbstractLoadBalance;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r3 := @parameter1: org.apache.dubbo.rpc.Invocation;	r9 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$z0 = r0 instanceof org.apache.dubbo.rpc.cluster.ClusterInvoker;	if $z0 == 0 goto $r2 = "org.apache.dubbo.registry.RegistryService";	$r2 = "org.apache.dubbo.registry.RegistryService";	$r1 = virtualinvoke r9.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3);	$r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3);	i10 = virtualinvoke r9.<org.apache.dubbo.common.URL: int getMethodParameter(java.lang.String,java.lang.String,int)>($r4, "weight", 100);	if i10 <= 0 goto $i11 = staticinvoke <java.lang.Math: int max(int,int)>(i10, 0);	$i11 = staticinvoke <java.lang.Math: int max(int,int)>(i10, 0);	return $i11
;block_num 4