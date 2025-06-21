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

(declare-sort var73 0)
(declare-sort var57 0)
(declare-sort var2125 0)
(declare-sort var2668 0)
(declare-sort var2926 0)
(declare-sort var2720 0)
(declare-sort var1994 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2125_isDefault/-1009400446 (String) Bool)
(declare-fun var2668_forName/-1763490630 (String) ClassObject)
(declare-fun var2720-init () var2720)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var2720 String var1994) void)
(declare-fun cast-from-var2926-to-var1994 (var2926) var1994)
(declare-const null-var73 var73)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2926 var2926)
(declare-const var1107 var73) ; Statement: r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector 
(assert (not (= var1107 null-var73)))
(declare-const var3397 String) ; Statement: r39 := @parameter1: java.lang.String 
(assert (not (= var3397 null-String)))
(declare-const var3225 ClassObject) ; Statement: r5 := @parameter2: java.lang.Class 
(assert (not (= var3225 null-ClassObject)))
(define-const var2164 Bool (var2125_isDefault/-1009400446 var3397)) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39) 
 ; Statement: if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39) 
(assert (= (ite var2164 1 0) 0)) ; Cond: z0 == 0 
(define-const var3704 ClassObject (var2668_forName/-1763490630 var3397)) ; Statement: $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2610 var2926) ; Statement: $r25 := @caughtexception 
(assert (not (= var2610 null-var2926)))
 ; Statement: if z0 != 0 goto $r26 = new java.lang.IllegalStateException 
(assert (not (= (ite var2164 1 0) 0))) ; Cond: z0 != 0 
(define-const var1739 var2720 var2720-init) ; Statement: $r26 = new java.lang.IllegalStateException 
(define-const var2187 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2187)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2187!1 String)
(assert (= var2187!1 ""))
(assert true)
(define-const var514 String (append/672562846 var2187!1 "Did not find mock class or instance ")) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Did not find mock class or instance ") 
(declare-const var2187!2 String)
(assert (= var2187!2 (str.++ var2187!1 "Did not find mock class or instance ")))
(assert true)
(define-const var2074 String (append/672562846 var514 var3397)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r39) 
(declare-const var514!1 String)
(assert (= var514!1 (str.++ var514 var3397)))
(assert true)
(define-const var656 String (append/672562846 var2074 ", please check if there\u0027s mock class or instance implementing interface ")) ; Statement: $r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check if there\'s mock class or instance implementing interface ") 
(declare-const var2074!1 String)
(assert (= var2074!1 (str.++ var2074 ", please check if there\u0027s mock class or instance implementing interface ")))
(assert true)
(define-const var1310 String (getName/-1958580599 var3225)) ; Statement: $r30 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var691 String (append/672562846 var656 var1310)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30) 
(declare-const var656!1 String)
(assert (= var656!1 (str.++ var656 var1310)))
(assert true)
(define-const var796 String (toString/-2075883882 var691)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var1739 var796 (cast-from-var2926-to-var1994 var2610))) ; Statement: specialinvoke $r26.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r33, $r25) 

(declare-const var1739!1 var2720)
(declare-const var796!1 String)
(declare-const var2610!1 var2926)
 ; Statement: throw $r26 
(check-sat)
; {var2125_isDefault/-1009400446=([java.lang.String], boolean), var2668_forName/-1763490630=([java.lang.String], java.lang.Class), var2720-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void), cast-from-var2926-to-var1994=([java.lang.Exception], java.lang.Throwable)}
; {var73=org.apache.dubbo.common.extension.ExtensionDirector, var1107=r34, var3397=r39, var57=null_type, var3225=r5, var2125=org.apache.dubbo.common.utils.ConfigUtils, var2164=z0, var2668=org.apache.dubbo.common.utils.ReflectUtils, var3704=$r15, var2926=java.lang.Exception, var2610=$r25, var2720=java.lang.IllegalStateException, var1739=$r26, var2187=$r27, var514=$r28, var2074=$r29, var656=$r31, var1310=$r30, var691=$r32, var796=$r33, var1994=java.lang.Throwable}
; {org.apache.dubbo.common.extension.ExtensionDirector=var73, r34=var1107, r39=var3397, null_type=var57, r5=var3225, org.apache.dubbo.common.utils.ConfigUtils=var2125, z0=var2164, org.apache.dubbo.common.utils.ReflectUtils=var2668, $r15=var3704, java.lang.Exception=var2926, $r25=var2610, java.lang.IllegalStateException=var2720, $r26=var1739, $r27=var2187, $r28=var514, $r29=var2074, $r31=var656, $r30=var1310, $r32=var691, $r33=var796, java.lang.Throwable=var1994}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector;	r39 := @parameter1: java.lang.String;	r5 := @parameter2: java.lang.Class;	z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39);	if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39);	$r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39);	$r25 := @caughtexception;	if z0 != 0 goto $r26 = new java.lang.IllegalStateException;	$r26 = new java.lang.IllegalStateException;	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Did not find mock class or instance ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r39);	$r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check if there\'s mock class or instance implementing interface ");	$r30 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r26.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r33, $r25);	throw $r26
;block_num 4