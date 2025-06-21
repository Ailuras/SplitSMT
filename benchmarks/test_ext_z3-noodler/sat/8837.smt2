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

(declare-sort var1211 0)
(declare-sort var3536 0)
(declare-sort var1437 0)
(declare-sort var1467 0)
(declare-sort var96 0)
(declare-sort var3573 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun applicationContext/-1480535362 (var1211) var3536)
(declare-fun var3536_containsBean/732272116 (var3536 String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1467_warn/1431914100 (var1467 String String String String) void)
(declare-fun moduleModel/-1480535362 (var1211) var96)
(declare-fun getDeployer/-1501284268 (var96) var3573)
(declare-fun var3573_prepare/-838434578 (var3573) void)
(declare-const null-var1211 var1211)
(declare-const var1437-BEAN_NAME String)
(declare-const var1211-logger var1467)
(declare-const var1537 var1211) ; Statement: r0 := @this: org.apache.dubbo.config.spring.context.DubboConfigApplicationListener 
(assert (not (= var1537 null-var1211)))
(define-const var1851 var3536 (applicationContext/-1480535362 var1537)) ; Statement: $r2 = r0.<org.apache.dubbo.config.spring.context.DubboConfigApplicationListener: org.springframework.context.ApplicationContext applicationContext> 
(define-const var3681 String var1437-BEAN_NAME) ; Statement: $r1 = <org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer: java.lang.String BEAN_NAME> 
(define-const var2989 Bool (var3536_containsBean/732272116 var1851 var3681)) ; Statement: $z0 = interfaceinvoke $r2.<org.springframework.context.ApplicationContext: boolean containsBean(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = <org.apache.dubbo.config.spring.context.DubboConfigApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= (ite var2989 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1532 var1467 var1211-logger) ; Statement: $r4 = <org.apache.dubbo.config.spring.context.DubboConfigApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3956 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3956)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3956!1 String)
(assert (= var3956!1 ""))
(assert true)
(define-const var2520 String (append/672562846 var3956!1 "Bean \u0027")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Bean \'") 
(declare-const var3956!2 String)
(assert (= var3956!2 (str.++ var3956!1 "Bean \u0027")))
(define-const var3723 String var1437-BEAN_NAME) ; Statement: $r5 = <org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer: java.lang.String BEAN_NAME> 
(assert true)
(define-const var1137 String (append/672562846 var2520 var3723)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2520!1 String)
(assert (= var2520!1 (str.++ var2520 var3723)))
(assert true)
(define-const var2116 String (append/672562846 var1137 "\u0027 was not found")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' was not found") 
(declare-const var1137!1 String)
(assert (= var1137!1 (str.++ var1137 "\u0027 was not found")))
(assert true)
(define-const var428 String (toString/-2075883882 var2116)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1467_warn/1431914100 var1532 "5-40" "" "" var428)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-40", "", "", $r9) 

(declare-const var1532!1 var1467)
(declare-const var221 String)
(declare-const var1364 String)
(declare-const var1364!1 String)
(declare-const var428!1 String)
(assert true) ; Non Conditional
(define-const var3746 var96 (moduleModel/-1480535362 var1537)) ; Statement: $r10 = r0.<org.apache.dubbo.config.spring.context.DubboConfigApplicationListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var141 var3573 (getDeployer/-1501284268 var3746)) ; Statement: $r11 = virtualinvoke $r10.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.deploy.ModuleDeployer getDeployer()>() 
;(assert (var3573_prepare/-838434578 var141)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.deploy.ModuleDeployer: void prepare()>() 

(declare-const var141!1 var3573)
 ; Statement: return 
(check-sat)
; {applicationContext/-1480535362=([org.apache.dubbo.config.spring.context.DubboConfigApplicationListener], org.springframework.context.ApplicationContext), var3536_containsBean/732272116=([org.springframework.context.ApplicationContext, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1467_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), moduleModel/-1480535362=([org.apache.dubbo.config.spring.context.DubboConfigApplicationListener], org.apache.dubbo.rpc.model.ModuleModel), getDeployer/-1501284268=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.common.deploy.ModuleDeployer), var3573_prepare/-838434578=([org.apache.dubbo.common.deploy.ModuleDeployer], void)}
; {var1211=org.apache.dubbo.config.spring.context.DubboConfigApplicationListener, var1537=r0, var3536=org.springframework.context.ApplicationContext, var1851=$r2, var1437=org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer, var3681=$r1, var2989=$z0, var1467=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1532=$r4, var3956=$r3, var2520=$r6, var3723=$r5, var1137=$r7, var2116=$r8, var428=$r9, var221="5-40", var1364="", var96=org.apache.dubbo.rpc.model.ModuleModel, var3746=$r10, var3573=org.apache.dubbo.common.deploy.ModuleDeployer, var141=$r11}
; {org.apache.dubbo.config.spring.context.DubboConfigApplicationListener=var1211, r0=var1537, org.springframework.context.ApplicationContext=var3536, $r2=var1851, org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer=var1437, $r1=var3681, $z0=var2989, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1467, $r4=var1532, $r3=var3956, $r6=var2520, $r5=var3723, $r7=var1137, $r8=var2116, $r9=var428, "5-40"=var221, ""=var1364, org.apache.dubbo.rpc.model.ModuleModel=var96, $r10=var3746, org.apache.dubbo.common.deploy.ModuleDeployer=var3573, $r11=var141}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.context.DubboConfigApplicationListener;	$r2 = r0.<org.apache.dubbo.config.spring.context.DubboConfigApplicationListener: org.springframework.context.ApplicationContext applicationContext>;	$r1 = <org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer: java.lang.String BEAN_NAME>;	$z0 = interfaceinvoke $r2.<org.springframework.context.ApplicationContext: boolean containsBean(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = <org.apache.dubbo.config.spring.context.DubboConfigApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = <org.apache.dubbo.config.spring.context.DubboConfigApplicationListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Bean \'");	$r5 = <org.apache.dubbo.config.spring.context.DubboConfigBeanInitializer: java.lang.String BEAN_NAME>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' was not found");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-40", "", "", $r9);	$r10 = r0.<org.apache.dubbo.config.spring.context.DubboConfigApplicationListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r11 = virtualinvoke $r10.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.deploy.ModuleDeployer getDeployer()>();	interfaceinvoke $r11.<org.apache.dubbo.common.deploy.ModuleDeployer: void prepare()>();	return
;block_num 3