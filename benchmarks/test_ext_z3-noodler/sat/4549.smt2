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

(declare-sort var1172 0)
(declare-sort var1914 0)
(declare-sort var1282 0)
(declare-sort var2455 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var1172) var1914)
(declare-fun hashCode/385986394 (var1282) Int)
(declare-fun cast-from-var1914-to-var1282 (var1914) var1282)
(declare-fun logMessage/2066159914 (var1172) String)
(declare-fun logName/2066159914 (var1172) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logThread/2066159914 (var1172) String)
(declare-const null-var1172 var1172)
(declare-const null-var1914 var1914)
(declare-const null-String String)
(declare-const var81 var1172) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var81 null-var1172)))
(define-const var2713 var1914 (logLevel/2066159914 var81)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (= var2713 null-var1914))) ; Cond: $r1 != null 
(define-const var1171 var1914 (logLevel/2066159914 var81)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert true)
(define-const var3662 Int (hashCode/385986394 (cast-from-var1914-to-var1282 var1171))) ; Statement: $i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var250 Int (+ 31 var3662)) ; Statement: $i6 = 31 + $i7 
(define-const var2574 Int (* 31 var250)) ; Statement: $i0 = 31 * $i6 
(define-const var2701 String (logMessage/2066159914 var81)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (not (= var2701 null-String)))) ; Negate: Cond: $r3 != null  
(define-const var1744 Int 0) ; Statement: $i8 = 0 
 ; Statement: goto [?= $i5 = $i0 + $i8] 
(assert true) ; Non Conditional
(define-const var2145 Int (+ var2574 var1744)) ; Statement: $i5 = $i0 + $i8 
(define-const var1668 Int (* 31 var2145)) ; Statement: $i1 = 31 * $i5 
(define-const var3965 String (logName/2066159914 var81)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (= var3965 null-String))) ; Cond: $r5 != null 
(define-const var1390 String (logName/2066159914 var81)) ; Statement: $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert true)
(define-const var1995 Int (hashCode/-467973558 var1390)) ; Statement: $i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3208 Int (+ var1668 var1995)) ; Statement: $i4 = $i1 + $i9 
(define-const var1458 Int (* 31 var3208)) ; Statement: $i2 = 31 * $i4 
(define-const var2549 String (logThread/2066159914 var81)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (not (= var2549 null-String)))) ; Negate: Cond: $r7 != null  
(define-const var380 Int 0) ; Statement: $i10 = 0 
 ; Statement: goto [?= $i3 = $i2 + $i10] 
(assert true) ; Non Conditional
(define-const var447 Int (+ var1458 var380)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), hashCode/385986394=([java.lang.Enum], int), cast-from-var1914-to-var1282=([org.apache.dubbo.common.logger.Level], java.lang.Enum), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var1172=org.apache.dubbo.common.utils.Log, var81=r0, var1914=org.apache.dubbo.common.logger.Level, var2713=$r1, var1171=$r2, var1282=java.lang.Enum, var3662=$i7, var250=$i6, var2574=$i0, var2701=$r3, var2455=null_type, var1744=$i8, var2145=$i5, var1668=$i1, var3965=$r5, var1390=$r6, var1995=$i9, var3208=$i4, var1458=$i2, var2549=$r7, var380=$i10, var447=$i3}
; {org.apache.dubbo.common.utils.Log=var1172, r0=var81, org.apache.dubbo.common.logger.Level=var1914, $r1=var2713, $r2=var1171, java.lang.Enum=var1282, $i7=var3662, $i6=var250, $i0=var2574, $r3=var2701, null_type=var2455, $i8=var1744, $i5=var2145, $i1=var1668, $r5=var3965, $r6=var1390, $i9=var1995, $i4=var3208, $i2=var1458, $r7=var2549, $i10=var380, $i3=var447}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>();	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = 0;	goto [?= $i5 = $i0 + $i8];	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>();	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = 0;	goto [?= $i3 = $i2 + $i10];	$i3 = $i2 + $i10;	return $i3
;block_num 9