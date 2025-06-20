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

(declare-sort var813 0)
(declare-sort var2012 0)
(declare-sort var2025 0)
(declare-sort var4 0)
(declare-sort var1770 0)
(declare-sort var1951 0)
(declare-sort var2435 0)
(declare-sort var140 0)
(declare-sort var3105 0)
(declare-sort var3757 0)
(declare-sort var1426 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var140!class ClassObject)
(declare-fun moduleModel/-1746140277 (var813) var2025)
(declare-fun getApplicationModel/723682732 (var2025) var4)
(declare-fun getBeanFactory/819046718 (var1951) var1770)
(declare-fun cast-from-var4-to-var1951 (var4) var1951)
(declare-fun getBean/643676830 (var1770 ClassObject) var2435)
(declare-fun cast-from-var2435-to-var140 (var2435) var140)
(declare-fun queryMap/-1577131577 (var3757) var3105)
(declare-fun cast-from-var813-to-var3757 (var813) var3757)
(declare-fun mergeUrl/-82480713 (var140 var2012 var3105) var2012)
(declare-fun overrideWithConfigurator/349125161 (var813 var2012) var2012)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameter/-1629709269 (var2012 String String) var2012)
(declare-fun hasParameter/1395508799 (var2012 String) Bool)
(declare-fun removeParameter/-1301002585 (var2012 String) var2012)
(declare-fun getPath/898047937 (var2012) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var813 var813)
(declare-const null-var2012 var2012)
(declare-const null-String String)
(declare-const var1515 var813) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var1515 null-var813)))
(declare-const var3151 var2012) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3151 null-var2012)))
(define-const var455 Bool false) ; Statement: $z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert (= (ite var455 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3527 var2025 (moduleModel/-1746140277 var1515)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var3617 var4 (getApplicationModel/723682732 var3527)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var2067 var1770 (getBeanFactory/819046718 (cast-from-var4-to-var1951 var3617))) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>() 
(assert true)
(define-const var3533 var2435 (getBean/643676830 var2067 var140!class)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/support/ClusterUtils;") 
(define-const var3535 var140 (cast-from-var2435-to-var140 var3533)) ; Statement: $r6 = (org.apache.dubbo.rpc.cluster.support.ClusterUtils) $r4 
(define-const var2323 var3105 (queryMap/-1577131577 (cast-from-var813-to-var3757 var1515))) ; Statement: $r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap> 
(assert true)
(define-const var3692 var2012 (mergeUrl/-82480713 var3535 var3151 var2323)) ; Statement: r15 = virtualinvoke $r6.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r13, $r5) 
(assert true)
(define-const var1323 var2012 (overrideWithConfigurator/349125161 var1515 var3692)) ; Statement: r16 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r15) 
(define-const var1107 String (String_valueOf/-1973653463 (ite (= 1 0) true false))) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0) 
(assert true)
(define-const var2485 var2012 (addParameter/-1629709269 var1323 "check" var1107)) ; Statement: r14 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("check", $r7) 
(assert true) ; Non Conditional
(assert true)
(define-const var1004 Bool (hasParameter/1395508799 var2485 "mock")) ; Statement: $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock") 
 ; Statement: if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert (not (= (ite var1004 1 0) 0))) ; Cond: $z1 != 0 
(assert true)
(define-const var2485!1 var2012 (removeParameter/-1301002585 var2485 "mock")) ; Statement: r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert true) ; Non Conditional
(assert true)
(define-const var603 String (getPath/898047937 var2485!1)) ; Statement: $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: if $r17 == null goto $r9 = "dubbo" 
(assert (not (= var603 null-String))) ; Negate: Cond: $r17 == null  
(assert true)
(define-const var143 String (getPath/898047937 var2485!1)) ; Statement: $r11 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var2665 Int (length/-134980193 var143)) ; Statement: $i2 = virtualinvoke $r11.<java.lang.String: int length()>() 
 ; Statement: if $i2 != 0 goto return r14 
(assert (not (= var2665 0))) ; Cond: $i2 != 0 
 ; Statement: return r14 
(check-sat)
; {moduleModel/-1746140277=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.model.ModuleModel), getApplicationModel/723682732=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ApplicationModel), getBeanFactory/819046718=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.beans.factory.ScopeBeanFactory), cast-from-var4-to-var1951=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), getBean/643676830=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.Class], java.lang.Object), cast-from-var2435-to-var140=([java.lang.Object], org.apache.dubbo.rpc.cluster.support.ClusterUtils), queryMap/-1577131577=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.util.Map), cast-from-var813-to-var3757=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), mergeUrl/-82480713=([org.apache.dubbo.rpc.cluster.support.ClusterUtils, org.apache.dubbo.common.URL, java.util.Map], org.apache.dubbo.common.URL), overrideWithConfigurator/349125161=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL), String_valueOf/-1973653463=([boolean], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), hasParameter/1395508799=([org.apache.dubbo.common.URL, java.lang.String], boolean), removeParameter/-1301002585=([org.apache.dubbo.common.URL, java.lang.String], org.apache.dubbo.common.URL), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var813=org.apache.dubbo.registry.integration.RegistryDirectory, var1515=r0, var2012=org.apache.dubbo.common.URL, var3151=r13, var455=$z0, var2025=org.apache.dubbo.rpc.model.ModuleModel, var3527=$r1, var4=org.apache.dubbo.rpc.model.ApplicationModel, var3617=$r2, var1770=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var1951=org.apache.dubbo.rpc.model.ScopeModel, var2067=$r3, var2435=java.lang.Object, var140=org.apache.dubbo.rpc.cluster.support.ClusterUtils, var3533=$r4, var3535=$r6, var3105=java.util.Map, var3757=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var2323=$r5, var3692=r15, var1323=r16, var1107=$r7, var2485=r14, var1004=$z1, var603=$r17, var1426=null_type, var143=$r11, var2665=$i2}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var813, r0=var1515, org.apache.dubbo.common.URL=var2012, r13=var3151, $z0=var455, org.apache.dubbo.rpc.model.ModuleModel=var2025, $r1=var3527, org.apache.dubbo.rpc.model.ApplicationModel=var4, $r2=var3617, org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var1770, org.apache.dubbo.rpc.model.ScopeModel=var1951, $r3=var2067, java.lang.Object=var2435, org.apache.dubbo.rpc.cluster.support.ClusterUtils=var140, $r4=var3533, $r6=var3535, java.util.Map=var3105, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var3757, $r5=var2323, r15=var3692, r16=var1323, $r7=var1107, r14=var2485, $z1=var1004, $r17=var603, null_type=var1426, $r11=var143, $i2=var2665}
;seq <java.lang.String: java.lang.String valueOf(boolean)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1,"<java.lang.String: int length()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r13 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/support/ClusterUtils;");	$r6 = (org.apache.dubbo.rpc.cluster.support.ClusterUtils) $r4;	$r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap>;	r15 = virtualinvoke $r6.<org.apache.dubbo.rpc.cluster.support.ClusterUtils: org.apache.dubbo.common.URL mergeUrl(org.apache.dubbo.common.URL,java.util.Map)>(r13, $r5);	r16 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r15);	$r7 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0);	r14 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("check", $r7);	$z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock");	if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	$r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	if $r17 == null goto $r9 = "dubbo";	$r11 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$i2 = virtualinvoke $r11.<java.lang.String: int length()>();	if $i2 != 0 goto return r14;	return r14
;block_num 7