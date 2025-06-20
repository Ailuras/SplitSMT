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

(declare-sort var371 0)
(declare-sort var1042 0)
(declare-sort var105 0)
(declare-sort var3871 0)
(declare-sort var2928 0)
(declare-sort var3554 0)
(declare-sort var854 0)
(declare-sort var1100 0)
(declare-sort var3648 0)
(declare-sort var961 0)
(declare-sort var3249 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1100!class ClassObject)
(declare-fun moduleModel/-1746140277 (var371) var105)
(declare-fun getApplicationModel/723682732 (var105) var3871)
(declare-fun getBeanFactory/819046718 (var3554) var2928)
(declare-fun cast-from-var3871-to-var3554 (var3871) var3554)
(declare-fun getBean/643676830 (var2928 ClassObject) var854)
(declare-fun cast-from-var854-to-var1100 (var854) var1100)
(declare-fun queryMap/-1577131577 (var961) var3648)
(declare-fun cast-from-var371-to-var961 (var371) var961)
(declare-fun mergeUrl/-82480713 (var1100 var1042 var3648) var1042)
(declare-fun overrideWithConfigurator/349125161 (var371 var1042) var1042)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameter/-1629709269 (var1042 String String) var1042)
(declare-fun hasParameter/1395508799 (var1042 String) Bool)
(declare-fun getAnyMethodParameter/748481455 (var1042 String) String)
(declare-fun getPath/898047937 (var1042) String)
(declare-fun getProtocol/491749358 (var1042) String)
(declare-const null-var371 var371)
(declare-const null-var1042 var1042)
(declare-const null-String String)
(declare-const var3817 var371) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var3817 null-var371)))
(declare-const var428 var1042) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var428 null-var1042)))
(define-const var3235 Bool false) ; Statement: $z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert (= (ite var3235 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2774 var105 (moduleModel/-1746140277 var3817)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var1010 var3871 (getApplicationModel/723682732 var2774)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var1706 var2928 (getBeanFactory/819046718 (cast-from-var3871-to-var3554 var1010))) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>() 
(assert true)
(define-const var1705 var854 (getBean/643676830 var1706 var1100!class)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/support/ClusterUtils;") 
(define-const var1800 var1100 (cast-from-var854-to-var1100 var1705)) ; Statement: $r6 = (org.apache.dubbo.rpc.cluster.support.ClusterUtils) $r4 
(define-const var3489 var3648 (queryMap/-1577131577 (cast-from-var371-to-var961 var3817))) ; Statement: $r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap> 
(assert true)
(define-const var1353 var1042 (mergeUrl/-82480713 var1800 var428 var3489)) ; Statement: r15 = virtualinvoke $r6.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r13, $r5) 
(assert true)
(define-const var441 var1042 (overrideWithConfigurator/349125161 var3817 var1353)) ; Statement: r16 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r15) 
(define-const var606 String (String_valueOf/-1973653463 (ite (= 1 0) true false))) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0) 
(assert true)
(define-const var290 var1042 (addParameter/-1629709269 var441 "check" var606)) ; Statement: r14 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("check", $r7) 
(assert true) ; Non Conditional
(assert true)
(define-const var265 Bool (hasParameter/1395508799 var290 "mock")) ; Statement: $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock") 
 ; Statement: if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert (not (not (= (ite var265 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(assert true)
(define-const var1333 String (getAnyMethodParameter/748481455 var290 "mock")) ; Statement: $r12 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getAnyMethodParameter(java.lang.String)>("mock") 
 ; Statement: if $r12 == null goto $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (= var1333 null-String)) ; Cond: $r12 == null 
(assert true)
(define-const var261 String (getPath/898047937 var290)) ; Statement: $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: if $r17 == null goto $r9 = "dubbo" 
(assert (= var261 null-String)) ; Cond: $r17 == null 
(define-const var139 String "dubbo") ; Statement: $r9 = "dubbo" 
(assert true)
(define-const var2687 String (getProtocol/491749358 var290)) ; Statement: $r8 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var3745 Bool (= var139 var2687)) ; Statement: $z2 = virtualinvoke $r9.<java.lang.String: boolean equals(java.lang.Object)>($r8) 
 ; Statement: if $z2 == 0 goto return r14 
(assert (= (ite var3745 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r14 
(check-sat)
; {moduleModel/-1746140277=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.model.ModuleModel), getApplicationModel/723682732=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ApplicationModel), getBeanFactory/819046718=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.beans.factory.ScopeBeanFactory), cast-from-var3871-to-var3554=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), getBean/643676830=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.Class], java.lang.Object), cast-from-var854-to-var1100=([java.lang.Object], org.apache.dubbo.rpc.cluster.support.ClusterUtils), queryMap/-1577131577=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.util.Map), cast-from-var371-to-var961=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), mergeUrl/-82480713=([org.apache.dubbo.rpc.cluster.support.ClusterUtils, org.apache.dubbo.common.URL, java.util.Map], org.apache.dubbo.common.URL), overrideWithConfigurator/349125161=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL), String_valueOf/-1973653463=([boolean], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), hasParameter/1395508799=([org.apache.dubbo.common.URL, java.lang.String], boolean), getAnyMethodParameter/748481455=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var371=org.apache.dubbo.registry.integration.RegistryDirectory, var3817=r0, var1042=org.apache.dubbo.common.URL, var428=r13, var3235=$z0, var105=org.apache.dubbo.rpc.model.ModuleModel, var2774=$r1, var3871=org.apache.dubbo.rpc.model.ApplicationModel, var1010=$r2, var2928=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var3554=org.apache.dubbo.rpc.model.ScopeModel, var1706=$r3, var854=java.lang.Object, var1100=org.apache.dubbo.rpc.cluster.support.ClusterUtils, var1705=$r4, var1800=$r6, var3648=java.util.Map, var961=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var3489=$r5, var1353=r15, var441=r16, var606=$r7, var290=r14, var265=$z1, var1333=$r12, var3249=null_type, var261=$r17, var139=$r9, var2687=$r8, var3745=$z2}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var371, r0=var3817, org.apache.dubbo.common.URL=var1042, r13=var428, $z0=var3235, org.apache.dubbo.rpc.model.ModuleModel=var105, $r1=var2774, org.apache.dubbo.rpc.model.ApplicationModel=var3871, $r2=var1010, org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var2928, org.apache.dubbo.rpc.model.ScopeModel=var3554, $r3=var1706, java.lang.Object=var854, org.apache.dubbo.rpc.cluster.support.ClusterUtils=var1100, $r4=var1705, $r6=var1800, java.util.Map=var3648, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var961, $r5=var3489, r15=var1353, r16=var441, $r7=var606, r14=var290, $z1=var265, $r12=var1333, null_type=var3249, $r17=var261, $r9=var139, $r8=var2687, $z2=var3745}
;seq <java.lang.String: java.lang.String valueOf(boolean)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r13 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/support/ClusterUtils;");	$r6 = (org.apache.dubbo.rpc.cluster.support.ClusterUtils) $r4;	$r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap>;	r15 = virtualinvoke $r6.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r13, $r5);	r16 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r15);	$r7 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0);	r14 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("check", $r7);	$z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock");	if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	$r12 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getAnyMethodParameter(java.lang.String)>("mock");	if $r12 == null goto $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	if $r17 == null goto $r9 = "dubbo";	$r9 = "dubbo";	$r8 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z2 = virtualinvoke $r9.<java.lang.String: boolean equals(java.lang.Object)>($r8);	if $z2 == 0 goto return r14;	return r14
;block_num 7