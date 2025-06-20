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

(declare-sort var2109 0)
(declare-sort var1888 0)
(declare-sort var1525 0)
(declare-sort var3547 0)
(declare-sort var214 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/1343906212 (var2109) var1888)
(declare-fun getParameters/-392598339 (var1888) var1525)
(declare-fun var3547_toQueryString/202647708 (var1525) String)
(declare-fun addParameter/-1629709269 (var1888 String String) var1888)
(declare-fun invoker/1343906212 (var2109) var214)
(declare-fun serviceDiscoveryInvoker/1343906212 (var2109) var214)
(declare-fun var214_isDestroyed/995967411 (var214) Bool)
(declare-const null-var2109 var2109)
(declare-const null-var1888 var1888)
(declare-const null-var214 var214)
(declare-const var1507 var2109) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker 
(assert (not (= var1507 null-var2109)))
(declare-const var3498 var1888) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3498 null-var1888)))
(define-const var933 var1888 (url/1343906212 var1507)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var2286 var1525 (getParameters/-392598339 var3498)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>() 
(define-const var1057 String (var3547_toQueryString/202647708 var2286)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>($r3) 
(assert true)
(define-const var3454 var1888 (addParameter/-1629709269 var933 "refer" var1057)) ; Statement: $r5 = virtualinvoke $r2.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("refer", $r4) 
(declare-const var1507!1 var2109)
(assert (not (= var1507!1 null-var2109)))
(assert (= (url/1343906212 var1507!1) var3454)) ; Statement: r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> = $r5 
(define-const var3979 var214 (invoker/1343906212 var1507!1)) ; Statement: $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker invoker> 
 ; Statement: if $r6 == null goto $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker> 
(assert (= var3979 null-var214)) ; Cond: $r6 == null 
(define-const var3110 var214 (serviceDiscoveryInvoker/1343906212 var1507!1)) ; Statement: $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker> 
 ; Statement: if $r11 == null goto return 
(assert (not (= var3110 null-var214))) ; Negate: Cond: $r11 == null  
(define-const var153 var214 (serviceDiscoveryInvoker/1343906212 var1507!1)) ; Statement: $r7 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker> 
(define-const var2876 Bool (var214_isDestroyed/995967411 var153)) ; Statement: $z0 = interfaceinvoke $r7.<org.apache.dubbo.rpc.cluster.ClusterInvoker: boolean isDestroyed()>() 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var2876 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {url/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.common.URL), getParameters/-392598339=([org.apache.dubbo.common.URL], java.util.Map), var3547_toQueryString/202647708=([java.util.Map], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), invoker/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker), serviceDiscoveryInvoker/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker), var214_isDestroyed/995967411=([org.apache.dubbo.rpc.cluster.ClusterInvoker], boolean)}
; {var2109=org.apache.dubbo.registry.client.migration.MigrationInvoker, var1507=r0, var1888=org.apache.dubbo.common.URL, var3498=r1, var933=$r2, var1525=java.util.Map, var2286=$r3, var3547=org.apache.dubbo.common.utils.StringUtils, var1057=$r4, var3454=$r5, var214=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3979=$r6, var3110=$r11, var153=$r7, var2876=$z0}
; {org.apache.dubbo.registry.client.migration.MigrationInvoker=var2109, r0=var1507, org.apache.dubbo.common.URL=var1888, r1=var3498, $r2=var933, java.util.Map=var1525, $r3=var2286, org.apache.dubbo.common.utils.StringUtils=var3547, $r4=var1057, $r5=var3454, org.apache.dubbo.rpc.cluster.ClusterInvoker=var214, $r6=var3979, $r11=var3110, $r7=var153, $z0=var2876}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url>;	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>();	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>($r3);	$r5 = virtualinvoke $r2.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("refer", $r4);	r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> = $r5;	$r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker invoker>;	if $r6 == null goto $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker>;	$r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker>;	if $r11 == null goto return;	$r7 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker>;	$z0 = interfaceinvoke $r7.<org.apache.dubbo.rpc.cluster.ClusterInvoker: boolean isDestroyed()>();	if $z0 != 0 goto return;	return
;block_num 4