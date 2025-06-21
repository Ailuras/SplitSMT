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

(declare-sort var1823 0)
(declare-sort var2523 0)
(declare-sort var292 0)
(declare-sort var3207 0)
(declare-sort var796 0)
(declare-sort var265 0)
(declare-sort var3197 0)
(declare-sort var2750 0)
(declare-sort var3915 0)
(declare-sort var681 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getDumpPath/-119345867 (var1823) String)
(declare-fun var2523_getSystemProperty/1393069448 (String) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var292-init () var292)
(declare-fun <init>/-1862704206 (var292 String) void)
(declare-fun var3207-init () var3207)
(declare-fun <init>/-788057745 (var3207) void)
(declare-fun format/215566421 (var796 var3207) String)
(declare-fun cast-from-var292-to-var796 (var292) var796)
(declare-fun var265-init () var265)
(declare-fun var3197-init () var3197)
(declare-fun String-init () String)
(declare-fun var3915_error/377575788 (var3915 String String String String var681) void)
(declare-fun cast-from-var2750-to-var681 (var2750) var681)
(declare-const null-var1823 var1823)
(declare-const null-var2750 var2750)
(declare-const var1823-logger var3915)
(declare-const var1114 var1823) ; Statement: r0 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport 
(assert (not (= var1114 null-var1823)))
(assert true)
(define-const var732 String (getDumpPath/-119345867 var1114)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String getDumpPath()>() 
(define-const var3019 String (var2523_getSystemProperty/1393069448 "os.name")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("os.name") 
(assert true)
(define-const var1156 String (toLowerCase/415700667 var3019)) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var3405 Bool (contains/1009244746 var1156 (cast-from-String-to-String "win"))) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean contains(java.lang.CharSequence)>("win") 
 ; Statement: if $z0 == 0 goto $r4 = new java.text.SimpleDateFormat 
(assert (not (= (ite var3405 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var273 var292 var292-init) ; Statement: $r12 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var273 "yyyy-MM-dd_HH-mm-ss")) ; Statement: specialinvoke $r12.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd_HH-mm-ss") 

(declare-const var273!1 var292)
(declare-const var2151 String)
(define-const var3550 var292 var273!1) ; Statement: r18 = $r12 
 ; Statement: goto [?= $r5 = new java.util.Date] 
(assert true) ; Non Conditional
(define-const var182 var3207 var3207-init) ; Statement: $r5 = new java.util.Date 
(assert true)
;(assert (<init>/-788057745 var182)) ; Statement: specialinvoke $r5.<java.util.Date: void <init>()>() 

(declare-const var182!1 var3207)
(assert true)
(define-const var3250 String (format/215566421 (cast-from-var292-to-var796 var3550) var182!1)) ; Statement: $r13 = virtualinvoke r18.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r5) 
(define-const var3368 var265 var265-init) ; Statement: $r6 = new java.io.FileOutputStream 
(define-const var3121 var3197 var3197-init) ; Statement: $r7 = new java.io.File 
(define-const var1482 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3675 var2750) ; Statement: $r14 := @caughtexception 
(assert (not (= var3675 null-var2750)))
(define-const var3298 var3915 var1823-logger) ; Statement: $r15 = <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3915_error/377575788 var3298 "0-20" "" "" "dump jStack error" (cast-from-var2750-to-var681 var3675))) ; Statement: interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-20", "", "", "dump jStack error", $r14) 

(declare-const var3298!1 var3915)
(declare-const var1744 String)
(declare-const var334 String)
(declare-const var334!1 String)
(declare-const var2532 String)
(declare-const var3675!1 var2750)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getDumpPath/-119345867=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], java.lang.String), var2523_getSystemProperty/1393069448=([java.lang.String], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var292-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var3207-init=([], java.util.Date), <init>/-788057745=([java.util.Date], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var292-to-var796=([java.text.SimpleDateFormat], java.text.DateFormat), var265-init=([], java.io.FileOutputStream), var3197-init=([], java.io.File), String-init=([], java.lang.StringBuilder), var3915_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var2750-to-var681=([java.lang.Exception], java.lang.Throwable)}
; {var1823=org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport, var1114=r0, var732=r1, var2523=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3019=$r2, var1156=r3, var3405=$z0, var292=java.text.SimpleDateFormat, var273=$r12, var2151="yyyy-MM-dd_HH-mm-ss", var3550=r18, var3207=java.util.Date, var182=$r5, var796=java.text.DateFormat, var3250=$r13, var265=java.io.FileOutputStream, var3368=$r6, var3197=java.io.File, var3121=$r7, var1482=$r8, var2750=java.lang.Exception, var3675=$r14, var3915=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3298=$r15, var681=java.lang.Throwable, var1744="0-20", var334="", var2532="dump jStack error"}
; {org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport=var1823, r0=var1114, r1=var732, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2523, $r2=var3019, r3=var1156, $z0=var3405, java.text.SimpleDateFormat=var292, $r12=var273, "yyyy-MM-dd_HH-mm-ss"=var2151, r18=var3550, java.util.Date=var3207, $r5=var182, java.text.DateFormat=var796, $r13=var3250, java.io.FileOutputStream=var265, $r6=var3368, java.io.File=var3197, $r7=var3121, $r8=var1482, java.lang.Exception=var2750, $r14=var3675, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3915, $r15=var3298, java.lang.Throwable=var681, "0-20"=var1744, ""=var334, "dump jStack error"=var2532}
;seq <java.lang.String: java.lang.String toLowerCase()>;	<java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport;	r1 = virtualinvoke r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String getDumpPath()>();	$r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("os.name");	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean contains(java.lang.CharSequence)>("win");	if $z0 == 0 goto $r4 = new java.text.SimpleDateFormat;	$r12 = new java.text.SimpleDateFormat;	specialinvoke $r12.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd_HH-mm-ss");	r18 = $r12;	goto [?= $r5 = new java.util.Date];	$r5 = new java.util.Date;	specialinvoke $r5.<java.util.Date: void <init>()>();	$r13 = virtualinvoke r18.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r5);	$r6 = new java.io.FileOutputStream;	$r7 = new java.io.File;	$r8 = new java.lang.StringBuilder;	$r14 := @caughtexception;	$r15 = <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-20", "", "", "dump jStack error", $r14);	return
;block_num 5