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

(declare-sort var3051 0)
(declare-sort var2134 0)
(declare-sort var3009 0)
(declare-sort var2819 0)
(declare-sort var1239 0)
(declare-sort var1175 0)
(declare-sort var3123 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClass/1258963082 (var3009) ClassObject)
(declare-fun cast-from-var2134-to-var3009 (var2134) var3009)
(declare-fun var2134_getTagName/1081555567 (ClassObject) String)
(declare-fun configIdIndexes/208128580 (var3051) var2819)
(declare-fun var1175_bootstrap$/-746441821 () var1239)
(declare-fun var2819_computeIfAbsent/2133881068 (var2819 var3009 var1239) var3009)
(declare-fun cast-from-String-to-var3009 (String) var3009)
(declare-fun cast-from-var3009-to-var3123 (var3009) var3123)
(declare-fun incrementAndGet/613115697 (var3123) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3051 var3051)
(declare-const null-var2134 var2134)
(declare-const var3876 var3051) ; Statement: r3 := @this: org.apache.dubbo.config.context.AbstractConfigManager 
(assert (not (= var3876 null-var3051)))
(declare-const var3710 var2134) ; Statement: r0 := @parameter0: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var3710 null-var2134)))
(assert true)
(define-const var2153 ClassObject (getClass/1258963082 (cast-from-var2134-to-var3009 var3710))) ; Statement: $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(define-const var872 String (var2134_getTagName/1081555567 var2153)) ; Statement: r2 = staticinvoke <org.apache.dubbo.config.AbstractConfig: java.lang.String getTagName(java.lang.Class)>($r1) 
(define-const var974 var2819 (configIdIndexes/208128580 var3876)) ; Statement: $r4 = r3.<org.apache.dubbo.config.context.AbstractConfigManager: java.util.Map configIdIndexes> 
(define-const var1958 var1239 var1175_bootstrap$/-746441821) ; Statement: $r5 = staticinvoke <org.apache.dubbo.config.context.AbstractConfigManager$lambda_generateConfigId_5__363: java.util.function.Function bootstrap$()>() 
(define-const var1919 var3009 (var2819_computeIfAbsent/2133881068 var974 (cast-from-String-to-var3009 var872) var1958)) ; Statement: $r6 = interfaceinvoke $r4.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r2, $r5) 
(define-const var752 var3123 (cast-from-var3009-to-var3123 var1919)) ; Statement: $r7 = (java.util.concurrent.atomic.AtomicInteger) $r6 
(assert true)
(define-const var3094 Int (incrementAndGet/613115697 var752)) ; Statement: i0 = virtualinvoke $r7.<java.util.concurrent.atomic.AtomicInteger: int incrementAndGet()>() 
(define-const var2932 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2932)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2932!1 String)
(assert (= var2932!1 ""))
(assert true)
(define-const var920 String (append/672562846 var2932!1 var872)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2932!2 String)
(assert (= var2932!2 (str.++ var2932!1 var872)))
(assert true)
(define-const var462 String (append/672562846 var920 "#")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("#") 
(declare-const var920!1 String)
(assert (= var920!1 (str.++ var920 "#")))
(assert true)
(define-const var3017 String (append/-1001720160 var462 var3094)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var462!1 String)
(assert (str.prefixof var462 var462!1))
(assert true)
(define-const var2520 String (toString/-2075883882 var3017)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var2134-to-var3009=([org.apache.dubbo.config.AbstractConfig], java.lang.Object), var2134_getTagName/1081555567=([java.lang.Class], java.lang.String), configIdIndexes/208128580=([org.apache.dubbo.config.context.AbstractConfigManager], java.util.Map), var1175_bootstrap$/-746441821=([], java.util.function.Function), var2819_computeIfAbsent/2133881068=([java.util.Map, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var3009=([java.lang.String], java.lang.Object), cast-from-var3009-to-var3123=([java.lang.Object], java.util.concurrent.atomic.AtomicInteger), incrementAndGet/613115697=([java.util.concurrent.atomic.AtomicInteger], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3051=org.apache.dubbo.config.context.AbstractConfigManager, var3876=r3, var2134=org.apache.dubbo.config.AbstractConfig, var3710=r0, var3009=java.lang.Object, var2153=$r1, var872=r2, var2819=java.util.Map, var974=$r4, var1239=java.util.function.Function, var1175=org.apache.dubbo.config.context.AbstractConfigManager$lambda_generateConfigId_5__363, var1958=$r5, var1919=$r6, var3123=java.util.concurrent.atomic.AtomicInteger, var752=$r7, var3094=i0, var2932=$r8, var920=$r9, var462=$r10, var3017=$r11, var2520=$r12}
; {org.apache.dubbo.config.context.AbstractConfigManager=var3051, r3=var3876, org.apache.dubbo.config.AbstractConfig=var2134, r0=var3710, java.lang.Object=var3009, $r1=var2153, r2=var872, java.util.Map=var2819, $r4=var974, java.util.function.Function=var1239, org.apache.dubbo.config.context.AbstractConfigManager$lambda_generateConfigId_5__363=var1175, $r5=var1958, $r6=var1919, java.util.concurrent.atomic.AtomicInteger=var3123, $r7=var752, i0=var3094, $r8=var2932, $r9=var920, $r10=var462, $r11=var3017, $r12=var2520}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.config.context.AbstractConfigManager;	r0 := @parameter0: org.apache.dubbo.config.AbstractConfig;	$r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	r2 = staticinvoke <org.apache.dubbo.config.AbstractConfig: java.lang.String getTagName(java.lang.Class)>($r1);	$r4 = r3.<org.apache.dubbo.config.context.AbstractConfigManager: java.util.Map configIdIndexes>;	$r5 = staticinvoke <org.apache.dubbo.config.context.AbstractConfigManager$lambda_generateConfigId_5__363: java.util.function.Function bootstrap$()>();	$r6 = interfaceinvoke $r4.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r2, $r5);	$r7 = (java.util.concurrent.atomic.AtomicInteger) $r6;	i0 = virtualinvoke $r7.<java.util.concurrent.atomic.AtomicInteger: int incrementAndGet()>();	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("#");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1