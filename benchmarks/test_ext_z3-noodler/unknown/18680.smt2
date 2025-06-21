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

(declare-sort var1868 0)
(declare-sort var2024 0)
(declare-sort var2056 0)
(declare-sort var2348 0)
(declare-sort var3342 0)
(declare-sort var795 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var1868) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun println/1773605060 (var2056 String) void)
(declare-fun getMessage/849299655 (var2024) String)
(declare-fun var3342_error/377575788 (var3342 String String String String var2024) void)
(define-fun append/1560614132 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const null-var1868 var1868)
(declare-const null-var2024 var2024)
(declare-const var2348-err var2056)
(declare-const var795-logger var3342)
(declare-const var3979 String) ; Statement: r1 := @parameter0: java.lang.StringBuffer 
(assert (not (= var3979 null-String)))
(declare-const var990 var1868) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var990 null-var1868)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2340 var2024) ; Statement: $r2 := @caughtexception 
(assert (not (= var2340 null-var2024)))
(define-const var3750 var2056 var2348-err) ; Statement: $r4 = <java.lang.System: java.io.PrintStream err> 
(define-const var357 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var357)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var357!1 String)
(assert (= var357!1 ""))
(assert true)
(define-const var126 String (append/672562846 var357!1 "SLF4J: Failed toString() invocation on an object of type [")) ; Statement: $r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("SLF4J: Failed toString() invocation on an object of type [") 
(declare-const var357!2 String)
(assert (= var357!2 (str.++ var357!1 "SLF4J: Failed toString() invocation on an object of type [")))
(assert true)
(define-const var1903 ClassObject (getClass/1258963082 var990)) ; Statement: $r5 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var919 String (getName/-1958580599 var1903)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var293 String (append/672562846 var126 var919)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var126!1 String)
(assert (= var126!1 (str.++ var126 var919)))
(assert true)
(define-const var229 String (append/-1166366385 var293 93)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(declare-const var293!1 String)
(assert (str.prefixof var293 var293!1))
(assert true)
(define-const var1057 String (toString/-2075883882 var229)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (println/1773605060 var3750 var1057)) ; Statement: virtualinvoke $r4.<java.io.PrintStream: void println(java.lang.String)>($r10) 

(declare-const var3750!1 var2056)
(declare-const var1057!1 String)
(define-const var3277 var3342 var795-logger) ; Statement: $r11 = <org.apache.dubbo.remoting.transport.netty4.logging.MessageFormatter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert true)
(define-const var3191 String (getMessage/849299655 var2340)) ; Statement: $r12 = virtualinvoke $r2.<java.lang.Throwable: java.lang.String getMessage()>() 
;(assert (var3342_error/377575788 var3277 "6-6" "" "" var3191 var2340)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-6", "", "", $r12, $r2) 

(declare-const var3277!1 var3342)
(declare-const var2139 String)
(declare-const var820 String)
(declare-const var820!1 String)
(declare-const var3191!1 String)
(declare-const var2340!1 var2024)
(assert true)
;(assert (append/1560614132 var3979 "[FAILED toString()]")) ; Statement: virtualinvoke r1.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("[FAILED toString()]") 
(declare-const var3979!1 String)
(assert (str.prefixof var3979 var3979!1))
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), println/1773605060=([java.io.PrintStream, java.lang.String], void), getMessage/849299655=([java.lang.Throwable], java.lang.String), var3342_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), append/1560614132=([java.lang.StringBuffer, java.lang.String], java.lang.StringBuffer)}
; {var3979=r1, var1868=java.lang.Object, var990=r0, var2024=java.lang.Throwable, var2340=$r2, var2056=java.io.PrintStream, var2348=java.lang.System, var3750=$r4, var357=$r3, var126=$r7, var1903=$r5, var919=$r6, var293=$r8, var229=$r9, var1057=$r10, var3342=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var795=org.apache.dubbo.remoting.transport.netty4.logging.MessageFormatter, var3277=$r11, var3191=$r12, var2139="6-6", var820=""}
; {r1=var3979, java.lang.Object=var1868, r0=var990, java.lang.Throwable=var2024, $r2=var2340, java.io.PrintStream=var2056, java.lang.System=var2348, $r4=var3750, $r3=var357, $r7=var126, $r5=var1903, $r6=var919, $r8=var293, $r9=var229, $r10=var1057, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3342, org.apache.dubbo.remoting.transport.netty4.logging.MessageFormatter=var795, $r11=var3277, $r12=var3191, "6-6"=var2139, ""=var820}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.StringBuffer;	r0 := @parameter1: java.lang.Object;	$r2 := @caughtexception;	$r4 = <java.lang.System: java.io.PrintStream err>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("SLF4J: Failed toString() invocation on an object of type [");	$r5 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r4.<java.io.PrintStream: void println(java.lang.String)>($r10);	$r11 = <org.apache.dubbo.remoting.transport.netty4.logging.MessageFormatter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r12 = virtualinvoke $r2.<java.lang.Throwable: java.lang.String getMessage()>();	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-6", "", "", $r12, $r2);	virtualinvoke r1.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("[FAILED toString()]");	return
;block_num 3