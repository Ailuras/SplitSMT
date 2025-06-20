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

(declare-sort var3952 0)
(declare-sort var1451 0)
(declare-sort var2835 0)
(declare-sort var876 0)
(declare-sort var3044 0)
(declare-sort var429 0)
(declare-sort var504 0)
(declare-sort var3959 0)
(declare-sort var267 0)
(declare-sort var2357 0)
(declare-sort var2295 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun moduleModel/1192063995 (var3952) var1451)
(declare-fun getApplicationModel/723682732 (var1451) var2835)
(declare-fun getApplicationConfigManager/1850072349 (var2835) var876)
(declare-fun getApplication/-787724749 (var876) var3044)
(declare-fun var504_bootstrap$/-794421272 () var429)
(declare-fun map/1305667865 (var3044 var429) var3044)
(declare-fun orElse/-757175127 (var3044 var3959) var3959)
(declare-fun cast-from-var3959-to-String (var3959) String)
(declare-fun var2357_isEmpty/-813097145 (String) Bool)
(declare-fun var267_valueOf/472746352 (String) var267)
(declare-const null-var3952 var3952)
(declare-const null-NullType var2295)
(declare-const null-var3959 var3959)
(declare-const null-var267 var267)
(declare-const var1692 var3952) ; Statement: r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator 
(assert (not (= var1692 null-var3952)))
(define-const var3296 var1451 (moduleModel/1192063995 var1692)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.SerializeSecurityConfigurator: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var646 var2835 (getApplicationModel/723682732 var3296)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var1933 var876 (getApplicationConfigManager/1850072349 var646)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>() 
(assert true)
(define-const var1094 var3044 (getApplication/-787724749 var1933)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getApplication()>() 
(define-const var3256 var429 var504_bootstrap$/-794421272) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.utils.SerializeSecurityConfigurator$getSerializeCheckStatus__288: java.util.function.Function bootstrap$()>() 
(assert true)
(define-const var485 var3044 (map/1305667865 var1094 var3256)) ; Statement: $r6 = virtualinvoke r4.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r5) 
(assert true)
(define-const var1829 var3959 (orElse/-757175127 var485 null-var3959)) ; Statement: $r7 = virtualinvoke $r6.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null) 
(define-const var3111 String (cast-from-var3959-to-String var1829)) ; Statement: r8 = (java.lang.String) $r7 
(define-const var372 var267 null-var267) ; Statement: r12 = null 
(define-const var2621 Bool (var2357_isEmpty/-813097145 var3111)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8) 
 ; Statement: if $z0 == 0 goto r12 = staticinvoke <org.apache.dubbo.common.utils.SerializeCheckStatus: org.apache.dubbo.common.utils.SerializeCheckStatus valueOf(java.lang.String)>(r8) 
(assert (= (ite var2621 1 0) 0)) ; Cond: $z0 == 0 
(define-const var372!1 var267 (var267_valueOf/472746352 var3111)) ; Statement: r12 = staticinvoke <org.apache.dubbo.common.utils.SerializeCheckStatus: org.apache.dubbo.common.utils.SerializeCheckStatus valueOf(java.lang.String)>(r8) 
(assert true) ; Non Conditional
 ; Statement: if r12 == null goto return 
(assert (= var372!1 null-var267)) ; Cond: r12 == null 
 ; Statement: return 
(check-sat)
; {moduleModel/1192063995=([org.apache.dubbo.common.utils.SerializeSecurityConfigurator], org.apache.dubbo.rpc.model.ModuleModel), getApplicationModel/723682732=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ApplicationModel), getApplicationConfigManager/1850072349=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.context.ConfigManager), getApplication/-787724749=([org.apache.dubbo.config.context.ConfigManager], java.util.Optional), var504_bootstrap$/-794421272=([], java.util.function.Function), map/1305667865=([java.util.Optional, java.util.function.Function], java.util.Optional), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var3959-to-String=([java.lang.Object], java.lang.String), var2357_isEmpty/-813097145=([java.lang.String], boolean), var267_valueOf/472746352=([java.lang.String], org.apache.dubbo.common.utils.SerializeCheckStatus)}
; {var3952=org.apache.dubbo.common.utils.SerializeSecurityConfigurator, var1692=r0, var1451=org.apache.dubbo.rpc.model.ModuleModel, var3296=$r1, var2835=org.apache.dubbo.rpc.model.ApplicationModel, var646=$r2, var876=org.apache.dubbo.config.context.ConfigManager, var1933=$r3, var3044=java.util.Optional, var1094=r4, var429=java.util.function.Function, var504=org.apache.dubbo.common.utils.SerializeSecurityConfigurator$getSerializeCheckStatus__288, var3256=$r5, var485=$r6, var3959=java.lang.Object, var1829=$r7, var3111=r8, var267=org.apache.dubbo.common.utils.SerializeCheckStatus, var372=r12, var2357=org.apache.dubbo.common.utils.StringUtils, var2621=$z0, var2295=null_type}
; {org.apache.dubbo.common.utils.SerializeSecurityConfigurator=var3952, r0=var1692, org.apache.dubbo.rpc.model.ModuleModel=var1451, $r1=var3296, org.apache.dubbo.rpc.model.ApplicationModel=var2835, $r2=var646, org.apache.dubbo.config.context.ConfigManager=var876, $r3=var1933, java.util.Optional=var3044, r4=var1094, java.util.function.Function=var429, org.apache.dubbo.common.utils.SerializeSecurityConfigurator$getSerializeCheckStatus__288=var504, $r5=var3256, $r6=var485, java.lang.Object=var3959, $r7=var1829, r8=var3111, org.apache.dubbo.common.utils.SerializeCheckStatus=var267, r12=var372, org.apache.dubbo.common.utils.StringUtils=var2357, $z0=var2621, null_type=var2295}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator;	$r1 = r0.<org.apache.dubbo.common.utils.SerializeSecurityConfigurator: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>();	r4 = virtualinvoke $r3.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getApplication()>();	$r5 = staticinvoke <org.apache.dubbo.common.utils.SerializeSecurityConfigurator$getSerializeCheckStatus__288: java.util.function.Function bootstrap$()>();	$r6 = virtualinvoke r4.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r5);	$r7 = virtualinvoke $r6.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null);	r8 = (java.lang.String) $r7;	r12 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8);	if $z0 == 0 goto r12 = staticinvoke <org.apache.dubbo.common.utils.SerializeCheckStatus: org.apache.dubbo.common.utils.SerializeCheckStatus valueOf(java.lang.String)>(r8);	r12 = staticinvoke <org.apache.dubbo.common.utils.SerializeCheckStatus: org.apache.dubbo.common.utils.SerializeCheckStatus valueOf(java.lang.String)>(r8);	if r12 == null goto return;	return
;block_num 4