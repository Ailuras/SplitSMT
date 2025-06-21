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

(declare-sort var1607 0)
(declare-sort var1986 0)
(declare-sort var967 0)
(declare-sort var223 0)
(declare-sort var2972 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1986_notNull/751190363 (var967 String) void)
(declare-fun cast-from-String-to-var967 (String) var967)
(declare-fun var223_values/-1577137613 () (Array Int var223))
(declare-fun getLength-Arr-var223-1 ((Array Int var223)) Int)
(declare-fun var2972-init () var2972)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2972 String) void)
(declare-const null-String String)
(declare-const var3039 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3039 null-String)))
;(assert (var1986_notNull/751190363 (cast-from-String-to-var967 var3039) "Value must not be null")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "Value must not be null") 

(declare-const var3039!1 String)
(declare-const var1965 String)
(define-const var3137 (Array Int var223) var223_values/-1577137613) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle[] values()>() 
(define-const var1504 Int (getLength-Arr-var223-1 var3137)) ; Statement: i0 = lengthof r1 
(define-const var3074 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r2 = new java.lang.IllegalArgumentException 
(assert (>= var3074 var1504)) ; Cond: i1 >= i0 
(define-const var1527 var2972 var2972-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var3079 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3079)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3079!1 String)
(assert (= var3079!1 ""))
(assert true)
(define-const var3200 String (append/672562846 var3079!1 "\u0027")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'") 
(declare-const var3079!2 String)
(assert (= var3079!2 (str.++ var3079!1 "\u0027")))
(assert true)
(define-const var2913 String (append/672562846 var3200 var3039!1)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var3200!1 String)
(assert (= var3200!1 (str.++ var3200 var3039!1)))
(assert true)
(define-const var2923 String (append/672562846 var2913 "\u0027 is not a valid duration")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' is not a valid duration") 
(declare-const var2913!1 String)
(assert (= var2913!1 (str.++ var2913 "\u0027 is not a valid duration")))
(assert true)
(define-const var295 String (toString/-2075883882 var2923)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var1527 var295)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7) 

(declare-const var1527!1 var2972)
(declare-const var295!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var1986_notNull/751190363=([java.lang.Object, java.lang.String], void), cast-from-String-to-var967=([java.lang.String], java.lang.Object), var223_values/-1577137613=([], org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle[]), getLength-Arr-var223-1=([org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle[]], int), var2972-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3039=r0, var1607=null_type, var1986=org.apache.dubbo.common.utils.Assert, var967=java.lang.Object, var1965="Value must not be null", var223=org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle, var3137=r1, var1504=i0, var3074=i1, var2972=java.lang.IllegalArgumentException, var1527=$r2, var3079=$r3, var3200=$r4, var2913=$r5, var2923=$r6, var295=$r7}
; {r0=var3039, null_type=var1607, org.apache.dubbo.common.utils.Assert=var1986, java.lang.Object=var967, "Value must not be null"=var1965, org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle=var223, r1=var3137, i0=var1504, i1=var3074, java.lang.IllegalArgumentException=var2972, $r2=var1527, $r3=var3079, $r4=var3200, $r5=var2913, $r6=var2923, $r7=var295}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "Value must not be null");	r1 = staticinvoke <org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle[] values()>();	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto $r2 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' is not a valid duration");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 3