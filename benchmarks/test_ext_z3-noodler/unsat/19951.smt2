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

(declare-sort var93 0)
(declare-sort var16 0)
(declare-sort var2424 0)
(declare-sort var2680 0)
(declare-sort var3609 0)
(declare-sort var1093 0)
(declare-sort var2790 0)
(declare-sort var1573 0)
(declare-sort var2906 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1093!class ClassObject)
(declare-fun var2424_isDefault/-1009400446 (String) Bool)
(declare-fun getExtensionLoader/1955029040 (var93 ClassObject) var3609)
(declare-fun getAdaptiveExtension/-2068350643 (var3609) var2790)
(declare-fun cast-from-var2790-to-var1093 (var2790) var1093)
(declare-fun var1093_getInstance/1223779195 (var1093 ClassObject String) var2790)
(declare-fun var1573-init () var1573)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var1573 String var2906) void)
(declare-fun cast-from-var2680-to-var2906 (var2680) var2906)
(declare-const null-var93 var93)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2680 var2680)
(declare-const null-var2790 var2790)
(declare-const var3839 var93) ; Statement: r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector 
(assert (not (= var3839 null-var93)))
(declare-const var2140 String) ; Statement: r39 := @parameter1: java.lang.String 
(assert (not (= var2140 null-String)))
(declare-const var3182 ClassObject) ; Statement: r5 := @parameter2: java.lang.Class 
(assert (not (= var3182 null-ClassObject)))
(define-const var515 Bool (var2424_isDefault/-1009400446 var2140)) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39) 
 ; Statement: if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39) 
(assert (not (= (ite var515 1 0) 0))) ; Negate: Cond: z0 == 0  
(declare-const var1202 var2680) ; Statement: $r25 := @caughtexception 
(assert (not (= var1202 null-var2680)))
 ; Statement: if z0 != 0 goto $r26 = new java.lang.IllegalStateException 
(assert (not (not (= (ite var515 1 0) 0)))) ; Negate: Cond: z0 != 0  
(assert true)
(define-const var1814 var3609 (getExtensionLoader/1955029040 var3839 var1093!class)) ; Statement: $r35 = virtualinvoke r34.<org.apache.dubbo.common.extension.ExtensionDirector: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/extension/ExtensionInjector;") 
(assert true)
(define-const var2108 var2790 (getAdaptiveExtension/-2068350643 var1814)) ; Statement: $r36 = virtualinvoke $r35.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getAdaptiveExtension()>() 
(define-const var1115 var1093 (cast-from-var2790-to-var1093 var2108)) ; Statement: r37 = (org.apache.dubbo.common.extension.ExtensionInjector) $r36 
(define-const var2260 var2790 (var1093_getInstance/1223779195 var1115 var3182 var2140)) ; Statement: r38 = interfaceinvoke r37.<org.apache.dubbo.common.extension.ExtensionInjector: java.lang.Object getInstance(java.lang.Class,java.lang.String)>(r5, r39) 
 ; Statement: if r38 == null goto $r26 = new java.lang.IllegalStateException 
(assert (= var2260 null-var2790)) ; Cond: r38 == null 
(define-const var3005 var1573 var1573-init) ; Statement: $r26 = new java.lang.IllegalStateException 
(define-const var2859 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2859)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2859!1 String)
(assert (= var2859!1 ""))
(assert true)
(define-const var835 String (append/672562846 var2859!1 "Did not find mock class or instance ")) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Did not find mock class or instance ") 
(declare-const var2859!2 String)
(assert (= var2859!2 (str.++ var2859!1 "Did not find mock class or instance ")))
(assert true)
(define-const var1902 String (append/672562846 var835 var2140)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r39) 
(declare-const var835!1 String)
(assert (= var835!1 (str.++ var835 var2140)))
(assert true)
(define-const var1381 String (append/672562846 var1902 ", please check if there\u0027s mock class or instance implementing interface ")) ; Statement: $r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check if there\'s mock class or instance implementing interface ") 
(declare-const var1902!1 String)
(assert (= var1902!1 (str.++ var1902 ", please check if there\u0027s mock class or instance implementing interface ")))
(assert true)
(define-const var3873 String (getName/-1958580599 var3182)) ; Statement: $r30 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1263 String (append/672562846 var1381 var3873)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30) 
(declare-const var1381!1 String)
(assert (= var1381!1 (str.++ var1381 var3873)))
(assert true)
(define-const var1407 String (toString/-2075883882 var1263)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var3005 var1407 (cast-from-var2680-to-var2906 var1202))) ; Statement: specialinvoke $r26.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r33, $r25) 

