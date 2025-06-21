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

(declare-sort var2488 0)
(declare-sort var1956 0)
(declare-sort var900 0)
(declare-sort var885 0)
(declare-sort var1793 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun moduleModel/-1750759578 (var2488) var1956)
(declare-fun var900_getProperty/-78901247 (var885 String) String)
(declare-fun cast-from-var1956-to-var885 (var1956) var885)
(declare-fun var1793_isEmpty/-813097145 (String) Bool)
(declare-const null-var2488 var2488)
(declare-const var3004 var2488) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var3004 null-var2488)))
(define-const var1760 Int (cast-from-Int-to-Int 60000)) ; Statement: $i2 = (int) 60000 
(define-const var3659 Int var1760) ; Statement: i0 = $i2 
(define-const var3800 var1956 (moduleModel/-1750759578 var3004)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(define-const var1716 String (var900_getProperty/-78901247 (cast-from-var1956-to-var885 var3800) "dubbo.application.migration.delay")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String)>($r1, "dubbo.application.migration.delay") 
(define-const var3649 Bool (var1793_isEmpty/-813097145 var1716)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
(assert (not (= (ite var3649 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1196 Int (cast-from-Int-to-Int 60000)) ; Statement: $i4 = (int) 60000 
 ; Statement: return $i4 
(check-sat)
; {cast-from-Int-to-Int=([int], int), moduleModel/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.rpc.model.ModuleModel), var900_getProperty/-78901247=([org.apache.dubbo.rpc.model.ScopeModel, java.lang.String], java.lang.String), cast-from-var1956-to-var885=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), var1793_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2488=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var3004=r0, var1760=$i2, var3659=i0, var1956=org.apache.dubbo.rpc.model.ModuleModel, var3800=$r1, var900=org.apache.dubbo.common.config.ConfigurationUtils, var885=org.apache.dubbo.rpc.model.ScopeModel, var1716=r2, var1793=org.apache.dubbo.common.utils.StringUtils, var3649=$z0, var1196=$i4}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var2488, r0=var3004, $i2=var1760, i0=var3659, org.apache.dubbo.rpc.model.ModuleModel=var1956, $r1=var3800, org.apache.dubbo.common.config.ConfigurationUtils=var900, org.apache.dubbo.rpc.model.ScopeModel=var885, r2=var1716, org.apache.dubbo.common.utils.StringUtils=var1793, $z0=var3649, $i4=var1196}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	$i2 = (int) 60000;	i0 = $i2;	$r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	r2 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String)>($r1, "dubbo.application.migration.delay");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	$i4 = (int) 60000;	return $i4
;block_num 2