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

(declare-sort var1611 0)
(declare-sort var418 0)
(declare-sort var306 0)
(declare-sort var152 0)
(declare-sort var2091 0)
(declare-sort var2356 0)
(declare-sort var3921 0)
(declare-sort var628 0)
(declare-sort var2333 0)
(declare-sort var1281 0)
(declare-sort var312 0)
(declare-sort var421 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun moduleModel/-1750759578 (var1611) var418)
(declare-fun getApplicationModel/723682732 (var418) var306)
(declare-fun getApplicationName/1861025684 (var306) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun ruleKey/-1750759578 (var1611) String)
(declare-fun modelEnvironment/424243254 (var418) var152)
(declare-fun getDynamicConfiguration/-1630019946 (var152) var2091)
(declare-fun orElse/-757175127 (var2091 var2356) var2356)
(declare-fun cast-from-var2356-to-var3921 (var2356) var3921)
(declare-fun configuration/-1750759578 (var1611) var3921)
(declare-fun var2333_info/484404803 (var2333 String) void)
(declare-fun cast-from-var628-to-var2333 (var628) var2333)
(declare-fun var3921_addListener/1343630713 (var3921 String String var1281) void)
(declare-fun cast-from-var1611-to-var1281 (var1611) var1281)
(declare-fun var3921_getConfig/235622967 (var3921 String String) String)
(declare-fun var312_isEmpty/-813097145 (String) Bool)
(declare-fun setRawRule/-1973426308 (var1611 String) void)
(declare-fun getLocalMigrationRule/-42081751 (var152) String)
(declare-const null-var1611 var1611)
(declare-const null-NullType var421)
(declare-const null-var2356 var2356)
(declare-const null-var3921 var3921)
(declare-const var1611-logger var628)
(declare-const var3611 var1611) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var3611 null-var1611)))
(define-const var1406 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1406)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1406!1 String)
(assert (= var1406!1 ""))
(define-const var2191 var418 (moduleModel/-1750759578 var3611)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var548 var306 (getApplicationModel/723682732 var2191)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var1054 String (getApplicationName/1861025684 var548)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>() 
(assert true)
(define-const var1786 String (append/672562846 var1406!1 var1054)) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1406!2 String)
(assert (= var1406!2 (str.++ var1406!1 var1054)))
(assert true)
(define-const var1200 String (append/672562846 var1786 ".migration")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".migration") 
(declare-const var1786!1 String)
(assert (= var1786!1 (str.++ var1786 ".migration")))
(assert true)
(define-const var1831 String (toString/-2075883882 var1200)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var3611!1 var1611)
(assert (not (= var3611!1 null-var1611)))
(assert (= (ruleKey/-1750759578 var3611!1) var1831)) ; Statement: r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey> = $r7 
(define-const var2263 var418 (moduleModel/-1750759578 var3611!1)) ; Statement: $r8 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var221 var152 (modelEnvironment/424243254 var2263)) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>() 
(assert true)
(define-const var2718 var2091 (getDynamicConfiguration/-1630019946 var221)) ; Statement: $r10 = virtualinvoke $r9.<org.apache.dubbo.common.config.ModuleEnvironment: java.util.Optional getDynamicConfiguration()>() 
(assert true)
(define-const var3829 var2356 (orElse/-757175127 var2718 null-var2356)) ; Statement: $r11 = virtualinvoke $r10.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null) 
(define-const var3477 var3921 (cast-from-var2356-to-var3921 var3829)) ; Statement: $r12 = (org.apache.dubbo.common.config.configcenter.DynamicConfiguration) $r11 
(declare-const var3611!2 var1611)
(assert (not (= var3611!2 null-var1611)))
(assert (= (configuration/-1750759578 var3611!2) var3477)) ; Statement: r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration> = $r12 
(define-const var2299 var3921 (configuration/-1750759578 var3611!2)) ; Statement: $r13 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration> 
 ; Statement: if $r13 == null goto $r14 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (not (= var2299 null-var3921))) ; Negate: Cond: $r13 == null  
