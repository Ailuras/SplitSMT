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

(declare-sort var2523 0)
(declare-sort var2542 0)
(declare-sort var3759 0)
(declare-sort var1303 0)
(declare-sort var1347 0)
(declare-sort var2179 0)
(declare-sort var673 0)
(declare-sort var461 0)
(declare-sort var391 0)
(declare-sort var3627 0)
(declare-sort var2761 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun moduleModel/-1750759578 (var2523) var2542)
(declare-fun getApplicationModel/723682732 (var2542) var3759)
(declare-fun getApplicationName/1861025684 (var3759) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun ruleKey/-1750759578 (var2523) String)
(declare-fun modelEnvironment/424243254 (var2542) var1303)
(declare-fun getDynamicConfiguration/-1630019946 (var1303) var1347)
(declare-fun orElse/-757175127 (var1347 var2179) var2179)
(declare-fun cast-from-var2179-to-var673 (var2179) var673)
(declare-fun configuration/-1750759578 (var2523) var673)
(declare-fun var391_isWarnEnabled/-569478753 (var391) Bool)
(declare-fun cast-from-var461-to-var391 (var461) var391)
(declare-fun setRawRule/-1973426308 (var2523 String) void)
(declare-fun getLocalMigrationRule/-42081751 (var1303) String)
(declare-fun var3627_isEmpty/-813097145 (String) Bool)
(declare-const null-var2523 var2523)
(declare-const null-NullType var2761)
(declare-const null-var2179 var2179)
(declare-const null-var673 var673)
(declare-const var2523-logger var461)
(declare-const var676 var2523) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var676 null-var2523)))
(define-const var3219 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3219)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3219!1 String)
(assert (= var3219!1 ""))
(define-const var3369 var2542 (moduleModel/-1750759578 var676)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var3662 var3759 (getApplicationModel/723682732 var3369)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var3646 String (getApplicationName/1861025684 var3662)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>() 
(assert true)
(define-const var2423 String (append/672562846 var3219!1 var3646)) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3219!2 String)
(assert (= var3219!2 (str.++ var3219!1 var3646)))
(assert true)
(define-const var2936 String (append/672562846 var2423 ".migration")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".migration") 
(declare-const var2423!1 String)
(assert (= var2423!1 (str.++ var2423 ".migration")))
(assert true)
(define-const var3498 String (toString/-2075883882 var2936)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var676!1 var2523)
(assert (not (= var676!1 null-var2523)))
(assert (= (ruleKey/-1750759578 var676!1) var3498)) ; Statement: r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey> = $r7 
(define-const var2041 var2542 (moduleModel/-1750759578 var676!1)) ; Statement: $r8 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var600 var1303 (modelEnvironment/424243254 var2041)) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>() 
(assert true)
(define-const var1143 var1347 (getDynamicConfiguration/-1630019946 var600)) ; Statement: $r10 = virtualinvoke $r9.<org.apache.dubbo.common.config.ModuleEnvironment: java.util.Optional getDynamicConfiguration()>() 
(assert true)
(define-const var1287 var2179 (orElse/-757175127 var1143 null-var2179)) ; Statement: $r11 = virtualinvoke $r10.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null) 
(define-const var3514 var673 (cast-from-var2179-to-var673 var1287)) ; Statement: $r12 = (org.apache.dubbo.common.config.configcenter.DynamicConfiguration) $r11 
(declare-const var676!2 var2523)
(assert (not (= var676!2 null-var2523)))
(assert (= (configuration/-1750759578 var676!2) var3514)) ; Statement: r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration> = $r12 
(define-const var2052 var673 (configuration/-1750759578 var676!2)) ; Statement: $r13 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration> 
 ; Statement: if $r13 == null goto $r14 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= var2052 null-var673)) ; Cond: $r13 == null 
