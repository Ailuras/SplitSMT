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

(declare-sort var3489 0)
(declare-sort var370 0)
(declare-sort var655 0)
(declare-sort var1402 0)
(declare-sort var2589 0)
(declare-sort var1560 0)
(declare-sort var1375 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2589_getFile/-1040015240 () var1402)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2589_getLevel/-706352403 () var1560)
(declare-fun append/-1031950772 (String var1375) String)
(declare-fun cast-from-var1560-to-var1375 (var1560) var1375)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getAbsolutePath/-802773300 (var1402) String)
(declare-const null-var3489 var3489)
(declare-const null-var370 var370)
(declare-const null-String String)
(declare-const null-var1402 var1402)
(declare-const var3316 var3489) ; Statement: r42 := @this: org.apache.dubbo.remoting.telnet.support.command.LogTelnetHandler 
(assert (not (= var3316 null-var3489)))
(declare-const var138 var370) ; Statement: r43 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var138 null-var370)))
(declare-const var2683 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2683 null-String)))
(define-const var2625 var1402 var2589_getFile/-1040015240) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.io.File getFile()>() 
(define-const var3254 String String-init) ; Statement: $r53 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3254)) ; Statement: specialinvoke $r53.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3254!1 String)
(assert (= var3254!1 ""))
 ; Statement: if r2 == null goto virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100") 
(assert (= var2683 null-String)) ; Cond: r2 == null 
(assert true)
;(assert (append/672562846 var3254!1 "EXAMPLE: log error / log 100")) ; Statement: virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100") 
(declare-const var3254!2 String)
(assert (= var3254!2 (str.++ var3254!1 "EXAMPLE: log error / log 100")))
 ; Statement: goto [?= $r61 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var974 String String-init) ; Statement: $r61 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var974)) ; Statement: specialinvoke $r61.<java.lang.StringBuilder: void <init>()>() 
(declare-const var974!1 String)
(assert (= var974!1 ""))
(assert true)
(define-const var529 String (append/672562846 var974!1 "\r\nCURRENT LOG LEVEL:")) ; Statement: $r47 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:") 
(declare-const var974!2 String)
(assert (= var974!2 (str.++ var974!1 "\r\nCURRENT LOG LEVEL:")))
(define-const var2782 var1560 var2589_getLevel/-706352403) ; Statement: $r48 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>() 
(assert true)
(define-const var2473 String (append/-1031950772 var529 (cast-from-var1560-to-var1375 var2782))) ; Statement: $r49 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r48) 
(declare-const var529!1 String)
(assert (str.prefixof var529 var529!1))
(assert true)
(define-const var2879 String (toString/-2075883882 var2473)) ; Statement: $r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var2953 String (append/672562846 var3254!2 var2879)) ; Statement: $r6 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r50) 
(declare-const var3254!3 String)
(assert (= var3254!3 (str.++ var3254!2 var2879)))
(define-const var3239 String String-init) ; Statement: $r62 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3239)) ; Statement: specialinvoke $r62.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3239!1 String)
(assert (= var3239!1 ""))
(assert true)
(define-const var173 String (append/672562846 var3239!1 "\r\nCURRENT LOG APPENDER:")) ; Statement: $r3 = virtualinvoke $r62.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG APPENDER:") 
(declare-const var3239!2 String)
(assert (= var3239!2 (str.++ var3239!1 "\r\nCURRENT LOG APPENDER:")))
 ; Statement: if r0 != null goto $r52 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>() 
(assert (not (= var2625 null-var1402))) ; Cond: r0 != null 
(assert true)
(define-const var403 String (getAbsolutePath/-802773300 var2625)) ; Statement: $r52 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var1458 String (append/672562846 var173 var403)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r52) 
(declare-const var173!1 String)
(assert (= var173!1 (str.++ var173 var403)))
(assert true)
(define-const var3941 String (toString/-2075883882 var1458)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (append/672562846 var2953 var3941)) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2953!1 String)
(assert (= var2953!1 (str.++ var2953 var3941)))
(assert true)
(define-const var1887 String (toString/-2075883882 var3254!3)) ; Statement: $r7 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {var2589_getFile/-1040015240=([], java.io.File), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2589_getLevel/-706352403=([], org.apache.dubbo.common.logger.Level), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1560-to-var1375=([org.apache.dubbo.common.logger.Level], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getAbsolutePath/-802773300=([java.io.File], java.lang.String)}
; {var3489=org.apache.dubbo.remoting.telnet.support.command.LogTelnetHandler, var3316=r42, var370=org.apache.dubbo.remoting.Channel, var138=r43, var2683=r2, var655=null_type, var1402=java.io.File, var2589=org.apache.dubbo.common.logger.LoggerFactory, var2625=r0, var3254=$r53, var974=$r61, var529=$r47, var1560=org.apache.dubbo.common.logger.Level, var2782=$r48, var1375=java.lang.Object, var2473=$r49, var2879=$r50, var2953=$r6, var3239=$r62, var173=$r3, var403=$r52, var1458=$r4, var3941=$r5, var1887=$r7}
; {org.apache.dubbo.remoting.telnet.support.command.LogTelnetHandler=var3489, r42=var3316, org.apache.dubbo.remoting.Channel=var370, r43=var138, r2=var2683, null_type=var655, java.io.File=var1402, org.apache.dubbo.common.logger.LoggerFactory=var2589, r0=var2625, $r53=var3254, $r61=var974, $r47=var529, org.apache.dubbo.common.logger.Level=var1560, $r48=var2782, java.lang.Object=var1375, $r49=var2473, $r50=var2879, $r6=var2953, $r62=var3239, $r3=var173, $r52=var403, $r4=var1458, $r5=var3941, $r7=var1887}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 3}
;stmts r42 := @this: org.apache.dubbo.remoting.telnet.support.command.LogTelnetHandler;	r43 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: java.lang.String;	r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.io.File getFile()>();	$r53 = new java.lang.StringBuilder;	specialinvoke $r53.<java.lang.StringBuilder: void <init>()>();	if r2 == null goto virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100");	virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100");	goto [?= $r61 = new java.lang.StringBuilder];	$r61 = new java.lang.StringBuilder;	specialinvoke $r61.<java.lang.StringBuilder: void <init>()>();	$r47 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:");	$r48 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>();	$r49 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r48);	$r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r50);	$r62 = new java.lang.StringBuilder;	specialinvoke $r62.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r62.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG APPENDER:");	if r0 != null goto $r52 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>();	$r52 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r52);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 5