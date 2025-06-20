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

(declare-sort var3556 0)
(declare-sort var589 0)
(declare-sort var2187 0)
(declare-sort var1557 0)
(declare-sort var2118 0)
(declare-sort var2370 0)
(declare-sort var2599 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3556_getSystemProperty/1393069448 (String) String)
(declare-fun var589_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2118_debug/470264832 (var2118 String) void)
(declare-fun cast-from-var2187-to-var2118 (var2187) var2118)
(declare-fun var2118_debug/-407276736 (var2118 String var2599) void)
(declare-fun cast-from-var2370-to-var2599 (var2370) var2599)
(declare-const var1557-logger var2187)
(declare-const null-var2370 var2370)
(declare-const var1557-JAVA_8 var1557)
(define-const var564 String (var3556_getSystemProperty/1393069448 "java.version")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version") 
(define-const var3262 Bool (var589_isBlank/-523695098 (cast-from-String-to-String var564))) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (not (= (ite var3262 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var1565 var2187 var1557-logger) ; Statement: $r23 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var2118_debug/470264832 (cast-from-var2187-to-var2118 var1565) "java.version is blank")) ; Statement: interfaceinvoke $r23.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>("java.version is blank") 

(declare-const var1565!1 var2187)
(declare-const var1283 String)
(assert true) ; Non Conditional
 ; Statement: if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert (not (not (= (ite var3262 1 0) 0)))) ; Negate: Cond: z0 != 0  
(declare-const var515 var2370) ; Statement: $r24 := @caughtexception 
(assert (not (= var515 null-var2370)))
(define-const var3920 var2187 var1557-logger) ; Statement: $r25 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var2118_debug/-407276736 (cast-from-var2187-to-var2118 var3920) "Can\u0027t determine current JRE version (maybe java.version is null), assuming that JRE version is 8." (cast-from-var2370-to-var2599 var515))) ; Statement: interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>("Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", $r24) 

(declare-const var3920!1 var2187)
(declare-const var577 String)
(declare-const var515!1 var2370)
(define-const var1072 var1557 var1557-JAVA_8) ; Statement: $r26 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8> 
 ; Statement: return $r26 
(check-sat)
; {var3556_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var589_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2118_debug/470264832=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var2187-to-var2118=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var2118_debug/-407276736=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Throwable], void), cast-from-var2370-to-var2599=([java.lang.Exception], java.lang.Throwable)}
; {var3556=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var564=r0, var589=org.apache.dubbo.common.utils.StringUtils, var3262=z0, var2187=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1557=org.apache.dubbo.common.utils.JRE, var1565=$r23, var2118=org.apache.dubbo.common.logger.Logger, var1283="java.version is blank", var2370=java.lang.Exception, var515=$r24, var3920=$r25, var2599=java.lang.Throwable, var577="Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", var1072=$r26}
; {org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3556, r0=var564, org.apache.dubbo.common.utils.StringUtils=var589, z0=var3262, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2187, org.apache.dubbo.common.utils.JRE=var1557, $r23=var1565, org.apache.dubbo.common.logger.Logger=var2118, "java.version is blank"=var1283, java.lang.Exception=var2370, $r24=var515, $r25=var3920, java.lang.Throwable=var2599, "Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8."=var577, $r26=var1072}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version");	z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if z0 == 0 goto (branch);	$r23 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r23.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>("java.version is blank");	if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	$r24 := @caughtexception;	$r25 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>("Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", $r24);	$r26 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8>;	return $r26
;block_num 4