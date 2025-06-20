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

(declare-sort var1904 0)
(declare-sort var805 0)
(declare-sort var1334 0)
(declare-sort var727 0)
(declare-sort var3941 0)
(declare-sort var1750 0)
(declare-sort var1158 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3941_getFile/-1040015240 () var727)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3941_getLevel/-706352403 () var1750)
(declare-fun append/-1031950772 (String var1158) String)
(declare-fun cast-from-var1750-to-var1158 (var1750) var1158)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1904 var1904)
(declare-const null-var805 var805)
(declare-const null-String String)
(declare-const null-var727 var727)
(declare-const var2741 var1904) ; Statement: r42 := @this: org.apache.dubbo.remoting.telnet.support.command.LogTelnetHandler 
(assert (not (= var2741 null-var1904)))
(declare-const var3841 var805) ; Statement: r43 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3841 null-var805)))
(declare-const var2366 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2366 null-String)))
(define-const var1749 var727 var3941_getFile/-1040015240) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.io.File getFile()>() 
(define-const var3963 String String-init) ; Statement: $r53 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3963)) ; Statement: specialinvoke $r53.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3963!1 String)
(assert (= var3963!1 ""))
 ; Statement: if r2 == null goto virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100") 
(assert (= var2366 null-String)) ; Cond: r2 == null 
(assert true)
;(assert (append/672562846 var3963!1 "EXAMPLE: log error / log 100")) ; Statement: virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100") 
(declare-const var3963!2 String)
(assert (= var3963!2 (str.++ var3963!1 "EXAMPLE: log error / log 100")))
 ; Statement: goto [?= $r61 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var117 String String-init) ; Statement: $r61 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var117)) ; Statement: specialinvoke $r61.<java.lang.StringBuilder: void <init>()>() 
(declare-const var117!1 String)
(assert (= var117!1 ""))
(assert true)
(define-const var1560 String (append/672562846 var117!1 "\r\nCURRENT LOG LEVEL:")) ; Statement: $r47 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:") 
(declare-const var117!2 String)
(assert (= var117!2 (str.++ var117!1 "\r\nCURRENT LOG LEVEL:")))
(define-const var1267 var1750 var3941_getLevel/-706352403) ; Statement: $r48 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>() 
(assert true)
(define-const var33 String (append/-1031950772 var1560 (cast-from-var1750-to-var1158 var1267))) ; Statement: $r49 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r48) 
(declare-const var1560!1 String)
(assert (str.prefixof var1560 var1560!1))
(assert true)
(define-const var3485 String (toString/-2075883882 var33)) ; Statement: $r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var2242 String (append/672562846 var3963!2 var3485)) ; Statement: $r6 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r50) 
(declare-const var3963!3 String)
(assert (= var3963!3 (str.++ var3963!2 var3485)))
(define-const var3772 String String-init) ; Statement: $r62 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3772)) ; Statement: specialinvoke $r62.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3772!1 String)
(assert (= var3772!1 ""))
(assert true)
(define-const var120 String (append/672562846 var3772!1 "\r\nCURRENT LOG APPENDER:")) ; Statement: $r3 = virtualinvoke $r62.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG APPENDER:") 
(declare-const var3772!2 String)
(assert (= var3772!2 (str.++ var3772!1 "\r\nCURRENT LOG APPENDER:")))
 ; Statement: if r0 != null goto $r52 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>() 
(assert (not (not (= var1749 null-var727)))) ; Negate: Cond: r0 != null  
(define-const var2420 String "console") ; Statement: $r52 = "console" 
 ; Statement: goto [?= $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r52)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1350 String (append/672562846 var120 var2420)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r52) 
(declare-const var120!1 String)
(assert (= var120!1 (str.++ var120 var2420)))
(assert true)
(define-const var2962 String (toString/-2075883882 var1350)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (append/672562846 var2242 var2962)) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2242!1 String)
(assert (= var2242!1 (str.++ var2242 var2962)))
(assert true)
(define-const var116 String (toString/-2075883882 var3963!3)) ; Statement: $r7 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {var3941_getFile/-1040015240=([], java.io.File), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3941_getLevel/-706352403=([], org.apache.dubbo.common.logger.Level), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1750-to-var1158=([org.apache.dubbo.common.logger.Level], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1904=org.apache.dubbo.remoting.telnet.support.command.LogTelnetHandler, var2741=r42, var805=org.apache.dubbo.remoting.Channel, var3841=r43, var2366=r2, var1334=null_type, var727=java.io.File, var3941=org.apache.dubbo.common.logger.LoggerFactory, var1749=r0, var3963=$r53, var117=$r61, var1560=$r47, var1750=org.apache.dubbo.common.logger.Level, var1267=$r48, var1158=java.lang.Object, var33=$r49, var3485=$r50, var2242=$r6, var3772=$r62, var120=$r3, var2420=$r52, var1350=$r4, var2962=$r5, var116=$r7}
; {org.apache.dubbo.remoting.telnet.support.command.LogTelnetHandler=var1904, r42=var2741, org.apache.dubbo.remoting.Channel=var805, r43=var3841, r2=var2366, null_type=var1334, java.io.File=var727, org.apache.dubbo.common.logger.LoggerFactory=var3941, r0=var1749, $r53=var3963, $r61=var117, $r47=var1560, org.apache.dubbo.common.logger.Level=var1750, $r48=var1267, java.lang.Object=var1158, $r49=var33, $r50=var3485, $r6=var2242, $r62=var3772, $r3=var120, $r52=var2420, $r4=var1350, $r5=var2962, $r7=var116}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 3}
;stmts r42 := @this: org.apache.dubbo.remoting.telnet.support.command.LogTelnetHandler;	r43 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: java.lang.String;	r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.io.File getFile()>();	$r53 = new java.lang.StringBuilder;	specialinvoke $r53.<java.lang.StringBuilder: void <init>()>();	if r2 == null goto virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100");	virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100");	goto [?= $r61 = new java.lang.StringBuilder];	$r61 = new java.lang.StringBuilder;	specialinvoke $r61.<java.lang.StringBuilder: void <init>()>();	$r47 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:");	$r48 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>();	$r49 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r48);	$r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r50);	$r62 = new java.lang.StringBuilder;	specialinvoke $r62.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r62.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG APPENDER:");	if r0 != null goto $r52 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>();	$r52 = "console";	goto [?= $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r52)];	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r52);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 5