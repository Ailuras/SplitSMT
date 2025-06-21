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

(declare-sort var2130 0)
(declare-sort var3963 0)
(declare-sort var1744 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var1744) String)
(declare-fun getParameterTypes/827748249 (var1744) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun target/1816099972 (var2130) var3963)
(declare-fun toString/-522406933 (var3963) String)
(declare-fun cast-from-var2130-to-var3963 (var2130) var3963)
(declare-const null-var2130 var2130)
(declare-const null-var3963 var3963)
(declare-const null-var1744 var1744)
(declare-const null-__Array__Int__var3963__ (Array Int var3963))
(declare-const var3094 var2130) ; Statement: r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler 
(assert (not (= var3094 null-var2130)))
(declare-const var3725 var3963) ; Statement: r36 := @parameter0: java.lang.Object 
(assert (not (= var3725 null-var3963)))
(declare-const var2687 var1744) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var2687 null-var1744)))
(declare-const var608 (Array Int var3963)) ; Statement: r19 := @parameter2: java.lang.Object[] 
(assert (not (= var608 null-__Array__Int__var3963__)))
(assert true)
(define-const var979 String (getName/1227988463 var2687)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var1507 (Array Int ClassObject) (getParameterTypes/827748249 var2687)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var593 Int (getLength-Arr-ClassObject-1 var1507)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r2 
(assert (not (not (= var593 0)))) ; Negate: Cond: $i0 != 0  
(define-const var1240 String "toString") ; Statement: $r27 = "toString" 
(assert true)
(define-const var981 Bool (= var1240 var979)) ; Statement: $z3 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z3 == 0 goto $r28 = "hashCode" 
(assert (not (= (ite var981 1 0) 0))) ; Negate: Cond: $z3 == 0  
(define-const var1350 var3963 (target/1816099972 var3094)) ; Statement: $r30 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
 ; Statement: if $r30 == null goto $r31 = virtualinvoke r3.<java.lang.Object: java.lang.String toString()>() 
(assert (= var1350 null-var3963)) ; Cond: $r30 == null 
(assert true)
(define-const var3765 String (toString/-522406933 (cast-from-var2130-to-var3963 var3094))) ; Statement: $r31 = virtualinvoke r3.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), target/1816099972=([org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler], java.lang.Object), toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var2130-to-var3963=([org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler], java.lang.Object)}
; {var2130=org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler, var3094=r3, var3963=java.lang.Object, var3725=r36, var1744=java.lang.reflect.Method, var2687=r0, var608=r19, var979=r1, var1507=r2, var593=$i0, var1240=$r27, var981=$z3, var1350=$r30, var3765=$r31}
; {org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler=var2130, r3=var3094, java.lang.Object=var3963, r36=var3725, java.lang.reflect.Method=var1744, r0=var2687, r19=var608, r1=var979, r2=var1507, $i0=var593, $r27=var1240, $z3=var981, $r30=var1350, $r31=var3765}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.Object: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler;	r36 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.reflect.Method;	r19 := @parameter2: java.lang.Object[];	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$i0 = lengthof r2;	if $i0 != 0 goto $i1 = lengthof r2;	$r27 = "toString";	$z3 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z3 == 0 goto $r28 = "hashCode";	$r30 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	if $r30 == null goto $r31 = virtualinvoke r3.<java.lang.Object: java.lang.String toString()>();	$r31 = virtualinvoke r3.<java.lang.Object: java.lang.String toString()>();	return $r31
;block_num 4