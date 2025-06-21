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

(declare-sort var3914 0)
(declare-sort var3334 0)
(declare-sort var3911 0)
(declare-sort var3957 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3911-init () var3911)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var3957) String)
(declare-fun cast-from-var3334-to-var3957 (var3334) var3957)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var3911 String var3957) void)
(declare-const null-String String)
(declare-const null-var3334 var3334)
(declare-const var358 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var358 null-String)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3252 var3334) ; Statement: $r2 := @caughtexception 
(assert (not (= var3252 null-var3334)))
(define-const var1668 var3911 var3911-init) ; Statement: $r3 = new java.lang.IllegalStateException 
(define-const var3689 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3689)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3689!1 String)
(assert (= var3689!1 ""))
(assert true)
(define-const var1071 String (append/672562846 var3689!1 "Not found class ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not found class ") 
(declare-const var3689!2 String)
(assert (= var3689!2 (str.++ var3689!1 "Not found class ")))
(assert true)
(define-const var2886 String (append/672562846 var1071 var358)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1071!1 String)
(assert (= var1071!1 (str.++ var1071 var358)))
(assert true)
(define-const var1901 String (append/672562846 var2886 ", cause: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var2886!1 String)
(assert (= var2886!1 (str.++ var2886 ", cause: ")))
(assert true)
(define-const var65 String (getMessage/849299655 (cast-from-var3334-to-var3957 var3252))) ; Statement: $r7 = virtualinvoke $r2.<java.lang.ClassNotFoundException: java.lang.String getMessage()>() 
(assert true)
(define-const var1081 String (append/672562846 var1901 var65)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1901!1 String)
(assert (= var1901!1 (str.++ var1901 var65)))
(assert true)
(define-const var1449 String (toString/-2075883882 var1081)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var1668 var1449 (cast-from-var3334-to-var3957 var3252))) ; Statement: specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r10, $r2) 

(declare-const var1668!1 var3911)
(declare-const var1449!1 String)
(declare-const var3252!1 var3334)
 ; Statement: throw $r3 
(check-sat)
; {var3911-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3334-to-var3957=([java.lang.ClassNotFoundException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var358=r0, var3914=null_type, var3334=java.lang.ClassNotFoundException, var3252=$r2, var3911=java.lang.IllegalStateException, var1668=$r3, var3689=$r4, var1071=$r5, var2886=$r6, var1901=$r8, var3957=java.lang.Throwable, var65=$r7, var1081=$r9, var1449=$r10}
; {r0=var358, null_type=var3914, java.lang.ClassNotFoundException=var3334, $r2=var3252, java.lang.IllegalStateException=var3911, $r3=var1668, $r4=var3689, $r5=var1071, $r6=var2886, $r8=var1901, java.lang.Throwable=var3957, $r7=var65, $r9=var1081, $r10=var1449}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r2 := @caughtexception;	$r3 = new java.lang.IllegalStateException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not found class ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r7 = virtualinvoke $r2.<java.lang.ClassNotFoundException: java.lang.String getMessage()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r10, $r2);	throw $r3
;block_num 2