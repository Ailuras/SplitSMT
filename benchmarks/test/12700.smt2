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

(declare-sort var3296 0)
(declare-sort var2818 0)
(declare-sort var633 0)
(declare-sort var255 0)
(declare-sort var66 0)
(declare-sort var1498 0)
(declare-sort var2328 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var66_getFile/-1040015240 () var255)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var66_getLevel/-706352403 () var1498)
(declare-fun append/-1031950772 (String var2328) String)
(declare-fun cast-from-var1498-to-var2328 (var1498) var2328)
(declare-fun getAbsolutePath/-802773300 (var255) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3296 var3296)
(declare-const null-var2818 var2818)
(declare-const null-String String)
(declare-const null-var255 var255)
(declare-const var627 var3296) ; Statement: r28 := @this: org.apache.dubbo.qos.legacy.LogTelnetHandler 
(assert (not (= var627 null-var3296)))
(declare-const var216 var2818) ; Statement: r29 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var216 null-var2818)))
(declare-const var1654 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1654 null-String)))
(define-const var2450 var255 var66_getFile/-1040015240) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.io.File getFile()>() 
(define-const var2046 String String-init) ; Statement: $r36 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2046)) ; Statement: specialinvoke $r36.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2046!1 String)
(assert (= var2046!1 ""))
 ; Statement: if r2 == null goto virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100") 
(assert (= var1654 null-String)) ; Cond: r2 == null 
(assert true)
;(assert (append/672562846 var2046!1 "EXAMPLE: log error / log 100")) ; Statement: virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100") 
(declare-const var2046!2 String)
(assert (= var2046!2 (str.++ var2046!1 "EXAMPLE: log error / log 100")))
 ; Statement: goto [?= $r32 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:")] 
(assert true) ; Non Conditional
(assert true)
(define-const var1572 String (append/672562846 var2046!2 "\r\nCURRENT LOG LEVEL:")) ; Statement: $r32 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:") 
(declare-const var2046!3 String)
(assert (= var2046!3 (str.++ var2046!2 "\r\nCURRENT LOG LEVEL:")))
(define-const var3102 var1498 var66_getLevel/-706352403) ; Statement: $r33 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>() 
(assert true)
(define-const var2808 String (append/-1031950772 var1572 (cast-from-var1498-to-var2328 var3102))) ; Statement: $r34 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var1572!1 String)
(assert (str.prefixof var1572 var1572!1))
(assert true)
(define-const var3872 String (append/672562846 var2808 "\r\nCURRENT LOG APPENDER:")) ; Statement: $r3 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG APPENDER:") 
(declare-const var2808!1 String)
(assert (= var2808!1 (str.++ var2808 "\r\nCURRENT LOG APPENDER:")))
 ; Statement: if r0 != null goto $r35 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>() 
(assert (not (= var2450 null-var255))) ; Cond: r0 != null 
(assert true)
(define-const var1242 String (getAbsolutePath/-802773300 var2450)) ; Statement: $r35 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>() 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var3872 var1242)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35) 
(declare-const var3872!1 String)
(assert (= var3872!1 (str.++ var3872 var1242)))
(assert true)
(define-const var1946 String (toString/-2075883882 var2046!3)) ; Statement: $r4 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {var66_getFile/-1040015240=([], java.io.File), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var66_getLevel/-706352403=([], org.apache.dubbo.common.logger.Level), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1498-to-var2328=([org.apache.dubbo.common.logger.Level], java.lang.Object), getAbsolutePath/-802773300=([java.io.File], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3296=org.apache.dubbo.qos.legacy.LogTelnetHandler, var627=r28, var2818=org.apache.dubbo.remoting.Channel, var216=r29, var1654=r2, var633=null_type, var255=java.io.File, var66=org.apache.dubbo.common.logger.LoggerFactory, var2450=r0, var2046=$r36, var1572=$r32, var1498=org.apache.dubbo.common.logger.Level, var3102=$r33, var2328=java.lang.Object, var2808=$r34, var3872=$r3, var1242=$r35, var1946=$r4}
; {org.apache.dubbo.qos.legacy.LogTelnetHandler=var3296, r28=var627, org.apache.dubbo.remoting.Channel=var2818, r29=var216, r2=var1654, null_type=var633, java.io.File=var255, org.apache.dubbo.common.logger.LoggerFactory=var66, r0=var2450, $r36=var2046, $r32=var1572, org.apache.dubbo.common.logger.Level=var1498, $r33=var3102, java.lang.Object=var2328, $r34=var2808, $r3=var3872, $r35=var1242, $r4=var1946}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r28 := @this: org.apache.dubbo.qos.legacy.LogTelnetHandler;	r29 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: java.lang.String;	r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.io.File getFile()>();	$r36 = new java.lang.StringBuilder;	specialinvoke $r36.<java.lang.StringBuilder: void <init>()>();	if r2 == null goto virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100");	virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("EXAMPLE: log error / log 100");	goto [?= $r32 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:")];	$r32 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG LEVEL:");	$r33 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>();	$r34 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r3 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nCURRENT LOG APPENDER:");	if r0 != null goto $r35 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>();	$r35 = virtualinvoke r0.<java.io.File: java.lang.String getAbsolutePath()>();	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35);	$r4 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 5