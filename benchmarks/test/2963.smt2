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

(declare-sort var163 0)
(declare-sort var2229 0)
(declare-sort var3243 0)
(declare-sort var261 0)
(declare-sort var2439 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var163) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun println/1773605060 (var3243 String) void)
(declare-fun getStackTrace/1942967699 (var2229) (Array Int var2439))
(declare-fun getLength-Arr-var2439-1 ((Array Int var2439)) Int)
(declare-fun println/69091442 (var3243 var163) void)
(declare-fun cast-from-String-to-var163 (String) var163)
(declare-const null-String String)
(declare-const null-var163 var163)
(declare-const null-var2229 var2229)
(declare-const var261-err var3243)
(declare-const var158 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var158 null-String)))
(declare-const var2136 var163) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var2136 null-var163)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var64 var2229) ; Statement: $r2 := @caughtexception 
(assert (not (= var64 null-var2229)))
(define-const var3385 var3243 var261-err) ; Statement: $r4 = <java.lang.System: java.io.PrintStream err> 
(define-const var2162 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2162)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2162!1 String)
(assert (= var2162!1 ""))
(assert true)
(define-const var894 String (append/672562846 var2162!1 "SLF4J: Failed toString() invocation on an object of type [")) ; Statement: $r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("SLF4J: Failed toString() invocation on an object of type [") 
(declare-const var2162!2 String)
(assert (= var2162!2 (str.++ var2162!1 "SLF4J: Failed toString() invocation on an object of type [")))
(assert true)
(define-const var2333 ClassObject (getClass/1258963082 var2136)) ; Statement: $r5 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1354 String (getName/-1958580599 var2333)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3161 String (append/672562846 var894 var1354)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var894!1 String)
(assert (= var894!1 (str.++ var894 var1354)))
(assert true)
(define-const var791 String (append/672562846 var3161 "]")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var3161!1 String)
(assert (= var3161!1 (str.++ var3161 "]")))
(assert true)
(define-const var318 String (toString/-2075883882 var791)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (println/1773605060 var3385 var318)) ; Statement: virtualinvoke $r4.<java.io.PrintStream: void println(java.lang.String)>($r10) 

(declare-const var3385!1 var3243)
(declare-const var318!1 String)
(define-const var885 var3243 var261-err) ; Statement: $r11 = <java.lang.System: java.io.PrintStream err> 
(assert true)
;(assert (println/1773605060 var885 "Reported exception:")) ; Statement: virtualinvoke $r11.<java.io.PrintStream: void println(java.lang.String)>("Reported exception:") 

(declare-const var885!1 var3243)
(declare-const var1242 String)
(assert true)
(define-const var1057 (Array Int var2439) (getStackTrace/1942967699 var64)) ; Statement: r12 = virtualinvoke $r2.<java.lang.Throwable: java.lang.StackTraceElement[] getStackTrace()>() 
(define-const var393 String String-init) ; Statement: $r13 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var393)) ; Statement: specialinvoke $r13.<java.lang.StringBuilder: void <init>()>() 
(declare-const var393!1 String)
(assert (= var393!1 ""))
(define-const var2729 Int (getLength-Arr-var2439-1 var1057)) ; Statement: i0 = lengthof r12 
(define-const var2632 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r14 = <java.lang.System: java.io.PrintStream err> 
(assert (>= var2632 var2729)) ; Cond: i1 >= i0 
(define-const var870 var3243 var261-err) ; Statement: $r14 = <java.lang.System: java.io.PrintStream err> 
(assert true)
;(assert (println/69091442 var870 (cast-from-String-to-var163 var393!1))) ; Statement: virtualinvoke $r14.<java.io.PrintStream: void println(java.lang.Object)>($r13) 

(declare-const var870!1 var3243)
(declare-const var393!2 String)
(assert true)
;(assert (append/672562846 var158 "[FAILED toString()]")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[FAILED toString()]") 
(declare-const var158!1 String)
(assert (= var158!1 (str.++ var158 "[FAILED toString()]")))
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), println/1773605060=([java.io.PrintStream, java.lang.String], void), getStackTrace/1942967699=([java.lang.Throwable], java.lang.StackTraceElement[]), getLength-Arr-var2439-1=([java.lang.StackTraceElement[]], int), println/69091442=([java.io.PrintStream, java.lang.Object], void), cast-from-String-to-var163=([java.lang.StringBuilder], java.lang.Object)}
; {var158=r1, var163=java.lang.Object, var2136=r0, var2229=java.lang.Throwable, var64=$r2, var3243=java.io.PrintStream, var261=java.lang.System, var3385=$r4, var2162=$r3, var894=$r7, var2333=$r5, var1354=$r6, var3161=$r8, var791=$r9, var318=$r10, var885=$r11, var1242="Reported exception:", var2439=java.lang.StackTraceElement, var1057=r12, var393=$r13, var2729=i0, var2632=i1, var870=$r14}
; {r1=var158, java.lang.Object=var163, r0=var2136, java.lang.Throwable=var2229, $r2=var64, java.io.PrintStream=var3243, java.lang.System=var261, $r4=var3385, $r3=var2162, $r7=var894, $r5=var2333, $r6=var1354, $r8=var3161, $r9=var791, $r10=var318, $r11=var885, "Reported exception:"=var1242, java.lang.StackTraceElement=var2439, r12=var1057, $r13=var393, i0=var2729, i1=var2632, $r14=var870}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r0 := @parameter1: java.lang.Object;	$r2 := @caughtexception;	$r4 = <java.lang.System: java.io.PrintStream err>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("SLF4J: Failed toString() invocation on an object of type [");	$r5 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r4.<java.io.PrintStream: void println(java.lang.String)>($r10);	$r11 = <java.lang.System: java.io.PrintStream err>;	virtualinvoke $r11.<java.io.PrintStream: void println(java.lang.String)>("Reported exception:");	r12 = virtualinvoke $r2.<java.lang.Throwable: java.lang.StackTraceElement[] getStackTrace()>();	$r13 = new java.lang.StringBuilder;	specialinvoke $r13.<java.lang.StringBuilder: void <init>()>();	i0 = lengthof r12;	i1 = 0;	if i1 >= i0 goto $r14 = <java.lang.System: java.io.PrintStream err>;	$r14 = <java.lang.System: java.io.PrintStream err>;	virtualinvoke $r14.<java.io.PrintStream: void println(java.lang.Object)>($r13);	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[FAILED toString()]");	return
;block_num 5