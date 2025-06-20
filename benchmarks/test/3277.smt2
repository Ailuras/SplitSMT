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

(declare-sort var1577 0)
(declare-sort var2501 0)
(declare-sort var333 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/1817828379 (var1577 String String) String)
(declare-fun var333_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1577 var1577)
(declare-const null-String String)
(declare-const var3778 var1577) ; Statement: r2 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3778 null-var1577)))
(declare-const var3926 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3926 null-String)))
(declare-const var3360 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3360 null-String)))
 ; Statement: if r0 != null goto (branch) 
(assert (not (= var3926 null-String))) ; Cond: r0 != null 
 ; Statement: if r1 != null goto r21 = virtualinvoke r2.<org.apache.dubbo.common.URLBuilder: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r0, r1) 
(assert (not (= var3360 null-String))) ; Cond: r1 != null 
(assert true)
(define-const var1991 String (getMethodParameter/1817828379 var3778 var3926 var3360)) ; Statement: r21 = virtualinvoke r2.<org.apache.dubbo.common.URLBuilder: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r0, r1) 
(define-const var3895 Bool (var333_isNotEmpty/-1251449450 var1991)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r21) 
 ; Statement: return $z0 
(check-sat)
; {getMethodParameter/1817828379=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], java.lang.String), var333_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1577=org.apache.dubbo.common.URLBuilder, var3778=r2, var3926=r0, var2501=null_type, var3360=r1, var1991=r21, var333=org.apache.dubbo.common.utils.StringUtils, var3895=$z0}
; {org.apache.dubbo.common.URLBuilder=var1577, r2=var3778, r0=var3926, null_type=var2501, r1=var3360, r21=var1991, org.apache.dubbo.common.utils.StringUtils=var333, $z0=var3895}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	if r0 != null goto (branch);	if r1 != null goto r21 = virtualinvoke r2.<org.apache.dubbo.common.URLBuilder: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r0, r1);	r21 = virtualinvoke r2.<org.apache.dubbo.common.URLBuilder: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r0, r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r21);	return $z0
;block_num 3