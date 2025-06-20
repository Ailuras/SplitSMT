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

(declare-sort var1245 0)
(declare-sort var1728 0)
(declare-sort var2812 0)
(declare-sort var236 0)
(declare-sort var3134 0)
(declare-sort var3636 0)
(declare-sort var3353 0)
(declare-sort var1736 0)
(declare-sort var3061 0)
(declare-sort var2936 0)
(declare-sort var2198 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1736!class ClassObject)
(declare-fun moduleModel/-1746140277 (var1245) var2812)
(declare-fun getApplicationModel/723682732 (var2812) var236)
(declare-fun getBeanFactory/819046718 (var3636) var3134)
(declare-fun cast-from-var236-to-var3636 (var236) var3636)
(declare-fun getBean/643676830 (var3134 ClassObject) var3353)
(declare-fun cast-from-var3353-to-var1736 (var3353) var1736)
(declare-fun queryMap/-1577131577 (var2936) var3061)
(declare-fun cast-from-var1245-to-var2936 (var1245) var2936)
(declare-fun mergeUrl/-82480713 (var1736 var1728 var3061) var1728)
(declare-fun overrideWithConfigurator/349125161 (var1245 var1728) var1728)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameter/-1629709269 (var1728 String String) var1728)
(declare-fun hasParameter/1395508799 (var1728 String) Bool)
(declare-fun getAnyMethodParameter/748481455 (var1728 String) String)
(declare-fun getPath/898047937 (var1728) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var1245 var1245)
(declare-const null-var1728 var1728)
(declare-const null-String String)
(declare-const var260 var1245) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var260 null-var1245)))
(declare-const var2534 var1728) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2534 null-var1728)))
(define-const var776 Bool false) ; Statement: $z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert (= (ite var776 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1884 var2812 (moduleModel/-1746140277 var260)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var2329 var236 (getApplicationModel/723682732 var1884)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var1849 var3134 (getBeanFactory/819046718 (cast-from-var236-to-var3636 var2329))) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>() 
(assert true)
(define-const var650 var3353 (getBean/643676830 var1849 var1736!class)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/support/ClusterUtils;") 
(define-const var1343 var1736 (cast-from-var3353-to-var1736 var650)) ; Statement: $r6 = (org.apache.dubbo.rpc.cluster.support.ClusterUtils) $r4 
(define-const var2482 var3061 (queryMap/-1577131577 (cast-from-var1245-to-var2936 var260))) ; Statement: $r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap> 
(assert true)
(define-const var12 var1728 (mergeUrl/-82480713 var1343 var2534 var2482)) ; Statement: r15 = virtualinvoke $r6.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r13, $r5) 
(assert true)
(define-const var3459 var1728 (overrideWithConfigurator/349125161 var260 var12)) ; Statement: r16 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r15) 
(define-const var487 String (String_valueOf/-1973653463 (ite (= 1 0) true false))) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0) 
(assert true)
(define-const var3834 var1728 (addParameter/-1629709269 var3459 "check" var487)) ; Statement: r14 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("check", $r7) 
(assert true) ; Non Conditional
(assert true)
(define-const var2168 Bool (hasParameter/1395508799 var3834 "mock")) ; Statement: $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock") 
 ; Statement: if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert (not (not (= (ite var2168 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(assert true)
(define-const var352 String (getAnyMethodParameter/748481455 var3834 "mock")) ; Statement: $r12 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getAnyMethodParameter(java.lang.String)>("mock") 
 ; Statement: if $r12 == null goto $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (= var352 null-String)) ; Cond: $r12 == null 
(assert true)
(define-const var2924 String (getPath/898047937 var3834)) ; Statement: $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: if $r17 == null goto $r9 = "dubbo" 
(assert (not (= var2924 null-String))) ; Negate: Cond: $r17 == null  
(assert true)
(define-const var1922 String (getPath/898047937 var3834)) ; Statement: $r11 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var1360 Int (length/-134980193 var1922)) ; Statement: $i2 = virtualinvoke $r11.<java.lang.String: int length()>() 
 ; Statement: if $i2 != 0 goto return r14 
(assert (not (= var1360 0))) ; Cond: $i2 != 0 
 ; Statement: return r14 
(check-sat)
; {moduleModel/-1746140277=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.model.ModuleModel), getApplicationModel/723682732=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ApplicationModel), getBeanFactory/819046718=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.beans.factory.ScopeBeanFactory), cast-from-var236-to-var3636=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), getBean/643676830=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.Class], java.lang.Object), cast-from-var3353-to-var1736=([java.lang.Object], org.apache.dubbo.rpc.cluster.support.ClusterUtils), queryMap/-1577131577=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.util.Map), cast-from-var1245-to-var2936=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), mergeUrl/-82480713=([org.apache.dubbo.rpc.cluster.support.ClusterUtils, org.apache.dubbo.common.URL, java.util.Map], org.apache.dubbo.common.URL), overrideWithConfigurator/349125161=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL), String_valueOf/-1973653463=([boolean], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), hasParameter/1395508799=([org.apache.dubbo.common.URL, java.lang.String], boolean), getAnyMethodParameter/748481455=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var1245=org.apache.dubbo.registry.integration.RegistryDirectory, var260=r0, var1728=org.apache.dubbo.common.URL, var2534=r13, var776=$z0, var2812=org.apache.dubbo.rpc.model.ModuleModel, var1884=$r1, var236=org.apache.dubbo.rpc.model.ApplicationModel, var2329=$r2, var3134=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var3636=org.apache.dubbo.rpc.model.ScopeModel, var1849=$r3, var3353=java.lang.Object, var1736=org.apache.dubbo.rpc.cluster.support.ClusterUtils, var650=$r4, var1343=$r6, var3061=java.util.Map, var2936=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var2482=$r5, var12=r15, var3459=r16, var487=$r7, var3834=r14, var2168=$z1, var352=$r12, var2198=null_type, var2924=$r17, var1922=$r11, var1360=$i2}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var1245, r0=var260, org.apache.dubbo.common.URL=var1728, r13=var2534, $z0=var776, org.apache.dubbo.rpc.model.ModuleModel=var2812, $r1=var1884, org.apache.dubbo.rpc.model.ApplicationModel=var236, $r2=var2329, org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var3134, org.apache.dubbo.rpc.model.ScopeModel=var3636, $r3=var1849, java.lang.Object=var3353, org.apache.dubbo.rpc.cluster.support.ClusterUtils=var1736, $r4=var650, $r6=var1343, java.util.Map=var3061, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var2936, $r5=var2482, r15=var12, r16=var3459, $r7=var487, r14=var3834, $z1=var2168, $r12=var352, null_type=var2198, $r17=var2924, $r11=var1922, $i2=var1360}
;seq <java.lang.String: java.lang.String valueOf(boolean)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1,"<java.lang.String: int length()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r13 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/support/ClusterUtils;");	$r6 = (org.apache.dubbo.rpc.cluster.support.ClusterUtils) $r4;	$r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap>;	r15 = virtualinvoke $r6.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r13, $r5);	r16 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r15);	$r7 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0);	r14 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("check", $r7);	$z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock");	if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	$r12 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getAnyMethodParameter(java.lang.String)>("mock");	if $r12 == null goto $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	if $r17 == null goto $r9 = "dubbo";	$r11 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$i2 = virtualinvoke $r11.<java.lang.String: int length()>();	if $i2 != 0 goto return r14;	return r14
;block_num 7