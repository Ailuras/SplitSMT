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

(declare-sort var1962 0)
(declare-sort var2180 0)
(declare-sort var1033 0)
(declare-sort var267 0)
(declare-sort var3576 0)
(declare-sort var2831 0)
(declare-sort var2666 0)
(declare-sort var3730 0)
(declare-sort var233 0)
(declare-sort var2939 0)
(declare-sort var3083 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3576_toTreeSet/1649672439 (var267) var267)
(declare-fun var2831_toStringKeys/-428103615 (var267) String)
(declare-fun getServiceKey/1456125852 (var2180) String)
(declare-fun logger/787708432 (var1962) var2666)
(declare-fun arr-var3730-init () (Array Int var3730))
(declare-fun cast-from-String-to-var3730 (String) var3730)
(declare-fun String_format/1339386452 (String (Array Int var3730)) String)
(declare-fun var233_info/484404803 (var233 String) void)
(declare-fun cast-from-var2666-to-var233 (var2666) var233)
(declare-fun getAppSubscription/-691910584 (var1962 String) var2939)
(declare-fun var2939_unlock/-967276353 (var2939) void)
(declare-const null-var1962 var1962)
(declare-const null-var2180 var2180)
(declare-const null-var1033 var1033)
(declare-const null-var267 var267)
(declare-const null-__Array__Int__var3730__ (Array Int var3730))
(declare-const null-var3083 var3083)
(declare-const var1372 var1962) ; Statement: r3 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistry 
(assert (not (= var1372 null-var1962)))
(declare-const var1612 var2180) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1612 null-var2180)))
(declare-const var3578 var1033) ; Statement: r14 := @parameter1: org.apache.dubbo.registry.NotifyListener 
(assert (not (= var3578 null-var1033)))
(declare-const var2832 var267) ; Statement: r27 := @parameter2: java.util.Set 
(assert (not (= var2832 null-var267)))
(define-const var250 var267 (var3576_toTreeSet/1649672439 var2832)) ; Statement: r28 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: java.util.Set toTreeSet(java.util.Set)>(r27) 
(define-const var2367 String (var2831_toStringKeys/-428103615 var250)) ; Statement: r0 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping: java.lang.String toStringKeys(java.util.Set)>(r28) 
(assert true)
(define-const var744 String (getServiceKey/1456125852 var1612)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(define-const var3380 var2666 (logger/787708432 var1372)) ; Statement: $r5 = r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1358 (Array Int var3730) arr-var3730-init) ; Statement: $r4 = newarray (java.lang.Object)[2] 
(declare-const var1358!1 (Array Int var3730))
(assert (not (= var1358!1 null-__Array__Int__var3730__)))
(assert (= (select var1358!1 0) (cast-from-String-to-var3730 var2367))) ; Statement: $r4[0] = r0 
(declare-const var1358!2 (Array Int var3730))
(assert (not (= var1358!2 null-__Array__Int__var3730__)))
(assert (= (select var1358!2 1) (cast-from-String-to-var3730 var744))) ; Statement: $r4[1] = r2 
(define-const var276 String (String_format/1339386452 "Trying to subscribe from apps %s for service key %s, " var1358!2)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Trying to subscribe from apps %s for service key %s, ", $r4) 
;(assert (var233_info/484404803 (cast-from-var2666-to-var233 var3380) var276)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r6) 

(declare-const var3380!1 var2666)
(declare-const var276!1 String)
(assert true)
(define-const var1921 var2939 (getAppSubscription/-691910584 var1372 var2367)) ; Statement: r7 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: java.util.concurrent.locks.Lock getAppSubscription(java.lang.String)>(r0) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var418 var3083) ; Statement: $r26 := @caughtexception 
(assert (not (= var418 null-var3083)))
(assert true) ; Non Conditional
;(assert (var2939_unlock/-967276353 var1921)) ; Statement: interfaceinvoke r7.<java.util.concurrent.locks.Lock: void unlock()>() 

(declare-const var1921!1 var2939)
 ; Statement: throw $r26 
(check-sat)
; {var3576_toTreeSet/1649672439=([java.util.Set], java.util.Set), var2831_toStringKeys/-428103615=([java.util.Set], java.lang.String), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), logger/787708432=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistry], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), arr-var3730-init=([], java.lang.Object[]), cast-from-String-to-var3730=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var233_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var2666-to-var233=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), getAppSubscription/-691910584=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistry, java.lang.String], java.util.concurrent.locks.Lock), var2939_unlock/-967276353=([java.util.concurrent.locks.Lock], void)}
; {var1962=org.apache.dubbo.registry.client.ServiceDiscoveryRegistry, var1372=r3, var2180=org.apache.dubbo.common.URL, var1612=r1, var1033=org.apache.dubbo.registry.NotifyListener, var3578=r14, var267=java.util.Set, var2832=r27, var3576=org.apache.dubbo.common.utils.CollectionUtils, var250=r28, var2831=org.apache.dubbo.metadata.ServiceNameMapping, var2367=r0, var744=r2, var2666=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3380=$r5, var3730=java.lang.Object, var1358=$r4, var276=$r6, var233=org.apache.dubbo.common.logger.Logger, var2939=java.util.concurrent.locks.Lock, var1921=r7, var3083=java.lang.Throwable, var418=$r26}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistry=var1962, r3=var1372, org.apache.dubbo.common.URL=var2180, r1=var1612, org.apache.dubbo.registry.NotifyListener=var1033, r14=var3578, java.util.Set=var267, r27=var2832, org.apache.dubbo.common.utils.CollectionUtils=var3576, r28=var250, org.apache.dubbo.metadata.ServiceNameMapping=var2831, r0=var2367, r2=var744, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2666, $r5=var3380, java.lang.Object=var3730, $r4=var1358, $r6=var276, org.apache.dubbo.common.logger.Logger=var233, java.util.concurrent.locks.Lock=var2939, r7=var1921, java.lang.Throwable=var3083, $r26=var418}
;seq <org.apache.dubbo.metadata.ServiceNameMapping: java.lang.String toStringKeys(java.util.Set)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	r14 := @parameter1: org.apache.dubbo.registry.NotifyListener;	r27 := @parameter2: java.util.Set;	r28 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: java.util.Set toTreeSet(java.util.Set)>(r27);	r0 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping: java.lang.String toStringKeys(java.util.Set)>(r28);	r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r5 = r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = newarray (java.lang.Object)[2];	$r4[0] = r0;	$r4[1] = r2;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Trying to subscribe from apps %s for service key %s, ", $r4);	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r6);	r7 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: java.util.concurrent.locks.Lock getAppSubscription(java.lang.String)>(r0);	$r26 := @caughtexception;	interfaceinvoke r7.<java.util.concurrent.locks.Lock: void unlock()>();	throw $r26
;block_num 3