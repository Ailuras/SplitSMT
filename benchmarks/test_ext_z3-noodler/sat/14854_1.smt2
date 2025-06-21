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

(declare-sort var2332 0)
(declare-sort var1119 0)
(declare-sort var352 0)
(declare-sort var84 0)
(declare-sort var1422 0)
(declare-sort var2164 0)
(declare-sort var3198 0)
(declare-sort var1936 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1558756437 (var2332) var84)
(declare-fun var1422_isDebugEnabled/-823448366 (var1422) Bool)
(declare-fun cast-from-var84-to-var1422 (var84) var1422)
(declare-fun var2164_isEmpty/-813097145 (String) Bool)
(declare-fun metadataMap/-1558756437 (var2332) var3198)
(declare-fun remove/583870081 (var3198 var1936) var1936)
(declare-fun cast-from-String-to-var1936 (String) var1936)
(declare-const null-var2332 var2332)
(declare-const null-var1119 var1119)
(declare-const null-String String)
(declare-const var934 var2332) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var934 null-var2332)))
(declare-const var3579 var1119) ; Statement: r9 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance 
(assert (not (= var3579 null-var1119)))
(declare-const var2069 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2069 null-String)))
(declare-const var3056 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var3056 null-String)))
(define-const var1484 var84 (logger/-1558756437 var934)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1413 Bool (var1422_isDebugEnabled/-823448366 (cast-from-var84-to-var1422 var1484))) ; Statement: $z0 = interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
(assert (= (ite var1413 1 0) 0)) ; Cond: $z0 == 0 
(define-const var457 Bool (var2164_isEmpty/-813097145 var3056)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert (not (= (ite var457 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3312 var3198 (metadataMap/-1558756437 var934)) ; Statement: $r5 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert true)
;(assert (remove/583870081 var3312 (cast-from-String-to-var1936 var2069))) ; Statement: virtualinvoke $r5.<java.util.concurrent.ConcurrentHashMap: java.lang.Object remove(java.lang.Object)>(r3) 

(declare-const var3312!1 var3198)
(declare-const var2069!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {logger/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var1422_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var84-to-var1422=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var2164_isEmpty/-813097145=([java.lang.String], boolean), metadataMap/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], java.util.concurrent.ConcurrentHashMap), remove/583870081=([java.util.concurrent.ConcurrentHashMap, java.lang.Object], java.lang.Object), cast-from-String-to-var1936=([java.lang.String], java.lang.Object)}
; {var2332=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var934=r0, var1119=org.apache.dubbo.registry.client.DefaultServiceInstance, var3579=r9, var2069=r3, var352=null_type, var3056=r2, var84=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1484=$r1, var1422=org.apache.dubbo.common.logger.Logger, var1413=$z0, var2164=org.apache.dubbo.common.utils.StringUtils, var457=$z1, var3198=java.util.concurrent.ConcurrentHashMap, var3312=$r5, var1936=java.lang.Object}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var2332, r0=var934, org.apache.dubbo.registry.client.DefaultServiceInstance=var1119, r9=var3579, r3=var2069, null_type=var352, r2=var3056, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var84, $r1=var1484, org.apache.dubbo.common.logger.Logger=var1422, $z0=var1413, org.apache.dubbo.common.utils.StringUtils=var2164, $z1=var457, java.util.concurrent.ConcurrentHashMap=var3198, $r5=var3312, java.lang.Object=var1936}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r9 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance;	r3 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	$r5 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	virtualinvoke $r5.<java.util.concurrent.ConcurrentHashMap: java.lang.Object remove(java.lang.Object)>(r3);	goto [?= return];	return
;block_num 4