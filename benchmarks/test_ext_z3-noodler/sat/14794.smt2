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

(declare-sort var3324 0)
(declare-sort var3351 0)
(declare-sort var2550 0)
(declare-sort var3392 0)
(declare-sort var3373 0)
(declare-sort var80 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getScopeModel/-1957927771 (var3351) var3392)
(declare-fun var3373_getCachedDynamicProperty/-2078950247 (var3392 String String) String)
(declare-fun var80_isEmpty/-813097145 (String) Bool)
(declare-const null-var3324 var3324)
(declare-const null-var3351 var3351)
(declare-const null-String String)
(declare-const var139 var3324) ; Statement: r4 := @this: org.apache.dubbo.registry.client.migration.model.MigrationRule 
(assert (not (= var139 null-var3324)))
(declare-const var1311 var3351) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1311 null-var3351)))
(declare-const var423 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var423 null-String)))
(assert true)
(define-const var959 var3392 (getScopeModel/-1957927771 var1311)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var793 String (var3373_getCachedDynamicProperty/-2078950247 var959 "dubbo.application.migration.step" null-String)) ; Statement: r5 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getCachedDynamicProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String,java.lang.String)>($r1, "dubbo.application.migration.step", null) 
(define-const var1435 Bool (var80_isEmpty/-813097145 var793)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto return r5 
(assert (= (ite var1435 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r5 
(check-sat)
; {getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var3373_getCachedDynamicProperty/-2078950247=([org.apache.dubbo.rpc.model.ScopeModel, java.lang.String, java.lang.String], java.lang.String), var80_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3324=org.apache.dubbo.registry.client.migration.model.MigrationRule, var139=r4, var3351=org.apache.dubbo.common.URL, var1311=r0, var423=r2, var2550=null_type, var3392=org.apache.dubbo.rpc.model.ScopeModel, var959=$r1, var3373=org.apache.dubbo.common.config.ConfigurationUtils, var793=r5, var80=org.apache.dubbo.common.utils.StringUtils, var1435=$z0}
; {org.apache.dubbo.registry.client.migration.model.MigrationRule=var3324, r4=var139, org.apache.dubbo.common.URL=var3351, r0=var1311, r2=var423, null_type=var2550, org.apache.dubbo.rpc.model.ScopeModel=var3392, $r1=var959, org.apache.dubbo.common.config.ConfigurationUtils=var3373, r5=var793, org.apache.dubbo.common.utils.StringUtils=var80, $z0=var1435}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.client.migration.model.MigrationRule;	r0 := @parameter0: org.apache.dubbo.common.URL;	r2 := @parameter1: java.lang.String;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	r5 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getCachedDynamicProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String,java.lang.String)>($r1, "dubbo.application.migration.step", null);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r5);	if $z0 == 0 goto return r5;	return r5
;block_num 2