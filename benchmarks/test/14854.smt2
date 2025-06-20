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

(declare-sort var928 0)
(declare-sort var445 0)
(declare-sort var2298 0)
(declare-sort var1632 0)
(declare-sort var2429 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/1343906212 (var928) var445)
(declare-fun getParameters/-392598339 (var445) var2298)
(declare-fun var1632_toQueryString/202647708 (var2298) String)
(declare-fun addParameter/-1629709269 (var445 String String) var445)
(declare-fun invoker/1343906212 (var928) var2429)
(declare-fun serviceDiscoveryInvoker/1343906212 (var928) var2429)
(declare-const null-var928 var928)
(declare-const null-var445 var445)
(declare-const null-var2429 var2429)
(declare-const var2571 var928) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker 
(assert (not (= var2571 null-var928)))
(declare-const var2006 var445) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2006 null-var445)))
(define-const var2486 var445 (url/1343906212 var2571)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var3121 var2298 (getParameters/-392598339 var2006)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>() 
(define-const var1260 String (var1632_toQueryString/202647708 var3121)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>($r3) 
(assert true)
(define-const var2685 var445 (addParameter/-1629709269 var2486 "refer" var1260)) ; Statement: $r5 = virtualinvoke $r2.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("refer", $r4) 
(declare-const var2571!1 var928)
(assert (not (= var2571!1 null-var928)))
(assert (= (url/1343906212 var2571!1) var2685)) ; Statement: r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> = $r5 
(define-const var3542 var2429 (invoker/1343906212 var2571!1)) ; Statement: $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker invoker> 
 ; Statement: if $r6 == null goto $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker> 
(assert (= var3542 null-var2429)) ; Cond: $r6 == null 
(define-const var2468 var2429 (serviceDiscoveryInvoker/1343906212 var2571!1)) ; Statement: $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker> 
 ; Statement: if $r11 == null goto return 
(assert (= var2468 null-var2429)) ; Cond: $r11 == null 
 ; Statement: return 
(check-sat)
; {url/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.common.URL), getParameters/-392598339=([org.apache.dubbo.common.URL], java.util.Map), var1632_toQueryString/202647708=([java.util.Map], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), invoker/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker), serviceDiscoveryInvoker/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker)}
; {var928=org.apache.dubbo.registry.client.migration.MigrationInvoker, var2571=r0, var445=org.apache.dubbo.common.URL, var2006=r1, var2486=$r2, var2298=java.util.Map, var3121=$r3, var1632=org.apache.dubbo.common.utils.StringUtils, var1260=$r4, var2685=$r5, var2429=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3542=$r6, var2468=$r11}
; {org.apache.dubbo.registry.client.migration.MigrationInvoker=var928, r0=var2571, org.apache.dubbo.common.URL=var445, r1=var2006, $r2=var2486, java.util.Map=var2298, $r3=var3121, org.apache.dubbo.common.utils.StringUtils=var1632, $r4=var1260, $r5=var2685, org.apache.dubbo.rpc.cluster.ClusterInvoker=var2429, $r6=var3542, $r11=var2468}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url>;	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>();	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toQueryString(java.util.Map)>($r3);	$r5 = virtualinvoke $r2.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("refer", $r4);	r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL url> = $r5;	$r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker invoker>;	if $r6 == null goto $r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker>;	$r11 = r0.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker serviceDiscoveryInvoker>;	if $r11 == null goto return;	return
;block_num 3