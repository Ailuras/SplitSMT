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

(declare-sort var1613 0)
(declare-sort var3706 0)
(declare-sort var1207 0)
(declare-sort var1439 0)
(declare-sort var1893 0)
(declare-sort var3942 0)
(declare-sort var261 0)
(declare-sort var3045 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1207_notNull/751190363 (var1439 String) void)
(declare-fun cast-from-var3706-to-var1439 (var3706) var1439)
(declare-fun originalUrls/1962874429 (var1613) var3706)
(declare-fun var3706_size/-959786421 (var3706) Int)
(declare-fun forbidden/2129308851 (var1893) Bool)
(declare-fun cast-from-var1613-to-var1893 (var1613) var1893)
(declare-fun var3942_isEmpty/73262611 (var261) Bool)
(declare-fun cast-from-var3706-to-var261 (var3706) var261)
(declare-fun arr-var1439-init () (Array Int var1439))
(declare-fun cast-from-var1613-to-var1439 (var1613) var1439)
(declare-fun String_format/1339386452 (String (Array Int var1439)) String)
(declare-fun var3045_warn/1431914100 (var3045 String String String String) void)
(declare-const null-var1613 var1613)
(declare-const null-var3706 var3706)
(declare-const var1613-logger var3045)
(declare-const null-__Array__Int__var1439__ (Array Int var1439))
(declare-const var1372 var1613) ; Statement: r1 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory 
(assert (not (= var1372 null-var1613)))
(declare-const var2798 var3706) ; Statement: r0 := @parameter0: java.util.List 
(assert (not (= var2798 null-var3706)))
;(assert (var1207_notNull/751190363 (cast-from-var3706-to-var1439 var2798) "invokerUrls should not be null, use EMPTY url to clear current addresses.")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "invokerUrls should not be null, use EMPTY url to clear current addresses.") 

(declare-const var2798!1 var3706)
(declare-const var251 String)
(declare-const var1372!1 var1613)
(assert (not (= var1372!1 null-var1613)))
(assert (= (originalUrls/1962874429 var1372!1) var2798!1)) ; Statement: r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.List originalUrls> = r0 
(define-const var159 Int (var3706_size/-959786421 var2798!1)) ; Statement: $i0 = interfaceinvoke r0.<java.util.List: int size()>() 
 ; Statement: if $i0 != 1 goto r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: boolean forbidden> = 0 
(assert (not (= var159 1))) ; Cond: $i0 != 1 
(declare-const var1372!2 var1613)
(assert (not (= var1372!2 null-var1613)))
(assert (= (forbidden/2129308851 (cast-from-var1613-to-var1893 var1372!2)) (ite (= 1 0) true false))) ; Statement: r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: boolean forbidden> = 0 
(define-const var1334 Bool (var3942_isEmpty/73262611 (cast-from-var3706-to-var261 var2798!1))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r0) 
 ; Statement: if $z0 == 0 goto r2 = r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.Map urlInvokerMap> 
(assert (not (= (ite var1334 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2892 var3045 var1613-logger) ; Statement: $r22 = <org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2615 (Array Int var1439) arr-var1439-init) ; Statement: $r21 = newarray (java.lang.Object)[1] 
(declare-const var2615!1 (Array Int var1439))
(assert (not (= var2615!1 null-__Array__Int__var1439__)))
(assert (= (select var2615!1 0) (cast-from-var1613-to-var1439 var1372!2))) ; Statement: $r21[0] = r1 
(define-const var978 String (String_format/1339386452 "Received empty url list from registry %s, will ignore for protection purpose." var2615!1)) ; Statement: $r23 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Received empty url list from registry %s, will ignore for protection purpose.", $r21) 
;(assert (var3045_warn/1431914100 var2892 "4-1" "" "" var978)) ; Statement: interfaceinvoke $r22.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("4-1", "", "", $r23) 

(declare-const var2892!1 var3045)
(declare-const var1028 String)
(declare-const var1333 String)
(declare-const var1333!1 String)
(declare-const var978!1 String)
 ; Statement: return 
(check-sat)
; {var1207_notNull/751190363=([java.lang.Object, java.lang.String], void), cast-from-var3706-to-var1439=([java.util.List], java.lang.Object), originalUrls/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], java.util.List), var3706_size/-959786421=([java.util.List], int), forbidden/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), cast-from-var1613-to-var1893=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.registry.integration.DynamicDirectory), var3942_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var3706-to-var261=([java.util.List], java.util.Collection), arr-var1439-init=([], java.lang.Object[]), cast-from-var1613-to-var1439=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var3045_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var1613=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory, var1372=r1, var3706=java.util.List, var2798=r0, var1207=org.apache.dubbo.common.utils.Assert, var1439=java.lang.Object, var251="invokerUrls should not be null, use EMPTY url to clear current addresses.", var159=$i0, var1893=org.apache.dubbo.registry.integration.DynamicDirectory, var3942=org.apache.dubbo.common.utils.CollectionUtils, var261=java.util.Collection, var1334=$z0, var3045=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2892=$r22, var2615=$r21, var978=$r23, var1028="4-1", var1333=""}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory=var1613, r1=var1372, java.util.List=var3706, r0=var2798, org.apache.dubbo.common.utils.Assert=var1207, java.lang.Object=var1439, "invokerUrls should not be null, use EMPTY url to clear current addresses."=var251, $i0=var159, org.apache.dubbo.registry.integration.DynamicDirectory=var1893, org.apache.dubbo.common.utils.CollectionUtils=var3942, java.util.Collection=var261, $z0=var1334, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3045, $r22=var2892, $r21=var2615, $r23=var978, "4-1"=var1028, ""=var1333}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory;	r0 := @parameter0: java.util.List;	staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "invokerUrls should not be null, use EMPTY url to clear current addresses.");	r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.List originalUrls> = r0;	$i0 = interfaceinvoke r0.<java.util.List: int size()>();	if $i0 != 1 goto r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: boolean forbidden> = 0;	r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: boolean forbidden> = 0;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r0);	if $z0 == 0 goto r2 = r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.Map urlInvokerMap>;	$r22 = <org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r21 = newarray (java.lang.Object)[1];	$r21[0] = r1;	$r23 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Received empty url list from registry %s, will ignore for protection purpose.", $r21);	interfaceinvoke $r22.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("4-1", "", "", $r23);	return
;block_num 3