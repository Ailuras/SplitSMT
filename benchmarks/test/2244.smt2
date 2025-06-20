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

(declare-sort var1912 0)
(declare-sort var2665 0)
(declare-sort var2772 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var1912 String String) String)
(declare-fun var2772_isEmpty/-813097145 (String) Bool)
(declare-const null-var1912 var1912)
(declare-const null-String String)
(declare-const var1988 var1912) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var1988 null-var1912)))
(declare-const var2963 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2963 null-String)))
(declare-const var1377 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1377 null-String)))
(assert true)
(define-const var842 String (getMethodParameter/2069355293 var1988 var2963 var1377)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2421 Bool (var2772_isEmpty/-813097145 var842)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (not (= (ite var2421 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var2772_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1912=org.apache.dubbo.common.Parameters, var1988=r0, var2963=r1, var2665=null_type, var1377=r2, var842=r3, var2772=org.apache.dubbo.common.utils.StringUtils, var2421=$z0}
; {org.apache.dubbo.common.Parameters=var1912, r0=var1988, r1=var2963, null_type=var2665, r2=var1377, r3=var842, org.apache.dubbo.common.utils.StringUtils=var2772, $z0=var2421}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	return 0
;block_num 2