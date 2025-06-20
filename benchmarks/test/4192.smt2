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

(declare-sort var2407 0)
(declare-sort var898 0)
(declare-sort var1973 0)
(declare-sort var2229 0)
(declare-sort var1323 0)
(declare-sort var2057 0)
(declare-sort var1103 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2407_getSystemProperty/1393069448 (String) String)
(declare-fun var898_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2057_debug/-407276736 (var2057 String var1103) void)
(declare-fun cast-from-var2229-to-var2057 (var2229) var2057)
(declare-fun cast-from-var1973-to-var1103 (var1973) var1103)
(declare-const null-var1973 var1973)
(declare-const var1323-logger var2229)
(declare-const var1323-JAVA_8 var1323)
(define-const var3636 String (var2407_getSystemProperty/1393069448 "java.version")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version") 
(define-const var186 Bool (var898_isBlank/-523695098 (cast-from-String-to-String var3636))) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (= (ite var186 1 0) 0)) ; Cond: z0 == 0 
 ; Statement: if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert (not (not (= (ite var186 1 0) 0)))) ; Negate: Cond: z0 != 0  
(declare-const var2841 var1973) ; Statement: $r24 := @caughtexception 
(assert (not (= var2841 null-var1973)))
(define-const var770 var2229 var1323-logger) ; Statement: $r25 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var2057_debug/-407276736 (cast-from-var2229-to-var2057 var770) "Can\u0027t determine current JRE version (maybe java.version is null), assuming that JRE version is 8." (cast-from-var1973-to-var1103 var2841))) ; Statement: interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>("Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", $r24) 

(declare-const var770!1 var2229)
(declare-const var1412 String)
(declare-const var2841!1 var1973)
(define-const var561 var1323 var1323-JAVA_8) ; Statement: $r26 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8> 
 ; Statement: return $r26 
(check-sat)
; {var2407_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var898_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2057_debug/-407276736=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Throwable], void), cast-from-var2229-to-var2057=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), cast-from-var1973-to-var1103=([java.lang.Exception], java.lang.Throwable)}
; {var2407=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3636=r0, var898=org.apache.dubbo.common.utils.StringUtils, var186=z0, var1973=java.lang.Exception, var2841=$r24, var2229=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1323=org.apache.dubbo.common.utils.JRE, var770=$r25, var2057=org.apache.dubbo.common.logger.Logger, var1103=java.lang.Throwable, var1412="Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", var561=$r26}
; {org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2407, r0=var3636, org.apache.dubbo.common.utils.StringUtils=var898, z0=var186, java.lang.Exception=var1973, $r24=var2841, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2229, org.apache.dubbo.common.utils.JRE=var1323, $r25=var770, org.apache.dubbo.common.logger.Logger=var2057, java.lang.Throwable=var1103, "Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8."=var1412, $r26=var561}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version");	z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if z0 == 0 goto (branch);	if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	$r24 := @caughtexception;	$r25 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>("Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", $r24);	$r26 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8>;	return $r26
;block_num 3