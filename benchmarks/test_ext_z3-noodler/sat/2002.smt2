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

(declare-sort var1990 0)
(declare-sort var3358 0)
(declare-sort var2300 0)
(declare-sort var2933 0)
(declare-sort var3424 0)
(declare-sort var623 0)
(declare-sort var3232 0)
(declare-sort var32 0)
(declare-sort var3786 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var623!class ClassObject)
(declare-fun var2300_getScopeModelOrDefaultApplicationModel/1426495981 (var1990) var1990)
(declare-fun getBeanFactory/819046718 (var1990) var2933)
(declare-fun getBean/643676830 (var2933 ClassObject) var3424)
(declare-fun cast-from-var3424-to-var623 (var3424) var623)
(declare-fun var32_bootstrap$/-638509817 (var1990) var3232)
(declare-fun computeIfAbsent/-1668886163 (var623 String var3232) String)
(declare-fun var3786_isEmpty/-813097145 (String) Bool)
(declare-const null-var1990 var1990)
(declare-const null-String String)
(declare-const var1311 var1990) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var1311 null-var1990)))
(declare-const var2514 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var2514 null-String)))
(declare-const var3025 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var3025 null-String)))
(define-const var3606 var1990 (var2300_getScopeModelOrDefaultApplicationModel/1426495981 var1311)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.rpc.model.ScopeModel getScopeModelOrDefaultApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>(r0) 
(assert true)
(define-const var2220 var2933 (getBeanFactory/819046718 var3606)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ScopeModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>() 
(assert true)
(define-const var1991 var3424 (getBean/643676830 var2220 var623!class)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/common/config/ConfigurationCache;") 
(define-const var1238 var623 (cast-from-var3424-to-var623 var1991)) ; Statement: r4 = (org.apache.dubbo.common.config.ConfigurationCache) $r3 
(define-const var641 var3232 (var32_bootstrap$/-638509817 var3606)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils$lambda_getCachedDynamicProperty_0__145: java.util.function.Function bootstrap$(org.apache.dubbo.rpc.model.ScopeModel)>(r1) 
(assert true)
(define-const var3059 String (computeIfAbsent/-1668886163 var1238 var2514 var641)) ; Statement: r7 = virtualinvoke r4.<org.apache.dubbo.common.config.ConfigurationCache: java.lang.String computeIfAbsent(java.lang.String,java.util.function.Function)>(r5, $r6) 
(define-const var2342 Bool (var3786_isEmpty/-813097145 var3059)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7) 
 ; Statement: if $z0 == 0 goto $r9 = r7 
(assert (= (ite var2342 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2560 String var3059) ; Statement: $r9 = r7 
(assert true) ; Non Conditional
 ; Statement: return $r9 
(check-sat)
; {var2300_getScopeModelOrDefaultApplicationModel/1426495981=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.ScopeModel), getBeanFactory/819046718=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.beans.factory.ScopeBeanFactory), getBean/643676830=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.Class], java.lang.Object), cast-from-var3424-to-var623=([java.lang.Object], org.apache.dubbo.common.config.ConfigurationCache), var32_bootstrap$/-638509817=([org.apache.dubbo.rpc.model.ScopeModel], java.util.function.Function), computeIfAbsent/-1668886163=([org.apache.dubbo.common.config.ConfigurationCache, java.lang.String, java.util.function.Function], java.lang.String), var3786_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1990=org.apache.dubbo.rpc.model.ScopeModel, var1311=r0, var2514=r5, var3358=null_type, var3025=r8, var2300=org.apache.dubbo.common.config.ConfigurationUtils, var3606=r1, var2933=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var2220=$r2, var3424=java.lang.Object, var623=org.apache.dubbo.common.config.ConfigurationCache, var1991=$r3, var1238=r4, var3232=java.util.function.Function, var32=org.apache.dubbo.common.config.ConfigurationUtils$lambda_getCachedDynamicProperty_0__145, var641=$r6, var3059=r7, var3786=org.apache.dubbo.common.utils.StringUtils, var2342=$z0, var2560=$r9}
; {org.apache.dubbo.rpc.model.ScopeModel=var1990, r0=var1311, r5=var2514, null_type=var3358, r8=var3025, org.apache.dubbo.common.config.ConfigurationUtils=var2300, r1=var3606, org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var2933, $r2=var2220, java.lang.Object=var3424, org.apache.dubbo.common.config.ConfigurationCache=var623, $r3=var1991, r4=var1238, java.util.function.Function=var3232, org.apache.dubbo.common.config.ConfigurationUtils$lambda_getCachedDynamicProperty_0__145=var32, $r6=var641, r7=var3059, org.apache.dubbo.common.utils.StringUtils=var3786, $z0=var2342, $r9=var2560}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	r5 := @parameter1: java.lang.String;	r8 := @parameter2: java.lang.String;	r1 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.rpc.model.ScopeModel getScopeModelOrDefaultApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>(r0);	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ScopeModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/common/config/ConfigurationCache;");	r4 = (org.apache.dubbo.common.config.ConfigurationCache) $r3;	$r6 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils$lambda_getCachedDynamicProperty_0__145: java.util.function.Function bootstrap$(org.apache.dubbo.rpc.model.ScopeModel)>(r1);	r7 = virtualinvoke r4.<org.apache.dubbo.common.config.ConfigurationCache: java.lang.String computeIfAbsent(java.lang.String,java.util.function.Function)>(r5, $r6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7);	if $z0 == 0 goto $r9 = r7;	$r9 = r7;	return $r9
;block_num 3