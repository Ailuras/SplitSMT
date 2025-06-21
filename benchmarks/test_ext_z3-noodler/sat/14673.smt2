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

(declare-sort var850 0)
(declare-sort var1678 0)
(declare-sort var3625 0)
(declare-sort var3512 0)
(declare-sort var3798 0)
(declare-sort var3016 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceDiscoveryInvoker/565745705 (var3512) var3625)
(declare-fun cast-from-var850-to-var3512 (var850) var3512)
(declare-fun var3016_invoke/-1860754555 (var3016 var1678) var3798)
(declare-fun cast-from-var3625-to-var3016 (var3625) var3016)
(declare-const null-var850 var850)
(declare-const null-var1678 var1678)
(declare-const null-var3625 var3625)
(declare-const var2901 var850) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker 
(assert (not (= var2901 null-var850)))
(declare-const var723 var1678) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var723 null-var1678)))
(assert true)
(define-const var1138 var3625 (getServiceDiscoveryInvoker/565745705 (cast-from-var850-to-var3512 var2901))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker getServiceDiscoveryInvoker()>() 
 ; Statement: if r1 != null goto $r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r2) 
(assert (not (= var1138 null-var3625))) ; Cond: r1 != null 
(define-const var1788 var3798 (var3016_invoke/-1860754555 (cast-from-var3625-to-var3016 var1138) var723)) ; Statement: $r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r2) 
 ; Statement: return $r3 
(check-sat)
; {getServiceDiscoveryInvoker/565745705=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker), cast-from-var850-to-var3512=([org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker], org.apache.dubbo.registry.client.migration.MigrationInvoker), var3016_invoke/-1860754555=([org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Result), cast-from-var3625-to-var3016=([org.apache.dubbo.rpc.cluster.ClusterInvoker], org.apache.dubbo.rpc.Invoker)}
; {var850=org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker, var2901=r0, var1678=org.apache.dubbo.rpc.Invocation, var723=r2, var3625=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3512=org.apache.dubbo.registry.client.migration.MigrationInvoker, var1138=r1, var3798=org.apache.dubbo.rpc.Result, var3016=org.apache.dubbo.rpc.Invoker, var1788=$r3}
; {org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker=var850, r0=var2901, org.apache.dubbo.rpc.Invocation=var1678, r2=var723, org.apache.dubbo.rpc.cluster.ClusterInvoker=var3625, org.apache.dubbo.registry.client.migration.MigrationInvoker=var3512, r1=var1138, org.apache.dubbo.rpc.Result=var3798, org.apache.dubbo.rpc.Invoker=var3016, $r3=var1788}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker;	r2 := @parameter0: org.apache.dubbo.rpc.Invocation;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker getServiceDiscoveryInvoker()>();	if r1 != null goto $r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r2);	$r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r2);	return $r3
;block_num 2