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

(declare-sort var3509 0)
(declare-sort var3350 0)
(declare-sort var1534 0)
(declare-sort var3546 0)
(declare-sort var1679 0)
(declare-sort var3843 0)
(declare-sort var1650 0)
(declare-sort var43 0)
(declare-sort var1315 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3843!class ClassObject)
(declare-fun var1534_getScopeModelOrDefaultApplicationModel/1426495981 (var3509) var3509)
(declare-fun getBeanFactory/819046718 (var3509) var3546)
(declare-fun getBean/643676830 (var3546 ClassObject) var1679)
(declare-fun cast-from-var1679-to-var3843 (var1679) var3843)
(declare-fun var43_bootstrap$/-638509817 (var3509) var1650)
(declare-fun computeIfAbsent/-1668886163 (var3843 String var1650) String)
(declare-fun var1315_isEmpty/-813097145 (String) Bool)
(declare-const null-var3509 var3509)
(declare-const null-String String)
(declare-const var1610 var3509) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var1610 null-var3509)))
(declare-const var2810 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var2810 null-String)))
(declare-const var3891 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var3891 null-String)))
(define-const var3047 var3509 (var1534_getScopeModelOrDefaultApplicationModel/1426495981 var1610)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.rpc.model.ScopeModel getScopeModelOrDefaultApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>(r0) 
(assert true)
(define-const var2620 var3546 (getBeanFactory/819046718 var3047)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ScopeModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>() 
(assert true)
(define-const var2196 var1679 (getBean/643676830 var2620 var3843!class)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/common/config/ConfigurationCache;") 
(define-const var1182 var3843 (cast-from-var1679-to-var3843 var2196)) ; Statement: r4 = (org.apache.dubbo.common.config.ConfigurationCache) $r3 
(define-const var138 var1650 (var43_bootstrap$/-638509817 var3047)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils$lambda_getCachedDynamicProperty_0__145: java.util.function.Function bootstrap$(org.apache.dubbo.rpc.model.ScopeModel)>(r1) 
(assert true)
(define-const var312 String (computeIfAbsent/-1668886163 var1182 var2810 var138)) ; Statement: r7 = virtualinvoke r4.<org.apache.dubbo.common.config.ConfigurationCache: java.lang.String computeIfAbsent(java.lang.String,java.util.function.Function)>(r5, $r6) 
(define-const var3263 Bool (var1315_isEmpty/-813097145 var312)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7) 
 ; Statement: if $z0 == 0 goto $r9 = r7 
(assert (not (= (ite var3263 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3352 String var3891) ; Statement: $r9 = r8 
 ; Statement: goto [?= return $r9] 
(assert true) ; Non Conditional
 ; Statement: return $r9 
(check-sat)
; {var1534_getScopeModelOrDefaultApplicationModel/1426495981=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.ScopeModel), getBeanFactory/819046718=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.beans.factory.ScopeBeanFactory), getBean/643676830=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.Class], java.lang.Object), cast-from-var1679-to-var3843=([java.lang.Object], org.apache.dubbo.common.config.ConfigurationCache), var43_bootstrap$/-638509817=([org.apache.dubbo.rpc.model.ScopeModel], java.util.function.Function), computeIfAbsent/-1668886163=([org.apache.dubbo.common.config.ConfigurationCache, java.lang.String, java.util.function.Function], java.lang.String), var1315_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3509=org.apache.dubbo.rpc.model.ScopeModel, var1610=r0, var2810=r5, var3350=null_type, var3891=r8, var1534=org.apache.dubbo.common.config.ConfigurationUtils, var3047=r1, var3546=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var2620=$r2, var1679=java.lang.Object, var3843=org.apache.dubbo.common.config.ConfigurationCache, var2196=$r3, var1182=r4, var1650=java.util.function.Function, var43=org.apache.dubbo.common.config.ConfigurationUtils$lambda_getCachedDynamicProperty_0__145, var138=$r6, var312=r7, var1315=org.apache.dubbo.common.utils.StringUtils, var3263=$z0, var3352=$r9}
; {org.apache.dubbo.rpc.model.ScopeModel=var3509, r0=var1610, r5=var2810, null_type=var3350, r8=var3891, org.apache.dubbo.common.config.ConfigurationUtils=var1534, r1=var3047, org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var3546, $r2=var2620, java.lang.Object=var1679, org.apache.dubbo.common.config.ConfigurationCache=var3843, $r3=var2196, r4=var1182, java.util.function.Function=var1650, org.apache.dubbo.common.config.ConfigurationUtils$lambda_getCachedDynamicProperty_0__145=var43, $r6=var138, r7=var312, org.apache.dubbo.common.utils.StringUtils=var1315, $z0=var3263, $r9=var3352}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	r5 := @parameter1: java.lang.String;	r8 := @parameter2: java.lang.String;	r1 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.rpc.model.ScopeModel getScopeModelOrDefaultApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>(r0);	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ScopeModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/common/config/ConfigurationCache;");	r4 = (org.apache.dubbo.common.config.ConfigurationCache) $r3;	$r6 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils$lambda_getCachedDynamicProperty_0__145: java.util.function.Function bootstrap$(org.apache.dubbo.rpc.model.ScopeModel)>(r1);	r7 = virtualinvoke r4.<org.apache.dubbo.common.config.ConfigurationCache: java.lang.String computeIfAbsent(java.lang.String,java.util.function.Function)>(r5, $r6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7);	if $z0 == 0 goto $r9 = r7;	$r9 = r8;	goto [?= return $r9];	return $r9
;block_num 3