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

(declare-sort var3021 0)
(declare-sort var277 0)
(declare-sort var1333 0)
(declare-sort var1394 0)
(declare-sort var2404 0)
(declare-sort var2441 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2404-init () var2404)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var2404 String var2441) void)
(declare-fun cast-from-var1394-to-var2441 (var1394) var2441)
(declare-const null-var3021 var3021)
(declare-const null-String String)
(declare-const null-var1333 var1333)
(declare-const null-var1394 var1394)
(declare-const var955 var3021) ; Statement: r0 := @this: org.apache.dubbo.common.config.Configuration 
(assert (not (= var955 null-var3021)))
(declare-const var284 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var284 null-String)))
(declare-const var3130 var1333) ; Statement: r2 := @parameter1: java.lang.Boolean 
(assert (not (= var3130 null-var1333)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var176 var1394) ; Statement: $r5 := @caughtexception 
(assert (not (= var176 null-var1394)))
(define-const var2749 var2404 var2404-init) ; Statement: $r6 = new java.lang.IllegalStateException 
(define-const var2042 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2042)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2042!1 String)
(assert (= var2042!1 ""))
(assert true)
(define-const var3008 String (append/672562846 var2042!1 "Try to get \u0027")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Try to get \'") 
(declare-const var2042!2 String)
(assert (= var2042!2 (str.++ var2042!1 "Try to get \u0027")))
(assert true)
(define-const var3641 String (append/672562846 var3008 var284)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3008!1 String)
(assert (= var3008!1 (str.++ var3008 var284)))
(assert true)
(define-const var1546 String (append/672562846 var3641 "\u0027 failed, maybe because this key doesn\u0027t map to a Boolean object")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' failed, maybe because this key doesn\'t map to a Boolean object") 
(declare-const var3641!1 String)
(assert (= var3641!1 (str.++ var3641 "\u0027 failed, maybe because this key doesn\u0027t map to a Boolean object")))
(assert true)
(define-const var2036 String (toString/-2075883882 var1546)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var2749 var2036 (cast-from-var1394-to-var2441 var176))) ; Statement: specialinvoke $r6.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r5) 

(declare-const var2749!1 var2404)
(declare-const var2036!1 String)
(declare-const var176!1 var1394)
 ; Statement: throw $r6 
(check-sat)
; {var2404-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void), cast-from-var1394-to-var2441=([java.lang.Exception], java.lang.Throwable)}
; {var3021=org.apache.dubbo.common.config.Configuration, var955=r0, var284=r1, var277=null_type, var1333=java.lang.Boolean, var3130=r2, var1394=java.lang.Exception, var176=$r5, var2404=java.lang.IllegalStateException, var2749=$r6, var2042=$r7, var3008=$r8, var3641=$r9, var1546=$r10, var2036=$r11, var2441=java.lang.Throwable}
; {org.apache.dubbo.common.config.Configuration=var3021, r0=var955, r1=var284, null_type=var277, java.lang.Boolean=var1333, r2=var3130, java.lang.Exception=var1394, $r5=var176, java.lang.IllegalStateException=var2404, $r6=var2749, $r7=var2042, $r8=var3008, $r9=var3641, $r10=var1546, $r11=var2036, java.lang.Throwable=var2441}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.config.Configuration;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Boolean;	$r5 := @caughtexception;	$r6 = new java.lang.IllegalStateException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Try to get \'");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' failed, maybe because this key doesn\'t map to a Boolean object");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r6.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r5);	throw $r6
;block_num 2