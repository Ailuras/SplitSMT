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

(declare-sort var3031 0)
(declare-sort var789 0)
(declare-sort var1031 0)
(declare-sort var2692 0)
(declare-sort var3069 0)
(declare-sort var1062 0)
(declare-sort var1782 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var789_getMetadata/1968437424 (var789) var1031)
(declare-fun var1031_get/1088891777 (var1031 var2692) var2692)
(declare-fun cast-from-String-to-var2692 (String) var2692)
(declare-fun cast-from-var2692-to-String (var2692) String)
(declare-fun var3069_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1782_emptyList/582664469 () var1062)
(declare-const null-var3031 var3031)
(declare-const null-var789 var789)
(declare-const var2952 var3031) ; Statement: r12 := @this: org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder 
(assert (not (= var2952 null-var3031)))
(declare-const var1157 var789) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var1157 null-var789)))
(define-const var2430 var1031 (var789_getMetadata/1968437424 var1157)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var1750 var2692 (var1031_get/1088891777 var2430 (cast-from-String-to-var2692 "dubbo.metadata-service.urls"))) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.urls") 
(define-const var3104 String (cast-from-var2692-to-String var1750)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var3306 Bool (var3069_isBlank/-523695098 (cast-from-String-to-String var3104))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3) 
 ; Statement: if $z0 == 0 goto r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.util.List toJavaList(java.lang.String,java.lang.Class)>(r3, class "Ljava/lang/String;") 
(assert (not (= (ite var3306 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2439 var1062 var1782_emptyList/582664469) ; Statement: $r11 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
 ; Statement: return $r11 
(check-sat)
; {var789_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var1031_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2692=([java.lang.String], java.lang.Object), cast-from-var2692-to-String=([java.lang.Object], java.lang.String), var3069_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1782_emptyList/582664469=([], java.util.List)}
; {var3031=org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder, var2952=r12, var789=org.apache.dubbo.registry.client.ServiceInstance, var1157=r0, var1031=java.util.Map, var2430=r1, var2692=java.lang.Object, var1750=$r2, var3104=r3, var3069=org.apache.dubbo.common.utils.StringUtils, var3306=$z0, var1062=java.util.List, var1782=java.util.Collections, var2439=$r11}
; {org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder=var3031, r12=var2952, org.apache.dubbo.registry.client.ServiceInstance=var789, r0=var1157, java.util.Map=var1031, r1=var2430, java.lang.Object=var2692, $r2=var1750, r3=var3104, org.apache.dubbo.common.utils.StringUtils=var3069, $z0=var3306, java.util.List=var1062, java.util.Collections=var1782, $r11=var2439}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r12 := @this: org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.urls");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3);	if $z0 == 0 goto r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.util.List toJavaList(java.lang.String,java.lang.Class)>(r3, class "Ljava/lang/String;");	$r11 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	return $r11
;block_num 2