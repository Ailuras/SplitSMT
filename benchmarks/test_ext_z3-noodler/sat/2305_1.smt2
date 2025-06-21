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

(declare-sort var3778 0)
(declare-sort var1545 0)
(declare-sort var1588 0)
(declare-sort var997 0)
(declare-sort var3005 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var997_getGlobalConfiguration/-670113096 (var3778) var1588)
(declare-fun var1588_getString/-24482226 (var1588 String String) String)
(declare-fun var3005_trim/1012475733 (String) String)
(declare-const null-var3778 var3778)
(declare-const null-String String)
(declare-const var923 var3778) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var923 null-var3778)))
(declare-const var1103 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1103 null-String)))
(declare-const var294 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var294 null-String)))
(define-const var3666 var1588 (var997_getGlobalConfiguration/-670113096 var923)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>(r0) 
(define-const var2077 String (var1588_getString/-24482226 var3666 var1103 var294)) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1014 String (var3005_trim/1012475733 var2077)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>($r4) 
 ; Statement: return $r5 
(check-sat)
; {var997_getGlobalConfiguration/-670113096=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), var1588_getString/-24482226=([org.apache.dubbo.common.config.Configuration, java.lang.String, java.lang.String], java.lang.String), var3005_trim/1012475733=([java.lang.String], java.lang.String)}
; {var3778=org.apache.dubbo.rpc.model.ScopeModel, var923=r0, var1103=r1, var1545=null_type, var294=r2, var1588=org.apache.dubbo.common.config.Configuration, var997=org.apache.dubbo.common.config.ConfigurationUtils, var3666=$r3, var2077=$r4, var3005=org.apache.dubbo.common.utils.StringUtils, var1014=$r5}
; {org.apache.dubbo.rpc.model.ScopeModel=var3778, r0=var923, r1=var1103, null_type=var1545, r2=var294, org.apache.dubbo.common.config.Configuration=var1588, org.apache.dubbo.common.config.ConfigurationUtils=var997, $r3=var3666, $r4=var2077, org.apache.dubbo.common.utils.StringUtils=var3005, $r5=var1014}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>(r0);	$r4 = interfaceinvoke $r3.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String,java.lang.String)>(r1, r2);	$r5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>($r4);	return $r5
;block_num 1