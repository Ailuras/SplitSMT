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

(declare-sort var2802 0)
(declare-sort var2500 0)
(declare-sort var981 0)
(declare-sort var210 0)
(declare-sort var2759 0)
(declare-sort var881 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2500) void)
(declare-fun cast-from-var2802-to-var2500 (var2802) var2500)
(declare-fun propertiesLoaded/-694500788 (var2802) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var881) String)
(declare-fun cast-from-var981-to-var881 (var981) var881)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun println/1773605060 (var210 String) void)
(declare-const null-var2802 var2802)
(declare-const null-var981 var981)
(declare-const var2759-err var210)
(declare-const var3518 var2802) ; Statement: r0 := @this: org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter 
(assert (not (= var3518 null-var2802)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2802-to-var2500 var3518))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3518!1 var2802)
(declare-const var3518!2 var2802)
(assert (not (= var3518!2 null-var2802)))
(assert (= (propertiesLoaded/-694500788 var3518!2) (ite (= 1 0) true false))) ; Statement: r0.<org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter: boolean propertiesLoaded> = 0 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2976 var981) ; Statement: $r14 := @caughtexception 
(assert (not (= var2976 null-var981)))
(define-const var29 var210 var2759-err) ; Statement: $r16 = <java.lang.System: java.io.PrintStream err> 
(define-const var790 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var790)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var790!1 String)
(assert (= var790!1 ""))
(assert true)
(define-const var1191 String (append/672562846 var790!1 "Failed to load logging.properties in classpath for jdk logging config, cause: ")) ; Statement: $r18 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to load logging.properties in classpath for jdk logging config, cause: ") 
(declare-const var790!2 String)
(assert (= var790!2 (str.++ var790!1 "Failed to load logging.properties in classpath for jdk logging config, cause: ")))
(assert true)
(define-const var573 String (getMessage/849299655 (cast-from-var981-to-var881 var2976))) ; Statement: $r17 = virtualinvoke $r14.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var1778 String (append/672562846 var1191 var573)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var1191!1 String)
(assert (= var1191!1 (str.++ var1191 var573)))
(assert true)
(define-const var1053 String (toString/-2075883882 var1778)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (println/1773605060 var29 var1053)) ; Statement: virtualinvoke $r16.<java.io.PrintStream: void println(java.lang.String)>($r20) 

(declare-const var29!1 var210)
(declare-const var1053!1 String)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3033 var981) ; Statement: $r13 := @caughtexception 
(assert (not (= var3033 null-var981)))
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2802-to-var2500=([org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter], java.lang.Object), propertiesLoaded/-694500788=([org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var981-to-var881=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), println/1773605060=([java.io.PrintStream, java.lang.String], void)}
; {var2802=org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter, var3518=r0, var2500=java.lang.Object, var981=java.lang.Exception, var2976=$r14, var210=java.io.PrintStream, var2759=java.lang.System, var29=$r16, var790=$r15, var1191=$r18, var881=java.lang.Throwable, var573=$r17, var1778=$r19, var1053=$r20, var3033=$r13}
; {org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter=var2802, r0=var3518, java.lang.Object=var2500, java.lang.Exception=var981, $r14=var2976, java.io.PrintStream=var210, java.lang.System=var2759, $r16=var29, $r15=var790, $r18=var1191, java.lang.Throwable=var881, $r17=var573, $r19=var1778, $r20=var1053, $r13=var3033}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter: boolean propertiesLoaded> = 0;	$r14 := @caughtexception;	$r16 = <java.lang.System: java.io.PrintStream err>;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to load logging.properties in classpath for jdk logging config, cause: ");	$r17 = virtualinvoke $r14.<java.lang.Exception: java.lang.String getMessage()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r16.<java.io.PrintStream: void println(java.lang.String)>($r20);	$r13 := @caughtexception;	return
;block_num 4