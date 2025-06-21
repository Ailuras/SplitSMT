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

(declare-sort var1749 0)
(declare-sort var734 0)
(declare-sort var1967 0)
(declare-sort var974 0)
(declare-sort var1779 0)
(declare-sort var3420 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1967_isDefault/-1009400446 (String) Bool)
(declare-fun var1779-init () var1779)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var1779 String var3420) void)
(declare-fun cast-from-var974-to-var3420 (var974) var3420)
(declare-const null-var1749 var1749)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var974 var974)
(declare-const var803 var1749) ; Statement: r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector 
(assert (not (= var803 null-var1749)))
(declare-const var2171 String) ; Statement: r39 := @parameter1: java.lang.String 
(assert (not (= var2171 null-String)))
(declare-const var412 ClassObject) ; Statement: r5 := @parameter2: java.lang.Class 
(assert (not (= var412 null-ClassObject)))
(define-const var313 Bool (var1967_isDefault/-1009400446 var2171)) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39) 
 ; Statement: if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39) 
(assert (not (= (ite var313 1 0) 0))) ; Negate: Cond: z0 == 0  
(declare-const var2021 var974) ; Statement: $r25 := @caughtexception 
(assert (not (= var2021 null-var974)))
 ; Statement: if z0 != 0 goto $r26 = new java.lang.IllegalStateException 
(assert (not (= (ite var313 1 0) 0))) ; Cond: z0 != 0 
(define-const var3322 var1779 var1779-init) ; Statement: $r26 = new java.lang.IllegalStateException 
(define-const var2140 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2140)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2140!1 String)
(assert (= var2140!1 ""))
(assert true)
(define-const var3625 String (append/672562846 var2140!1 "Did not find mock class or instance ")) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Did not find mock class or instance ") 
(declare-const var2140!2 String)
(assert (= var2140!2 (str.++ var2140!1 "Did not find mock class or instance ")))
(assert true)
(define-const var519 String (append/672562846 var3625 var2171)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r39) 
(declare-const var3625!1 String)
(assert (= var3625!1 (str.++ var3625 var2171)))
(assert true)
(define-const var3087 String (append/672562846 var519 ", please check if there\u0027s mock class or instance implementing interface ")) ; Statement: $r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check if there\'s mock class or instance implementing interface ") 
(declare-const var519!1 String)
(assert (= var519!1 (str.++ var519 ", please check if there\u0027s mock class or instance implementing interface ")))
(assert true)
(define-const var2566 String (getName/-1958580599 var412)) ; Statement: $r30 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var950 String (append/672562846 var3087 var2566)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30) 
(declare-const var3087!1 String)
(assert (= var3087!1 (str.++ var3087 var2566)))
(assert true)
(define-const var1307 String (toString/-2075883882 var950)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var3322 var1307 (cast-from-var974-to-var3420 var2021))) ; Statement: specialinvoke $r26.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r33, $r25) 

(declare-const var3322!1 var1779)
(declare-const var1307!1 String)
(declare-const var2021!1 var974)
 ; Statement: throw $r26 
(check-sat)
; {var1967_isDefault/-1009400446=([java.lang.String], boolean), var1779-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void), cast-from-var974-to-var3420=([java.lang.Exception], java.lang.Throwable)}
; {var1749=org.apache.dubbo.common.extension.ExtensionDirector, var803=r34, var2171=r39, var734=null_type, var412=r5, var1967=org.apache.dubbo.common.utils.ConfigUtils, var313=z0, var974=java.lang.Exception, var2021=$r25, var1779=java.lang.IllegalStateException, var3322=$r26, var2140=$r27, var3625=$r28, var519=$r29, var3087=$r31, var2566=$r30, var950=$r32, var1307=$r33, var3420=java.lang.Throwable}
; {org.apache.dubbo.common.extension.ExtensionDirector=var1749, r34=var803, r39=var2171, null_type=var734, r5=var412, org.apache.dubbo.common.utils.ConfigUtils=var1967, z0=var313, java.lang.Exception=var974, $r25=var2021, java.lang.IllegalStateException=var1779, $r26=var3322, $r27=var2140, $r28=var3625, $r29=var519, $r31=var3087, $r30=var2566, $r32=var950, $r33=var1307, java.lang.Throwable=var3420}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector;	r39 := @parameter1: java.lang.String;	r5 := @parameter2: java.lang.Class;	z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39);	if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39);	$r25 := @caughtexception;	if z0 != 0 goto $r26 = new java.lang.IllegalStateException;	$r26 = new java.lang.IllegalStateException;	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Did not find mock class or instance ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r39);	$r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check if there\'s mock class or instance implementing interface ");	$r30 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r26.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r33, $r25);	throw $r26
;block_num 3