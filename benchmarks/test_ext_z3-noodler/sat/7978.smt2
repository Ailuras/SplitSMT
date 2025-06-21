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

(declare-sort var1246 0)
(declare-sort var3768 0)
(declare-sort var2887 0)
(declare-sort var1743 0)
(declare-sort var3307 0)
(declare-sort var3863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3768_getMetadata/1968437424 (var3768) var1743)
(declare-fun resolveMetadataPropertyName/-1865293569 (var1246 var3768) String)
(declare-fun resolveMetadataPropertyValue/-1968983802 (var1246 var2887) String)
(declare-fun var3307_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1246_resolveMetadataServiceVersion/400032941 (var2887) String)
(declare-fun var1743_put/1464166817 (var1743 var3863 var3863) var3863)
(declare-fun cast-from-String-to-var3863 (String) var3863)
(declare-const null-var1246 var1246)
(declare-const null-var3768 var3768)
(declare-const null-var2887 var2887)
(declare-const var3593 var1246) ; Statement: r2 := @this: org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer 
(assert (not (= var3593 null-var1246)))
(declare-const var2258 var3768) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2258 null-var3768)))
(declare-const var1325 var2887) ; Statement: r4 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var1325 null-var2887)))
(define-const var2767 var1743 (var3768_getMetadata/1968437424 var2258)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(assert true)
(define-const var2419 String (resolveMetadataPropertyName/-1865293569 var3593 var2258)) ; Statement: r3 = specialinvoke r2.<org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer: java.lang.String resolveMetadataPropertyName(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(assert true)
(define-const var0 String (resolveMetadataPropertyValue/-1968983802 var3593 var1325)) ; Statement: r5 = specialinvoke r2.<org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer: java.lang.String resolveMetadataPropertyValue(org.apache.dubbo.rpc.model.ApplicationModel)>(r4) 
(define-const var1027 Bool (var3307_isBlank/-523695098 (cast-from-String-to-String var2419))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3) 
 ; Statement: if $z0 != 0 goto $r6 = staticinvoke <org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer: java.lang.String resolveMetadataServiceVersion(org.apache.dubbo.rpc.model.ApplicationModel)>(r4) 
(assert (not (= (ite var1027 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1400 String (var1246_resolveMetadataServiceVersion/400032941 var1325)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer: java.lang.String resolveMetadataServiceVersion(org.apache.dubbo.rpc.model.ApplicationModel)>(r4) 
;(assert (var1743_put/1464166817 var2767 (cast-from-String-to-var3863 "meta-v") (cast-from-String-to-var3863 var1400))) ; Statement: interfaceinvoke r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("meta-v", $r6) 

(declare-const var2767!1 var1743)
(declare-const var804 String)
(declare-const var1400!1 String)
 ; Statement: return 
(check-sat)
; {var3768_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), resolveMetadataPropertyName/-1865293569=([org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer, org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), resolveMetadataPropertyValue/-1968983802=([org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer, org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String), var3307_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1246_resolveMetadataServiceVersion/400032941=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String), var1743_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3863=([java.lang.String], java.lang.Object)}
; {var1246=org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer, var3593=r2, var3768=org.apache.dubbo.registry.client.ServiceInstance, var2258=r0, var2887=org.apache.dubbo.rpc.model.ApplicationModel, var1325=r4, var1743=java.util.Map, var2767=r1, var2419=r3, var0=r5, var3307=org.apache.dubbo.common.utils.StringUtils, var1027=$z0, var1400=$r6, var3863=java.lang.Object, var804="meta-v"}
; {org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer=var1246, r2=var3593, org.apache.dubbo.registry.client.ServiceInstance=var3768, r0=var2258, org.apache.dubbo.rpc.model.ApplicationModel=var2887, r4=var1325, java.util.Map=var1743, r1=var2767, r3=var2419, r5=var0, org.apache.dubbo.common.utils.StringUtils=var3307, $z0=var1027, $r6=var1400, java.lang.Object=var3863, "meta-v"=var804}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r2 := @this: org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r4 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel;	r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	r3 = specialinvoke r2.<org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer: java.lang.String resolveMetadataPropertyName(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	r5 = specialinvoke r2.<org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer: java.lang.String resolveMetadataPropertyValue(org.apache.dubbo.rpc.model.ApplicationModel)>(r4);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3);	if $z0 != 0 goto $r6 = staticinvoke <org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer: java.lang.String resolveMetadataServiceVersion(org.apache.dubbo.rpc.model.ApplicationModel)>(r4);	$r6 = staticinvoke <org.apache.dubbo.config.metadata.MetadataServiceURLParamsMetadataCustomizer: java.lang.String resolveMetadataServiceVersion(org.apache.dubbo.rpc.model.ApplicationModel)>(r4);	interfaceinvoke r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("meta-v", $r6);	return
;block_num 2