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

(declare-sort var1973 0)
(declare-sort var1387 0)
(declare-sort var2705 0)
(declare-sort var955 0)
(declare-sort var557 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ruleRepository/1837053584 (var1973) var2705)
(declare-fun var2705_addListener/-1609928644 (var2705 String var955) void)
(declare-fun cast-from-var1973-to-var955 (var1973) var955)
(declare-fun var2705_getRule/-103020285 (var2705 String String) String)
(declare-fun var557_isEmpty/-813097145 (String) Bool)
(declare-const null-var1973 var1973)
(declare-const null-String String)
(declare-const var3978 var1973) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.AbstractConfiguratorListener 
(assert (not (= var3978 null-var1973)))
(declare-const var352 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var352 null-String)))
(define-const var912 var2705 (ruleRepository/1837053584 var3978)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository ruleRepository> 
;(assert (var2705_addListener/-1609928644 var912 var352 (cast-from-var1973-to-var955 var3978))) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void addListener(java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>(r1, r0) 

(declare-const var912!1 var2705)
(declare-const var352!1 String)
(declare-const var3978!1 var1973)
(define-const var134 var2705 (ruleRepository/1837053584 var3978!1)) ; Statement: $r3 = r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository ruleRepository> 
(define-const var3892 String (var2705_getRule/-103020285 var134 var352!1 "dubbo")) ; Statement: r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: java.lang.String getRule(java.lang.String,java.lang.String)>(r1, "dubbo") 
(define-const var12 Bool (var557_isEmpty/-813097145 var3892)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var12 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {ruleRepository/1837053584=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener], org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository), var2705_addListener/-1609928644=([org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, java.lang.String, org.apache.dubbo.common.config.configcenter.ConfigurationListener], void), cast-from-var1973-to-var955=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener], org.apache.dubbo.common.config.configcenter.ConfigurationListener), var2705_getRule/-103020285=([org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, java.lang.String, java.lang.String], java.lang.String), var557_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1973=org.apache.dubbo.registry.integration.AbstractConfiguratorListener, var3978=r0, var352=r1, var1387=null_type, var2705=org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, var912=$r2, var955=org.apache.dubbo.common.config.configcenter.ConfigurationListener, var134=$r3, var3892=r4, var557=org.apache.dubbo.common.utils.StringUtils, var12=$z0}
; {org.apache.dubbo.registry.integration.AbstractConfiguratorListener=var1973, r0=var3978, r1=var352, null_type=var1387, org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository=var2705, $r2=var912, org.apache.dubbo.common.config.configcenter.ConfigurationListener=var955, $r3=var134, r4=var3892, org.apache.dubbo.common.utils.StringUtils=var557, $z0=var12}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.AbstractConfiguratorListener;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository ruleRepository>;	interfaceinvoke $r2.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void addListener(java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>(r1, r0);	$r3 = r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository ruleRepository>;	r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: java.lang.String getRule(java.lang.String,java.lang.String)>(r1, "dubbo");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 != 0 goto return;	return
;block_num 2