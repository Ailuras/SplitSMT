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

(declare-sort var1257 0)
(declare-sort var3844 0)
(declare-sort var1658 0)
(declare-sort var1076 0)
(declare-sort var2612 0)
(declare-sort var1830 0)
(declare-sort var153 0)
(declare-sort var3281 0)
(declare-sort var2743 0)
(declare-sort var2314 0)
(declare-sort var3731 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun setRegistry/166282311 (var1257 var3844) void)
(declare-fun setBeanFactory/1226431556 (var1257 var1658) void)
(declare-fun var1076_customize/235656301 (var1257) void)
(declare-fun getModuleModel/-2135133257 (var1257) var2612)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getDesc/-1571219874 (var153) String)
(declare-fun cast-from-var2612-to-var153 (var2612) var153)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1830_info/484404803 (var1830 String) void)
(declare-fun var3281_identityToString/-563384262 (var2743) String)
(declare-fun cast-from-var3844-to-var2743 (var3844) var2743)
(declare-fun getModuleAttributes/13128384 (var1257) var2314)
(declare-fun var2314_size/-1594421051 (var2314) Int)
(declare-fun var1076_registerContextBeans/-1975467542 (var1658 var1257) void)
(declare-fun markAsBound/-6724142 (var1257) void)
(declare-fun setLifeCycleManagedExternally/-1559150941 (var2612 Bool) void)
(declare-fun var3731_useGeneratedArtifacts/1913282522 () Bool)
(declare-const null-var1257 var1257)
(declare-const null-var3844 var3844)
(declare-const null-var1658 var1658)
(declare-const null-var2612 var2612)
(declare-const var1076-logger var1830)
(declare-const var2293 var1257) ; Statement: r0 := @parameter0: org.apache.dubbo.config.spring.context.DubboSpringInitContext 
(assert (not (= var2293 null-var1257)))
(declare-const var2252 var3844) ; Statement: r1 := @parameter1: org.springframework.beans.factory.support.BeanDefinitionRegistry 
(assert (not (= var2252 null-var3844)))
(declare-const var3419 var1658) ; Statement: r2 := @parameter2: org.springframework.beans.factory.config.ConfigurableListableBeanFactory 
(assert (not (= var3419 null-var1658)))
(assert true)
;(assert (setRegistry/166282311 var2293 var2252)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: void setRegistry(org.springframework.beans.factory.support.BeanDefinitionRegistry)>(r1) 

(declare-const var2293!1 var1257)
(declare-const var2252!1 var3844)
(assert true)
;(assert (setBeanFactory/1226431556 var2293!1 var3419)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: void setBeanFactory(org.springframework.beans.factory.config.ConfigurableListableBeanFactory)>(r2) 

(declare-const var2293!2 var1257)
(declare-const var3419!1 var1658)
;(assert (var1076_customize/235656301 var2293!2)) ; Statement: staticinvoke <org.apache.dubbo.config.spring.context.DubboSpringInitializer: void customize(org.apache.dubbo.config.spring.context.DubboSpringInitContext)>(r0) 

(declare-const var2293!3 var1257)
(assert true)
(define-const var2137 var2612 (getModuleModel/-2135133257 var2293!3)) ; Statement: r42 = virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: org.apache.dubbo.rpc.model.ModuleModel getModuleModel()>() 
 ; Statement: if r42 != null goto $r4 = <org.apache.dubbo.config.spring.context.DubboSpringInitializer: org.apache.dubbo.common.logger.Logger logger> 
(assert (not (= var2137 null-var2612))) ; Cond: r42 != null 
(define-const var1783 var1830 var1076-logger) ; Statement: $r4 = <org.apache.dubbo.config.spring.context.DubboSpringInitializer: org.apache.dubbo.common.logger.Logger logger> 
(define-const var2156 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2156)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2156!1 String)
(assert (= var2156!1 ""))
(assert true)
(define-const var1805 String (append/672562846 var2156!1 "Use module model from customizer: ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Use module model from customizer: ") 
(declare-const var2156!2 String)
(assert (= var2156!2 (str.++ var2156!1 "Use module model from customizer: ")))
(assert true)
(define-const var439 String (getDesc/-1571219874 (cast-from-var2612-to-var153 var2137))) ; Statement: $r5 = virtualinvoke r42.<org.apache.dubbo.rpc.model.ModuleModel: java.lang.String getDesc()>() 
(assert true)
(define-const var1622 String (append/672562846 var1805 var439)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1805!1 String)
(assert (= var1805!1 (str.++ var1805 var439)))
(assert true)
(define-const var3633 String (toString/-2075883882 var1622)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1830_info/484404803 var1783 var3633)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r8) 

(declare-const var1783!1 var1830)
(declare-const var3633!1 String)
(assert true) ; Non Conditional
(define-const var1964 var1830 var1076-logger) ; Statement: $r10 = <org.apache.dubbo.config.spring.context.DubboSpringInitializer: org.apache.dubbo.common.logger.Logger logger> 
(define-const var1946 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1946)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1946!1 String)
(assert (= var1946!1 ""))
(assert true)
(define-const var228 String (append/672562846 var1946!1 "Bind ")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Bind ") 
(declare-const var1946!2 String)
(assert (= var1946!2 (str.++ var1946!1 "Bind ")))
(assert true)
(define-const var3317 String (getDesc/-1571219874 (cast-from-var2612-to-var153 var2137))) ; Statement: $r11 = virtualinvoke r42.<org.apache.dubbo.rpc.model.ModuleModel: java.lang.String getDesc()>() 
(assert true)
(define-const var1854 String (append/672562846 var228 var3317)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var228!1 String)
(assert (= var228!1 (str.++ var228 var3317)))
(assert true)
(define-const var2805 String (append/672562846 var1854 " to spring container: ")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to spring container: ") 
(declare-const var1854!1 String)
(assert (= var1854!1 (str.++ var1854 " to spring container: ")))
(define-const var3783 String (var3281_identityToString/-563384262 (cast-from-var3844-to-var2743 var2252!1))) ; Statement: $r14 = staticinvoke <org.springframework.util.ObjectUtils: java.lang.String identityToString(java.lang.Object)>(r1) 
(assert true)
(define-const var1573 String (append/672562846 var2805 var3783)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var2805!1 String)
(assert (= var2805!1 (str.++ var2805 var3783)))
(assert true)
(define-const var2653 String (toString/-2075883882 var1573)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1830_info/484404803 var1964 var2653)) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r17) 