(define-const var341 var461 var2523-logger) ; Statement: $r14 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var255 Bool (var391_isWarnEnabled/-569478753 (cast-from-var461-to-var391 var341))) ; Statement: $z0 = interfaceinvoke $r14.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isWarnEnabled()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>("INIT") 
(assert (= (ite var255 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (setRawRule/-1973426308 var676!2 "INIT")) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>("INIT") 

(declare-const var676!3 var2523)
(declare-const var1285 String)
(assert true) ; Non Conditional
(define-const var2383 var2542 (moduleModel/-1750759578 var676!3)) ; Statement: $r39 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var733 var1303 (modelEnvironment/424243254 var2383)) ; Statement: $r40 = virtualinvoke $r39.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>() 
(assert true)
(define-const var3240 String (getLocalMigrationRule/-42081751 var733)) ; Statement: $r41 = virtualinvoke $r40.<org.apache.dubbo.common.config.ModuleEnvironment: java.lang.String getLocalMigrationRule()>() 
(define-const var1928 Bool (var3627_isEmpty/-813097145 var3240)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r41) 
 ; Statement: if $z2 != 0 goto return 
(assert (not (= (ite var1928 1 0) 0))) ; Cond: $z2 != 0 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), moduleModel/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.rpc.model.ModuleModel), getApplicationModel/723682732=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ApplicationModel), getApplicationName/1861025684=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), ruleKey/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], java.lang.String), modelEnvironment/424243254=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.common.config.ModuleEnvironment), getDynamicConfiguration/-1630019946=([org.apache.dubbo.common.config.ModuleEnvironment], java.util.Optional), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var2179-to-var673=([java.lang.Object], org.apache.dubbo.common.config.configcenter.DynamicConfiguration), configuration/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.common.config.configcenter.DynamicConfiguration), var391_isWarnEnabled/-569478753=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var461-to-var391=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), setRawRule/-1973426308=([org.apache.dubbo.registry.client.migration.MigrationRuleListener, java.lang.String], void), getLocalMigrationRule/-42081751=([org.apache.dubbo.common.config.ModuleEnvironment], java.lang.String), var3627_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2523=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var676=r0, var3219=$r1, var2542=org.apache.dubbo.rpc.model.ModuleModel, var3369=$r2, var3759=org.apache.dubbo.rpc.model.ApplicationModel, var3662=$r3, var3646=$r4, var2423=$r5, var2936=$r6, var3498=$r7, var2041=$r8, var1303=org.apache.dubbo.common.config.ModuleEnvironment, var600=$r9, var1347=java.util.Optional, var1143=$r10, var2179=java.lang.Object, var1287=$r11, var673=org.apache.dubbo.common.config.configcenter.DynamicConfiguration, var3514=$r12, var2052=$r13, var461=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var341=$r14, var391=org.apache.dubbo.common.logger.Logger, var255=$z0, var1285="INIT", var2383=$r39, var733=$r40, var3240=$r41, var3627=org.apache.dubbo.common.utils.StringUtils, var1928=$z2, var2761=null_type}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var2523, r0=var676, $r1=var3219, org.apache.dubbo.rpc.model.ModuleModel=var2542, $r2=var3369, org.apache.dubbo.rpc.model.ApplicationModel=var3759, $r3=var3662, $r4=var3646, $r5=var2423, $r6=var2936, $r7=var3498, $r8=var2041, org.apache.dubbo.common.config.ModuleEnvironment=var1303, $r9=var600, java.util.Optional=var1347, $r10=var1143, java.lang.Object=var2179, $r11=var1287, org.apache.dubbo.common.config.configcenter.DynamicConfiguration=var673, $r12=var3514, $r13=var2052, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var461, $r14=var341, org.apache.dubbo.common.logger.Logger=var391, $z0=var255, "INIT"=var1285, $r39=var2383, $r40=var733, $r41=var3240, org.apache.dubbo.common.utils.StringUtils=var3627, $z2=var1928, null_type=var2761}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".migration");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String ruleKey> = $r7;	$r8 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>();	$r10 = virtualinvoke $r9.<org.apache.dubbo.common.config.ModuleEnvironment: java.util.Optional getDynamicConfiguration()>();	$r11 = virtualinvoke $r10.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null);	$r12 = (org.apache.dubbo.common.config.configcenter.DynamicConfiguration) $r11;	r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration> = $r12;	$r13 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.config.configcenter.DynamicConfiguration configuration>;	if $r13 == null goto $r14 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r14 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r14.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isWarnEnabled()>();	if $z0 == 0 goto virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>("INIT");	virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>("INIT");	$r39 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r40 = virtualinvoke $r39.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>();	$r41 = virtualinvoke $r40.<org.apache.dubbo.common.config.ModuleEnvironment: java.lang.String getLocalMigrationRule()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r41);	if $z2 != 0 goto return;	return
;block_num 5