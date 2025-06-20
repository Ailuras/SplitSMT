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

(declare-sort var2347 0)
(declare-sort var2170 0)
(declare-sort var611 0)
(declare-sort var3055 0)
(declare-sort var1399 0)
(declare-sort var1645 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var611!class ClassObject)
(declare-fun var2170_getMetadata/1968437424 (var2170) var611)
(declare-fun var611_get/1088891777 (var611 var3055) var3055)
(declare-fun cast-from-String-to-var3055 (String) var3055)
(declare-fun cast-from-var3055-to-String (var3055) String)
(declare-fun var1399_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1645_toJavaObject/-1745526013 (String ClassObject) var3055)
(define-fun cast-from-ClassObject-to-ClassObject ((arg ClassObject)) ClassObject arg)
(declare-fun cast-from-var3055-to-var611 (var3055) var611)
(declare-const null-var2347 var2347)
(declare-const null-var2170 var2170)
(declare-const var867 var2347) ; Statement: r5 := @this: org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder 
(assert (not (= var867 null-var2347)))
(declare-const var2135 var2170) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2135 null-var2170)))
(define-const var3234 var611 (var2170_getMetadata/1968437424 var2135)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var2771 var3055 (var611_get/1088891777 var3234 (cast-from-String-to-var3055 "dubbo.metadata-service.url-params"))) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.url-params") 
(define-const var3963 String (cast-from-var3055-to-String var2771)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var1895 Bool (var1399_isBlank/-523695098 (cast-from-String-to-String var3963))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.Object toJavaObject(java.lang.String,java.lang.reflect.Type)>(r3, class "Ljava/util/Map;") 
(assert (= (ite var1895 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1554 var3055 (var1645_toJavaObject/-1745526013 var3963 (cast-from-ClassObject-to-ClassObject var611!class))) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.Object toJavaObject(java.lang.String,java.lang.reflect.Type)>(r3, class "Ljava/util/Map;") 
(define-const var2445 var611 (cast-from-var3055-to-var611 var1554)) ; Statement: $r6 = (java.util.Map) $r4 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {var2170_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var611_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3055=([java.lang.String], java.lang.Object), cast-from-var3055-to-String=([java.lang.Object], java.lang.String), var1399_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1645_toJavaObject/-1745526013=([java.lang.String, java.lang.reflect.Type], java.lang.Object), cast-from-ClassObject-to-ClassObject=([java.lang.Class], java.lang.reflect.Type), cast-from-var3055-to-var611=([java.lang.Object], java.util.Map)}
; {var2347=org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder, var867=r5, var2170=org.apache.dubbo.registry.client.ServiceInstance, var2135=r0, var611=java.util.Map, var3234=r1, var3055=java.lang.Object, var2771=$r2, var3963=r3, var1399=org.apache.dubbo.common.utils.StringUtils, var1895=$z0, var1645=org.apache.dubbo.common.utils.JsonUtils, var1554=$r4, var2445=$r6}
; {org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder=var2347, r5=var867, org.apache.dubbo.registry.client.ServiceInstance=var2170, r0=var2135, java.util.Map=var611, r1=var3234, java.lang.Object=var3055, $r2=var2771, r3=var3963, org.apache.dubbo.common.utils.StringUtils=var1399, $z0=var1895, org.apache.dubbo.common.utils.JsonUtils=var1645, $r4=var1554, $r6=var2445}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.url-params");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3);	if $z0 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.Object toJavaObject(java.lang.String,java.lang.reflect.Type)>(r3, class "Ljava/util/Map;");	$r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.Object toJavaObject(java.lang.String,java.lang.reflect.Type)>(r3, class "Ljava/util/Map;");	$r6 = (java.util.Map) $r4;	return $r6
;block_num 3