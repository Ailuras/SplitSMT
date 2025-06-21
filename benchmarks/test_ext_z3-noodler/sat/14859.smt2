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

(declare-sort var1371 0)
(declare-sort var3558 0)
(declare-sort var1926 0)
(declare-sort var552 0)
(declare-sort var2650 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/1343906212 (var1371) var3558)
(declare-fun getParameters/-392598339 (var3558) var1926)
(declare-fun var552_toQueryString/202647708 (var1926) String)
(declare-fun addParameter/-1629709269 (var3558 String String) var3558)
(declare-fun invoker/1343906212 (var1371) var2650)
(declare-fun var2650_isDestroyed/995967411 (var2650) Bool)
(declare-fun serviceDiscoveryInvoker/1343906212 (var1371) var2650)
(declare-const null-var1371 var1371)
(declare-const null-var3558 var3558)
(declare-const null-var2650 var2650)
(declare-const var3328 var1371) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker 
(assert (not (= var3328 null-var1371)))
(declare-const var3388 var3558) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3388 null-var3558)))
(define-const var229 var3558 (url/1343906212 var3328)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var805 var1926 (getParameters/-392598339 var3388)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>() 
(define-const var1596 String (var552_toQueryString/202647708 var805)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>($r3) 
(assert true)
(define-const var2093 var3558 (addParameter/-1629709269 var229 "refer" var1596)) ; Statement: $r5 = virtualinvoke $r2.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("refer", $r4) 
(declare-const var3328!1 var1371)
(assert (not (= var3328!1 null-var1371)))
(assert (= (url/1343906212 var3328!1) var2093)) ; Statement: r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> = $r5 
(define-const var3335 var2650 (invoker/1343906212 var3328!1)) ; Statement: $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker invoker> 
 ; Statement: if $r6 == null goto $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker> 
(assert (not (= var3335 null-var2650))) ; Negate: Cond: $r6 == null  
(define-const var390 var2650 (invoker/1343906212 var3328!1)) ; Statement: $r9 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker invoker> 
(define-const var736 Bool (var2650_isDestroyed/995967411 var390)) ; Statement: $z1 = interfaceinvoke $r9.<org.apache.dubbo.rpc.cluster.ClusterInvoker: boolean isDestroyed()>() 
 ; Statement: if $z1 != 0 goto $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker> 
(assert (not (= (ite var736 1 0) 0))) ; Cond: $z1 != 0 
(define-const var2322 var2650 (serviceDiscoveryInvoker/1343906212 var3328!1)) ; Statement: $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker> 
 ; Statement: if $r11 == null goto return 
(assert (= var2322 null-var2650)) ; Cond: $r11 == null 
 ; Statement: return 
(check-sat)
; {url/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.common.URL), getParameters/-392598339=([org.apache.dubbo.common.URL], java.util.Map), var552_toQueryString/202647708=([java.util.Map], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), invoker/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker), var2650_isDestroyed/995967411=([org.apache.dubbo.rpc.cluster.ClusterInvoker], boolean), serviceDiscoveryInvoker/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker)}
; {var1371=org.apache.dubbo.registry.client.migration.MigrationInvoker, var3328=r0, var3558=org.apache.dubbo.common.URL, var3388=r1, var229=$r2, var1926=java.util.Map, var805=$r3, var552=org.apache.dubbo.common.utils.StringUtils, var1596=$r4, var2093=$r5, var2650=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3335=$r6, var390=$r9, var736=$z1, var2322=$r11}
; {org.apache.dubbo.registry.client.migration.MigrationInvoker=var1371, r0=var3328, org.apache.dubbo.common.URL=var3558, r1=var3388, $r2=var229, java.util.Map=var1926, $r3=var805, org.apache.dubbo.common.utils.StringUtils=var552, $r4=var1596, $r5=var2093, org.apache.dubbo.rpc.cluster.ClusterInvoker=var2650, $r6=var3335, $r9=var390, $z1=var736, $r11=var2322}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url>;	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>();	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>($r3);	$r5 = virtualinvoke $r2.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("refer", $r4);	r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> = $r5;	$r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker invoker>;	if $r6 == null goto $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker>;	$r9 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker invoker>;	$z1 = interfaceinvoke $r9.<org.apache.dubbo.rpc.cluster.ClusterInvoker: boolean isDestroyed()>();	if $z1 != 0 goto $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker>;	$r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker>;	if $r11 == null goto return;	return
;block_num 4