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

(declare-sort var3811 0)
(declare-sort var3515 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var3811 String String) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var3811 var3811)
(declare-const null-String String)
(declare-const var2515 var3811) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var2515 null-var3811)))
(declare-const var2393 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2393 null-String)))
(declare-const var2965 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2965 null-String)))
(assert true)
(define-const var1574 String (getMethodParameter/2069355293 var2515 var2393 var2965)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
 ; Statement: if r3 == null goto $z0 = 0 
(assert (not (= var1574 null-String))) ; Negate: Cond: r3 == null  
(assert true)
(define-const var3290 Int (length/-134980193 var1574)) ; Statement: $i0 = virtualinvoke r3.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $z0 = 0 
(assert (<= var3290 0)) ; Cond: $i0 <= 0 
(define-const var2155 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var3811=org.apache.dubbo.common.Parameters, var2515=r0, var2393=r1, var3515=null_type, var2965=r2, var1574=r3, var3290=$i0, var2155=$z0}
; {org.apache.dubbo.common.Parameters=var3811, r0=var2515, r1=var2393, null_type=var3515, r2=var2965, r3=var1574, $i0=var3290, $z0=var2155}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	if r3 == null goto $z0 = 0;	$i0 = virtualinvoke r3.<java.lang.String: int length()>();	if $i0 <= 0 goto $z0 = 0;	$z0 = 0;	return $z0
;block_num 4