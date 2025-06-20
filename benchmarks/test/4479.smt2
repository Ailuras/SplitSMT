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

(declare-sort var3585 0)
(declare-sort var1147 0)
(declare-sort var1480 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var3585) var1147)
(declare-fun logMessage/2066159914 (var3585) String)
(declare-fun logName/2066159914 (var3585) String)
(declare-fun logThread/2066159914 (var3585) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-const null-var3585 var3585)
(declare-const null-var1147 var1147)
(declare-const null-String String)
(declare-const var2031 var3585) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2031 null-var3585)))
(define-const var3349 var1147 (logLevel/2066159914 var2031)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (not (= var3349 null-var1147)))) ; Negate: Cond: $r1 != null  
(define-const var2081 Int 0) ; Statement: $i7 = 0 
 ; Statement: goto [?= $i6 = 31 + $i7] 
(assert true) ; Non Conditional
(define-const var3112 Int (+ 31 var2081)) ; Statement: $i6 = 31 + $i7 
(define-const var3975 Int (* 31 var3112)) ; Statement: $i0 = 31 * $i6 
(define-const var3 String (logMessage/2066159914 var2031)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (not (= var3 null-String)))) ; Negate: Cond: $r3 != null  
(define-const var2217 Int 0) ; Statement: $i8 = 0 
 ; Statement: goto [?= $i5 = $i0 + $i8] 
(assert true) ; Non Conditional
(define-const var2765 Int (+ var3975 var2217)) ; Statement: $i5 = $i0 + $i8 
(define-const var480 Int (* 31 var2765)) ; Statement: $i1 = 31 * $i5 
(define-const var316 String (logName/2066159914 var2031)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (not (= var316 null-String)))) ; Negate: Cond: $r5 != null  
(define-const var2086 Int 0) ; Statement: $i9 = 0 
 ; Statement: goto [?= $i4 = $i1 + $i9] 
(assert true) ; Non Conditional
(define-const var867 Int (+ var480 var2086)) ; Statement: $i4 = $i1 + $i9 
(define-const var2024 Int (* 31 var867)) ; Statement: $i2 = 31 * $i4 
(define-const var306 String (logThread/2066159914 var2031)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (= var306 null-String))) ; Cond: $r7 != null 
(define-const var49 String (logThread/2066159914 var2031)) ; Statement: $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert true)
(define-const var2211 Int (hashCode/-467973558 var49)) ; Statement: $i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2099 Int (+ var2024 var2211)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int)}
; {var3585=org.apache.dubbo.common.utils.Log, var2031=r0, var1147=org.apache.dubbo.common.logger.Level, var3349=$r1, var2081=$i7, var3112=$i6, var3975=$i0, var3=$r3, var1480=null_type, var2217=$i8, var2765=$i5, var480=$i1, var316=$r5, var2086=$i9, var867=$i4, var2024=$i2, var306=$r7, var49=$r8, var2211=$i10, var2099=$i3}
; {org.apache.dubbo.common.utils.Log=var3585, r0=var2031, org.apache.dubbo.common.logger.Level=var1147, $r1=var3349, $i7=var2081, $i6=var3112, $i0=var3975, $r3=var3, null_type=var1480, $i8=var2217, $i5=var2765, $i1=var480, $r5=var316, $i9=var2086, $i4=var867, $i2=var2024, $r7=var306, $r8=var49, $i10=var2211, $i3=var2099}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = 0;	goto [?= $i6 = 31 + $i7];	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = 0;	goto [?= $i5 = $i0 + $i8];	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = 0;	goto [?= $i4 = $i1 + $i9];	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i10;	return $i3
;block_num 9