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

(declare-sort var3121 0)
(declare-sort var1267 0)
(declare-sort var1820 0)
(declare-sort var552 0)
(declare-sort var2204 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun forbidden/2129308851 (var3121) Bool)
(declare-fun multiGroup/2129308851 (var3121) Bool)
(declare-fun getInvokers/-1026765557 (var2204) var1820)
(declare-fun cast-from-var3121-to-var2204 (var3121) var2204)
(declare-const null-var3121 var3121)
(declare-const null-var1267 var1267)
(declare-const null-var1820 var1820)
(declare-const null-var552 var552)
(declare-const var2224 var3121) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory 
(assert (not (= var2224 null-var3121)))
(declare-const var2246 var1267) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.cluster.SingleRouterChain 
(assert (not (= var2246 null-var1267)))
(declare-const var2936 var1820) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var2936 null-var1820)))
(declare-const var3518 var552) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3518 null-var552)))
(define-const var1476 Bool (forbidden/2129308851 var2224)) ; Statement: $z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean forbidden> 
 ; Statement: if $z0 == 0 goto $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup> 
(assert (= (ite var1476 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2918 Bool (multiGroup/2129308851 var2224)) ; Statement: $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup> 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert (not (= (ite var2918 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var1646 var1820 (getInvokers/-1026765557 (cast-from-var3121-to-var2204 var2224))) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.rpc.cluster.router.state.BitList getInvokers()>() 
 ; Statement: return $r5 
(check-sat)
; {forbidden/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), multiGroup/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), getInvokers/-1026765557=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.rpc.cluster.router.state.BitList), cast-from-var3121-to-var2204=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory)}
; {var3121=org.apache.dubbo.registry.integration.DynamicDirectory, var2224=r0, var1267=org.apache.dubbo.rpc.cluster.SingleRouterChain, var2246=r1, var1820=org.apache.dubbo.rpc.cluster.router.state.BitList, var2936=r2, var552=org.apache.dubbo.rpc.Invocation, var3518=r3, var1476=$z0, var2918=$z1, var2204=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var1646=$r5}
; {org.apache.dubbo.registry.integration.DynamicDirectory=var3121, r0=var2224, org.apache.dubbo.rpc.cluster.SingleRouterChain=var1267, r1=var2246, org.apache.dubbo.rpc.cluster.router.state.BitList=var1820, r2=var2936, org.apache.dubbo.rpc.Invocation=var552, r3=var3518, $z0=var1476, $z1=var2918, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var2204, $r5=var1646}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory;	r1 := @parameter0: org.apache.dubbo.rpc.cluster.SingleRouterChain;	r2 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList;	r3 := @parameter2: org.apache.dubbo.rpc.Invocation;	$z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean forbidden>;	if $z0 == 0 goto $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup>;	$z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup>;	if $z1 == 0 goto $r4 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL getConsumerUrl()>();	$r5 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.rpc.cluster.router.state.BitList getInvokers()>();	return $r5
;block_num 3