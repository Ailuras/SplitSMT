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

(declare-sort var1819 0)
(declare-sort var2087 0)
(declare-sort var3979 0)
(declare-sort var3048 0)
(declare-sort var2774 0)
(declare-sort var427 0)
(declare-sort var2598 0)
(declare-sort var3061 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1558756437 (var1819) var3048)
(declare-fun var2774_isDebugEnabled/-823448366 (var2774) Bool)
(declare-fun cast-from-var3048-to-var2774 (var3048) var2774)
(declare-fun var427_isEmpty/-813097145 (String) Bool)
(declare-fun metadataMap/-1558756437 (var1819) var2598)
(declare-fun put/-1753019971 (var2598 var3061 var3061) var3061)
(declare-fun cast-from-String-to-var3061 (String) var3061)
(declare-const null-var1819 var1819)
(declare-const null-var2087 var2087)
(declare-const null-String String)
(declare-const var1731 var1819) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var1731 null-var1819)))
(declare-const var3728 var2087) ; Statement: r9 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance 
(assert (not (= var3728 null-var2087)))
(declare-const var1088 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var1088 null-String)))
(declare-const var2341 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2341 null-String)))
(define-const var3776 var3048 (logger/-1558756437 var1731)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1858 Bool (var2774_isDebugEnabled/-823448366 (cast-from-var3048-to-var2774 var3776))) ; Statement: $z0 = interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
(assert (= (ite var1858 1 0) 0)) ; Cond: $z0 == 0 
(define-const var603 Bool (var427_isEmpty/-813097145 var2341)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert (= (ite var603 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1927 var2598 (metadataMap/-1558756437 var1731)) ; Statement: $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert true)
;(assert (put/-1753019971 var1927 (cast-from-String-to-var3061 var1088) (cast-from-String-to-var3061 var2341))) ; Statement: virtualinvoke $r4.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r3, r2) 

(declare-const var1927!1 var2598)
(declare-const var1088!1 String)
(declare-const var2341!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {logger/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var2774_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var3048-to-var2774=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var427_isEmpty/-813097145=([java.lang.String], boolean), metadataMap/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], java.util.concurrent.ConcurrentHashMap), put/-1753019971=([java.util.concurrent.ConcurrentHashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3061=([java.lang.String], java.lang.Object)}
; {var1819=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var1731=r0, var2087=org.apache.dubbo.registry.client.DefaultServiceInstance, var3728=r9, var1088=r3, var3979=null_type, var2341=r2, var3048=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3776=$r1, var2774=org.apache.dubbo.common.logger.Logger, var1858=$z0, var427=org.apache.dubbo.common.utils.StringUtils, var603=$z1, var2598=java.util.concurrent.ConcurrentHashMap, var1927=$r4, var3061=java.lang.Object}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var1819, r0=var1731, org.apache.dubbo.registry.client.DefaultServiceInstance=var2087, r9=var3728, r3=var1088, null_type=var3979, r2=var2341, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3048, $r1=var3776, org.apache.dubbo.common.logger.Logger=var2774, $z0=var1858, org.apache.dubbo.common.utils.StringUtils=var427, $z1=var603, java.util.concurrent.ConcurrentHashMap=var2598, $r4=var1927, java.lang.Object=var3061}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r9 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance;	r3 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	$r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	virtualinvoke $r4.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r3, r2);	return
;block_num 4