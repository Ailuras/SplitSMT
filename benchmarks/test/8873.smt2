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

(declare-sort var729 0)
(declare-sort var697 0)
(declare-sort var2354 0)
(declare-sort var1592 0)
(declare-sort var2502 0)
(declare-sort var2095 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun applicationContext/2023641114 (var729) var697)
(declare-fun var697_containsBean/732272116 (var697 String) Bool)
(declare-fun logger/2023641114 (var729) var1592)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1592_warn/1431914100 (var1592 String String String String) void)
(declare-fun moduleModel/2023641114 (var729) var2502)
(declare-fun getDeployer/-1501284268 (var2502) var2095)
(declare-fun var2095_initialize/-1994367275 (var2095) void)
(declare-const null-var729 var729)
(declare-const var2354-BEAN_NAME String)
(declare-const var1219 var729) ; Statement: r0 := @this: org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener 
(assert (not (= var1219 null-var729)))
(define-const var1092 var697 (applicationContext/2023641114 var1219)) ; Statement: $r2 = r0.<org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener: org.springframework.context.ApplicationContext applicationContext> 
(define-const var1627 String var2354-BEAN_NAME) ; Statement: $r1 = <org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer: java.lang.String BEAN_NAME> 
(define-const var3687 Bool (var697_containsBean/732272116 var1092 var1627)) ; Statement: $z0 = interfaceinvoke $r2.<org.springframework.context.ApplicationContext: boolean containsBean(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= (ite var3687 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2902 var1592 (logger/2023641114 var1219)) ; Statement: $r4 = r0.<org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3156 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3156)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3156!1 String)
(assert (= var3156!1 ""))
(assert true)
(define-const var1967 String (append/672562846 var3156!1 "Bean \u0027")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Bean \'") 
(declare-const var3156!2 String)
(assert (= var3156!2 (str.++ var3156!1 "Bean \u0027")))
(define-const var2024 String var2354-BEAN_NAME) ; Statement: $r5 = <org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer: java.lang.String BEAN_NAME> 
(assert true)
(define-const var856 String (append/672562846 var1967 var2024)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1967!1 String)
(assert (= var1967!1 (str.++ var1967 var2024)))
(assert true)
(define-const var944 String (append/672562846 var856 "\u0027 was not found")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' was not found") 
(declare-const var856!1 String)
(assert (= var856!1 (str.++ var856 "\u0027 was not found")))
(assert true)
(define-const var825 String (toString/-2075883882 var944)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1592_warn/1431914100 var2902 "5-40" "" "" var825)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-40", "", "", $r9) 

(declare-const var2902!1 var1592)
(declare-const var1772 String)
(declare-const var2396 String)
(declare-const var2396!1 String)
(declare-const var825!1 String)
(assert true) ; Non Conditional
(define-const var2857 var2502 (moduleModel/2023641114 var1219)) ; Statement: $r10 = r0.<org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var2034 var2095 (getDeployer/-1501284268 var2857)) ; Statement: $r11 = virtualinvoke $r10.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.deploy.ModuleDeployer getDeployer()>() 
;(assert (var2095_initialize/-1994367275 var2034)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.deploy.ModuleDeployer: void initialize()>() 

(declare-const var2034!1 var2095)
 ; Statement: return 
(check-sat)
; {applicationContext/2023641114=([org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener], org.springframework.context.ApplicationContext), var697_containsBean/732272116=([org.springframework.context.ApplicationContext, java.lang.String], boolean), logger/2023641114=([org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1592_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), moduleModel/2023641114=([org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener], org.apache.dubbo.rpc.model.ModuleModel), getDeployer/-1501284268=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.common.deploy.ModuleDeployer), var2095_initialize/-1994367275=([org.apache.dubbo.common.deploy.ModuleDeployer], void)}
; {var729=org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener, var1219=r0, var697=org.springframework.context.ApplicationContext, var1092=$r2, var2354=org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer, var1627=$r1, var3687=$z0, var1592=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2902=$r4, var3156=$r3, var1967=$r6, var2024=$r5, var856=$r7, var944=$r8, var825=$r9, var1772="5-40", var2396="", var2502=org.apache.dubbo.rpc.model.ModuleModel, var2857=$r10, var2095=org.apache.dubbo.common.deploy.ModuleDeployer, var2034=$r11}
; {org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener=var729, r0=var1219, org.springframework.context.ApplicationContext=var697, $r2=var1092, org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer=var2354, $r1=var1627, $z0=var3687, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1592, $r4=var2902, $r3=var3156, $r6=var1967, $r5=var2024, $r7=var856, $r8=var944, $r9=var825, "5-40"=var1772, ""=var2396, org.apache.dubbo.rpc.model.ModuleModel=var2502, $r10=var2857, org.apache.dubbo.common.deploy.ModuleDeployer=var2095, $r11=var2034}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener;	$r2 = r0.<org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener: org.springframework.context.ApplicationContext applicationContext>;	$r1 = <org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer: java.lang.String BEAN_NAME>;	$z0 = interfaceinvoke $r2.<org.springframework.context.ApplicationContext: boolean containsBean(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = r0.<org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Bean \'");	$r5 = <org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer: java.lang.String BEAN_NAME>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' was not found");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-40", "", "", $r9);	$r10 = r0.<org.apache.dubbo.config.spring.context.DubboBootstrapApplicationListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r11 = virtualinvoke $r10.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.deploy.ModuleDeployer getDeployer()>();	interfaceinvoke $r11.<org.apache.dubbo.common.deploy.ModuleDeployer: void initialize()>();	return
;block_num 3