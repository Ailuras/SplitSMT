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

(declare-sort var2051 0)
(declare-sort var1811 0)
(declare-sort var2905 0)
(declare-sort var320 0)
(declare-sort var3287 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun matcher/468719934 (var2905 String) var320)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun matches/-149940873 (var320) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun error/-1899379871 (var3287 String) void)
(declare-fun cast-from-var2051-to-var3287 (var2051) var3287)
(declare-const null-var2051 var2051)
(declare-const null-String String)
(declare-const var2051-ERROR_CODE_PATTERN var2905)
(declare-const var796 var2051) ; Statement: r12 := @this: org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger 
(assert (not (= var796 null-var2051)))
(declare-const var3454 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3454 null-String)))
(assert true)
(define-const var261 String (trim/-847153721 var3454)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(define-const var2046 var2905 var2051-ERROR_CODE_PATTERN) ; Statement: $r2 = <org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger: java.util.regex.Pattern ERROR_CODE_PATTERN> 
(assert true)
(define-const var3521 var320 (matcher/468719934 var2046 (cast-from-String-to-String var261))) ; Statement: $r3 = virtualinvoke $r2.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r1) 
(assert true)
(define-const var296 Bool (matches/-149940873 var3521)) ; Statement: $z0 = virtualinvoke $r3.<java.util.regex.Matcher: boolean matches()>() 
 ; Statement: if $z0 != 0 goto r4 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[-]") 
(assert (not (not (= (ite var296 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var131 String String-init) ; Statement: $r13 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var131)) ; Statement: specialinvoke $r13.<java.lang.StringBuilder: void <init>()>() 
(declare-const var131!1 String)
(assert (= var131!1 ""))
(assert true)
(define-const var2747 String (append/672562846 var131!1 "Invalid error code: ")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid error code: ") 
(declare-const var131!2 String)
(assert (= var131!2 (str.++ var131!1 "Invalid error code: ")))
(assert true)
(define-const var358 String (append/672562846 var2747 var3454)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2747!1 String)
(assert (= var2747!1 (str.++ var2747 var3454)))
(assert true)
(define-const var2689 String (append/672562846 var358 ", the format of error code is: X-X (where X is a number).")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", the format of error code is: X-X (where X is a number).") 
(declare-const var358!1 String)
(assert (= var358!1 (str.++ var358 ", the format of error code is: X-X (where X is a number).")))
(assert true)
(define-const var2946 String (toString/-2075883882 var2689)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (error/-1899379871 (cast-from-var2051-to-var3287 var796) var2946)) ; Statement: virtualinvoke r12.<org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger: void error(java.lang.String)>($r17) 

(declare-const var796!1 var2051)
(declare-const var2946!1 String)
 ; Statement: return "" 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), matcher/468719934=([java.util.regex.Pattern, java.lang.CharSequence], java.util.regex.Matcher), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), matches/-149940873=([java.util.regex.Matcher], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), error/-1899379871=([org.apache.dubbo.common.logger.support.FailsafeLogger, java.lang.String], void), cast-from-var2051-to-var3287=([org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger], org.apache.dubbo.common.logger.support.FailsafeLogger)}
; {var2051=org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger, var796=r12, var3454=r0, var1811=null_type, var261=r1, var2905=java.util.regex.Pattern, var2046=$r2, var320=java.util.regex.Matcher, var3521=$r3, var296=$z0, var131=$r13, var2747=$r14, var358=$r15, var2689=$r16, var2946=$r17, var3287=org.apache.dubbo.common.logger.support.FailsafeLogger}
; {org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger=var2051, r12=var796, r0=var3454, null_type=var1811, r1=var261, java.util.regex.Pattern=var2905, $r2=var2046, java.util.regex.Matcher=var320, $r3=var3521, $z0=var296, $r13=var131, $r14=var2747, $r15=var358, $r16=var2689, $r17=var2946, org.apache.dubbo.common.logger.support.FailsafeLogger=var3287}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r2 = <org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger: java.util.regex.Pattern ERROR_CODE_PATTERN>;	$r3 = virtualinvoke $r2.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r1);	$z0 = virtualinvoke $r3.<java.util.regex.Matcher: boolean matches()>();	if $z0 != 0 goto r4 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[-]");	$r13 = new java.lang.StringBuilder;	specialinvoke $r13.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid error code: ");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", the format of error code is: X-X (where X is a number).");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r12.<org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger: void error(java.lang.String)>($r17);	return ""
;block_num 2