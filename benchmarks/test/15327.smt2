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

(declare-sort var3386 0)
(declare-sort var3152 0)
(declare-sort var1833 0)
(declare-sort var1919 0)
(declare-sort var3081 0)
(declare-sort var2061 0)
(declare-sort var2206 0)
(declare-sort var2035 0)
(declare-sort var3364 0)
(declare-sort var2771 0)
(declare-sort var1091 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2035!class ClassObject)
(declare-fun moduleModel/-1746140277 (var3386) var1833)
(declare-fun getApplicationModel/723682732 (var1833) var1919)
(declare-fun getBeanFactory/819046718 (var2061) var3081)
(declare-fun cast-from-var1919-to-var2061 (var1919) var2061)
(declare-fun getBean/643676830 (var3081 ClassObject) var2206)
(declare-fun cast-from-var2206-to-var2035 (var2206) var2035)
(declare-fun queryMap/-1577131577 (var2771) var3364)
(declare-fun cast-from-var3386-to-var2771 (var3386) var2771)
(declare-fun mergeUrl/-82480713 (var2035 var3152 var3364) var3152)
(declare-fun overrideWithConfigurator/349125161 (var3386 var3152) var3152)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameter/-1629709269 (var3152 String String) var3152)
(declare-fun hasParameter/1395508799 (var3152 String) Bool)
(declare-fun removeParameter/-1301002585 (var3152 String) var3152)
(declare-fun getPath/898047937 (var3152) String)
(declare-fun getProtocol/491749358 (var3152) String)
(declare-const null-var3386 var3386)
(declare-const null-var3152 var3152)
(declare-const null-String String)
(declare-const var913 var3386) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var913 null-var3386)))
(declare-const var1773 var3152) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1773 null-var3152)))
(define-const var309 Bool false) ; Statement: $z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert (= (ite var309 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1368 var1833 (moduleModel/-1746140277 var913)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var1983 var1919 (getApplicationModel/723682732 var1368)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var2573 var3081 (getBeanFactory/819046718 (cast-from-var1919-to-var2061 var1983))) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>() 
(assert true)
(define-const var1251 var2206 (getBean/643676830 var2573 var2035!class)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/support/ClusterUtils;") 
(define-const var562 var2035 (cast-from-var2206-to-var2035 var1251)) ; Statement: $r6 = (org.apache.dubbo.rpc.cluster.support.ClusterUtils) $r4 
(define-const var1772 var3364 (queryMap/-1577131577 (cast-from-var3386-to-var2771 var913))) ; Statement: $r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap> 
(assert true)
(define-const var3615 var3152 (mergeUrl/-82480713 var562 var1773 var1772)) ; Statement: r15 = virtualinvoke $r6.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r13, $r5) 
(assert true)
(define-const var1345 var3152 (overrideWithConfigurator/349125161 var913 var3615)) ; Statement: r16 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r15) 
(define-const var873 String (String_valueOf/-1973653463 (ite (= 1 0) true false))) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0) 
(assert true)
(define-const var3905 var3152 (addParameter/-1629709269 var1345 "check" var873)) ; Statement: r14 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("check", $r7) 
(assert true) ; Non Conditional
(assert true)
(define-const var1535 Bool (hasParameter/1395508799 var3905 "mock")) ; Statement: $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock") 
 ; Statement: if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert (not (= (ite var1535 1 0) 0))) ; Cond: $z1 != 0 
(assert true)
(define-const var3905!1 var3152 (removeParameter/-1301002585 var3905 "mock")) ; Statement: r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert true) ; Non Conditional
(assert true)
(define-const var2075 String (getPath/898047937 var3905!1)) ; Statement: $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: if $r17 == null goto $r9 = "dubbo" 
(assert (= var2075 null-String)) ; Cond: $r17 == null 
(define-const var642 String "dubbo") ; Statement: $r9 = "dubbo" 
(assert true)
(define-const var3819 String (getProtocol/491749358 var3905!1)) ; Statement: $r8 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1907 Bool (= var642 var3819)) ; Statement: $z2 = virtualinvoke $r9.<java.lang.String: boolean equals(java.lang.Object)>($r8) 
 ; Statement: if $z2 == 0 goto return r14 
(assert (= (ite var1907 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r14 
(check-sat)
; {moduleModel/-1746140277=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.model.ModuleModel), getApplicationModel/723682732=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ApplicationModel), getBeanFactory/819046718=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.beans.factory.ScopeBeanFactory), cast-from-var1919-to-var2061=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), getBean/643676830=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.Class], java.lang.Object), cast-from-var2206-to-var2035=([java.lang.Object], org.apache.dubbo.rpc.cluster.support.ClusterUtils), queryMap/-1577131577=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.util.Map), cast-from-var3386-to-var2771=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), mergeUrl/-82480713=([org.apache.dubbo.rpc.cluster.support.ClusterUtils, org.apache.dubbo.common.URL, java.util.Map], org.apache.dubbo.common.URL), overrideWithConfigurator/349125161=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL), String_valueOf/-1973653463=([boolean], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), hasParameter/1395508799=([org.apache.dubbo.common.URL, java.lang.String], boolean), removeParameter/-1301002585=([org.apache.dubbo.common.URL, java.lang.String], org.apache.dubbo.common.URL), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var3386=org.apache.dubbo.registry.integration.RegistryDirectory, var913=r0, var3152=org.apache.dubbo.common.URL, var1773=r13, var309=$z0, var1833=org.apache.dubbo.rpc.model.ModuleModel, var1368=$r1, var1919=org.apache.dubbo.rpc.model.ApplicationModel, var1983=$r2, var3081=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var2061=org.apache.dubbo.rpc.model.ScopeModel, var2573=$r3, var2206=java.lang.Object, var2035=org.apache.dubbo.rpc.cluster.support.ClusterUtils, var1251=$r4, var562=$r6, var3364=java.util.Map, var2771=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var1772=$r5, var3615=r15, var1345=r16, var873=$r7, var3905=r14, var1535=$z1, var2075=$r17, var1091=null_type, var642=$r9, var3819=$r8, var1907=$z2}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var3386, r0=var913, org.apache.dubbo.common.URL=var3152, r13=var1773, $z0=var309, org.apache.dubbo.rpc.model.ModuleModel=var1833, $r1=var1368, org.apache.dubbo.rpc.model.ApplicationModel=var1919, $r2=var1983, org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var3081, org.apache.dubbo.rpc.model.ScopeModel=var2061, $r3=var2573, java.lang.Object=var2206, org.apache.dubbo.rpc.cluster.support.ClusterUtils=var2035, $r4=var1251, $r6=var562, java.util.Map=var3364, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var2771, $r5=var1772, r15=var3615, r16=var1345, $r7=var873, r14=var3905, $z1=var1535, $r17=var2075, null_type=var1091, $r9=var642, $r8=var3819, $z2=var1907}
;seq <java.lang.String: java.lang.String valueOf(boolean)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r13 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/support/ClusterUtils;");	$r6 = (org.apache.dubbo.rpc.cluster.support.ClusterUtils) $r4;	$r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap>;	r15 = virtualinvoke $r6.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r13, $r5);	r16 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r15);	$r7 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0);	r14 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("check", $r7);	$z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock");	if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	$r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	if $r17 == null goto $r9 = "dubbo";	$r9 = "dubbo";	$r8 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z2 = virtualinvoke $r9.<java.lang.String: boolean equals(java.lang.Object)>($r8);	if $z2 == 0 goto return r14;	return r14
;block_num 7