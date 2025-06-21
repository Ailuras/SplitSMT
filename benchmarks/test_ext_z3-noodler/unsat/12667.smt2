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

(declare-sort var911 0)
(declare-sort var1462 0)
(declare-sort var256 0)
(declare-sort var2169 0)
(declare-sort var2767 0)
(declare-sort var993 0)
(declare-sort var377 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2767_getFile/-1040015240 () var2169)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2767_getLevel/-706352403 () var993)
(declare-fun append/-1031950772 (String var377) String)
(declare-fun cast-from-var993-to-var377 (var993) var377)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var911 var911)
(declare-const null-var1462 var1462)
(declare-const null-String String)
(declare-const null-var2169 var2169)
(declare-const var3829 var911) ; Statement: r28 := @this: org.apache.dubbo.qos.legacy.LogTelnetHandler 
(assert (not (= var3829 null-var911)))
(declare-const var1400 var1462) ; Statement: r29 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1400 null-var1462)))
(declare-const var2472 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2472 null-String)))
(define-const var3364 var2169 var2767_getFile/-1040015240) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.io.File getFile()>() 
(define-const var3300 String String-init) ; Statement: $r36 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3300)) ; Statement: specialinvoke $r36.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3300!1 String)
(assert (= var3300!1 ""))
 ; Statement: if r2 == null goto virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100") 
(assert (= var2472 null-String)) ; Cond: r2 == null 
(assert true)
;(assert (append/672562846 var3300!1 "EXAMPLE: log error / log 100")) ; Statement: virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100") 
(declare-const var3300!2 String)
(assert (= var3300!2 (str.++ var3300!1 "EXAMPLE: log error / log 100")))
 ; Statement: goto [?= $r32 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:")] 
(assert true) ; Non Conditional
(assert true)
(define-const var2441 String (append/672562846 var3300!2 "\r\nCURRENT LOG LEVEL:")) ; Statement: $r32 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:") 
(declare-const var3300!3 String)
(assert (= var3300!3 (str.++ var3300!2 "\r\nCURRENT LOG LEVEL:")))
(define-const var2620 var993 var2767_getLevel/-706352403) ; Statement: $r33 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>() 
(assert true)
(define-const var2640 String (append/-1031950772 var2441 (cast-from-var993-to-var377 var2620))) ; Statement: $r34 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var2441!1 String)
(assert (str.prefixof var2441 var2441!1))
(assert true)
(define-const var1831 String (append/672562846 var2640 "\r\nCURRENT LOG APPENDER:")) ; Statement: $r3 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG APPENDER:") 
(declare-const var2640!1 String)
(assert (= var2640!1 (str.++ var2640 "\r\nCURRENT LOG APPENDER:")))
 ; Statement: if r0 != null goto $r35 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>() 
(assert (not (not (= var3364 null-var2169)))) ; Negate: Cond: r0 != null  
(define-const var3024 String "console") ; Statement: $r35 = "console" 
 ; Statement: goto [?= virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35)] 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var1831 var3024)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35) 
(declare-const var1831!1 String)
(assert (= var1831!1 (str.++ var1831 var3024)))
(assert true)
(define-const var1539 String (toString/-2075883882 var3300!3)) ; Statement: $r4 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {var2767_getFile/-1040015240=([], java.io.File), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2767_getLevel/-706352403=([], org.apache.dubbo.common.logger.Level), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var993-to-var377=([org.apache.dubbo.common.logger.Level], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var911=org.apache.dubbo.qos.legacy.LogTelnetHandler, var3829=r28, var1462=org.apache.dubbo.remoting.Channel, var1400=r29, var2472=r2, var256=null_type, var2169=java.io.File, var2767=org.apache.dubbo.common.logger.LoggerFactory, var3364=r0, var3300=$r36, var2441=$r32, var993=org.apache.dubbo.common.logger.Level, var2620=$r33, var377=java.lang.Object, var2640=$r34, var1831=$r3, var3024=$r35, var1539=$r4}
; {org.apache.dubbo.qos.legacy.LogTelnetHandler=var911, r28=var3829, org.apache.dubbo.remoting.Channel=var1462, r29=var1400, r2=var2472, null_type=var256, java.io.File=var2169, org.apache.dubbo.common.logger.LoggerFactory=var2767, r0=var3364, $r36=var3300, $r32=var2441, org.apache.dubbo.common.logger.Level=var993, $r33=var2620, java.lang.Object=var377, $r34=var2640, $r3=var1831, $r35=var3024, $r4=var1539}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r28 := @this: org.apache.dubbo.qos.legacy.LogTelnetHandler;	r29 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: java.lang.String;	r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.io.File getFile()>();	$r36 = new java.lang.StringBuilder;	specialinvoke $r36.<java.lang.StringBuilder: void <init>()>();	if r2 == null goto virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100");	virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100");	goto [?= $r32 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:")];	$r32 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:");	$r33 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>();	$r34 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r3 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG APPENDER:");	if r0 != null goto $r35 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>();	$r35 = "console";	goto [?= virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35)];	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35);	$r4 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 5