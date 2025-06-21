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

(declare-sort var2352 0)
(declare-sort var2838 0)
(declare-sort var2382 0)
(declare-sort var2763 0)
(declare-sort var2180 0)
(declare-sort var241 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2838_getMetadata/1968437424 (var2838) var2382)
(declare-fun var2382_get/1088891777 (var2382 var2763) var2763)
(declare-fun cast-from-String-to-var2763 (String) var2763)
(declare-fun cast-from-var2763-to-String (var2763) String)
(declare-fun var2180_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var241_emptyMap/401053835 () var2382)
(declare-const null-var2352 var2352)
(declare-const null-var2838 var2838)
(declare-const var3592 var2352) ; Statement: r5 := @this: org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder 
(assert (not (= var3592 null-var2352)))
(declare-const var195 var2838) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var195 null-var2838)))
(define-const var3121 var2382 (var2838_getMetadata/1968437424 var195)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var742 var2763 (var2382_get/1088891777 var3121 (cast-from-String-to-var2763 "dubbo.metadata-service.url-params"))) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.url-params") 
(define-const var1857 String (cast-from-var2763-to-String var742)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var718 Bool (var2180_isBlank/-523695098 (cast-from-String-to-String var1857))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.Object toJavaObject(java.lang.String,java.lang.reflect.Type)>(r3, class "Ljava/util/Map;") 
(assert (not (= (ite var718 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3055 var2382 var241_emptyMap/401053835) ; Statement: $r6 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>() 
 ; Statement: goto [?= return $r6] 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {var2838_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var2382_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2763=([java.lang.String], java.lang.Object), cast-from-var2763-to-String=([java.lang.Object], java.lang.String), var2180_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var241_emptyMap/401053835=([], java.util.Map)}
; {var2352=org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder, var3592=r5, var2838=org.apache.dubbo.registry.client.ServiceInstance, var195=r0, var2382=java.util.Map, var3121=r1, var2763=java.lang.Object, var742=$r2, var1857=r3, var2180=org.apache.dubbo.common.utils.StringUtils, var718=$z0, var241=java.util.Collections, var3055=$r6}
; {org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder=var2352, r5=var3592, org.apache.dubbo.registry.client.ServiceInstance=var2838, r0=var195, java.util.Map=var2382, r1=var3121, java.lang.Object=var2763, $r2=var742, r3=var1857, org.apache.dubbo.common.utils.StringUtils=var2180, $z0=var718, java.util.Collections=var241, $r6=var3055}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.url-params");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3);	if $z0 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.Object toJavaObject(java.lang.String,java.lang.reflect.Type)>(r3, class "Ljava/util/Map;");	$r6 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>();	goto [?= return $r6];	return $r6
;block_num 3