(declare-const var3005!1 var1573)
(declare-const var1407!1 String)
(declare-const var1202!1 var2680)
 ; Statement: throw $r26 
(check-sat)
; {var2424_isDefault/-1009400446=([java.lang.String], boolean), getExtensionLoader/1955029040=([org.apache.dubbo.common.extension.ExtensionDirector, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), getAdaptiveExtension/-2068350643=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), cast-from-var2790-to-var1093=([java.lang.Object], org.apache.dubbo.common.extension.ExtensionInjector), var1093_getInstance/1223779195=([org.apache.dubbo.common.extension.ExtensionInjector, java.lang.Class, java.lang.String], java.lang.Object), var1573-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void), cast-from-var2680-to-var2906=([java.lang.Exception], java.lang.Throwable)}
; {var93=org.apache.dubbo.common.extension.ExtensionDirector, var3839=r34, var2140=r39, var16=null_type, var3182=r5, var2424=org.apache.dubbo.common.utils.ConfigUtils, var515=z0, var2680=java.lang.Exception, var1202=$r25, var3609=org.apache.dubbo.common.extension.ExtensionLoader, var1093=org.apache.dubbo.common.extension.ExtensionInjector, var1814=$r35, var2790=java.lang.Object, var2108=$r36, var1115=r37, var2260=r38, var1573=java.lang.IllegalStateException, var3005=$r26, var2859=$r27, var835=$r28, var1902=$r29, var1381=$r31, var3873=$r30, var1263=$r32, var1407=$r33, var2906=java.lang.Throwable}
; {org.apache.dubbo.common.extension.ExtensionDirector=var93, r34=var3839, r39=var2140, null_type=var16, r5=var3182, org.apache.dubbo.common.utils.ConfigUtils=var2424, z0=var515, java.lang.Exception=var2680, $r25=var1202, org.apache.dubbo.common.extension.ExtensionLoader=var3609, org.apache.dubbo.common.extension.ExtensionInjector=var1093, $r35=var1814, java.lang.Object=var2790, $r36=var2108, r37=var1115, r38=var2260, java.lang.IllegalStateException=var1573, $r26=var3005, $r27=var2859, $r28=var835, $r29=var1902, $r31=var1381, $r30=var3873, $r32=var1263, $r33=var1407, java.lang.Throwable=var2906}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector;	r39 := @parameter1: java.lang.String;	r5 := @parameter2: java.lang.Class;	z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39);	if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39);	$r25 := @caughtexception;	if z0 != 0 goto $r26 = new java.lang.IllegalStateException;	$r35 = virtualinvoke r34.<org.apache.dubbo.common.extension.ExtensionDirector: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/extension/ExtensionInjector;");	$r36 = virtualinvoke $r35.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getAdaptiveExtension()>();	r37 = (org.apache.dubbo.common.extension.ExtensionInjector) $r36;	r38 = interfaceinvoke r37.<org.apache.dubbo.common.extension.ExtensionInjector: java.lang.Object getInstance(java.lang.Class,java.lang.String)>(r5, r39);	if r38 == null goto $r26 = new java.lang.IllegalStateException;	$r26 = new java.lang.IllegalStateException;	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Did not find mock class or instance ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r39);	$r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check if there\'s mock class or instance implementing interface ");	$r30 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r26.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r33, $r25);	throw $r26
;block_num 4