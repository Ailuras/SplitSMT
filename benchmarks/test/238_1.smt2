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

(declare-sort var488 0)
(declare-sort var299 0)
(declare-sort var3559 0)
(declare-sort var2911 0)
(declare-sort var3809 0)
(declare-sort var3413 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3809_getUrl/-275947851 (var3809) var2911)
(declare-fun cast-from-var299-to-var3809 (var299) var3809)
(declare-fun getServiceInterface/-1311863806 (var2911) String)
(declare-fun getParameter/448702405 (var2911 String Int) Int)
(declare-fun var3413_max/1360571700 (Int Int) Int)
(declare-const null-var488 var488)
(declare-const null-var299 var299)
(declare-const null-var3559 var3559)
(declare-const var3176 var488) ; Statement: r8 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AbstractLoadBalance 
(assert (not (= var3176 null-var488)))
(declare-const var734 var299) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var734 null-var299)))
(declare-const var570 var3559) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var570 null-var3559)))
(define-const var2138 var2911 (var3809_getUrl/-275947851 (cast-from-var299-to-var3809 var734))) ; Statement: r9 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2883 Bool true) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.cluster.ClusterInvoker 
 ; Statement: if $z0 == 0 goto $r2 = "org.apache.dubbo.registry.RegistryService" 
(assert (= (ite var2883 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3438 String "org.apache.dubbo.registry.RegistryService") ; Statement: $r2 = "org.apache.dubbo.registry.RegistryService" 
(assert true)
(define-const var1752 String (getServiceInterface/-1311863806 var2138)) ; Statement: $r1 = virtualinvoke r9.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var26 Bool (= var3438 var1752)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3) 
(assert (not (= (ite var26 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var3453 Int (getParameter/448702405 var2138 "weight" 100)) ; Statement: i10 = virtualinvoke r9.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("weight", 100) 
 ; Statement: goto [?= $i11 = staticinvoke <java.lang.Math: int max(int,int)>(i10, 0)] 
(assert true) ; Non Conditional
(define-const var1527 Int (var3413_max/1360571700 var3453 0)) ; Statement: $i11 = staticinvoke <java.lang.Math: int max(int,int)>(i10, 0) 
 ; Statement: return $i11 
(check-sat)
; {var3809_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var299-to-var3809=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), var3413_max/1360571700=([int, int], int)}
; {var488=org.apache.dubbo.rpc.cluster.loadbalance.AbstractLoadBalance, var3176=r8, var299=org.apache.dubbo.rpc.Invoker, var734=r0, var3559=org.apache.dubbo.rpc.Invocation, var570=r3, var2911=org.apache.dubbo.common.URL, var3809=org.apache.dubbo.common.Node, var2138=r9, var2883=$z0, var3438=$r2, var1752=$r1, var26=$z1, var3453=i10, var3413=java.lang.Math, var1527=$i11}
; {org.apache.dubbo.rpc.cluster.loadbalance.AbstractLoadBalance=var488, r8=var3176, org.apache.dubbo.rpc.Invoker=var299, r0=var734, org.apache.dubbo.rpc.Invocation=var3559, r3=var570, org.apache.dubbo.common.URL=var2911, org.apache.dubbo.common.Node=var3809, r9=var2138, $z0=var2883, $r2=var3438, $r1=var1752, $z1=var26, i10=var3453, java.lang.Math=var3413, $i11=var1527}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AbstractLoadBalance;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r3 := @parameter1: org.apache.dubbo.rpc.Invocation;	r9 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$z0 = r0 instanceof org.apache.dubbo.rpc.cluster.ClusterInvoker;	if $z0 == 0 goto $r2 = "org.apache.dubbo.registry.RegistryService";	$r2 = "org.apache.dubbo.registry.RegistryService";	$r1 = virtualinvoke r9.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r3);	i10 = virtualinvoke r9.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("weight", 100);	goto [?= $i11 = staticinvoke <java.lang.Math: int max(int,int)>(i10, 0)];	$i11 = staticinvoke <java.lang.Math: int max(int,int)>(i10, 0);	return $i11
;block_num 4