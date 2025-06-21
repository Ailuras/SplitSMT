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

(declare-sort var3243 0)
(declare-sort var3638 0)
(declare-sort var1040 0)
(declare-sort var1041 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var3243) var3638)
(declare-fun hashCode/385986394 (var1040) Int)
(declare-fun cast-from-var3638-to-var1040 (var3638) var1040)
(declare-fun logMessage/2066159914 (var3243) String)
(declare-fun logName/2066159914 (var3243) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logThread/2066159914 (var3243) String)
(declare-const null-var3243 var3243)
(declare-const null-var3638 var3638)
(declare-const null-String String)
(declare-const var2268 var3243) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2268 null-var3243)))
(define-const var2020 var3638 (logLevel/2066159914 var2268)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (= var2020 null-var3638))) ; Cond: $r1 != null 
(define-const var709 var3638 (logLevel/2066159914 var2268)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert true)
(define-const var1821 Int (hashCode/385986394 (cast-from-var3638-to-var1040 var709))) ; Statement: $i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2247 Int (+ 31 var1821)) ; Statement: $i6 = 31 + $i7 
(define-const var3210 Int (* 31 var2247)) ; Statement: $i0 = 31 * $i6 
(define-const var1192 String (logMessage/2066159914 var2268)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (not (= var1192 null-String)))) ; Negate: Cond: $r3 != null  
(define-const var3448 Int 0) ; Statement: $i8 = 0 
 ; Statement: goto [?= $i5 = $i0 + $i8] 
(assert true) ; Non Conditional
(define-const var3106 Int (+ var3210 var3448)) ; Statement: $i5 = $i0 + $i8 
(define-const var37 Int (* 31 var3106)) ; Statement: $i1 = 31 * $i5 
(define-const var2134 String (logName/2066159914 var2268)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (= var2134 null-String))) ; Cond: $r5 != null 
(define-const var520 String (logName/2066159914 var2268)) ; Statement: $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert true)
(define-const var3427 Int (hashCode/-467973558 var520)) ; Statement: $i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3714 Int (+ var37 var3427)) ; Statement: $i4 = $i1 + $i9 
(define-const var1996 Int (* 31 var3714)) ; Statement: $i2 = 31 * $i4 
(define-const var1794 String (logThread/2066159914 var2268)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (= var1794 null-String))) ; Cond: $r7 != null 
(define-const var1893 String (logThread/2066159914 var2268)) ; Statement: $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert true)
(define-const var575 Int (hashCode/-467973558 var1893)) ; Statement: $i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2777 Int (+ var1996 var575)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), hashCode/385986394=([java.lang.Enum], int), cast-from-var3638-to-var1040=([org.apache.dubbo.common.logger.Level], java.lang.Enum), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var3243=org.apache.dubbo.common.utils.Log, var2268=r0, var3638=org.apache.dubbo.common.logger.Level, var2020=$r1, var709=$r2, var1040=java.lang.Enum, var1821=$i7, var2247=$i6, var3210=$i0, var1192=$r3, var1041=null_type, var3448=$i8, var3106=$i5, var37=$i1, var2134=$r5, var520=$r6, var3427=$i9, var3714=$i4, var1996=$i2, var1794=$r7, var1893=$r8, var575=$i10, var2777=$i3}
; {org.apache.dubbo.common.utils.Log=var3243, r0=var2268, org.apache.dubbo.common.logger.Level=var3638, $r1=var2020, $r2=var709, java.lang.Enum=var1040, $i7=var1821, $i6=var2247, $i0=var3210, $r3=var1192, null_type=var1041, $i8=var3448, $i5=var3106, $i1=var37, $r5=var2134, $r6=var520, $i9=var3427, $i4=var3714, $i2=var1996, $r7=var1794, $r8=var1893, $i10=var575, $i3=var2777}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>();	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = 0;	goto [?= $i5 = $i0 + $i8];	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>();	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i10;	return $i3
;block_num 9