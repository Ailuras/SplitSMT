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

(declare-sort var742 0)
(declare-sort var2382 0)
(declare-sort var2351 0)
(declare-sort var1044 0)
(declare-sort var3985 0)
(declare-sort var1443 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2382-init () var2382)
(declare-fun <init>/358169345 (var2382) void)
(declare-fun var2351-init () var2351)
(declare-fun <init>/-1864438596 (var2351 var1044) void)
(declare-fun cast-from-var2382-to-var1044 (var2382) var1044)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var3985) ClassObject)
(declare-fun cast-from-var742-to-var3985 (var742) var3985)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun print/-2007916749 (var2351 String) void)
(declare-fun getMessage/849299655 (var742) String)
(declare-fun println/348898060 (var2351) void)
(declare-fun close/2116439267 (var2351) void)
(declare-const null-var742 var742)
(declare-const null-String String)
(declare-const var3581 var742) ; Statement: r3 := @parameter0: java.lang.Throwable 
(assert (not (= var3581 null-var742)))
(define-const var1007 var2382 var2382-init) ; Statement: $r0 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var1007)) ; Statement: specialinvoke $r0.<java.io.StringWriter: void <init>()>() 

(declare-const var1007!1 var2382)
(define-const var3862 var2351 var2351-init) ; Statement: $r1 = new java.io.PrintWriter 
(assert true)
;(assert (<init>/-1864438596 var3862 (cast-from-var2382-to-var1044 var1007!1))) ; Statement: specialinvoke $r1.<java.io.PrintWriter: void <init>(java.io.Writer)>($r0) 

(declare-const var3862!1 var2351)
(declare-const var1007!2 var2382)
(define-const var2926 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2926)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2926!1 String)
(assert (= var2926!1 ""))
(assert true)
(define-const var2616 ClassObject (getClass/1258963082 (cast-from-var742-to-var3985 var3581))) ; Statement: $r4 = virtualinvoke r3.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1944 String (getName/-1958580599 var2616)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2814 String (append/672562846 var2926!1 var1944)) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2926!2 String)
(assert (= var2926!2 (str.++ var2926!1 var1944)))
(assert true)
(define-const var1013 String (append/672562846 var2814 ": ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": ") 
(declare-const var2814!1 String)
(assert (= var2814!1 (str.++ var2814 ": ")))
(assert true)
(define-const var3605 String (toString/-2075883882 var1013)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (print/-2007916749 var3862!1 var3605)) ; Statement: virtualinvoke $r1.<java.io.PrintWriter: void print(java.lang.String)>($r8) 

(declare-const var3862!2 var2351)
(declare-const var3605!1 String)
(assert true)
(define-const var526 String (getMessage/849299655 var3581)) ; Statement: $r9 = virtualinvoke r3.<java.lang.Throwable: java.lang.String getMessage()>() 
 ; Statement: if $r9 == null goto virtualinvoke $r1.<java.io.PrintWriter: void println()>() 
(assert (= var526 null-String)) ; Cond: $r9 == null 
(assert true)
;(assert (println/348898060 var3862!2)) ; Statement: virtualinvoke $r1.<java.io.PrintWriter: void println()>() 

(declare-const var3862!3 var2351)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3635 var742) ; Statement: $r16 := @caughtexception 
(assert (not (= var3635 null-var742)))
(assert true) ; Non Conditional
(assert true)
;(assert (close/2116439267 var3862!3)) ; Statement: virtualinvoke $r1.<java.io.PrintWriter: void close()>() 

(declare-const var3862!4 var2351)
 ; Statement: throw $r16 
(check-sat)
; {var2382-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), var2351-init=([], java.io.PrintWriter), <init>/-1864438596=([java.io.PrintWriter, java.io.Writer], void), cast-from-var2382-to-var1044=([java.io.StringWriter], java.io.Writer), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var742-to-var3985=([java.lang.Throwable], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), print/-2007916749=([java.io.PrintWriter, java.lang.String], void), getMessage/849299655=([java.lang.Throwable], java.lang.String), println/348898060=([java.io.PrintWriter], void), close/2116439267=([java.io.PrintWriter], void)}
; {var742=java.lang.Throwable, var3581=r3, var2382=java.io.StringWriter, var1007=$r0, var2351=java.io.PrintWriter, var3862=$r1, var1044=java.io.Writer, var2926=$r2, var3985=java.lang.Object, var2616=$r4, var1944=$r5, var2814=$r6, var1013=$r7, var3605=$r8, var526=$r9, var1443=null_type, var3635=$r16}
; {java.lang.Throwable=var742, r3=var3581, java.io.StringWriter=var2382, $r0=var1007, java.io.PrintWriter=var2351, $r1=var3862, java.io.Writer=var1044, $r2=var2926, java.lang.Object=var3985, $r4=var2616, $r5=var1944, $r6=var2814, $r7=var1013, $r8=var3605, $r9=var526, null_type=var1443, $r16=var3635}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: java.lang.Throwable;	$r0 = new java.io.StringWriter;	specialinvoke $r0.<java.io.StringWriter: void <init>()>();	$r1 = new java.io.PrintWriter;	specialinvoke $r1.<java.io.PrintWriter: void <init>(java.io.Writer)>($r0);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke r3.<java.lang.Object: java.lang.Class getClass()>();	$r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>();	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r1.<java.io.PrintWriter: void print(java.lang.String)>($r8);	$r9 = virtualinvoke r3.<java.lang.Throwable: java.lang.String getMessage()>();	if $r9 == null goto virtualinvoke $r1.<java.io.PrintWriter: void println()>();	virtualinvoke $r1.<java.io.PrintWriter: void println()>();	$r16 := @caughtexception;	virtualinvoke $r1.<java.io.PrintWriter: void close()>();	throw $r16
;block_num 4