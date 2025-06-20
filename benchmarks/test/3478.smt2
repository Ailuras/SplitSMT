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

(declare-sort var1465 0)
(declare-sort var3373 0)
(declare-sort var2394 0)
(declare-sort var321 0)
(declare-sort var1683 0)
(declare-sort var867 0)
(declare-sort var3311 0)
(declare-sort var3721 0)
(declare-sort var847 0)
(declare-sort var3477 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getDumpPath/-119345867 (var1465) String)
(declare-fun var3373_getSystemProperty/1393069448 (String) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2394-init () var2394)
(declare-fun <init>/-1862704206 (var2394 String) void)
(declare-fun var321-init () var321)
(declare-fun <init>/-788057745 (var321) void)
(declare-fun format/215566421 (var1683 var321) String)
(declare-fun cast-from-var2394-to-var1683 (var2394) var1683)
(declare-fun var867-init () var867)
(declare-fun var3311-init () var3311)
(declare-fun String-init () String)
(declare-fun var847_error/377575788 (var847 String String String String var3477) void)
(declare-fun cast-from-var3721-to-var3477 (var3721) var3477)
(declare-const null-var1465 var1465)
(declare-const null-var3721 var3721)
(declare-const var1465-logger var847)
(declare-const var141 var1465) ; Statement: r0 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport 
(assert (not (= var141 null-var1465)))
(assert true)
(define-const var2979 String (getDumpPath/-119345867 var141)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String getDumpPath()>() 
(define-const var2222 String (var3373_getSystemProperty/1393069448 "os.name")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("os.name") 
(assert true)
(define-const var3823 String (toLowerCase/415700667 var2222)) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var1103 Bool (contains/1009244746 var3823 (cast-from-String-to-String "win"))) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean contains(java.lang.CharSequence)>("win") 
 ; Statement: if $z0 == 0 goto $r4 = new java.text.SimpleDateFormat 
(assert (= (ite var1103 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3458 var2394 var2394-init) ; Statement: $r4 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var3458 "yyyy-MM-dd_HH:mm:ss")) ; Statement: specialinvoke $r4.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd_HH:mm:ss") 

(declare-const var3458!1 var2394)
(declare-const var632 String)
(define-const var2609 var2394 var3458!1) ; Statement: r18 = $r4 
(assert true) ; Non Conditional
(define-const var2360 var321 var321-init) ; Statement: $r5 = new java.util.Date 
(assert true)
;(assert (<init>/-788057745 var2360)) ; Statement: specialinvoke $r5.<java.util.Date: void <init>()>() 

(declare-const var2360!1 var321)
(assert true)
(define-const var2338 String (format/215566421 (cast-from-var2394-to-var1683 var2609) var2360!1)) ; Statement: $r13 = virtualinvoke r18.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r5) 
(define-const var848 var867 var867-init) ; Statement: $r6 = new java.io.FileOutputStream 
(define-const var1011 var3311 var3311-init) ; Statement: $r7 = new java.io.File 
(define-const var663 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var338 var3721) ; Statement: $r14 := @caughtexception 
(assert (not (= var338 null-var3721)))
(define-const var3086 var847 var1465-logger) ; Statement: $r15 = <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var847_error/377575788 var3086 "0-20" "" "" "dump jStack error" (cast-from-var3721-to-var3477 var338))) ; Statement: interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-20", "", "", "dump jStack error", $r14) 

(declare-const var3086!1 var847)
(declare-const var3431 String)
(declare-const var507 String)
(declare-const var507!1 String)
(declare-const var265 String)
(declare-const var338!1 var3721)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getDumpPath/-119345867=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], java.lang.String), var3373_getSystemProperty/1393069448=([java.lang.String], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2394-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var321-init=([], java.util.Date), <init>/-788057745=([java.util.Date], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var2394-to-var1683=([java.text.SimpleDateFormat], java.text.DateFormat), var867-init=([], java.io.FileOutputStream), var3311-init=([], java.io.File), String-init=([], java.lang.StringBuilder), var847_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var3721-to-var3477=([java.lang.Exception], java.lang.Throwable)}
; {var1465=org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport, var141=r0, var2979=r1, var3373=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2222=$r2, var3823=r3, var1103=$z0, var2394=java.text.SimpleDateFormat, var3458=$r4, var632="yyyy-MM-dd_HH:mm:ss", var2609=r18, var321=java.util.Date, var2360=$r5, var1683=java.text.DateFormat, var2338=$r13, var867=java.io.FileOutputStream, var848=$r6, var3311=java.io.File, var1011=$r7, var663=$r8, var3721=java.lang.Exception, var338=$r14, var847=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3086=$r15, var3477=java.lang.Throwable, var3431="0-20", var507="", var265="dump jStack error"}
; {org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport=var1465, r0=var141, r1=var2979, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3373, $r2=var2222, r3=var3823, $z0=var1103, java.text.SimpleDateFormat=var2394, $r4=var3458, "yyyy-MM-dd_HH:mm:ss"=var632, r18=var2609, java.util.Date=var321, $r5=var2360, java.text.DateFormat=var1683, $r13=var2338, java.io.FileOutputStream=var867, $r6=var848, java.io.File=var3311, $r7=var1011, $r8=var663, java.lang.Exception=var3721, $r14=var338, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var847, $r15=var3086, java.lang.Throwable=var3477, "0-20"=var3431, ""=var507, "dump jStack error"=var265}
;seq <java.lang.String: java.lang.String toLowerCase()>;	<java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport;	r1 = virtualinvoke r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String getDumpPath()>();	$r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("os.name");	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean contains(java.lang.CharSequence)>("win");	if $z0 == 0 goto $r4 = new java.text.SimpleDateFormat;	$r4 = new java.text.SimpleDateFormat;	specialinvoke $r4.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd_HH:mm:ss");	r18 = $r4;	$r5 = new java.util.Date;	specialinvoke $r5.<java.util.Date: void <init>()>();	$r13 = virtualinvoke r18.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r5);	$r6 = new java.io.FileOutputStream;	$r7 = new java.io.File;	$r8 = new java.lang.StringBuilder;	$r14 := @caughtexception;	$r15 = <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-20", "", "", "dump jStack error", $r14);	return
;block_num 5