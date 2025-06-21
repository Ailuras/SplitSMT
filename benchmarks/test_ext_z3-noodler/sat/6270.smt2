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

(declare-sort var1437 0)
(declare-sort var2024 0)
(declare-sort var775 0)
(declare-sort var196 0)
(declare-sort var191 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getAdaptiveExtensionClass/745691076 (var1437) ClassObject)
(declare-fun var775-init () var775)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/-1855590362 (var1437) ClassObject)
(declare-fun append/-1031950772 (String var196) String)
(declare-fun cast-from-ClassObject-to-var196 (ClassObject) var196)
(declare-fun getMessage/849299655 (var191) String)
(declare-fun cast-from-var2024-to-var191 (var2024) var191)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var775 String var191) void)
(declare-const null-var1437 var1437)
(declare-const null-var2024 var2024)
(declare-const var3829 var1437) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var3829 null-var1437)))
(assert true) ; Non Conditional
(assert true)
(define-const var2563 ClassObject (getAdaptiveExtensionClass/745691076 var3829)) ; Statement: $r1 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getAdaptiveExtensionClass()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3147 var2024) ; Statement: $r2 := @caughtexception 
(assert (not (= var3147 null-var2024)))
(define-const var2715 var775 var775-init) ; Statement: $r3 = new java.lang.IllegalStateException 
(define-const var3837 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3837)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3837!1 String)
(assert (= var3837!1 ""))
(assert true)
(define-const var860 String (append/672562846 var3837!1 "Can\u0027t create adaptive extension ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Can\'t create adaptive extension ") 
(declare-const var3837!2 String)
(assert (= var3837!2 (str.++ var3837!1 "Can\u0027t create adaptive extension ")))
(define-const var843 ClassObject (type/-1855590362 var3829)) ; Statement: $r5 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var1725 String (append/-1031950772 var860 (cast-from-ClassObject-to-var196 var843))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var860!1 String)
(assert (str.prefixof var860 var860!1))
(assert true)
(define-const var839 String (append/672562846 var1725 ", cause: ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1725!1 String)
(assert (= var1725!1 (str.++ var1725 ", cause: ")))
(assert true)
(define-const var1769 String (getMessage/849299655 (cast-from-var2024-to-var191 var3147))) ; Statement: $r8 = virtualinvoke $r2.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var2871 String (append/672562846 var839 var1769)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var839!1 String)
(assert (= var839!1 (str.++ var839 var1769)))
(assert true)
(define-const var2201 String (toString/-2075883882 var2871)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var2715 var2201 (cast-from-var2024-to-var191 var3147))) ; Statement: specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r2) 

(declare-const var2715!1 var775)
(declare-const var2201!1 String)
(declare-const var3147!1 var2024)
 ; Statement: throw $r3 
(check-sat)
; {getAdaptiveExtensionClass/745691076=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), var775-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var196=([java.lang.Class], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2024-to-var191=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var1437=org.apache.dubbo.common.extension.ExtensionLoader, var3829=r0, var2563=$r1, var2024=java.lang.Exception, var3147=$r2, var775=java.lang.IllegalStateException, var2715=$r3, var3837=$r4, var860=$r6, var843=$r5, var196=java.lang.Object, var1725=$r7, var839=$r9, var191=java.lang.Throwable, var1769=$r8, var2871=$r10, var2201=$r11}
; {org.apache.dubbo.common.extension.ExtensionLoader=var1437, r0=var3829, $r1=var2563, java.lang.Exception=var2024, $r2=var3147, java.lang.IllegalStateException=var775, $r3=var2715, $r4=var3837, $r6=var860, $r5=var843, java.lang.Object=var196, $r7=var1725, $r9=var839, java.lang.Throwable=var191, $r8=var1769, $r10=var2871, $r11=var2201}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	$r1 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getAdaptiveExtensionClass()>();	$r2 := @caughtexception;	$r3 = new java.lang.IllegalStateException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Can\'t create adaptive extension ");	$r5 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r8 = virtualinvoke $r2.<java.lang.Exception: java.lang.String getMessage()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r2);	throw $r3
;block_num 3