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

(declare-sort var2191 0)
(declare-sort var2557 0)
(declare-sort var2856 0)
(declare-sort var306 0)
(declare-sort var3548 0)
(declare-sort var514 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3548-init () var3548)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1425936906 (var3548 String var514) void)
(declare-fun cast-from-var306-to-var514 (var306) var514)
(declare-const null-var2191 var2191)
(declare-const null-String String)
(declare-const null-var2856 var2856)
(declare-const null-var306 var306)
(declare-const var3272 var2191) ; Statement: r9 := @this: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$2 
(assert (not (= var3272 null-var2191)))
(declare-const var1208 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1208 null-String)))
(declare-const var1119 var2856) ; Statement: r10 := @parameter1: java.time.temporal.ChronoUnit 
(assert (not (= var1119 null-var2856)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3281 var306) ; Statement: $r2 := @caughtexception 
(assert (not (= var3281 null-var306)))
(define-const var1831 var3548 var3548-init) ; Statement: $r3 = new java.lang.IllegalArgumentException 
(define-const var579 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var579)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var579!1 String)
(assert (= var579!1 ""))
(assert true)
(define-const var128 String (append/672562846 var579!1 "\u0027")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'") 
(declare-const var579!2 String)
(assert (= var579!2 (str.++ var579!1 "\u0027")))
(assert true)
(define-const var807 String (append/672562846 var128 var1208)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var128!1 String)
(assert (= var128!1 (str.++ var128 var1208)))
(assert true)
(define-const var1402 String (append/672562846 var807 "\u0027 is not a valid ISO-8601 duration")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' is not a valid ISO-8601 duration") 
(declare-const var807!1 String)
(assert (= var807!1 (str.++ var807 "\u0027 is not a valid ISO-8601 duration")))
(assert true)
(define-const var3182 String (toString/-2075883882 var1402)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1425936906 var1831 var3182 (cast-from-var306-to-var514 var3281))) ; Statement: specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String,java.lang.Throwable)>($r8, $r2) 

(declare-const var1831!1 var3548)
(declare-const var3182!1 String)
(declare-const var3281!1 var306)
 ; Statement: throw $r3 
(check-sat)
; {var3548-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1425936906=([java.lang.IllegalArgumentException, java.lang.String, java.lang.Throwable], void), cast-from-var306-to-var514=([java.lang.Exception], java.lang.Throwable)}
; {var2191=org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$2, var3272=r9, var1208=r0, var2557=null_type, var2856=java.time.temporal.ChronoUnit, var1119=r10, var306=java.lang.Exception, var3281=$r2, var3548=java.lang.IllegalArgumentException, var1831=$r3, var579=$r4, var128=$r5, var807=$r6, var1402=$r7, var3182=$r8, var514=java.lang.Throwable}
; {org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$2=var2191, r9=var3272, r0=var1208, null_type=var2557, java.time.temporal.ChronoUnit=var2856, r10=var1119, java.lang.Exception=var306, $r2=var3281, java.lang.IllegalArgumentException=var3548, $r3=var1831, $r4=var579, $r5=var128, $r6=var807, $r7=var1402, $r8=var3182, java.lang.Throwable=var514}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$2;	r0 := @parameter0: java.lang.String;	r10 := @parameter1: java.time.temporal.ChronoUnit;	$r2 := @caughtexception;	$r3 = new java.lang.IllegalArgumentException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' is not a valid ISO-8601 duration");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String,java.lang.Throwable)>($r8, $r2);	throw $r3
;block_num 2