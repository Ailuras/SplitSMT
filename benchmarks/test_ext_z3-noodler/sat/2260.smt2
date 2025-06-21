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

(declare-sort var1951 0)
(declare-sort var2876 0)
(declare-sort var1902 0)
(declare-sort var613 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var1951 String String) String)
(declare-fun var1902_isEmpty/-813097145 (String) Bool)
(declare-fun var613_parseBoolean/746105335 (String) Bool)
(declare-const null-var1951 var1951)
(declare-const null-String String)
(declare-const var3223 var1951) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3223 null-var1951)))
(declare-const var502 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var502 null-String)))
(declare-const var1002 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1002 null-String)))
(assert true)
(define-const var901 String (getMethodParameter/2069355293 var3223 var502 var1002)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2427 Bool (var1902_isEmpty/-813097145 var901)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (= (ite var2427 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2666 Bool (var613_parseBoolean/746105335 var901)) ; Statement: $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
 ; Statement: return $z1 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var1902_isEmpty/-813097145=([java.lang.String], boolean), var613_parseBoolean/746105335=([java.lang.String], boolean)}
; {var1951=org.apache.dubbo.common.Parameters, var3223=r0, var502=r1, var2876=null_type, var1002=r2, var901=r3, var1902=org.apache.dubbo.common.utils.StringUtils, var2427=$z0, var613=java.lang.Boolean, var2666=$z1}
; {org.apache.dubbo.common.Parameters=var1951, r0=var3223, r1=var502, null_type=var2876, r2=var1002, r3=var901, org.apache.dubbo.common.utils.StringUtils=var1902, $z0=var2427, java.lang.Boolean=var613, $z1=var2666}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	return $z1
;block_num 2