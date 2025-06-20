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

(declare-sort var2647 0)
(declare-sort var2084 0)
(declare-sort var1845 0)
(declare-sort var2593 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1845_checkName/-1092541379 (String String) void)
(declare-fun var2593_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2647 var2647)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const var25 var2647) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var25 null-var2647)))
(declare-const var2495 ClassObject) ; Statement: r3 := @parameter1: java.lang.Class 
(assert (not (= var2495 null-ClassObject)))
(declare-const var1992 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var1992 null-String)))
(declare-const var1274 String) ; Statement: r1 := @parameter3: java.lang.String 
(assert (not (= var1274 null-String)))
;(assert (var1845_checkName/-1092541379 var1992 var1274)) ; Statement: staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkName(java.lang.String,java.lang.String)>(r0, r1) 

(declare-const var1992!1 String)
(declare-const var1274!1 String)
(define-const var969 Bool (var2593_isNotEmpty/-1251449450 var1274!1)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var969 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var1845_checkName/-1092541379=([java.lang.String, java.lang.String], void), var2593_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2647=org.apache.dubbo.rpc.model.ScopeModel, var25=r2, var2495=r3, var1992=r0, var2084=null_type, var1274=r1, var1845=org.apache.dubbo.config.utils.ConfigValidationUtils, var2593=org.apache.dubbo.common.utils.StringUtils, var969=$z0}
; {org.apache.dubbo.rpc.model.ScopeModel=var2647, r2=var25, r3=var2495, r0=var1992, null_type=var2084, r1=var1274, org.apache.dubbo.config.utils.ConfigValidationUtils=var1845, org.apache.dubbo.common.utils.StringUtils=var2593, $z0=var969}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r2 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	r3 := @parameter1: java.lang.Class;	r0 := @parameter2: java.lang.String;	r1 := @parameter3: java.lang.String;	staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void checkName(java.lang.String,java.lang.String)>(r0, r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto return;	return
;block_num 2