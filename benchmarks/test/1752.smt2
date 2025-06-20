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

(declare-sort var3864 0)
(declare-sort var505 0)
(declare-sort var3350 0)
(declare-sort var2560 0)
(declare-sort var2573 0)
(declare-sort var885 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2573-init () var2573)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1425936906 (var2573 String var885) void)
(declare-fun cast-from-var2560-to-var885 (var2560) var885)
(declare-const null-var3864 var3864)
(declare-const null-String String)
(declare-const null-var3350 var3350)
(declare-const null-var2560 var2560)
(declare-const var2241 var3864) ; Statement: r0 := @this: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$1 
(assert (not (= var2241 null-var3864)))
(declare-const var1657 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1657 null-String)))
(declare-const var3235 var3350) ; Statement: r3 := @parameter1: java.time.temporal.ChronoUnit 
(assert (not (= var3235 null-var3350)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2388 var2560) ; Statement: $r6 := @caughtexception 
(assert (not (= var2388 null-var2560)))
(define-const var3670 var2573 var2573-init) ; Statement: $r7 = new java.lang.IllegalArgumentException 
(define-const var2852 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2852)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2852!1 String)
(assert (= var2852!1 ""))
(assert true)
(define-const var2049 String (append/672562846 var2852!1 "\u0027")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'") 
(declare-const var2852!2 String)
(assert (= var2852!2 (str.++ var2852!1 "\u0027")))
(assert true)
(define-const var3124 String (append/672562846 var2049 var1657)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2049!1 String)
(assert (= var2049!1 (str.++ var2049 var1657)))
(assert true)
(define-const var786 String (append/672562846 var3124 "\u0027 is not a valid simple duration")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' is not a valid simple duration") 
(declare-const var3124!1 String)
(assert (= var3124!1 (str.++ var3124 "\u0027 is not a valid simple duration")))
(assert true)
(define-const var495 String (toString/-2075883882 var786)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1425936906 var3670 var495 (cast-from-var2560-to-var885 var2388))) ; Statement: specialinvoke $r7.<java.lang.IllegalArgumentException: void <init>(java.lang.String,java.lang.Throwable)>($r12, $r6) 

(declare-const var3670!1 var2573)
(declare-const var495!1 String)
(declare-const var2388!1 var2560)
 ; Statement: throw $r7 
(check-sat)
; {var2573-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1425936906=([java.lang.IllegalArgumentException, java.lang.String, java.lang.Throwable], void), cast-from-var2560-to-var885=([java.lang.Exception], java.lang.Throwable)}
; {var3864=org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$1, var2241=r0, var1657=r1, var505=null_type, var3350=java.time.temporal.ChronoUnit, var3235=r3, var2560=java.lang.Exception, var2388=$r6, var2573=java.lang.IllegalArgumentException, var3670=$r7, var2852=$r8, var2049=$r9, var3124=$r10, var786=$r11, var495=$r12, var885=java.lang.Throwable}
; {org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$1=var3864, r0=var2241, r1=var1657, null_type=var505, java.time.temporal.ChronoUnit=var3350, r3=var3235, java.lang.Exception=var2560, $r6=var2388, java.lang.IllegalArgumentException=var2573, $r7=var3670, $r8=var2852, $r9=var2049, $r10=var3124, $r11=var786, $r12=var495, java.lang.Throwable=var885}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$1;	r1 := @parameter0: java.lang.String;	r3 := @parameter1: java.time.temporal.ChronoUnit;	$r6 := @caughtexception;	$r7 = new java.lang.IllegalArgumentException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' is not a valid simple duration");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<java.lang.IllegalArgumentException: void <init>(java.lang.String,java.lang.Throwable)>($r12, $r6);	throw $r7
;block_num 2