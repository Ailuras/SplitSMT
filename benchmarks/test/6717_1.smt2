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

(declare-sort var2066 0)
(declare-sort var2072 0)
(declare-sort var1503 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var2066 String String) String)
(declare-fun var1503_isEmpty/-813097145 (String) Bool)
(declare-const null-var2066 var2066)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var862 var2066) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var862 null-var2066)))
(declare-const var2843 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2843 null-String)))
(declare-const var738 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var738 null-String)))
(declare-const var750 Float64) ; Statement: d1 := @parameter2: double 
(assert (not (= var750 null-Float64)))
(assert true)
(define-const var2774 String (getMethodParameter/2015795402 var862 var2843 var738)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2367 Bool (var1503_isEmpty/-813097145 var2774)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3) 
(assert (not (= (ite var2367 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return d1 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1503_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2066=org.apache.dubbo.common.URL, var862=r0, var2843=r1, var2072=null_type, var738=r2, var750=d1, var2774=r3, var1503=org.apache.dubbo.common.utils.StringUtils, var2367=$z0}
; {org.apache.dubbo.common.URL=var2066, r0=var862, r1=var2843, null_type=var2072, r2=var738, d1=var750, r3=var2774, org.apache.dubbo.common.utils.StringUtils=var1503, $z0=var2367}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	d1 := @parameter2: double;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3);	return d1
;block_num 2