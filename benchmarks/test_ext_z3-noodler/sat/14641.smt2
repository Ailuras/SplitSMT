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

(declare-sort var58 0)
(declare-sort var1302 0)
(declare-sort var1431 0)
(declare-sort var3508 0)
(declare-sort var771 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceDiscoveryInvoker/565745705 (var3508) var1431)
(declare-fun cast-from-var58-to-var3508 (var58) var3508)
(declare-fun var771-init () var771)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1302_getServiceName/-67876927 (var1302) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var771 String) void)
(declare-const null-var58 var58)
(declare-const null-var1302 var1302)
(declare-const null-var1431 var1431)
(declare-const var3123 var58) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker 
(assert (not (= var3123 null-var58)))
(declare-const var1462 var1302) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1462 null-var1302)))
(assert true)
(define-const var1826 var1431 (getServiceDiscoveryInvoker/565745705 (cast-from-var58-to-var3508 var3123))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker getServiceDiscoveryInvoker()>() 
 ; Statement: if r1 != null goto $r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r2) 
(assert (not (not (= var1826 null-var1431)))) ; Negate: Cond: r1 != null  
(define-const var1619 var771 var771-init) ; Statement: $r4 = new java.lang.IllegalStateException 
(define-const var3277 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3277)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3277!1 String)
(assert (= var3277!1 ""))
(assert true)
(define-const var2048 String (append/672562846 var3277!1 "There\u0027s no service discovery invoker available for service ")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("There\'s no service discovery invoker available for service ") 
(declare-const var3277!2 String)
(assert (= var3277!2 (str.++ var3277!1 "There\u0027s no service discovery invoker available for service ")))
(define-const var1727 String (var1302_getServiceName/-67876927 var1462)) ; Statement: $r6 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
(assert true)
(define-const var2288 String (append/672562846 var2048 var1727)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2048!1 String)
(assert (= var2048!1 (str.++ var2048 var1727)))
(assert true)
(define-const var51 String (toString/-2075883882 var2288)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var1619 var51)) ; Statement: specialinvoke $r4.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r9) 

(declare-const var1619!1 var771)
(declare-const var51!1 String)
 ; Statement: throw $r4 
(check-sat)
; {getServiceDiscoveryInvoker/565745705=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker), cast-from-var58-to-var3508=([org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker], org.apache.dubbo.registry.client.migration.MigrationInvoker), var771-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1302_getServiceName/-67876927=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var58=org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker, var3123=r0, var1302=org.apache.dubbo.rpc.Invocation, var1462=r2, var1431=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3508=org.apache.dubbo.registry.client.migration.MigrationInvoker, var1826=r1, var771=java.lang.IllegalStateException, var1619=$r4, var3277=$r5, var2048=$r7, var1727=$r6, var2288=$r8, var51=$r9}
; {org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker=var58, r0=var3123, org.apache.dubbo.rpc.Invocation=var1302, r2=var1462, org.apache.dubbo.rpc.cluster.ClusterInvoker=var1431, org.apache.dubbo.registry.client.migration.MigrationInvoker=var3508, r1=var1826, java.lang.IllegalStateException=var771, $r4=var1619, $r5=var3277, $r7=var2048, $r6=var1727, $r8=var2288, $r9=var51}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker;	r2 := @parameter0: org.apache.dubbo.rpc.Invocation;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.migration.ServiceDiscoveryMigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker getServiceDiscoveryInvoker()>();	if r1 != null goto $r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r2);	$r4 = new java.lang.IllegalStateException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("There\'s no service discovery invoker available for service ");	$r6 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r9);	throw $r4
;block_num 2