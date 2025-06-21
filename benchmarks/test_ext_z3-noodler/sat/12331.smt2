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

(declare-sort var683 0)
(declare-sort var1224 0)
(declare-sort var1406 0)
(declare-sort var1189 0)
(declare-sort var2183 0)
(declare-sort var2828 0)
(declare-sort var3419 0)
(declare-sort var2722 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun configManager/-235729372 (var683) var1406)
(declare-fun getId/-1659575909 (var1189) String)
(declare-fun cast-from-var1224-to-var1189 (var1224) var1189)
(declare-fun getConfigCenter/-1960614011 (var1406 String) var2183)
(declare-fun isPresent/580259846 (var2183) Bool)
(declare-fun addConfigCenter/1831267424 (var1406 var1224) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3419) String)
(declare-fun cast-from-var1224-to-var3419 (var1224) var3419)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2722_info/484404803 (var2722 String) void)
(declare-fun cast-from-var2828-to-var2722 (var2828) var2722)
(declare-const null-var683 var683)
(declare-const null-var1224 var1224)
(declare-const var683-logger var2828)
(declare-const var2435 var683) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer 
(assert (not (= var2435 null-var683)))
(declare-const var3508 var1224) ; Statement: r1 := @parameter0: org.apache.dubbo.config.ConfigCenterConfig 
(assert (not (= var3508 null-var1224)))
(define-const var3515 var1406 (configManager/-235729372 var2435)) ; Statement: $r2 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
(define-const var2655 String (getId/-1659575909 (cast-from-var1224-to-var1189 var3508))) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String getId()>() 
(assert true)
(define-const var3922 var2183 (getConfigCenter/-1960614011 var3515 var2655)) ; Statement: $r4 = virtualinvoke $r2.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getConfigCenter(java.lang.String)>($r3) 
(assert true)
(define-const var1782 Bool (isPresent/580259846 var3922)) ; Statement: $z0 = virtualinvoke $r4.<java.util.Optional: boolean isPresent()>() 
 ; Statement: if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert (= (ite var1782 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3549 var1406 (configManager/-235729372 var2435)) ; Statement: $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
;(assert (addConfigCenter/1831267424 var3549 var3508)) ; Statement: virtualinvoke $r5.<org.apache.dubbo.config.context.ConfigManager: void addConfigCenter(org.apache.dubbo.config.ConfigCenterConfig)>(r1) 

(declare-const var3549!1 var1406)
(declare-const var3508!1 var1224)
(define-const var3061 var2828 var683-logger) ; Statement: $r7 = <org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3375 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3375)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3375!1 String)
(assert (= var3375!1 ""))
(assert true)
(define-const var2615 String (append/672562846 var3375!1 "use registry as config-center: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("use registry as config-center: ") 
(declare-const var3375!2 String)
(assert (= var3375!2 (str.++ var3375!1 "use registry as config-center: ")))
(assert true)
(define-const var2803 String (append/-1031950772 var2615 (cast-from-var1224-to-var3419 var3508!1))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2615!1 String)
(assert (str.prefixof var2615 var2615!1))
(assert true)
(define-const var3512 String (toString/-2075883882 var2803)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2722_info/484404803 (cast-from-var2828-to-var2722 var3061) var3512)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r10) 

(declare-const var3061!1 var2828)
(declare-const var3512!1 String)
 ; Statement: return 
(check-sat)
; {configManager/-235729372=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.config.context.ConfigManager), getId/-1659575909=([org.apache.dubbo.config.AbstractConfig], java.lang.String), cast-from-var1224-to-var1189=([org.apache.dubbo.config.ConfigCenterConfig], org.apache.dubbo.config.AbstractConfig), getConfigCenter/-1960614011=([org.apache.dubbo.config.context.ConfigManager, java.lang.String], java.util.Optional), isPresent/580259846=([java.util.Optional], boolean), addConfigCenter/1831267424=([org.apache.dubbo.config.context.ConfigManager, org.apache.dubbo.config.ConfigCenterConfig], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1224-to-var3419=([org.apache.dubbo.config.ConfigCenterConfig], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2722_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var2828-to-var2722=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var683=org.apache.dubbo.config.deploy.DefaultApplicationDeployer, var2435=r0, var1224=org.apache.dubbo.config.ConfigCenterConfig, var3508=r1, var1406=org.apache.dubbo.config.context.ConfigManager, var3515=$r2, var1189=org.apache.dubbo.config.AbstractConfig, var2655=$r3, var2183=java.util.Optional, var3922=$r4, var1782=$z0, var3549=$r5, var2828=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3061=$r7, var3375=$r6, var2615=$r8, var3419=java.lang.Object, var2803=$r9, var3512=$r10, var2722=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.config.deploy.DefaultApplicationDeployer=var683, r0=var2435, org.apache.dubbo.config.ConfigCenterConfig=var1224, r1=var3508, org.apache.dubbo.config.context.ConfigManager=var1406, $r2=var3515, org.apache.dubbo.config.AbstractConfig=var1189, $r3=var2655, java.util.Optional=var2183, $r4=var3922, $z0=var1782, $r5=var3549, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2828, $r7=var3061, $r6=var3375, $r8=var2615, java.lang.Object=var3419, $r9=var2803, $r10=var3512, org.apache.dubbo.common.logger.Logger=var2722}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer;	r1 := @parameter0: org.apache.dubbo.config.ConfigCenterConfig;	$r2 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	$r3 = virtualinvoke r1.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String getId()>();	$r4 = virtualinvoke $r2.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getConfigCenter(java.lang.String)>($r3);	$z0 = virtualinvoke $r4.<java.util.Optional: boolean isPresent()>();	if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	$r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	virtualinvoke $r5.<org.apache.dubbo.config.context.ConfigManager: void addConfigCenter(org.apache.dubbo.config.ConfigCenterConfig)>(r1);	$r7 = <org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("use registry as config-center: ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r10);	return
;block_num 2