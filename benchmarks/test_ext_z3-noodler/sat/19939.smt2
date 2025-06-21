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

(declare-sort var554 0)
(declare-sort var1660 0)
(declare-sort var3945 0)
(declare-sort var342 0)
(declare-sort var133 0)
(declare-sort var1840 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3945_isDefault/-1009400446 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var133-init () var133)
(declare-fun <init>/-1447874194 (var133 String var1840) void)
(declare-fun cast-from-var342-to-var1840 (var342) var1840)
(declare-const null-var554 var554)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var342 var342)
(declare-const var2098 var554) ; Statement: r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector 
(assert (not (= var2098 null-var554)))
(declare-const var2381 String) ; Statement: r39 := @parameter1: java.lang.String 
(assert (not (= var2381 null-String)))
(declare-const var1821 ClassObject) ; Statement: r5 := @parameter2: java.lang.Class 
(assert (not (= var1821 null-ClassObject)))
(define-const var383 Bool (var3945_isDefault/-1009400446 var2381)) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39) 
 ; Statement: if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39) 
(assert (not (= (ite var383 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var1594 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1594)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1594!1 String)
(assert (= var1594!1 ""))
(assert true)
(define-const var809 String (getName/-1958580599 var1821)) ; Statement: $r12 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3800 String (append/672562846 var1594!1 var809)) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var1594!2 String)
(assert (= var1594!2 (str.++ var1594!1 var809)))
(assert true)
(define-const var846 String (append/672562846 var3800 "Mock")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Mock") 
(declare-const var3800!1 String)
(assert (= var3800!1 (str.++ var3800 "Mock")))
(assert true)
(define-const var2381!1 String (toString/-2075883882 var846)) ; Statement: r39 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1085 var342) ; Statement: $r25 := @caughtexception 
(assert (not (= var1085 null-var342)))
 ; Statement: if z0 != 0 goto $r26 = new java.lang.IllegalStateException 
(assert (not (= (ite var383 1 0) 0))) ; Cond: z0 != 0 
(define-const var2493 var133 var133-init) ; Statement: $r26 = new java.lang.IllegalStateException 
(define-const var3666 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3666)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3666!1 String)
(assert (= var3666!1 ""))
(assert true)
(define-const var3554 String (append/672562846 var3666!1 "Did not find mock class or instance ")) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Did not find mock class or instance ") 
(declare-const var3666!2 String)
(assert (= var3666!2 (str.++ var3666!1 "Did not find mock class or instance ")))
(assert true)
(define-const var3497 String (append/672562846 var3554 var2381!1)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r39) 
(declare-const var3554!1 String)
(assert (= var3554!1 (str.++ var3554 var2381!1)))
(assert true)
(define-const var3410 String (append/672562846 var3497 ", please check if there\u0027s mock class or instance implementing interface ")) ; Statement: $r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check if there\'s mock class or instance implementing interface ") 
(declare-const var3497!1 String)
(assert (= var3497!1 (str.++ var3497 ", please check if there\u0027s mock class or instance implementing interface ")))
(assert true)
(define-const var70 String (getName/-1958580599 var1821)) ; Statement: $r30 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3744 String (append/672562846 var3410 var70)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30) 
(declare-const var3410!1 String)
(assert (= var3410!1 (str.++ var3410 var70)))
(assert true)
(define-const var264 String (toString/-2075883882 var3744)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var2493 var264 (cast-from-var342-to-var1840 var1085))) ; Statement: specialinvoke $r26.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r33, $r25) 

(declare-const var2493!1 var133)
(declare-const var264!1 String)
(declare-const var1085!1 var342)
 ; Statement: throw $r26 
(check-sat)
; {var3945_isDefault/-1009400446=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var133-init=([], java.lang.IllegalStateException), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void), cast-from-var342-to-var1840=([java.lang.Exception], java.lang.Throwable)}
; {var554=org.apache.dubbo.common.extension.ExtensionDirector, var2098=r34, var2381=r39, var1660=null_type, var1821=r5, var3945=org.apache.dubbo.common.utils.ConfigUtils, var383=z0, var1594=$r11, var809=$r12, var3800=$r13, var846=$r14, var342=java.lang.Exception, var1085=$r25, var133=java.lang.IllegalStateException, var2493=$r26, var3666=$r27, var3554=$r28, var3497=$r29, var3410=$r31, var70=$r30, var3744=$r32, var264=$r33, var1840=java.lang.Throwable}
; {org.apache.dubbo.common.extension.ExtensionDirector=var554, r34=var2098, r39=var2381, null_type=var1660, r5=var1821, org.apache.dubbo.common.utils.ConfigUtils=var3945, z0=var383, $r11=var1594, $r12=var809, $r13=var3800, $r14=var846, java.lang.Exception=var342, $r25=var1085, java.lang.IllegalStateException=var133, $r26=var2493, $r27=var3666, $r28=var3554, $r29=var3497, $r31=var3410, $r30=var70, $r32=var3744, $r33=var264, java.lang.Throwable=var1840}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector;	r39 := @parameter1: java.lang.String;	r5 := @parameter2: java.lang.Class;	z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39);	if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39);	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Mock");	r39 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	$r25 := @caughtexception;	if z0 != 0 goto $r26 = new java.lang.IllegalStateException;	$r26 = new java.lang.IllegalStateException;	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Did not find mock class or instance ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r39);	$r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check if there\'s mock class or instance implementing interface ");	$r30 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r26.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r33, $r25);	throw $r26
;block_num 4