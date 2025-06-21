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

(declare-sort var1184 0)
(declare-sort var116 0)
(declare-sort var353 0)
(declare-sort var2318 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var353) String)
(declare-fun getParameterTypes/827748249 (var353) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun target/1816099972 (var1184) var116)
(declare-fun getDeclaringClass/501867354 (var353) ClassObject)
(declare-fun isInstance/451912363 (ClassObject var116) Bool)
(declare-fun var2318-init () var2318)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var116) String)
(declare-fun cast-from-ClassObject-to-var116 (ClassObject) var116)
(declare-fun cast-from-var353-to-var116 (var353) var116)
(declare-fun getClass/1258963082 (var116) ClassObject)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var2318 String) void)
(declare-const null-var1184 var1184)
(declare-const null-var116 var116)
(declare-const null-var353 var353)
(declare-const null-__Array__Int__var116__ (Array Int var116))
(declare-const var3107 var1184) ; Statement: r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler 
(assert (not (= var3107 null-var1184)))
(declare-const var3653 var116) ; Statement: r36 := @parameter0: java.lang.Object 
(assert (not (= var3653 null-var116)))
(declare-const var570 var353) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var570 null-var353)))
(declare-const var691 (Array Int var116)) ; Statement: r19 := @parameter2: java.lang.Object[] 
(assert (not (= var691 null-__Array__Int__var116__)))
(assert true)
(define-const var2038 String (getName/1227988463 var570)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2084 (Array Int ClassObject) (getParameterTypes/827748249 var570)) ; Statement: r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var2663 Int (getLength-Arr-ClassObject-1 var2084)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r2 
(assert (not (= var2663 0))) ; Cond: $i0 != 0 
(define-const var3161 Int (getLength-Arr-ClassObject-1 var2084)) ; Statement: $i1 = lengthof r2 
 ; Statement: if $i1 != 1 goto $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
(assert (not (= var3161 1))) ; Cond: $i1 != 1 
(define-const var2267 var116 (target/1816099972 var3107)) ; Statement: $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
 ; Statement: if $r37 != null goto $r5 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>() 
(assert (not (= var2267 null-var116))) ; Cond: $r37 != null 
(assert true)
(define-const var1376 ClassObject (getDeclaringClass/501867354 var570)) ; Statement: $r5 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>() 
(define-const var3226 var116 (target/1816099972 var3107)) ; Statement: $r4 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
(assert true)
(define-const var1526 Bool (isInstance/451912363 var1376 var3226)) ; Statement: $z0 = virtualinvoke $r5.<java.lang.Class: boolean isInstance(java.lang.Object)>($r4) 
 ; Statement: if $z0 == 0 goto $r6 = new java.lang.IllegalStateException 
(assert (= (ite var1526 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2098 var2318 var2318-init) ; Statement: $r6 = new java.lang.IllegalStateException 
(define-const var3218 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3218)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3218!1 String)
(assert (= var3218!1 ""))
(assert true)
(define-const var1196 String (append/672562846 var3218!1 "The proxied interface [")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The proxied interface [") 
(declare-const var3218!2 String)
(assert (= var3218!2 (str.++ var3218!1 "The proxied interface [")))
(assert true)
(define-const var2037 ClassObject (getDeclaringClass/501867354 var570)) ; Statement: $r8 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>() 
(assert true)
(define-const var166 String (append/-1031950772 var1196 (cast-from-ClassObject-to-var116 var2037))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var1196!1 String)
(assert (str.prefixof var1196 var1196!1))
(assert true)
(define-const var272 String (append/672562846 var166 "] contains a method [")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] contains a method [") 
(declare-const var166!1 String)
(assert (= var166!1 (str.++ var166 "] contains a method [")))
(assert true)
(define-const var527 String (append/-1031950772 var272 (cast-from-var353-to-var116 var570))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var272!1 String)
(assert (str.prefixof var272 var272!1))
(assert true)
(define-const var1968 String (append/672562846 var527 "] that is not implemented by the proxy class [")) ; Statement: $r15 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] that is not implemented by the proxy class [") 
(declare-const var527!1 String)
(assert (= var527!1 (str.++ var527 "] that is not implemented by the proxy class [")))
(define-const var2553 var116 (target/1816099972 var3107)) ; Statement: $r13 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target> 
(assert true)
(define-const var231 ClassObject (getClass/1258963082 var2553)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var961 String (append/-1031950772 var1968 (cast-from-ClassObject-to-var116 var231))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14) 
(declare-const var1968!1 String)
(assert (str.prefixof var1968 var1968!1))
(assert true)
(define-const var2571 String (append/672562846 var961 "]")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var961!1 String)
(assert (= var961!1 (str.++ var961 "]")))
(assert true)
(define-const var323 String (toString/-2075883882 var2571)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var2098 var323)) ; Statement: specialinvoke $r6.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r18) 

(declare-const var2098!1 var2318)
(declare-const var323!1 String)
 ; Statement: throw $r6 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), target/1816099972=([org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler], java.lang.Object), getDeclaringClass/501867354=([java.lang.reflect.Method], java.lang.Class), isInstance/451912363=([java.lang.Class, java.lang.Object], boolean), var2318-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var116=([java.lang.Class], java.lang.Object), cast-from-var353-to-var116=([java.lang.reflect.Method], java.lang.Object), getClass/1258963082=([java.lang.Object], java.lang.Class), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1184=org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler, var3107=r3, var116=java.lang.Object, var3653=r36, var353=java.lang.reflect.Method, var570=r0, var691=r19, var2038=r1, var2084=r2, var2663=$i0, var3161=$i1, var2267=$r37, var1376=$r5, var3226=$r4, var1526=$z0, var2318=java.lang.IllegalStateException, var2098=$r6, var3218=$r7, var1196=$r9, var2037=$r8, var166=$r10, var272=$r11, var527=$r12, var1968=$r15, var2553=$r13, var231=$r14, var961=$r16, var2571=$r17, var323=$r18}
; {org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler=var1184, r3=var3107, java.lang.Object=var116, r36=var3653, java.lang.reflect.Method=var353, r0=var570, r19=var691, r1=var2038, r2=var2084, $i0=var2663, $i1=var3161, $r37=var2267, $r5=var1376, $r4=var3226, $z0=var1526, java.lang.IllegalStateException=var2318, $r6=var2098, $r7=var3218, $r9=var1196, $r8=var2037, $r10=var166, $r11=var272, $r12=var527, $r15=var1968, $r13=var2553, $r14=var231, $r16=var961, $r17=var2571, $r18=var323}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler;	r36 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.reflect.Method;	r19 := @parameter2: java.lang.Object[];	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$i0 = lengthof r2;	if $i0 != 0 goto $i1 = lengthof r2;	$i1 = lengthof r2;	if $i1 != 1 goto $r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	$r37 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	if $r37 != null goto $r5 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>();	$r5 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>();	$r4 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	$z0 = virtualinvoke $r5.<java.lang.Class: boolean isInstance(java.lang.Object)>($r4);	if $z0 == 0 goto $r6 = new java.lang.IllegalStateException;	$r6 = new java.lang.IllegalStateException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The proxied interface [");	$r8 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] contains a method [");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r15 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] that is not implemented by the proxy class [");	$r13 = r3.<org.apache.dubbo.config.spring.util.LazyTargetInvocationHandler: java.lang.Object target>;	$r14 = virtualinvoke $r13.<java.lang.Object: java.lang.Class getClass()>();	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r6.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r18);	throw $r6
;block_num 5