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

(declare-sort var2671 0)
(declare-sort var750 0)
(declare-sort var3142 0)
(declare-sort var574 0)
(declare-sort var3306 0)
(declare-sort var422 0)
(declare-sort var351 0)
(declare-sort var2753 0)
(declare-sort var2151 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/-678384623 (var750) String)
(declare-fun cast-from-var2671-to-var750 (var2671) var750)
(declare-fun var3142_isEmpty/-813097145 (String) Bool)
(declare-fun applicationContext/1406957930 (var2671) var574)
(declare-fun cast-from-var574-to-var3306 (var574) var3306)
(declare-fun var351_getModuleModel/-210837767 (var3306) var422)
(declare-fun getConfigManager/-335416425 (var422) var2753)
(declare-fun addService/324144651 (var2753 var750) void)
(declare-fun getDeployer/-1501284268 (var422) var2151)
(declare-fun var2151_setPending/-301787792 (var2151) void)
(declare-const null-var2671 var2671)
(declare-const var3437 var2671) ; Statement: r0 := @this: org.apache.dubbo.config.spring.ServiceBean 
(assert (not (= var3437 null-var2671)))
(assert true)
(define-const var3467 String (getPath/-678384623 (cast-from-var2671-to-var750 var3437))) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.spring.ServiceBean: java.lang.String getPath()>() 
(define-const var3185 Bool (var3142_isEmpty/-813097145 var3467)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.spring.ServiceBean: org.springframework.context.ApplicationContext applicationContext> 
(assert (= (ite var3185 1 0) 0)) ; Cond: $z0 == 0 
(define-const var871 var574 (applicationContext/1406957930 var3437)) ; Statement: $r4 = r0.<org.apache.dubbo.config.spring.ServiceBean: org.springframework.context.ApplicationContext applicationContext> 
(define-const var733 var3306 (cast-from-var574-to-var3306 var871)) ; Statement: $r8 = (org.springframework.beans.factory.BeanFactory) $r4 
(define-const var3047 var422 (var351_getModuleModel/-210837767 var733)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.config.spring.util.DubboBeanUtils: org.apache.dubbo.rpc.model.ModuleModel getModuleModel(org.springframework.beans.factory.BeanFactory)>($r8) 
(assert true)
(define-const var3999 var2753 (getConfigManager/-335416425 var3047)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.config.context.ModuleConfigManager getConfigManager()>() 
(assert true)
;(assert (addService/324144651 var3999 (cast-from-var2671-to-var750 var3437))) ; Statement: virtualinvoke $r6.<org.apache.dubbo.config.context.ModuleConfigManager: void addService(org.apache.dubbo.config.ServiceConfigBase)>(r0) 

(declare-const var3999!1 var2753)
(declare-const var3437!1 var2671)
(assert true)
(define-const var700 var2151 (getDeployer/-1501284268 var3047)) ; Statement: $r7 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.deploy.ModuleDeployer getDeployer()>() 
;(assert (var2151_setPending/-301787792 var700)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.deploy.ModuleDeployer: void setPending()>() 

(declare-const var700!1 var2151)
 ; Statement: return 
(check-sat)
; {getPath/-678384623=([org.apache.dubbo.config.ServiceConfigBase], java.lang.String), cast-from-var2671-to-var750=([org.apache.dubbo.config.spring.ServiceBean], org.apache.dubbo.config.ServiceConfigBase), var3142_isEmpty/-813097145=([java.lang.String], boolean), applicationContext/1406957930=([org.apache.dubbo.config.spring.ServiceBean], org.springframework.context.ApplicationContext), cast-from-var574-to-var3306=([org.springframework.context.ApplicationContext], org.springframework.beans.factory.BeanFactory), var351_getModuleModel/-210837767=([org.springframework.beans.factory.BeanFactory], org.apache.dubbo.rpc.model.ModuleModel), getConfigManager/-335416425=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.config.context.ModuleConfigManager), addService/324144651=([org.apache.dubbo.config.context.ModuleConfigManager, org.apache.dubbo.config.ServiceConfigBase], void), getDeployer/-1501284268=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.common.deploy.ModuleDeployer), var2151_setPending/-301787792=([org.apache.dubbo.common.deploy.ModuleDeployer], void)}
; {var2671=org.apache.dubbo.config.spring.ServiceBean, var3437=r0, var750=org.apache.dubbo.config.ServiceConfigBase, var3467=$r1, var3142=org.apache.dubbo.common.utils.StringUtils, var3185=$z0, var574=org.springframework.context.ApplicationContext, var871=$r4, var3306=org.springframework.beans.factory.BeanFactory, var733=$r8, var422=org.apache.dubbo.rpc.model.ModuleModel, var351=org.apache.dubbo.config.spring.util.DubboBeanUtils, var3047=$r5, var2753=org.apache.dubbo.config.context.ModuleConfigManager, var3999=$r6, var2151=org.apache.dubbo.common.deploy.ModuleDeployer, var700=$r7}
; {org.apache.dubbo.config.spring.ServiceBean=var2671, r0=var3437, org.apache.dubbo.config.ServiceConfigBase=var750, $r1=var3467, org.apache.dubbo.common.utils.StringUtils=var3142, $z0=var3185, org.springframework.context.ApplicationContext=var574, $r4=var871, org.springframework.beans.factory.BeanFactory=var3306, $r8=var733, org.apache.dubbo.rpc.model.ModuleModel=var422, org.apache.dubbo.config.spring.util.DubboBeanUtils=var351, $r5=var3047, org.apache.dubbo.config.context.ModuleConfigManager=var2753, $r6=var3999, org.apache.dubbo.common.deploy.ModuleDeployer=var2151, $r7=var700}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.ServiceBean;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.spring.ServiceBean: java.lang.String getPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.spring.ServiceBean: org.springframework.context.ApplicationContext applicationContext>;	$r4 = r0.<org.apache.dubbo.config.spring.ServiceBean: org.springframework.context.ApplicationContext applicationContext>;	$r8 = (org.springframework.beans.factory.BeanFactory) $r4;	$r5 = staticinvoke <org.apache.dubbo.config.spring.util.DubboBeanUtils: org.apache.dubbo.rpc.model.ModuleModel getModuleModel(org.springframework.beans.factory.BeanFactory)>($r8);	$r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.config.context.ModuleConfigManager getConfigManager()>();	virtualinvoke $r6.<org.apache.dubbo.config.context.ModuleConfigManager: void addService(org.apache.dubbo.config.ServiceConfigBase)>(r0);	$r7 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.deploy.ModuleDeployer getDeployer()>();	interfaceinvoke $r7.<org.apache.dubbo.common.deploy.ModuleDeployer: void setPending()>();	return
;block_num 2