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

(declare-sort var3658 0)
(declare-sort var1668 0)
(declare-sort var462 0)
(declare-sort var3971 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var462) String)
(declare-fun getParameterTypes/827748249 (var462) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun equals/-1650223740 (var1668 var1668) Bool)
(declare-fun cast-from-var3658-to-var1668 (var3658) var1668)
(declare-fun var3971_valueOf/1602327315 (Bool) var3971)
(declare-const null-var3658 var3658)
(declare-const null-var1668 var1668)
(declare-const null-var462 var462)
(declare-const null-__Array__Int__var1668__ (Array Int var1668))
(declare-const var1464 var3658) ; Statement: r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler 
(assert (not (= var1464 null-var3658)))
(declare-const var739 var1668) ; Statement: r36 := @parameter0: java.lang.Object 
(assert (not (= var739 null-var1668)))
(declare-const var1626 var462) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var1626 null-var462)))
(declare-const var1040 (Array Int var1668)) ; Statement: r19 := @parameter2: java.lang.Object[] 
(assert (not (= var1040 null-__Array__Int__var1668__)))
(assert true)
(define-const var3972 String (getName/1227988463 var1626)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var376 (Array Int ClassObject) (getParameterTypes/827748249 var1626)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var3904 Int (getLength-Arr-ClassObject-1 var376)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r2 
(assert (not (= var3904 0))) ; Cond: $i0 != 0 
(define-const var1235 Int (getLength-Arr-ClassObject-1 var376)) ; Statement: $i1 = lengthof r2 
 ; Statement: if $i1 != 1 goto $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
(assert (not (not (= var1235 1)))) ; Negate: Cond: $i1 != 1  
(define-const var669 String "equals") ; Statement: $r24 = "equals" 
(assert true)
(define-const var190 Bool (= var669 var3972)) ; Statement: $z1 = virtualinvoke $r24.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z1 == 0 goto $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
(assert (not (= (ite var190 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2164 var1668 (select var1040 0)) ; Statement: $r25 = r19[0] 
(assert true)
(define-const var1895 Bool (equals/-1650223740 (cast-from-var3658-to-var1668 var1464) var2164)) ; Statement: $z2 = virtualinvoke r3.<java.lang.Object: boolean equals(java.lang.Object)>($r25) 
(define-const var3 var3971 (var3971_valueOf/1602327315 var1895)) ; Statement: $r26 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z2) 
 ; Statement: return $r26 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), equals/-1650223740=([java.lang.Object, java.lang.Object], boolean), cast-from-var3658-to-var1668=([org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler], java.lang.Object), var3971_valueOf/1602327315=([boolean], java.lang.Boolean)}
; {var3658=org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler, var1464=r3, var1668=java.lang.Object, var739=r36, var462=java.lang.reflect.Method, var1626=r0, var1040=r19, var3972=r1, var376=r2, var3904=$i0, var1235=$i1, var669=$r24, var190=$z1, var2164=$r25, var1895=$z2, var3971=java.lang.Boolean, var3=$r26}
; {org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler=var3658, r3=var1464, java.lang.Object=var1668, r36=var739, java.lang.reflect.Method=var462, r0=var1626, r19=var1040, r1=var3972, r2=var376, $i0=var3904, $i1=var1235, $r24=var669, $z1=var190, $r25=var2164, $z2=var1895, java.lang.Boolean=var3971, $r26=var3}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler;	r36 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.reflect.Method;	r19 := @parameter2: java.lang.Object[];	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$i0 = lengthof r2;	if $i0 != 0 goto $i1 = lengthof r2;	$i1 = lengthof r2;	if $i1 != 1 goto $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	$r24 = "equals";	$z1 = virtualinvoke $r24.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z1 == 0 goto $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	$r25 = r19[0];	$z2 = virtualinvoke r3.<java.lang.Object: boolean equals(java.lang.Object)>($r25);	$r26 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z2);	return $r26
;block_num 4