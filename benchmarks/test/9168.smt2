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

(declare-sort var799 0)
(declare-sort var424 0)
(declare-sort var712 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var712) String)
(declare-fun getParameterTypes/827748249 (var712) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun target/1816099972 (var799) var424)
(declare-fun toString/-522406933 (var424) String)
(declare-const null-var799 var799)
(declare-const null-var424 var424)
(declare-const null-var712 var712)
(declare-const null-__Array__Int__var424__ (Array Int var424))
(declare-const var790 var799) ; Statement: r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler 
(assert (not (= var790 null-var799)))
(declare-const var2301 var424) ; Statement: r36 := @parameter0: java.lang.Object 
(assert (not (= var2301 null-var424)))
(declare-const var1092 var712) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var1092 null-var712)))
(declare-const var1222 (Array Int var424)) ; Statement: r19 := @parameter2: java.lang.Object[] 
(assert (not (= var1222 null-__Array__Int__var424__)))
(assert true)
(define-const var2617 String (getName/1227988463 var1092)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var236 (Array Int ClassObject) (getParameterTypes/827748249 var1092)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var0 Int (getLength-Arr-ClassObject-1 var236)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r2 
(assert (not (not (= var0 0)))) ; Negate: Cond: $i0 != 0  
(define-const var19 String "toString") ; Statement: $r27 = "toString" 
(assert true)
(define-const var3935 Bool (= var19 var2617)) ; Statement: $z3 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z3 == 0 goto $r28 = "hashCode" 
(assert (not (= (ite var3935 1 0) 0))) ; Negate: Cond: $z3 == 0  
(define-const var35 var424 (target/1816099972 var790)) ; Statement: $r30 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
 ; Statement: if $r30 == null goto $r31 = virtualinvoke r3.<java.lang.Object: java.lang.String toString()>() 
(assert (not (= var35 null-var424))) ; Negate: Cond: $r30 == null  
(define-const var2443 var424 (target/1816099972 var790)) ; Statement: $r32 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
(assert true)
(define-const var583 String (toString/-522406933 var2443)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: return $r33 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), target/1816099972=([org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler], java.lang.Object), toString/-522406933=([java.lang.Object], java.lang.String)}
; {var799=org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler, var790=r3, var424=java.lang.Object, var2301=r36, var712=java.lang.reflect.Method, var1092=r0, var1222=r19, var2617=r1, var236=r2, var0=$i0, var19=$r27, var3935=$z3, var35=$r30, var2443=$r32, var583=$r33}
; {org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler=var799, r3=var790, java.lang.Object=var424, r36=var2301, java.lang.reflect.Method=var712, r0=var1092, r19=var1222, r1=var2617, r2=var236, $i0=var0, $r27=var19, $z3=var3935, $r30=var35, $r32=var2443, $r33=var583}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.Object: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler;	r36 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.reflect.Method;	r19 := @parameter2: java.lang.Object[];	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$i0 = lengthof r2;	if $i0 != 0 goto $i1 = lengthof r2;	$r27 = "toString";	$z3 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z3 == 0 goto $r28 = "hashCode";	$r30 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	if $r30 == null goto $r31 = virtualinvoke r3.<java.lang.Object: java.lang.String toString()>();	$r32 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	$r33 = virtualinvoke $r32.<java.lang.Object: java.lang.String toString()>();	return $r33
;block_num 4