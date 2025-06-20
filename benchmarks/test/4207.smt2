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

(declare-sort var3440 0)
(declare-sort var3426 0)
(declare-sort var3383 0)
(declare-sort var1670 0)
(declare-sort var908 0)
(declare-sort var179 0)
(declare-sort var3574 0)
(declare-sort var1482 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3440_getSystemProperty/1393069448 (String) String)
(declare-fun var3426_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3383_getRuntime/1249267505 () var3383)
(declare-fun var3574_debug/-407276736 (var3574 String var1482) void)
(declare-fun cast-from-var908-to-var3574 (var908) var3574)
(declare-fun cast-from-var1670-to-var1482 (var1670) var1482)
(declare-const null-var1670 var1670)
(declare-const var179-logger var908)
(declare-const var179-JAVA_8 var179)
(define-const var1115 String (var3440_getSystemProperty/1393069448 "java.version")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version") 
(define-const var986 Bool (var3426_isBlank/-523695098 (cast-from-String-to-String var1115))) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (= (ite var986 1 0) 0)) ; Cond: z0 == 0 
 ; Statement: if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert (not (= (ite var986 1 0) 0))) ; Cond: z0 != 0 
(define-const var1820 var3383 var3383_getRuntime/1249267505) ; Statement: $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var106 var1670) ; Statement: $r24 := @caughtexception 
(assert (not (= var106 null-var1670)))
(define-const var1810 var908 var179-logger) ; Statement: $r25 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3574_debug/-407276736 (cast-from-var908-to-var3574 var1810) "Can\u0027t determine current JRE version (maybe java.version is null), assuming that JRE version is 8." (cast-from-var1670-to-var1482 var106))) ; Statement: interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>("Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", $r24) 

(declare-const var1810!1 var908)
(declare-const var1343 String)
(declare-const var106!1 var1670)
(define-const var1545 var179 var179-JAVA_8) ; Statement: $r26 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8> 
 ; Statement: return $r26 
(check-sat)
; {var3440_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var3426_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3383_getRuntime/1249267505=([], java.lang.Runtime), var3574_debug/-407276736=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Throwable], void), cast-from-var908-to-var3574=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), cast-from-var1670-to-var1482=([java.lang.Exception], java.lang.Throwable)}
; {var3440=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var1115=r0, var3426=org.apache.dubbo.common.utils.StringUtils, var986=z0, var3383=java.lang.Runtime, var1820=$r2, var1670=java.lang.Exception, var106=$r24, var908=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var179=org.apache.dubbo.common.utils.JRE, var1810=$r25, var3574=org.apache.dubbo.common.logger.Logger, var1482=java.lang.Throwable, var1343="Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", var1545=$r26}
; {org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3440, r0=var1115, org.apache.dubbo.common.utils.StringUtils=var3426, z0=var986, java.lang.Runtime=var3383, $r2=var1820, java.lang.Exception=var1670, $r24=var106, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var908, org.apache.dubbo.common.utils.JRE=var179, $r25=var1810, org.apache.dubbo.common.logger.Logger=var3574, java.lang.Throwable=var1482, "Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8."=var1343, $r26=var1545}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version");	z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if z0 == 0 goto (branch);	if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	$r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	$r24 := @caughtexception;	$r25 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>("Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", $r24);	$r26 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8>;	return $r26
;block_num 4