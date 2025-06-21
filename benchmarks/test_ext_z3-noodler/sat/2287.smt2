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

(declare-sort var1579 0)
(declare-sort var95 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var1579 String String) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var1579 var1579)
(declare-const null-String String)
(declare-const var428 var1579) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var428 null-var1579)))
(declare-const var2383 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2383 null-String)))
(declare-const var2511 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2511 null-String)))
(assert true)
(define-const var2203 String (getMethodParameter/2069355293 var428 var2383 var2511)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
 ; Statement: if r3 == null goto $z0 = 0 
(assert (not (= var2203 null-String))) ; Negate: Cond: r3 == null  
(assert true)
(define-const var3825 Int (length/-134980193 var2203)) ; Statement: $i0 = virtualinvoke r3.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $z0 = 0 
(assert (not (<= var3825 0))) ; Negate: Cond: $i0 <= 0  
(define-const var1121 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= return $z0] 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var1579=org.apache.dubbo.common.Parameters, var428=r0, var2383=r1, var95=null_type, var2511=r2, var2203=r3, var3825=$i0, var1121=$z0}
; {org.apache.dubbo.common.Parameters=var1579, r0=var428, r1=var2383, null_type=var95, r2=var2511, r3=var2203, $i0=var3825, $z0=var1121}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	if r3 == null goto $z0 = 0;	$i0 = virtualinvoke r3.<java.lang.String: int length()>();	if $i0 <= 0 goto $z0 = 0;	$z0 = 1;	goto [?= return $z0];	return $z0
;block_num 4