(define-const var3952 var628 var1611-logger) ; Statement: $r27 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1019 String String-init) ; Statement: $r26 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1019)) ; Statement: specialinvoke $r26.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1019!1 String)
(assert (= var1019!1 ""))
(assert true)
(define-const var1551 String (append/672562846 var1019!1 "Listening for migration rules on dataId ")) ; Statement: $r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Listening for migration rules on dataId ") 
(declare-const var1019!2 String)
(assert (= var1019!2 (str.++ var1019!1 "Listening for migration rules on dataId ")))
(define-const var1388 String (ruleKey/-1750759578 var3611!2)) ; Statement: $r28 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey> 
(assert true)
(define-const var1998 String (append/672562846 var1551 var1388)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28) 
(declare-const var1551!1 String)
(assert (= var1551!1 (str.++ var1551 var1388)))
(assert true)
(define-const var987 String (append/672562846 var1998 ", group ")) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", group ") 
(declare-const var1998!1 String)
(assert (= var1998!1 (str.++ var1998 ", group ")))
(assert true)
(define-const var3772 String (append/672562846 var987 "DUBBO_SERVICEDISCOVERY_MIGRATION")) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DUBBO_SERVICEDISCOVERY_MIGRATION") 
(declare-const var987!1 String)
(assert (= var987!1 (str.++ var987 "DUBBO_SERVICEDISCOVERY_MIGRATION")))
(assert true)
(define-const var519 String (toString/-2075883882 var3772)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2333_info/484404803 (cast-from-var628-to-var2333 var3952) var519)) ; Statement: interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r33) 

