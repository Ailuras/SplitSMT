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

(declare-sort var2332 0)
(declare-sort var2549 0)
(declare-sort var1306 0)
(declare-sort var2322 0)
(declare-sort var1344 0)
(declare-sort var3074 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1306-init () var1306)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1681595970 (var1306 String) void)
(declare-fun var1344-init () var1344)
(declare-fun <init>/-1645845558 (var1344 var3074) void)
(declare-fun cast-from-var2322-to-var3074 (var2322) var3074)
(declare-const null-var2332 var2332)
(declare-const null-String String)
(declare-const null-var2322 var2322)
(declare-const var2610 var2332) ; Statement: r7 := @parameter0: org.apache.dubbo.common.cache.FileCacheStore$Builder 
(assert (not (= var2610 null-var2332)))
(declare-const var2241 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2241 null-String)))
(define-const var2563 var1306 var1306-init) ; Statement: $r0 = new java.io.File 
(define-const var3030 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3030)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3030!1 String)
(assert (= var3030!1 ""))
(assert true)
(define-const var1324 String (append/672562846 var3030!1 var2241)) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var3030!2 String)
(assert (= var3030!2 (str.++ var3030!1 var2241)))
(assert true)
(define-const var3960 String (append/672562846 var1324 ".lock")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".lock") 
(declare-const var1324!1 String)
(assert (= var1324!1 (str.++ var1324 ".lock")))
(assert true)
(define-const var190 String (toString/-2075883882 var3960)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1681595970 var2563 var190)) ; Statement: specialinvoke $r0.<java.io.File: void <init>(java.lang.String)>($r5) 

(declare-const var2563!1 var1306)
(declare-const var190!1 String)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2562 var2322) ; Statement: $r19 := @caughtexception 
(assert (not (= var2562 null-var2322)))
(define-const var202 var1344 var1344-init) ; Statement: $r20 = new java.lang.RuntimeException 
(assert true)
;(assert (<init>/-1645845558 var202 (cast-from-var2322-to-var3074 var2562))) ; Statement: specialinvoke $r20.<java.lang.RuntimeException: void <init>(java.lang.Throwable)>($r19) 

(declare-const var202!1 var1344)
(declare-const var2562!1 var2322)
 ; Statement: throw $r20 
(check-sat)
; {var1306-init=([], java.io.File), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1681595970=([java.io.File, java.lang.String], void), var1344-init=([], java.lang.RuntimeException), <init>/-1645845558=([java.lang.RuntimeException, java.lang.Throwable], void), cast-from-var2322-to-var3074=([java.io.IOException], java.lang.Throwable)}
; {var2332=org.apache.dubbo.common.cache.FileCacheStore$Builder, var2610=r7, var2241=r2, var2549=null_type, var1306=java.io.File, var2563=$r0, var3030=$r1, var1324=$r3, var3960=$r4, var190=$r5, var2322=java.io.IOException, var2562=$r19, var1344=java.lang.RuntimeException, var202=$r20, var3074=java.lang.Throwable}
; {org.apache.dubbo.common.cache.FileCacheStore$Builder=var2332, r7=var2610, r2=var2241, null_type=var2549, java.io.File=var1306, $r0=var2563, $r1=var3030, $r3=var1324, $r4=var3960, $r5=var190, java.io.IOException=var2322, $r19=var2562, java.lang.RuntimeException=var1344, $r20=var202, java.lang.Throwable=var3074}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @parameter0: org.apache.dubbo.common.cache.FileCacheStore$Builder;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.File;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".lock");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<java.io.File: void <init>(java.lang.String)>($r5);	$r19 := @caughtexception;	$r20 = new java.lang.RuntimeException;	specialinvoke $r20.<java.lang.RuntimeException: void <init>(java.lang.Throwable)>($r19);	throw $r20
;block_num 2