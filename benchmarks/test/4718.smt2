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

(declare-sort var1625 0)
(declare-sort var1432 0)
(declare-sort var0 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var0_isEmpty/-813097145 (String) Bool)
(declare-const null-var1625 var1625)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const var939 var1625) ; Statement: r5 := @parameter0: org.apache.dubbo.rpc.model.FrameworkModel 
(assert (not (= var939 null-var1625)))
(declare-const var3869 ClassObject) ; Statement: r1 := @parameter1: java.lang.Class 
(assert (not (= var3869 null-ClassObject)))
(declare-const var1777 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var1777 null-String)))
(define-const var300 Bool (var0_isEmpty/-813097145 var1777)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = <org.apache.dubbo.common.utils.ClassUtils: java.util.Map WRAPPER_PRIMITIVE_TYPE_MAP> 
(assert (not (= (ite var300 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {var0_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1625=org.apache.dubbo.rpc.model.FrameworkModel, var939=r5, var3869=r1, var1777=r0, var1432=null_type, var0=org.apache.dubbo.common.utils.StringUtils, var300=$z0}
; {org.apache.dubbo.rpc.model.FrameworkModel=var1625, r5=var939, r1=var3869, r0=var1777, null_type=var1432, org.apache.dubbo.common.utils.StringUtils=var0, $z0=var300}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r5 := @parameter0: org.apache.dubbo.rpc.model.FrameworkModel;	r1 := @parameter1: java.lang.Class;	r0 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = <org.apache.dubbo.common.utils.ClassUtils: java.util.Map WRAPPER_PRIMITIVE_TYPE_MAP>;	return null
;block_num 2