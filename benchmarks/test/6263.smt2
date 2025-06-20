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

(declare-sort var3079 0)
(declare-sort var1729 0)
(declare-sort var514 0)
(declare-sort var3640 0)
(declare-sort var3751 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var514-init () var514)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/-1855590362 (var3079) ClassObject)
(declare-fun append/-1031950772 (String var3640) String)
(declare-fun cast-from-ClassObject-to-var3640 (ClassObject) var3640)
(declare-fun getMessage/849299655 (var3751) String)
(declare-fun cast-from-var1729-to-var3751 (var1729) var3751)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var514 String var3751) void)
(declare-const null-var3079 var3079)
(declare-const null-var1729 var1729)
(declare-const var308 var3079) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var308 null-var3079)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3756 var1729) ; Statement: $r2 := @caughtexception 
(assert (not (= var3756 null-var1729)))
(define-const var3879 var514 var514-init) ; Statement: $r3 = new java.lang.IllegalStateException 
(define-const var1942 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1942)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1942!1 String)
(assert (= var1942!1 ""))
(assert true)
(define-const var2726 String (append/672562846 var1942!1 "Can\u0027t create adaptive extension ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Can\'t create adaptive extension ") 
(declare-const var1942!2 String)
(assert (= var1942!2 (str.++ var1942!1 "Can\u0027t create adaptive extension ")))
(define-const var395 ClassObject (type/-1855590362 var308)) ; Statement: $r5 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var3809 String (append/-1031950772 var2726 (cast-from-ClassObject-to-var3640 var395))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2726!1 String)
(assert (str.prefixof var2726 var2726!1))
(assert true)
(define-const var698 String (append/672562846 var3809 ", cause: ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3809!1 String)
(assert (= var3809!1 (str.++ var3809 ", cause: ")))
(assert true)
(define-const var3734 String (getMessage/849299655 (cast-from-var1729-to-var3751 var3756))) ; Statement: $r8 = virtualinvoke $r2.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var1037 String (append/672562846 var698 var3734)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var698!1 String)
(assert (= var698!1 (str.++ var698 var3734)))
(assert true)
(define-const var1590 String (toString/-2075883882 var1037)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var3879 var1590 (cast-from-var1729-to-var3751 var3756))) ; Statement: specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r2) 

(declare-const var3879!1 var514)
(declare-const var1590!1 String)
(declare-const var3756!1 var1729)
 ; Statement: throw $r3 
(check-sat)
; {var514-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3640=([java.lang.Class], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var1729-to-var3751=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var3079=org.apache.dubbo.common.extension.ExtensionLoader, var308=r0, var1729=java.lang.Exception, var3756=$r2, var514=java.lang.IllegalStateException, var3879=$r3, var1942=$r4, var2726=$r6, var395=$r5, var3640=java.lang.Object, var3809=$r7, var698=$r9, var3751=java.lang.Throwable, var3734=$r8, var1037=$r10, var1590=$r11}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3079, r0=var308, java.lang.Exception=var1729, $r2=var3756, java.lang.IllegalStateException=var514, $r3=var3879, $r4=var1942, $r6=var2726, $r5=var395, java.lang.Object=var3640, $r7=var3809, $r9=var698, java.lang.Throwable=var3751, $r8=var3734, $r10=var1037, $r11=var1590}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	$r2 := @caughtexception;	$r3 = new java.lang.IllegalStateException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Can\'t create adaptive extension ");	$r5 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r8 = virtualinvoke $r2.<java.lang.Exception: java.lang.String getMessage()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r2);	throw $r3
;block_num 2