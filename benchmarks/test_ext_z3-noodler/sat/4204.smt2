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

(declare-sort var420 0)
(declare-sort var1996 0)
(declare-sort var1071 0)
(declare-sort var238 0)
(declare-sort var2876 0)
(declare-sort var2698 0)
(declare-sort var3336 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var420_getSystemProperty/1393069448 (String) String)
(declare-fun var1996_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun var2698_debug/-407276736 (var2698 String var3336) void)
(declare-fun cast-from-var238-to-var2698 (var238) var2698)
(declare-fun cast-from-var1071-to-var3336 (var1071) var3336)
(declare-const null-var1071 var1071)
(declare-const var2876-logger var238)
(declare-const var2876-JAVA_8 var2876)
(define-const var2004 String (var420_getSystemProperty/1393069448 "java.version")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version") 
(define-const var802 Bool (var1996_isBlank/-523695098 (cast-from-String-to-String var2004))) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (= (ite var802 1 0) 0)) ; Cond: z0 == 0 
 ; Statement: if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert (not (not (= (ite var802 1 0) 0)))) ; Negate: Cond: z0 != 0  
(assert true)
(define-const var2925 Bool (startsWith/-1785782452 var2004 "1.8")) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("1.8") 
 ; Statement: if $z1 == 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert (not (= (ite var2925 1 0) 0))) ; Negate: Cond: $z1 == 0  
(declare-const var3459 var1071) ; Statement: $r24 := @caughtexception 
(assert (not (= var3459 null-var1071)))
(define-const var3153 var238 var2876-logger) ; Statement: $r25 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var2698_debug/-407276736 (cast-from-var238-to-var2698 var3153) "Can\u0027t determine current JRE version (maybe java.version is null), assuming that JRE version is 8." (cast-from-var1071-to-var3336 var3459))) ; Statement: interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>("Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", $r24) 

(declare-const var3153!1 var238)
(declare-const var2456 String)
(declare-const var3459!1 var1071)
(define-const var3708 var2876 var2876-JAVA_8) ; Statement: $r26 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8> 
 ; Statement: return $r26 
(check-sat)
; {var420_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var1996_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), var2698_debug/-407276736=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Throwable], void), cast-from-var238-to-var2698=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), cast-from-var1071-to-var3336=([java.lang.Exception], java.lang.Throwable)}
; {var420=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2004=r0, var1996=org.apache.dubbo.common.utils.StringUtils, var802=z0, var2925=$z1, var1071=java.lang.Exception, var3459=$r24, var238=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2876=org.apache.dubbo.common.utils.JRE, var3153=$r25, var2698=org.apache.dubbo.common.logger.Logger, var3336=java.lang.Throwable, var2456="Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", var3708=$r26}
; {org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var420, r0=var2004, org.apache.dubbo.common.utils.StringUtils=var1996, z0=var802, $z1=var2925, java.lang.Exception=var1071, $r24=var3459, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var238, org.apache.dubbo.common.utils.JRE=var2876, $r25=var3153, org.apache.dubbo.common.logger.Logger=var2698, java.lang.Throwable=var3336, "Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8."=var2456, $r26=var3708}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version");	z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if z0 == 0 goto (branch);	if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	$z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("1.8");	if $z1 == 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	$r24 := @caughtexception;	$r25 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r25.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>("Can\'t determine current JRE version (maybe java.version is null), assuming that JRE version is 8.", $r24);	$r26 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8>;	return $r26
;block_num 4