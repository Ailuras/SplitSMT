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

(declare-sort var3443 0)
(declare-sort var1837 0)
(declare-sort var2357 0)
(declare-sort var2267 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var3443) var1837)
(declare-fun hashCode/385986394 (var2357) Int)
(declare-fun cast-from-var1837-to-var2357 (var1837) var2357)
(declare-fun logMessage/2066159914 (var3443) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logName/2066159914 (var3443) String)
(declare-fun logThread/2066159914 (var3443) String)
(declare-const null-var3443 var3443)
(declare-const null-var1837 var1837)
(declare-const null-String String)
(declare-const var2243 var3443) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2243 null-var3443)))
(define-const var1691 var1837 (logLevel/2066159914 var2243)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (= var1691 null-var1837))) ; Cond: $r1 != null 
(define-const var3474 var1837 (logLevel/2066159914 var2243)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert true)
(define-const var2006 Int (hashCode/385986394 (cast-from-var1837-to-var2357 var3474))) ; Statement: $i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var1141 Int (+ 31 var2006)) ; Statement: $i6 = 31 + $i7 
(define-const var3322 Int (* 31 var1141)) ; Statement: $i0 = 31 * $i6 
(define-const var3901 String (logMessage/2066159914 var2243)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (= var3901 null-String))) ; Cond: $r3 != null 
(define-const var2454 String (logMessage/2066159914 var2243)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert true)
(define-const var3310 Int (hashCode/-467973558 var2454)) ; Statement: $i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var1 Int (+ var3322 var3310)) ; Statement: $i5 = $i0 + $i8 
(define-const var3436 Int (* 31 var1)) ; Statement: $i1 = 31 * $i5 
(define-const var2893 String (logName/2066159914 var2243)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (= var2893 null-String))) ; Cond: $r5 != null 
(define-const var2418 String (logName/2066159914 var2243)) ; Statement: $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert true)
(define-const var852 Int (hashCode/-467973558 var2418)) ; Statement: $i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3518 Int (+ var3436 var852)) ; Statement: $i4 = $i1 + $i9 
(define-const var543 Int (* 31 var3518)) ; Statement: $i2 = 31 * $i4 
(define-const var2951 String (logThread/2066159914 var2243)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (not (= var2951 null-String)))) ; Negate: Cond: $r7 != null  
(define-const var1551 Int 0) ; Statement: $i10 = 0 
 ; Statement: goto [?= $i3 = $i2 + $i10] 
(assert true) ; Non Conditional
(define-const var3133 Int (+ var543 var1551)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), hashCode/385986394=([java.lang.Enum], int), cast-from-var1837-to-var2357=([org.apache.dubbo.common.logger.Level], java.lang.Enum), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var3443=org.apache.dubbo.common.utils.Log, var2243=r0, var1837=org.apache.dubbo.common.logger.Level, var1691=$r1, var3474=$r2, var2357=java.lang.Enum, var2006=$i7, var1141=$i6, var3322=$i0, var3901=$r3, var2267=null_type, var2454=$r4, var3310=$i8, var1=$i5, var3436=$i1, var2893=$r5, var2418=$r6, var852=$i9, var3518=$i4, var543=$i2, var2951=$r7, var1551=$i10, var3133=$i3}
; {org.apache.dubbo.common.utils.Log=var3443, r0=var2243, org.apache.dubbo.common.logger.Level=var1837, $r1=var1691, $r2=var3474, java.lang.Enum=var2357, $i7=var2006, $i6=var1141, $i0=var3322, $r3=var3901, null_type=var2267, $r4=var2454, $i8=var3310, $i5=var1, $i1=var3436, $r5=var2893, $r6=var2418, $i9=var852, $i4=var3518, $i2=var543, $r7=var2951, $i10=var1551, $i3=var3133}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>();	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>();	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = 0;	goto [?= $i3 = $i2 + $i10];	$i3 = $i2 + $i10;	return $i3
;block_num 9