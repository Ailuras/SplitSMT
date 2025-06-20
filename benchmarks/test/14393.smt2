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

(declare-sort var2063 0)
(declare-sort var953 0)
(declare-sort var1318 0)
(declare-sort var2082 0)
(declare-sort var1939 0)
(declare-sort var2850 0)
(declare-sort var3884 0)
(declare-sort var230 0)
(declare-sort var3115 0)
(declare-sort var2276 0)
(declare-sort var305 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2082!class ClassObject)
(declare-fun var2063_getApplicationModel/1173884853 (var2063) var953)
(declare-fun getExtensionLoader/-514331157 (var1939 ClassObject) var1318)
(declare-fun cast-from-var953-to-var1939 (var953) var1939)
(declare-fun var2063_getMetadata/1968437424 (var2063) var2850)
(declare-fun var2850_get/1088891777 (var2850 var3884) var3884)
(declare-fun cast-from-String-to-var3884 (String) var3884)
(declare-fun cast-from-var3884-to-String (var3884) String)
(declare-fun var2850_isEmpty/-1655013448 (var2850) Bool)
(declare-fun getExtension/-1809037860 (var1318 String) var3884)
(declare-fun cast-from-var3884-to-var2082 (var3884) var2082)
(declare-fun var2082_build/873388238 (var2082 var2063) var230)
(declare-fun var3115_isEmpty/73262611 (var2276) Bool)
(declare-fun cast-from-var230-to-var2276 (var230) var2276)
(declare-fun var305-init () var305)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3884) String)
(declare-fun cast-from-var2063-to-var3884 (var2063) var3884)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var305 String) void)
(declare-const null-var2063 var2063)
(declare-const var3780 var2063) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var3780 null-var2063)))
(define-const var224 var953 (var2063_getApplicationModel/1173884853 var3780)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var1137 var1318 (getExtensionLoader/-514331157 (cast-from-var953-to-var1939 var224) var2082!class)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/registry/client/metadata/MetadataServiceURLBuilder;") 
(define-const var20 var2850 (var2063_getMetadata/1968437424 var3780)) ; Statement: r3 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var3729 var3884 (var2850_get/1088891777 var20 (cast-from-String-to-var3884 "dubbo.metadata-service.urls"))) ; Statement: $r4 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.urls") 
(define-const var1262 String (cast-from-var3884-to-String var3729)) ; Statement: r5 = (java.lang.String) $r4 
(define-const var2525 Bool (var2850_isEmpty/-1655013448 var20)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Map: boolean isEmpty()>() 
 ; Statement: if $z0 != 0 goto $r6 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("standard") 
(assert (not (= (ite var2525 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var2350 var3884 (getExtension/-1809037860 var1137 "standard")) ; Statement: $r6 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("standard") 
(define-const var52 var2082 (cast-from-var3884-to-var2082 var2350)) ; Statement: r18 = (org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder) $r6 
 ; Statement: goto [?= $r17 = interfaceinvoke r18.<org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder: java.util.List build(org.apache.dubbo.registry.client.ServiceInstance)>(r0)] 
(assert true) ; Non Conditional
(define-const var1684 var230 (var2082_build/873388238 var52 var3780)) ; Statement: $r17 = interfaceinvoke r18.<org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder: java.util.List build(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(define-const var2758 Bool (var3115_isEmpty/73262611 (cast-from-var230-to-var2276 var1684))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r17) 
 ; Statement: if $z1 == 0 goto $r7 = interfaceinvoke $r17.<java.util.List: java.lang.Object get(int)>(0) 
(assert (not (= (ite var2758 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var352 var305 var305-init) ; Statement: $r10 = new java.lang.IllegalStateException 
(define-const var1393 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1393)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1393!1 String)
(assert (= var1393!1 ""))
(assert true)
(define-const var34 String (append/672562846 var1393!1 "Introspection service discovery mode is enabled ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Introspection service discovery mode is enabled ") 
(declare-const var1393!2 String)
(assert (= var1393!2 (str.++ var1393!1 "Introspection service discovery mode is enabled ")))
(assert true)
(define-const var178 String (append/-1031950772 var34 (cast-from-var2063-to-var3884 var3780))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var34!1 String)
(assert (str.prefixof var34 var34!1))
(assert true)
(define-const var579 String (append/672562846 var178 ", but no metadata service can build from it.")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", but no metadata service can build from it.") 
(declare-const var178!1 String)
(assert (= var178!1 (str.++ var178 ", but no metadata service can build from it.")))
(assert true)
(define-const var1120 String (toString/-2075883882 var579)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var352 var1120)) ; Statement: specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r15) 

(declare-const var352!1 var305)
(declare-const var1120!1 String)
 ; Statement: throw $r10 
(check-sat)
; {var2063_getApplicationModel/1173884853=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var953-to-var1939=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), var2063_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var2850_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3884=([java.lang.String], java.lang.Object), cast-from-var3884-to-String=([java.lang.Object], java.lang.String), var2850_isEmpty/-1655013448=([java.util.Map], boolean), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var3884-to-var2082=([java.lang.Object], org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder), var2082_build/873388238=([org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder, org.apache.dubbo.registry.client.ServiceInstance], java.util.List), var3115_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var230-to-var2276=([java.util.List], java.util.Collection), var305-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2063-to-var3884=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2063=org.apache.dubbo.registry.client.ServiceInstance, var3780=r0, var953=org.apache.dubbo.rpc.model.ApplicationModel, var224=$r1, var1318=org.apache.dubbo.common.extension.ExtensionLoader, var2082=org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder, var1939=org.apache.dubbo.common.extension.ExtensionAccessor, var1137=r2, var2850=java.util.Map, var20=r3, var3884=java.lang.Object, var3729=$r4, var1262=r5, var2525=$z0, var2350=$r6, var52=r18, var230=java.util.List, var1684=$r17, var3115=org.apache.dubbo.common.utils.CollectionUtils, var2276=java.util.Collection, var2758=$z1, var305=java.lang.IllegalStateException, var352=$r10, var1393=$r11, var34=$r12, var178=$r13, var579=$r14, var1120=$r15}
; {org.apache.dubbo.registry.client.ServiceInstance=var2063, r0=var3780, org.apache.dubbo.rpc.model.ApplicationModel=var953, $r1=var224, org.apache.dubbo.common.extension.ExtensionLoader=var1318, org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder=var2082, org.apache.dubbo.common.extension.ExtensionAccessor=var1939, r2=var1137, java.util.Map=var2850, r3=var20, java.lang.Object=var3884, $r4=var3729, r5=var1262, $z0=var2525, $r6=var2350, r18=var52, java.util.List=var230, $r17=var1684, org.apache.dubbo.common.utils.CollectionUtils=var3115, java.util.Collection=var2276, $z1=var2758, java.lang.IllegalStateException=var305, $r10=var352, $r11=var1393, $r12=var34, $r13=var178, $r14=var579, $r15=var1120}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	$r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/registry/client/metadata/MetadataServiceURLBuilder;");	r3 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r4 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.urls");	r5 = (java.lang.String) $r4;	$z0 = interfaceinvoke r3.<java.util.Map: boolean isEmpty()>();	if $z0 != 0 goto $r6 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("standard");	$r6 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("standard");	r18 = (org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder) $r6;	goto [?= $r17 = interfaceinvoke r18.<org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder: java.util.List build(org.apache.dubbo.registry.client.ServiceInstance)>(r0)];	$r17 = interfaceinvoke r18.<org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder: java.util.List build(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r17);	if $z1 == 0 goto $r7 = interfaceinvoke $r17.<java.util.List: java.lang.Object get(int)>(0);	$r10 = new java.lang.IllegalStateException;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Introspection service discovery mode is enabled ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", but no metadata service can build from it.");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r15);	throw $r10
;block_num 4