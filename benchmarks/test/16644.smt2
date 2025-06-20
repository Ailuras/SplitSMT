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

(declare-sort var1609 0)
(declare-sort var1322 0)
(declare-sort var2439 0)
(declare-sort var2376 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1322-to-var2376 (var1322) var2376)
(declare-fun var2376_reRefer/1562131768 (var2376 var2439) void)
(declare-const null-var1609 var1609)
(declare-const null-var1322 var1322)
(declare-const null-var2439 var2439)
(declare-const var2259 var1609) ; Statement: r9 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var2259 null-var1609)))
(declare-const var3328 var1322) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.cluster.ClusterInvoker 
(assert (not (= var3328 null-var1322)))
(declare-const var1808 var2439) ; Statement: r2 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1808 null-var2439)))
(define-const var877 Bool true) ; Statement: $z0 = r0 instanceof org.apache.dubbo.registry.client.migration.MigrationClusterInvoker 
 ; Statement: if $z0 != 0 goto r1 = (org.apache.dubbo.registry.client.migration.MigrationClusterInvoker) r0 
(assert (not (= (ite var877 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2989 var2376 (cast-from-var1322-to-var2376 var3328)) ; Statement: r1 = (org.apache.dubbo.registry.client.migration.MigrationClusterInvoker) r0 
;(assert (var2376_reRefer/1562131768 var2989 var1808)) ; Statement: interfaceinvoke r1.<org.apache.dubbo.registry.client.migration.MigrationClusterInvoker: void reRefer(org.apache.dubbo.common.URL)>(r2) 

(declare-const var2989!1 var2376)
(declare-const var1808!1 var2439)
 ; Statement: return 
(check-sat)
; {cast-from-var1322-to-var2376=([org.apache.dubbo.rpc.cluster.ClusterInvoker], org.apache.dubbo.registry.client.migration.MigrationClusterInvoker), var2376_reRefer/1562131768=([org.apache.dubbo.registry.client.migration.MigrationClusterInvoker, org.apache.dubbo.common.URL], void)}
; {var1609=org.apache.dubbo.registry.integration.RegistryProtocol, var2259=r9, var1322=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3328=r0, var2439=org.apache.dubbo.common.URL, var1808=r2, var877=$z0, var2376=org.apache.dubbo.registry.client.migration.MigrationClusterInvoker, var2989=r1}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var1609, r9=var2259, org.apache.dubbo.rpc.cluster.ClusterInvoker=var1322, r0=var3328, org.apache.dubbo.common.URL=var2439, r2=var1808, $z0=var877, org.apache.dubbo.registry.client.migration.MigrationClusterInvoker=var2376, r1=var2989}
;seq 
;cnt {}
;stmts r9 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r0 := @parameter0: org.apache.dubbo.rpc.cluster.ClusterInvoker;	r2 := @parameter1: org.apache.dubbo.common.URL;	$z0 = r0 instanceof org.apache.dubbo.registry.client.migration.MigrationClusterInvoker;	if $z0 != 0 goto r1 = (org.apache.dubbo.registry.client.migration.MigrationClusterInvoker) r0;	r1 = (org.apache.dubbo.registry.client.migration.MigrationClusterInvoker) r0;	interfaceinvoke r1.<org.apache.dubbo.registry.client.migration.MigrationClusterInvoker: void reRefer(org.apache.dubbo.common.URL)>(r2);	return
;block_num 2