(declare-const var1964!1 var1830)
(declare-const var2653!1 String)
(assert true)
(define-const var3916 var2314 (getModuleAttributes/13128384 var2293!3)) ; Statement: $r34 = virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: java.util.Map getModuleAttributes()>() 
(define-const var1997 Int (var2314_size/-1594421051 var3916)) ; Statement: $i0 = interfaceinvoke $r34.<java.util.Map: int size()>() 
 ; Statement: if $i0 <= 0 goto staticinvoke <org.apache.dubbo.config.spring.context.DubboSpringInitializer: void registerContextBeans(org.springframework.beans.factory.config.ConfigurableListableBeanFactory,org.apache.dubbo.config.spring.context.DubboSpringInitContext)>(r2, r0) 
(assert (<= var1997 0)) ; Cond: $i0 <= 0 
;(assert (var1076_registerContextBeans/-1975467542 var3419!1 var2293!3)) ; Statement: staticinvoke <org.apache.dubbo.config.spring.context.DubboSpringInitializer: void registerContextBeans(org.springframework.beans.factory.config.ConfigurableListableBeanFactory,org.apache.dubbo.config.spring.context.DubboSpringInitContext)>(r2, r0) 

(declare-const var3419!2 var1658)
(declare-const var2293!4 var1257)
(assert true)
;(assert (markAsBound/-6724142 var2293!4)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: void markAsBound()>() 

(declare-const var2293!5 var1257)
(assert true)
;(assert (setLifeCycleManagedExternally/-1559150941 var2137 (ite (= 1 1) true false))) ; Statement: virtualinvoke r42.<org.apache.dubbo.rpc.model.ModuleModel: void setLifeCycleManagedExternally(boolean)>(1) 

(declare-const var2137!1 var2612)
(declare-const var1664 Int)
(define-const var2094 Bool var3731_useGeneratedArtifacts/1913282522) ; Statement: $z0 = staticinvoke <org.apache.dubbo.config.spring.aot.AotWithSpringDetector: boolean useGeneratedArtifacts()>() 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var2094 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {setRegistry/166282311=([org.apache.dubbo.config.spring.context.DubboSpringInitContext, org.springframework.beans.factory.support.BeanDefinitionRegistry], void), setBeanFactory/1226431556=([org.apache.dubbo.config.spring.context.DubboSpringInitContext, org.springframework.beans.factory.config.ConfigurableListableBeanFactory], void), var1076_customize/235656301=([org.apache.dubbo.config.spring.context.DubboSpringInitContext], void), getModuleModel/-2135133257=([org.apache.dubbo.config.spring.context.DubboSpringInitContext], org.apache.dubbo.rpc.model.ModuleModel), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getDesc/-1571219874=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), cast-from-var2612-to-var153=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1830_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), var3281_identityToString/-563384262=([java.lang.Object], java.lang.String), cast-from-var3844-to-var2743=([org.springframework.beans.factory.support.BeanDefinitionRegistry], java.lang.Object), getModuleAttributes/13128384=([org.apache.dubbo.config.spring.context.DubboSpringInitContext], java.util.Map), var2314_size/-1594421051=([java.util.Map], int), var1076_registerContextBeans/-1975467542=([org.springframework.beans.factory.config.ConfigurableListableBeanFactory, org.apache.dubbo.config.spring.context.DubboSpringInitContext], void), markAsBound/-6724142=([org.apache.dubbo.config.spring.context.DubboSpringInitContext], void), setLifeCycleManagedExternally/-1559150941=([org.apache.dubbo.rpc.model.ModuleModel, boolean], void), var3731_useGeneratedArtifacts/1913282522=([], boolean)}
; {var1257=org.apache.dubbo.config.spring.context.DubboSpringInitContext, var2293=r0, var3844=org.springframework.beans.factory.support.BeanDefinitionRegistry, var2252=r1, var1658=org.springframework.beans.factory.config.ConfigurableListableBeanFactory, var3419=r2, var1076=org.apache.dubbo.config.spring.context.DubboSpringInitializer, var2612=org.apache.dubbo.rpc.model.ModuleModel, var2137=r42, var1830=org.apache.dubbo.common.logger.Logger, var1783=$r4, var2156=$r3, var1805=$r6, var153=org.apache.dubbo.rpc.model.ScopeModel, var439=$r5, var1622=$r7, var3633=$r8, var1964=$r10, var1946=$r9, var228=$r12, var3317=$r11, var1854=$r13, var2805=$r15, var3281=org.springframework.util.ObjectUtils, var2743=java.lang.Object, var3783=$r14, var1573=$r16, var2653=$r17, var2314=java.util.Map, var3916=$r34, var1997=$i0, var1664=1, var3731=org.apache.dubbo.config.spring.aot.AotWithSpringDetector, var2094=$z0}
; {org.apache.dubbo.config.spring.context.DubboSpringInitContext=var1257, r0=var2293, org.springframework.beans.factory.support.BeanDefinitionRegistry=var3844, r1=var2252, org.springframework.beans.factory.config.ConfigurableListableBeanFactory=var1658, r2=var3419, org.apache.dubbo.config.spring.context.DubboSpringInitializer=var1076, org.apache.dubbo.rpc.model.ModuleModel=var2612, r42=var2137, org.apache.dubbo.common.logger.Logger=var1830, $r4=var1783, $r3=var2156, $r6=var1805, org.apache.dubbo.rpc.model.ScopeModel=var153, $r5=var439, $r7=var1622, $r8=var3633, $r10=var1964, $r9=var1946, $r12=var228, $r11=var3317, $r13=var1854, $r15=var2805, org.springframework.util.ObjectUtils=var3281, java.lang.Object=var2743, $r14=var3783, $r16=var1573, $r17=var2653, java.util.Map=var2314, $r34=var3916, $i0=var1997, 1=var1664, org.apache.dubbo.config.spring.aot.AotWithSpringDetector=var3731, $z0=var2094}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @parameter0: org.apache.dubbo.config.spring.context.DubboSpringInitContext;	r1 := @parameter1: org.springframework.beans.factory.support.BeanDefinitionRegistry;	r2 := @parameter2: org.springframework.beans.factory.config.ConfigurableListableBeanFactory;	virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: void setRegistry(org.springframework.beans.factory.support.BeanDefinitionRegistry)>(r1);	virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: void setBeanFactory(org.springframework.beans.factory.config.ConfigurableListableBeanFactory)>(r2);	staticinvoke <org.apache.dubbo.config.spring.context.DubboSpringInitializer: void customize(org.apache.dubbo.config.spring.context.DubboSpringInitContext)>(r0);	r42 = virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: org.apache.dubbo.rpc.model.ModuleModel getModuleModel()>();	if r42 != null goto $r4 = <org.apache.dubbo.config.spring.context.DubboSpringInitializer: org.apache.dubbo.common.logger.Logger logger>;	$r4 = <org.apache.dubbo.config.spring.context.DubboSpringInitializer: org.apache.dubbo.common.logger.Logger logger>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Use module model from customizer: ");	$r5 = virtualinvoke r42.<org.apache.dubbo.rpc.model.ModuleModel: java.lang.String getDesc()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r8);	$r10 = <org.apache.dubbo.config.spring.context.DubboSpringInitializer: org.apache.dubbo.common.logger.Logger logger>;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Bind ");	$r11 = virtualinvoke r42.<org.apache.dubbo.rpc.model.ModuleModel: java.lang.String getDesc()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to spring container: ");	$r14 = staticinvoke <org.springframework.util.ObjectUtils: java.lang.String identityToString(java.lang.Object)>(r1);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r10.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r17);	$r34 = virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: java.util.Map getModuleAttributes()>();	$i0 = interfaceinvoke $r34.<java.util.Map: int size()>();	if $i0 <= 0 goto staticinvoke <org.apache.dubbo.config.spring.context.DubboSpringInitializer: void registerContextBeans(org.springframework.beans.factory.config.ConfigurableListableBeanFactory,org.apache.dubbo.config.spring.context.DubboSpringInitContext)>(r2, r0);	staticinvoke <org.apache.dubbo.config.spring.context.DubboSpringInitializer: void registerContextBeans(org.springframework.beans.factory.config.ConfigurableListableBeanFactory,org.apache.dubbo.config.spring.context.DubboSpringInitContext)>(r2, r0);	virtualinvoke r0.<org.apache.dubbo.config.spring.context.DubboSpringInitContext: void markAsBound()>();	virtualinvoke r42.<org.apache.dubbo.rpc.model.ModuleModel: void setLifeCycleManagedExternally(boolean)>(1);	$z0 = staticinvoke <org.apache.dubbo.config.spring.aot.AotWithSpringDetector: boolean useGeneratedArtifacts()>();	if $z0 != 0 goto return;	return
;block_num 5