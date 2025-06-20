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

(declare-sort var3293 0)
(declare-sort var1377 0)
(declare-sort var592 0)
(declare-sort var2923 0)
(declare-sort var2348 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2923-init () var2923)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var2348) String)
(declare-fun cast-from-var592-to-var2348 (var592) var2348)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var2923 String var2348) void)
(declare-const null-var3293 var3293)
(declare-const null-String String)
(declare-const null-var592 var592)
(declare-const var957 var3293) ; Statement: r0 := @parameter0: java.lang.ClassLoader 
(assert (not (= var957 null-var3293)))
(declare-const var3403 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3403 null-String)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2274 var592) ; Statement: $r3 := @caughtexception 
(assert (not (= var2274 null-var592)))
(define-const var667 var2923 var2923-init) ; Statement: $r4 = new java.lang.IllegalStateException 
(define-const var3048 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3048)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3048!1 String)
(assert (= var3048!1 ""))
(assert true)
(define-const var1171 String (append/672562846 var3048!1 "Not found class ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not found class ") 
(declare-const var3048!2 String)
(assert (= var3048!2 (str.++ var3048!1 "Not found class ")))
(assert true)
(define-const var3421 String (append/672562846 var1171 var3403)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1171!1 String)
(assert (= var1171!1 (str.++ var1171 var3403)))
(assert true)
(define-const var535 String (append/672562846 var3421 ", cause: ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3421!1 String)
(assert (= var3421!1 (str.++ var3421 ", cause: ")))
(assert true)
(define-const var2945 String (getMessage/849299655 (cast-from-var592-to-var2348 var2274))) ; Statement: $r8 = virtualinvoke $r3.<java.lang.ClassNotFoundException: java.lang.String getMessage()>() 
(assert true)
(define-const var2919 String (append/672562846 var535 var2945)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var535!1 String)
(assert (= var535!1 (str.++ var535 var2945)))
(assert true)
(define-const var152 String (toString/-2075883882 var2919)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var667 var152 (cast-from-var592-to-var2348 var2274))) ; Statement: specialinvoke $r4.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r3) 

(declare-const var667!1 var2923)
(declare-const var152!1 String)
(declare-const var2274!1 var592)
 ; Statement: throw $r4 
(check-sat)
; {var2923-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var592-to-var2348=([java.lang.ClassNotFoundException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var3293=java.lang.ClassLoader, var957=r0, var3403=r1, var1377=null_type, var592=java.lang.ClassNotFoundException, var2274=$r3, var2923=java.lang.IllegalStateException, var667=$r4, var3048=$r5, var1171=$r6, var3421=$r7, var535=$r9, var2348=java.lang.Throwable, var2945=$r8, var2919=$r10, var152=$r11}
; {java.lang.ClassLoader=var3293, r0=var957, r1=var3403, null_type=var1377, java.lang.ClassNotFoundException=var592, $r3=var2274, java.lang.IllegalStateException=var2923, $r4=var667, $r5=var3048, $r6=var1171, $r7=var3421, $r9=var535, java.lang.Throwable=var2348, $r8=var2945, $r10=var2919, $r11=var152}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.ClassLoader;	r1 := @parameter1: java.lang.String;	$r3 := @caughtexception;	$r4 = new java.lang.IllegalStateException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not found class ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r8 = virtualinvoke $r3.<java.lang.ClassNotFoundException: java.lang.String getMessage()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r3);	throw $r4
;block_num 2