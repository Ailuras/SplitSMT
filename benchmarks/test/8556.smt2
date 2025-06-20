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

(declare-sort var3586 0)
(declare-sort var3306 0)
(declare-sort var3535 0)
(declare-sort var2012 0)
(declare-sort var3832 0)
(declare-sort var3274 0)
(declare-sort var1702 0)
(declare-sort var2063 0)
(declare-sort var1467 0)
(declare-sort var2447 0)
(declare-sort var2016 0)
(declare-sort var2996 0)
(declare-sort var2351 0)
(declare-sort var2938 0)
(declare-sort var1167 0)
(declare-sort var1672 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2012!class ClassObject)
(declare-fun completeCompoundConfigs/-2023000048 (var3306) void)
(declare-fun cast-from-var3586-to-var3306 (var3586) var3306)
(declare-fun checkProtocol/404701757 (var3306) void)
(declare-fun getExtensionLoader/1668578899 (var3832 ClassObject) var3535)
(declare-fun cast-from-var3586-to-var3832 (var3586) var3832)
(declare-fun getScopeModel/439405660 (var1702) var3274)
(declare-fun cast-from-var3586-to-var1702 (var3586) var1702)
(declare-fun var2063_valueOf/-1099231967 (String var1467) var2063)
(declare-fun cast-from-var3274-to-var1467 (var3274) var1467)
(declare-fun getActivateExtension/-383749130 (var3535 var2063 (Array Int String)) var2447)
(declare-fun var2996_bootstrap$/-227965708 (var3586) var2016)
(declare-fun var2351_forEach/-1836413473 (var2351 var2016) void)
(declare-fun cast-from-var2447-to-var2351 (var2447) var2351)
(declare-fun isOnlyInJvm/187167018 (var3586) Bool)
(declare-fun interfaceName/2049477907 (var2938) String)
(declare-fun cast-from-var3586-to-var2938 (var3586) var2938)
(declare-fun var1167_isEmpty/-813097145 (String) Bool)
(declare-fun var1672-init () var1672)
(declare-fun <init>/-1092629202 (var1672 String) void)
(declare-const null-var3586 var3586)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2936 var3586) ; Statement: r0 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var2936 null-var3586)))
(assert true)
;(assert (completeCompoundConfigs/-2023000048 (cast-from-var3586-to-var3306 var2936))) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.ServiceConfig: void completeCompoundConfigs()>() 

(declare-const var2936!1 var3586)
(assert true)
;(assert (checkProtocol/404701757 (cast-from-var3586-to-var3306 var2936!1))) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.ServiceConfig: void checkProtocol()>() 

