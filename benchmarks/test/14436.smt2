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

(declare-sort var1336 0)
(declare-sort var2714 0)
(declare-sort var745 0)
(declare-sort var519 0)
(declare-sort var1414 0)
(declare-sort var1814 0)
(declare-sort var3880 0)
(declare-sort var3508 0)
(declare-sort var3847 0)
(declare-sort var1495 0)
(declare-sort var3808 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var519!class ClassObject)
(declare-fun var1336_getApplicationModel/1173884853 (var1336) var2714)
(declare-fun getExtensionLoader/-514331157 (var1414 ClassObject) var745)
(declare-fun cast-from-var2714-to-var1414 (var2714) var1414)
(declare-fun var1336_getMetadata/1968437424 (var1336) var1814)
(declare-fun var1814_get/1088891777 (var1814 var3880) var3880)
(declare-fun cast-from-String-to-var3880 (String) var3880)
(declare-fun cast-from-var3880-to-String (var3880) String)
(declare-fun var1814_isEmpty/-1655013448 (var1814) Bool)
(declare-fun getExtension/-1809037860 (var745 String) var3880)
(declare-fun cast-from-var3880-to-var519 (var3880) var519)
(declare-fun var519_build/873388238 (var519 var1336) var3508)
(declare-fun var3847_isEmpty/73262611 (var1495) Bool)
(declare-fun cast-from-var3508-to-var1495 (var3508) var1495)
(declare-fun var3508_get/-1216255739 (var3508 Int) var3880)
(declare-fun cast-from-var3880-to-var3808 (var3880) var3808)
(declare-fun putAttribute/-158571106 (var3808 String var3880) var3808)
(declare-fun addParameter/1347068524 (var3808 String Bool) var3808)
(declare-const null-var1336 var1336)
(declare-const var2954 var1336) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2954 null-var1336)))
(define-const var3021 var2714 (var1336_getApplicationModel/1173884853 var2954)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var1852 var745 (getExtensionLoader/-514331157 (cast-from-var2714-to-var1414 var3021) var519!class)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/registry/client/metadata/MetadataServiceURLBuilder;") 
(define-const var1802 var1814 (var1336_getMetadata/1968437424 var2954)) ; Statement: r3 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var275 var3880 (var1814_get/1088891777 var1802 (cast-from-String-to-var3880 "dubbo.metadata-service.urls"))) ; Statement: $r4 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.urls") 
(define-const var2902 String (cast-from-var3880-to-String var275)) ; Statement: r5 = (java.lang.String) $r4 
(define-const var2134 Bool (var1814_isEmpty/-1655013448 var1802)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Map: boolean isEmpty()>() 
 ; Statement: if $z0 != 0 goto $r6 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("standard") 
(assert (not (= (ite var2134 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var3359 var3880 (getExtension/-1809037860 var1852 "standard")) ; Statement: $r6 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("standard") 
(define-const var1339 var519 (cast-from-var3880-to-var519 var3359)) ; Statement: r18 = (org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder) $r6 
 ; Statement: goto [?= $r17 = interfaceinvoke r18.<org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder: java.util.List build(org.apache.dubbo.registry.client.ServiceInstance)>(r0)] 
(assert true) ; Non Conditional
(define-const var1614 var3508 (var519_build/873388238 var1339 var2954)) ; Statement: $r17 = interfaceinvoke r18.<org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder: java.util.List build(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(define-const var1758 Bool (var3847_isEmpty/73262611 (cast-from-var3508-to-var1495 var1614))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r17) 
 ; Statement: if $z1 == 0 goto $r7 = interfaceinvoke $r17.<java.util.List: java.lang.Object get(int)>(0) 
(assert (= (ite var1758 1 0) 0)) ; Cond: $z1 == 0 
(define-const var364 var3880 (var3508_get/-1216255739 var1614 0)) ; Statement: $r7 = interfaceinvoke $r17.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var2430 var3808 (cast-from-var3880-to-var3808 var364)) ; Statement: r19 = (org.apache.dubbo.common.URL) $r7 
(define-const var3085 var3880 (var1814_get/1088891777 var1802 (cast-from-String-to-var3880 "meta-v"))) ; Statement: $r8 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("meta-v") 
(define-const var1117 String (cast-from-var3880-to-String var3085)) ; Statement: r9 = (java.lang.String) $r8 
(assert true)
(define-const var2212 var3808 (putAttribute/-158571106 var2430 "meta-v" (cast-from-String-to-var3880 var1117))) ; Statement: r20 = virtualinvoke r19.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL putAttribute(java.lang.String,java.lang.Object)>("meta-v", r9) 
(assert true)
(define-const var2630 var3808 (addParameter/1347068524 var2212 "check" (ite (= 1 0) true false))) ; Statement: r21 = virtualinvoke r20.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,boolean)>("check", 0) 
 ; Statement: return r21 
(check-sat)
; {var1336_getApplicationModel/1173884853=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var2714-to-var1414=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), var1336_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var1814_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3880=([java.lang.String], java.lang.Object), cast-from-var3880-to-String=([java.lang.Object], java.lang.String), var1814_isEmpty/-1655013448=([java.util.Map], boolean), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var3880-to-var519=([java.lang.Object], org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder), var519_build/873388238=([org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder, org.apache.dubbo.registry.client.ServiceInstance], java.util.List), var3847_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var3508-to-var1495=([java.util.List], java.util.Collection), var3508_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var3880-to-var3808=([java.lang.Object], org.apache.dubbo.common.URL), putAttribute/-158571106=([org.apache.dubbo.common.URL, java.lang.String, java.lang.Object], org.apache.dubbo.common.URL), addParameter/1347068524=([org.apache.dubbo.common.URL, java.lang.String, boolean], org.apache.dubbo.common.URL)}
; {var1336=org.apache.dubbo.registry.client.ServiceInstance, var2954=r0, var2714=org.apache.dubbo.rpc.model.ApplicationModel, var3021=$r1, var745=org.apache.dubbo.common.extension.ExtensionLoader, var519=org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder, var1414=org.apache.dubbo.common.extension.ExtensionAccessor, var1852=r2, var1814=java.util.Map, var1802=r3, var3880=java.lang.Object, var275=$r4, var2902=r5, var2134=$z0, var3359=$r6, var1339=r18, var3508=java.util.List, var1614=$r17, var3847=org.apache.dubbo.common.utils.CollectionUtils, var1495=java.util.Collection, var1758=$z1, var364=$r7, var3808=org.apache.dubbo.common.URL, var2430=r19, var3085=$r8, var1117=r9, var2212=r20, var2630=r21}
; {org.apache.dubbo.registry.client.ServiceInstance=var1336, r0=var2954, org.apache.dubbo.rpc.model.ApplicationModel=var2714, $r1=var3021, org.apache.dubbo.common.extension.ExtensionLoader=var745, org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder=var519, org.apache.dubbo.common.extension.ExtensionAccessor=var1414, r2=var1852, java.util.Map=var1814, r3=var1802, java.lang.Object=var3880, $r4=var275, r5=var2902, $z0=var2134, $r6=var3359, r18=var1339, java.util.List=var3508, $r17=var1614, org.apache.dubbo.common.utils.CollectionUtils=var3847, java.util.Collection=var1495, $z1=var1758, $r7=var364, org.apache.dubbo.common.URL=var3808, r19=var2430, $r8=var3085, r9=var1117, r20=var2212, r21=var2630}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	$r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/registry/client/metadata/MetadataServiceURLBuilder;");	r3 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r4 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.urls");	r5 = (java.lang.String) $r4;	$z0 = interfaceinvoke r3.<java.util.Map: boolean isEmpty()>();	if $z0 != 0 goto $r6 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("standard");	$r6 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>("standard");	r18 = (org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder) $r6;	goto [?= $r17 = interfaceinvoke r18.<org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder: java.util.List build(org.apache.dubbo.registry.client.ServiceInstance)>(r0)];	$r17 = interfaceinvoke r18.<org.apache.dubbo.registry.client.metadata.MetadataServiceURLBuilder: java.util.List build(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r17);	if $z1 == 0 goto $r7 = interfaceinvoke $r17.<java.util.List: java.lang.Object get(int)>(0);	$r7 = interfaceinvoke $r17.<java.util.List: java.lang.Object get(int)>(0);	r19 = (org.apache.dubbo.common.URL) $r7;	$r8 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("meta-v");	r9 = (java.lang.String) $r8;	r20 = virtualinvoke r19.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL putAttribute(java.lang.String,java.lang.Object)>("meta-v", r9);	r21 = virtualinvoke r20.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,boolean)>("check", 0);	return r21
;block_num 4