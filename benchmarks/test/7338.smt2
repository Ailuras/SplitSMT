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

(declare-sort var1778 0)
(declare-sort var1021 0)
(declare-sort var2355 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameterStrict/-1593628045 (var1778 String String) String)
(declare-fun var2355_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1778 var1778)
(declare-const null-String String)
(declare-const var3073 var1778) ; Statement: r2 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3073 null-var1778)))
(declare-const var111 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var111 null-String)))
(declare-const var3574 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3574 null-String)))
 ; Statement: if r0 != null goto (branch) 
(assert (not (= var111 null-String))) ; Cond: r0 != null 
 ; Statement: if r1 != null goto r21 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getMethodParameterStrict(java.lang.String,java.lang.String)>(r0, r1) 
(assert (not (= var3574 null-String))) ; Cond: r1 != null 
(assert true)
(define-const var26 String (getMethodParameterStrict/-1593628045 var3073 var111 var3574)) ; Statement: r21 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getMethodParameterStrict(java.lang.String,java.lang.String)>(r0, r1) 
(define-const var1409 Bool (var2355_isNotEmpty/-1251449450 var26)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r21) 
 ; Statement: return $z0 
(check-sat)
; {getMethodParameterStrict/-1593628045=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2355_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1778=org.apache.dubbo.common.URL, var3073=r2, var111=r0, var1021=null_type, var3574=r1, var26=r21, var2355=org.apache.dubbo.common.utils.StringUtils, var1409=$z0}
; {org.apache.dubbo.common.URL=var1778, r2=var3073, r0=var111, null_type=var1021, r1=var3574, r21=var26, org.apache.dubbo.common.utils.StringUtils=var2355, $z0=var1409}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	if r0 != null goto (branch);	if r1 != null goto r21 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getMethodParameterStrict(java.lang.String,java.lang.String)>(r0, r1);	r21 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getMethodParameterStrict(java.lang.String,java.lang.String)>(r0, r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r21);	return $z0
;block_num 3