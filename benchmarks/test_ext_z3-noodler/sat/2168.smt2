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

(declare-sort var71 0)
(declare-sort var2599 0)
(declare-sort var3850 0)
(declare-sort var2700 0)
(declare-sort var2727 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2700_getDynamicGlobalConfiguration/1591402683 (var71) var3850)
(declare-fun var3850_getString/-24482226 (var3850 String String) String)
(declare-fun var2727_trim/1012475733 (String) String)
(declare-const null-var71 var71)
(declare-const null-String String)
(declare-const var1492 var71) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var1492 null-var71)))
(declare-const var2898 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2898 null-String)))
(declare-const var3315 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var3315 null-String)))
(define-const var1385 var3850 (var2700_getDynamicGlobalConfiguration/1591402683 var1492)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getDynamicGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>(r0) 
(define-const var3729 String (var3850_getString/-24482226 var1385 var2898 var3315)) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var188 String (var2727_trim/1012475733 var3729)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>($r4) 
 ; Statement: return $r5 
(check-sat)
; {var2700_getDynamicGlobalConfiguration/1591402683=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), var3850_getString/-24482226=([org.apache.dubbo.common.config.Configuration, java.lang.String, java.lang.String], java.lang.String), var2727_trim/1012475733=([java.lang.String], java.lang.String)}
; {var71=org.apache.dubbo.rpc.model.ScopeModel, var1492=r0, var2898=r1, var2599=null_type, var3315=r2, var3850=org.apache.dubbo.common.config.Configuration, var2700=org.apache.dubbo.common.config.ConfigurationUtils, var1385=$r3, var3729=$r4, var2727=org.apache.dubbo.common.utils.StringUtils, var188=$r5}
; {org.apache.dubbo.rpc.model.ScopeModel=var71, r0=var1492, r1=var2898, null_type=var2599, r2=var3315, org.apache.dubbo.common.config.Configuration=var3850, org.apache.dubbo.common.config.ConfigurationUtils=var2700, $r3=var1385, $r4=var3729, org.apache.dubbo.common.utils.StringUtils=var2727, $r5=var188}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getDynamicGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>(r0);	$r4 = interfaceinvoke $r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String,java.lang.String)>(r1, r2);	$r5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>($r4);	return $r5
;block_num 1