(declare-const var2936!2 var3586)
(assert true)
(define-const var3353 var3535 (getExtensionLoader/1668578899 (cast-from-var3586-to-var3832 var2936!2) var2012!class)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/config/ConfigInitializer;") 
(assert true)
(define-const var599 var3274 (getScopeModel/439405660 (cast-from-var3586-to-var1702 var2936!2))) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(define-const var2241 var2063 (var2063_valueOf/-1099231967 "configInitializer://" (cast-from-var3274-to-var1467 var599))) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String,org.apache.dubbo.rpc.model.ScopeModel)>("configInitializer://", $r1) 
(define-const var2255 (Array Int String) null-__Array__Int__String__) ; Statement: $r2 = (java.lang.String[]) null 
(assert true)
(define-const var551 var2447 (getActivateExtension/-383749130 var3353 var2241 var2255)) ; Statement: r5 = virtualinvoke $r4.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[])>($r3, $r2) 
(define-const var3995 var2016 (var2996_bootstrap$/-227965708 var2936!2)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.config.ServiceConfig$lambda_checkAndUpdateSubConfigs_3__480: java.util.function.Consumer bootstrap$(org.apache.dubbo.config.ServiceConfig)>(r0) 
;(assert (var2351_forEach/-1836413473 (cast-from-var2447-to-var2351 var551) var3995)) ; Statement: interfaceinvoke r5.<java.util.List: void forEach(java.util.function.Consumer)>($r6) 

(declare-const var551!1 var2447)
(declare-const var3995!1 var2016)
(assert true)
(define-const var633 Bool (isOnlyInJvm/187167018 var2936!2)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.config.ServiceConfig: boolean isOnlyInJvm()>() 
 ; Statement: if $z0 != 0 goto $r7 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.String interfaceName> 
(assert (not (= (ite var633 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1670 String (interfaceName/2049477907 (cast-from-var3586-to-var2938 var2936!2))) ; Statement: $r7 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.String interfaceName> 
(define-const var3749 Bool (var1167_isEmpty/-813097145 var1670)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7) 
 ; Statement: if $z1 == 0 goto $r8 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.Object ref> 
(assert (not (= (ite var3749 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var836 var1672 var1672-init) ; Statement: $r62 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var836 "<dubbo:service interface=\u0022\u0022 /> interface not allow null!")) ; Statement: specialinvoke $r62.<java.lang.IllegalStateException: void <init>(java.lang.String)>("<dubbo:service interface=\"\" /> interface not allow null!") 

(declare-const var836!1 var1672)
(declare-const var957 String)
 ; Statement: throw $r62 
(check-sat)
; {completeCompoundConfigs/-2023000048=([org.apache.dubbo.config.ServiceConfigBase], void), cast-from-var3586-to-var3306=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), checkProtocol/404701757=([org.apache.dubbo.config.ServiceConfigBase], void), getExtensionLoader/1668578899=([org.apache.dubbo.config.AbstractConfig, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var3586-to-var3832=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractConfig), getScopeModel/439405660=([org.apache.dubbo.config.AbstractMethodConfig], org.apache.dubbo.rpc.model.ModuleModel), cast-from-var3586-to-var1702=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractMethodConfig), var2063_valueOf/-1099231967=([java.lang.String, org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.URL), cast-from-var3274-to-var1467=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), getActivateExtension/-383749130=([org.apache.dubbo.common.extension.ExtensionLoader, org.apache.dubbo.common.URL, java.lang.String[]], java.util.List), var2996_bootstrap$/-227965708=([org.apache.dubbo.config.ServiceConfig], java.util.function.Consumer), var2351_forEach/-1836413473=([java.lang.Iterable, java.util.function.Consumer], void), cast-from-var2447-to-var2351=([java.util.List], java.lang.Iterable), isOnlyInJvm/187167018=([org.apache.dubbo.config.ServiceConfig], boolean), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var3586-to-var2938=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var1167_isEmpty/-813097145=([java.lang.String], boolean), var1672-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3586=org.apache.dubbo.config.ServiceConfig, var2936=r0, var3306=org.apache.dubbo.config.ServiceConfigBase, var3535=org.apache.dubbo.common.extension.ExtensionLoader, var2012=org.apache.dubbo.config.ConfigInitializer, var3832=org.apache.dubbo.config.AbstractConfig, var3353=$r4, var3274=org.apache.dubbo.rpc.model.ModuleModel, var1702=org.apache.dubbo.config.AbstractMethodConfig, var599=$r1, var2063=org.apache.dubbo.common.URL, var1467=org.apache.dubbo.rpc.model.ScopeModel, var2241=$r3, var2255=$r2, var2447=java.util.List, var551=r5, var2016=java.util.function.Consumer, var2996=org.apache.dubbo.config.ServiceConfig$lambda_checkAndUpdateSubConfigs_3__480, var3995=$r6, var2351=java.lang.Iterable, var633=$z0, var2938=org.apache.dubbo.config.AbstractInterfaceConfig, var1670=$r7, var1167=org.apache.dubbo.common.utils.StringUtils, var3749=$z1, var1672=java.lang.IllegalStateException, var836=$r62, var957="<dubbo:service interface=\"\" /> interface not allow null!"}
; {org.apache.dubbo.config.ServiceConfig=var3586, r0=var2936, org.apache.dubbo.config.ServiceConfigBase=var3306, org.apache.dubbo.common.extension.ExtensionLoader=var3535, org.apache.dubbo.config.ConfigInitializer=var2012, org.apache.dubbo.config.AbstractConfig=var3832, $r4=var3353, org.apache.dubbo.rpc.model.ModuleModel=var3274, org.apache.dubbo.config.AbstractMethodConfig=var1702, $r1=var599, org.apache.dubbo.common.URL=var2063, org.apache.dubbo.rpc.model.ScopeModel=var1467, $r3=var2241, $r2=var2255, java.util.List=var2447, r5=var551, java.util.function.Consumer=var2016, org.apache.dubbo.config.ServiceConfig$lambda_checkAndUpdateSubConfigs_3__480=var2996, $r6=var3995, java.lang.Iterable=var2351, $z0=var633, org.apache.dubbo.config.AbstractInterfaceConfig=var2938, $r7=var1670, org.apache.dubbo.common.utils.StringUtils=var1167, $z1=var3749, java.lang.IllegalStateException=var1672, $r62=var836, "<dubbo:service interface=\"\" /> interface not allow null!"=var957}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ServiceConfig;	virtualinvoke r0.<org.apache.dubbo.config.ServiceConfig: void completeCompoundConfigs()>();	virtualinvoke r0.<org.apache.dubbo.config.ServiceConfig: void checkProtocol()>();	$r4 = virtualinvoke r0.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/config/ConfigInitializer;");	$r1 = virtualinvoke r0.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r3 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String,org.apache.dubbo.rpc.model.ScopeModel)>("configInitializer://", $r1);	$r2 = (java.lang.String[]) null;	r5 = virtualinvoke $r4.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[])>($r3, $r2);	$r6 = staticinvoke <org.apache.dubbo.config.ServiceConfig$lambda_checkAndUpdateSubConfigs_3__480: java.util.function.Consumer bootstrap$(org.apache.dubbo.config.ServiceConfig)>(r0);	interfaceinvoke r5.<java.util.List: void forEach(java.util.function.Consumer)>($r6);	$z0 = specialinvoke r0.<org.apache.dubbo.config.ServiceConfig: boolean isOnlyInJvm()>();	if $z0 != 0 goto $r7 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.String interfaceName>;	$r7 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.String interfaceName>;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7);	if $z1 == 0 goto $r8 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.Object ref>;	$r62 = new java.lang.IllegalStateException;	specialinvoke $r62.<java.lang.IllegalStateException: void <init>(java.lang.String)>("<dubbo:service interface=\"\" /> interface not allow null!");	throw $r62
;block_num 3