(declare-const var3952!1 var628)
(declare-const var519!1 String)
(define-const var3895 var3921 (configuration/-1750759578 var3611!2)) ; Statement: $r35 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration> 
(define-const var2554 String (ruleKey/-1750759578 var3611!2)) ; Statement: $r34 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey> 
;(assert (var3921_addListener/1343630713 var3895 var2554 "DUBBO_SERVICEDISCOVERY_MIGRATION" (cast-from-var1611-to-var1281 var3611!2))) ; Statement: interfaceinvoke $r35.<org.apache.dubbo.common.config.configcenter.DynamicConfiguration: void addListener(java.lang.String,java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>($r34, "DUBBO_SERVICEDISCOVERY_MIGRATION", r0) 

(declare-const var3895!1 var3921)
(declare-const var2554!1 String)
(declare-const var3513 String)
(declare-const var3611!3 var1611)
(define-const var3323 var3921 (configuration/-1750759578 var3611!3)) ; Statement: $r37 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration> 
(define-const var2131 String (ruleKey/-1750759578 var3611!3)) ; Statement: $r36 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey> 
(define-const var3265 String (var3921_getConfig/235622967 var3323 var2131 "DUBBO_SERVICEDISCOVERY_MIGRATION")) ; Statement: r38 = interfaceinvoke $r37.<org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getConfig(java.lang.String,java.lang.String)>($r36, "DUBBO_SERVICEDISCOVERY_MIGRATION") 
(define-const var1495 Bool (var312_isEmpty/-813097145 var3265)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r38) 
 ; Statement: if $z1 == 0 goto virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>(r38) 
(assert (= (ite var1495 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (setRawRule/-1973426308 var3611!3 var3265)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>(r38) 

(declare-const var3611!4 var1611)
(declare-const var3265!1 String)
 ; Statement: goto [?= $r39 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>] 
(assert true) ; Non Conditional
(define-const var261 var418 (moduleModel/-1750759578 var3611!4)) ; Statement: $r39 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var181 var152 (modelEnvironment/424243254 var261)) ; Statement: $r40 = virtualinvoke $r39.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>() 
(assert true)
(define-const var2759 String (getLocalMigrationRule/-42081751 var181)) ; Statement: $r41 = virtualinvoke $r40.<org.apache.dubbo.common.config.ModuleEnvironment: java.lang.String getLocalMigrationRule()>() 
(define-const var2646 Bool (var312_isEmpty/-813097145 var2759)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r41) 
 ; Statement: if $z2 != 0 goto return 
(assert (not (= (ite var2646 1 0) 0))) ; Cond: $z2 != 0 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), moduleModel/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.rpc.model.ModuleModel), getApplicationModel/723682732=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ApplicationModel), getApplicationName/1861025684=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), ruleKey/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], java.lang.String), modelEnvironment/424243254=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.common.config.ModuleEnvironment), getDynamicConfiguration/-1630019946=([org.apache.dubbo.common.config.ModuleEnvironment], java.util.Optional), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var2356-to-var3921=([java.lang.Object], org.apache.dubbo.common.config.configcenter.DynamicConfiguration), configuration/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.common.config.configcenter.DynamicConfiguration), var2333_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var628-to-var2333=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var3921_addListener/1343630713=([org.apache.dubbo.common.config.configcenter.DynamicConfiguration, java.lang.String, java.lang.String, org.apache.dubbo.common.config.configcenter.ConfigurationListener], void), cast-from-var1611-to-var1281=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.common.config.configcenter.ConfigurationListener), var3921_getConfig/235622967=([org.apache.dubbo.common.config.configcenter.DynamicConfiguration, java.lang.String, java.lang.String], java.lang.String), var312_isEmpty/-813097145=([java.lang.String], boolean), setRawRule/-1973426308=([org.apache.dubbo.registry.client.migration.MigrationRuleListener, java.lang.String], void), getLocalMigrationRule/-42081751=([org.apache.dubbo.common.config.ModuleEnvironment], java.lang.String)}
; {var1611=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var3611=r0, var1406=$r1, var418=org.apache.dubbo.rpc.model.ModuleModel, var2191=$r2, var306=org.apache.dubbo.rpc.model.ApplicationModel, var548=$r3, var1054=$r4, var1786=$r5, var1200=$r6, var1831=$r7, var2263=$r8, var152=org.apache.dubbo.common.config.ModuleEnvironment, var221=$r9, var2091=java.util.Optional, var2718=$r10, var2356=java.lang.Object, var3829=$r11, var3921=org.apache.dubbo.common.config.configcenter.DynamicConfiguration, var3477=$r12, var2299=$r13, var628=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3952=$r27, var1019=$r26, var1551=$r29, var1388=$r28, var1998=$r30, var987=$r31, var3772=$r32, var519=$r33, var2333=org.apache.dubbo.common.logger.Logger, var3895=$r35, var2554=$r34, var1281=org.apache.dubbo.common.config.configcenter.ConfigurationListener, var3513="DUBBO_SERVICEDISCOVERY_MIGRATION", var3323=$r37, var2131=$r36, var3265=r38, var312=org.apache.dubbo.common.utils.StringUtils, var1495=$z1, var261=$r39, var181=$r40, var2759=$r41, var2646=$z2, var421=null_type}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var1611, r0=var3611, $r1=var1406, org.apache.dubbo.rpc.model.ModuleModel=var418, $r2=var2191, org.apache.dubbo.rpc.model.ApplicationModel=var306, $r3=var548, $r4=var1054, $r5=var1786, $r6=var1200, $r7=var1831, $r8=var2263, org.apache.dubbo.common.config.ModuleEnvironment=var152, $r9=var221, java.util.Optional=var2091, $r10=var2718, java.lang.Object=var2356, $r11=var3829, org.apache.dubbo.common.config.configcenter.DynamicConfiguration=var3921, $r12=var3477, $r13=var2299, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var628, $r27=var3952, $r26=var1019, $r29=var1551, $r28=var1388, $r30=var1998, $r31=var987, $r32=var3772, $r33=var519, org.apache.dubbo.common.logger.Logger=var2333, $r35=var3895, $r34=var2554, org.apache.dubbo.common.config.configcenter.ConfigurationListener=var1281, "DUBBO_SERVICEDISCOVERY_MIGRATION"=var3513, $r37=var3323, $r36=var2131, r38=var3265, org.apache.dubbo.common.utils.StringUtils=var312, $z1=var1495, $r39=var261, $r40=var181, $r41=var2759, $z2=var2646, null_type=var421}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".migration");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey> = $r7;	$r8 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>();	$r10 = virtualinvoke $r9.<org.apache.dubbo.common.config.ModuleEnvironment: java.util.Optional getDynamicConfiguration()>();	$r11 = virtualinvoke $r10.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null);	$r12 = (org.apache.dubbo.common.config.configcenter.DynamicConfiguration) $r11;	r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration> = $r12;	$r13 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration>;	if $r13 == null goto $r14 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r27 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r26 = new java.lang.StringBuilder;	specialinvoke $r26.<java.lang.StringBuilder: void <init>()>();	$r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Listening for migration rules on dataId ");	$r28 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey>;	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", group ");	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DUBBO_SERVICEDISCOVERY_MIGRATION");	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r33);	$r35 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration>;	$r34 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey>;	interfaceinvoke $r35.<org.apache.dubbo.common.config.configcenter.DynamicConfiguration: void addListener(java.lang.String,java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>($r34, "DUBBO_SERVICEDISCOVERY_MIGRATION", r0);	$r37 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration>;	$r36 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey>;	r38 = interfaceinvoke $r37.<org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getConfig(java.lang.String,java.lang.String)>($r36, "DUBBO_SERVICEDISCOVERY_MIGRATION");	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r38);	if $z1 == 0 goto virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>(r38);	virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>(r38);	goto [?= $r39 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>];	$r39 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r40 = virtualinvoke $r39.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>();	$r41 = virtualinvoke $r40.<org.apache.dubbo.common.config.ModuleEnvironment: java.lang.String getLocalMigrationRule()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r41);	if $z2 != 0 goto return;	return
;block_num 5