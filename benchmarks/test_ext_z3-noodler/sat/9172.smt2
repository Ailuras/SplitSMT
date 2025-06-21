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

(declare-sort var735 0)
(declare-sort var778 0)
(declare-sort var2511 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var2511) String)
(declare-fun getParameterTypes/827748249 (var2511) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun hashCode/1739917532 (var778) Int)
(declare-fun cast-from-var735-to-var778 (var735) var778)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-const null-var735 var735)
(declare-const null-var778 var778)
(declare-const null-var2511 var2511)
(declare-const null-__Array__Int__var778__ (Array Int var778))
(declare-const var2312 var735) ; Statement: r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler 
(assert (not (= var2312 null-var735)))
(declare-const var1416 var778) ; Statement: r36 := @parameter0: java.lang.Object 
(assert (not (= var1416 null-var778)))
(declare-const var3810 var2511) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var3810 null-var2511)))
(declare-const var3271 (Array Int var778)) ; Statement: r19 := @parameter2: java.lang.Object[] 
(assert (not (= var3271 null-__Array__Int__var778__)))
(assert true)
(define-const var3237 String (getName/1227988463 var3810)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var1862 (Array Int ClassObject) (getParameterTypes/827748249 var3810)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var1114 Int (getLength-Arr-ClassObject-1 var1862)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r2 
(assert (not (not (= var1114 0)))) ; Negate: Cond: $i0 != 0  
(define-const var1997 String "toString") ; Statement: $r27 = "toString" 
(assert true)
(define-const var1307 Bool (= var1997 var3237)) ; Statement: $z3 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z3 == 0 goto $r28 = "hashCode" 
(assert (= (ite var1307 1 0) 0)) ; Cond: $z3 == 0 
(define-const var3238 String "hashCode") ; Statement: $r28 = "hashCode" 
(assert true)
(define-const var1211 Bool (= var3238 var3237)) ; Statement: $z4 = virtualinvoke $r28.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z4 == 0 goto $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
(assert (not (= (ite var1211 1 0) 0))) ; Negate: Cond: $z4 == 0  
(assert true)
(define-const var1182 Int (hashCode/1739917532 (cast-from-var735-to-var778 var2312))) ; Statement: $i2 = virtualinvoke r3.<java.lang.Object: int hashCode()>() 
(define-const var1056 Int (Int_valueOf/-1371140006 var1182)) ; Statement: $r29 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i2) 
 ; Statement: return $r29 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), hashCode/1739917532=([java.lang.Object], int), cast-from-var735-to-var778=([org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler], java.lang.Object), Int_valueOf/-1371140006=([int], java.lang.Integer)}
; {var735=org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler, var2312=r3, var778=java.lang.Object, var1416=r36, var2511=java.lang.reflect.Method, var3810=r0, var3271=r19, var3237=r1, var1862=r2, var1114=$i0, var1997=$r27, var1307=$z3, var3238=$r28, var1211=$z4, var1182=$i2, var1056=$r29}
; {org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler=var735, r3=var2312, java.lang.Object=var778, r36=var1416, java.lang.reflect.Method=var2511, r0=var3810, r19=var3271, r1=var3237, r2=var1862, $i0=var1114, $r27=var1997, $z3=var1307, $r28=var3238, $z4=var1211, $i2=var1182, $r29=var1056}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler;	r36 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.reflect.Method;	r19 := @parameter2: java.lang.Object[];	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$i0 = lengthof r2;	if $i0 != 0 goto $i1 = lengthof r2;	$r27 = "toString";	$z3 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z3 == 0 goto $r28 = "hashCode";	$r28 = "hashCode";	$z4 = virtualinvoke $r28.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z4 == 0 goto $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	$i2 = virtualinvoke r3.<java.lang.Object: int hashCode()>();	$r29 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i2);	return $r29
;block_num 4