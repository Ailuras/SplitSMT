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

(declare-sort var1758 0)
(declare-sort var1461 0)
(declare-sort var20 0)
(declare-sort var889 0)
(declare-sort var1872 0)
(declare-sort var1155 0)
(declare-sort var340 0)
(declare-sort var1617 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var20!class ClassObject)
(declare-fun var1461_getErrorTypeAwareLogger/453021605 (ClassObject) var1758)
(declare-fun var889_compile/2141929305 (String) var889)
(declare-fun var1872-init () var1872)
(declare-fun <init>/-201242697 (var1872) void)
(declare-fun cast-from-var1872-to-var1155 (var1872) var1155)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var340) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1758_warn/126438324 (var1758 String String String String var340) void)
(declare-fun var1617_isEmpty/-813097145 (String) Bool)
(declare-const null-var340 var340)
(declare-const var20-logger var1758)
(declare-const var20-VERSION String)
(declare-const var20-LATEST_COMMIT_ID String)
(define-const var3421 var1758 (var1461_getErrorTypeAwareLogger/453021605 var20!class)) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/common/Version;") 
(define-const var966 var1758 var3421) ; Statement: <org.apache.dubbo.common.Version: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r0 
(define-const var739 var889 (var889_compile/2141929305 "^([0-9]*).*")) ; Statement: $r1 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("^([0-9]*).*") 
(define-const var1904 var889 var739) ; Statement: <org.apache.dubbo.common.Version: java.util.regex.Pattern PREFIX_DIGITS_PATTERN> = $r1 
(define-const var3094 var1872 var1872-init) ; Statement: $r2 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3094)) ; Statement: specialinvoke $r2.<java.util.HashMap: void <init>()>() 

(declare-const var3094!1 var1872)
(define-const var3091 var1155 (cast-from-var1872-to-var1155 var3094!1)) ; Statement: <org.apache.dubbo.common.Version: java.util.Map VERSION2INT> = $r2 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2875 var340) ; Statement: $r6 := @caughtexception 
(assert (not (= var2875 null-var340)))
(define-const var2889 var1758 var20-logger) ; Statement: $r8 = <org.apache.dubbo.common.Version: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var636 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var636)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var636!1 String)
(assert (= var636!1 ""))
(assert true)
(define-const var2075 String (append/672562846 var636!1 "continue the old logic, ignore exception ")) ; Statement: $r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("continue the old logic, ignore exception ") 
(declare-const var636!2 String)
(assert (= var636!2 (str.++ var636!1 "continue the old logic, ignore exception ")))
(assert true)
(define-const var309 String (getMessage/849299655 var2875)) ; Statement: $r9 = virtualinvoke $r6.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1083 String (append/672562846 var2075 var309)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var2075!1 String)
(assert (= var2075!1 (str.++ var2075 var309)))
(assert true)
(define-const var2330 String (toString/-2075883882 var1083)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1758_warn/126438324 var2889 "0-12" "" "" var2330 var2875)) ; Statement: interfaceinvoke $r8.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-12", "", "", $r12, $r6) 

(declare-const var2889!1 var1758)
(declare-const var1681 String)
(declare-const var2813 String)
(declare-const var2813!1 String)
(declare-const var2330!1 String)
(declare-const var2875!1 var340)
(assert true) ; Non Conditional
(define-const var1649 String var20-VERSION) ; Statement: $r3 = <org.apache.dubbo.common.Version: java.lang.String VERSION> 
(define-const var2478 Bool (var1617_isEmpty/-813097145 var1649)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r3) 
 ; Statement: if $z0 == 0 goto $r4 = <org.apache.dubbo.common.Version: java.lang.String LATEST_COMMIT_ID> 
(assert (= (ite var2478 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1897 String var20-LATEST_COMMIT_ID) ; Statement: $r4 = <org.apache.dubbo.common.Version: java.lang.String LATEST_COMMIT_ID> 
(define-const var572 Bool (var1617_isEmpty/-813097145 var1897)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var572 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {var1461_getErrorTypeAwareLogger/453021605=([java.lang.Class], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var889_compile/2141929305=([java.lang.String], java.util.regex.Pattern), var1872-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var1872-to-var1155=([java.util.HashMap], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1758_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var1617_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1758=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1461=org.apache.dubbo.common.logger.LoggerFactory, var20=org.apache.dubbo.common.Version, var3421=$r0, var966=<org.apache.dubbo.common.Version: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>, var889=java.util.regex.Pattern, var739=$r1, var1904=<org.apache.dubbo.common.Version: java.util.regex.Pattern PREFIX_DIGITS_PATTERN>, var1872=java.util.HashMap, var3094=$r2, var1155=java.util.Map, var3091=<org.apache.dubbo.common.Version: java.util.Map VERSION2INT>, var340=java.lang.Throwable, var2875=$r6, var2889=$r8, var636=$r7, var2075=$r10, var309=$r9, var1083=$r11, var2330=$r12, var1681="0-12", var2813="", var1649=$r3, var1617=org.apache.dubbo.common.utils.StringUtils, var2478=$z0, var1897=$r4, var572=$z1}
; {org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1758, org.apache.dubbo.common.logger.LoggerFactory=var1461, org.apache.dubbo.common.Version=var20, $r0=var3421, <org.apache.dubbo.common.Version: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>=var966, java.util.regex.Pattern=var889, $r1=var739, <org.apache.dubbo.common.Version: java.util.regex.Pattern PREFIX_DIGITS_PATTERN>=var1904, java.util.HashMap=var1872, $r2=var3094, java.util.Map=var1155, <org.apache.dubbo.common.Version: java.util.Map VERSION2INT>=var3091, java.lang.Throwable=var340, $r6=var2875, $r8=var2889, $r7=var636, $r10=var2075, $r9=var309, $r11=var1083, $r12=var2330, "0-12"=var1681, ""=var2813, $r3=var1649, org.apache.dubbo.common.utils.StringUtils=var1617, $z0=var2478, $r4=var1897, $z1=var572}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts $r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/common/Version;");	<org.apache.dubbo.common.Version: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r0;	$r1 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("^([0-9]*).*");	<org.apache.dubbo.common.Version: java.util.regex.Pattern PREFIX_DIGITS_PATTERN> = $r1;	$r2 = new java.util.HashMap;	specialinvoke $r2.<java.util.HashMap: void <init>()>();	<org.apache.dubbo.common.Version: java.util.Map VERSION2INT> = $r2;	$r6 := @caughtexception;	$r8 = <org.apache.dubbo.common.Version: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("continue the old logic, ignore exception ");	$r9 = virtualinvoke $r6.<java.lang.Throwable: java.lang.String getMessage()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r8.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-12", "", "", $r12, $r6);	$r3 = <org.apache.dubbo.common.Version: java.lang.String VERSION>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r3);	if $z0 == 0 goto $r4 = <org.apache.dubbo.common.Version: java.lang.String LATEST_COMMIT_ID>;	$r4 = <org.apache.dubbo.common.Version: java.lang.String LATEST_COMMIT_ID>;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z1 == 0 goto return;	return
;block_num 5