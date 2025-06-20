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

(declare-sort var3519 0)
(declare-sort var405 0)
(declare-sort var585 0)
(declare-sort var2193 0)
(declare-sort var103 0)
(declare-sort var1509 0)
(declare-sort var1911 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var405_notNull/751190363 (var585 String) void)
(declare-fun cast-from-String-to-var585 (String) var585)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun var2193-init () var2193)
(declare-fun var1509-init () var1509)
(declare-fun var1911-init () var1911)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1681661674 (var1911 String) void)
(declare-const null-String String)
(declare-const null-var103 var103)
(declare-const var436 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var436 null-String)))
;(assert (var405_notNull/751190363 (cast-from-String-to-var585 var436) "Resource location must not be null")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "Resource location must not be null") 

(declare-const var436!1 String)
(declare-const var2470 String)
(assert true)
(define-const var348 Bool (startsWith/-1785782452 var436!1 "classpath:")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("classpath:") 
 ; Statement: if $z0 == 0 goto $r1 = new java.net.URL 
(assert (= (ite var348 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3973 var2193 var2193-init) ; Statement: $r1 = new java.net.URL 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var731 var103) ; Statement: $r20 := @caughtexception 
(assert (not (= var731 null-var103)))
(define-const var1891 var1509 var1509-init) ; Statement: $r21 = new java.io.File 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2577 var103) ; Statement: $r13 := @caughtexception 
(assert (not (= var2577 null-var103)))
(define-const var3734 var1911 var1911-init) ; Statement: $r14 = new java.io.FileNotFoundException 
(define-const var1071 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1071)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1071!1 String)
(assert (= var1071!1 ""))
(assert true)
(define-const var35 String (append/672562846 var1071!1 "Resource location [")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Resource location [") 
(declare-const var1071!2 String)
(assert (= var1071!2 (str.++ var1071!1 "Resource location [")))
(assert true)
(define-const var1726 String (append/672562846 var35 var436!1)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var35!1 String)
(assert (= var35!1 (str.++ var35 var436!1)))
(assert true)
(define-const var2681 String (append/672562846 var1726 "] is neither a URL not a well-formed file path")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] is neither a URL not a well-formed file path") 
(declare-const var1726!1 String)
(assert (= var1726!1 (str.++ var1726 "] is neither a URL not a well-formed file path")))
(assert true)
(define-const var2516 String (toString/-2075883882 var2681)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1681661674 var3734 var2516)) ; Statement: specialinvoke $r14.<java.io.FileNotFoundException: void <init>(java.lang.String)>($r19) 

(declare-const var3734!1 var1911)
(declare-const var2516!1 String)
 ; Statement: throw $r14 
(check-sat)
; {var405_notNull/751190363=([java.lang.Object, java.lang.String], void), cast-from-String-to-var585=([java.lang.String], java.lang.Object), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), var2193-init=([], java.net.URL), var1509-init=([], java.io.File), var1911-init=([], java.io.FileNotFoundException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1681661674=([java.io.FileNotFoundException, java.lang.String], void)}
; {var436=r0, var3519=null_type, var405=org.apache.dubbo.common.utils.Assert, var585=java.lang.Object, var2470="Resource location must not be null", var348=$z0, var2193=java.net.URL, var3973=$r1, var103=java.net.MalformedURLException, var731=$r20, var1509=java.io.File, var1891=$r21, var2577=$r13, var1911=java.io.FileNotFoundException, var3734=$r14, var1071=$r15, var35=$r16, var1726=$r17, var2681=$r18, var2516=$r19}
; {r0=var436, null_type=var3519, org.apache.dubbo.common.utils.Assert=var405, java.lang.Object=var585, "Resource location must not be null"=var2470, $z0=var348, java.net.URL=var2193, $r1=var3973, java.net.MalformedURLException=var103, $r20=var731, java.io.File=var1509, $r21=var1891, $r13=var2577, java.io.FileNotFoundException=var1911, $r14=var3734, $r15=var1071, $r16=var35, $r17=var1726, $r18=var2681, $r19=var2516}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "Resource location must not be null");	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("classpath:");	if $z0 == 0 goto $r1 = new java.net.URL;	$r1 = new java.net.URL;	$r20 := @caughtexception;	$r21 = new java.io.File;	$r13 := @caughtexception;	$r14 = new java.io.FileNotFoundException;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Resource location [");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] is neither a URL not a well-formed file path");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r14.<java.io.FileNotFoundException: void <init>(java.lang.String)>($r19);	throw $r14
;block_num 4