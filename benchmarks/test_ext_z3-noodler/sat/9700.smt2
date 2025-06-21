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

(declare-sort var1793 0)
(declare-sort var2685 0)
(declare-sort var2584 0)
(declare-sort var1346 0)
(declare-sort var2124 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1346_checkMultiName/341367172 (String String) void)
(declare-fun var2124_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1793 var1793)
(declare-const null-var2685 var2685)
(declare-const null-String String)
(declare-const var2679 var1793) ; Statement: r23 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var2679 null-var1793)))
(declare-const var2212 var2685) ; Statement: r4 := @parameter1: java.util.List 
(assert (not (= var2212 null-var2685)))
(declare-const var3383 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var3383 null-String)))
(declare-const var1747 String) ; Statement: r1 := @parameter3: java.lang.String 
(assert (not (= var1747 null-String)))
;(assert (var1346_checkMultiName/341367172 var3383 var1747)) ; Statement: staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkMultiName(java.lang.String,java.lang.String)>(r0, r1) 

(declare-const var3383!1 String)
(declare-const var1747!1 String)
(define-const var3884 Bool (var2124_isNotEmpty/-1251449450 var1747!1)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3884 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var1346_checkMultiName/341367172=([java.lang.String, java.lang.String], void), var2124_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1793=org.apache.dubbo.rpc.model.ScopeModel, var2679=r23, var2685=java.util.List, var2212=r4, var3383=r0, var2584=null_type, var1747=r1, var1346=org.apache.dubbo.config.utils.ConfigValidationUtils, var2124=org.apache.dubbo.common.utils.StringUtils, var3884=$z0}
; {org.apache.dubbo.rpc.model.ScopeModel=var1793, r23=var2679, java.util.List=var2685, r4=var2212, r0=var3383, null_type=var2584, r1=var1747, org.apache.dubbo.config.utils.ConfigValidationUtils=var1346, org.apache.dubbo.common.utils.StringUtils=var2124, $z0=var3884}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r23 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	r4 := @parameter1: java.util.List;	r0 := @parameter2: java.lang.String;	r1 := @parameter3: java.lang.String;	staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkMultiName(java.lang.String,java.lang.String)>(r0, r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto return;	return
;block_num 2