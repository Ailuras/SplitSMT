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

(declare-sort var1157 0)
(declare-sort var117 0)
(declare-sort var3752 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var1157) var117)
(declare-fun logMessage/2066159914 (var1157) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logName/2066159914 (var1157) String)
(declare-fun logThread/2066159914 (var1157) String)
(declare-const null-var1157 var1157)
(declare-const null-var117 var117)
(declare-const null-String String)
(declare-const var2113 var1157) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2113 null-var1157)))
(define-const var1276 var117 (logLevel/2066159914 var2113)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (not (= var1276 null-var117)))) ; Negate: Cond: $r1 != null  
(define-const var3725 Int 0) ; Statement: $i7 = 0 
 ; Statement: goto [?= $i6 = 31 + $i7] 
(assert true) ; Non Conditional
(define-const var499 Int (+ 31 var3725)) ; Statement: $i6 = 31 + $i7 
(define-const var1102 Int (* 31 var499)) ; Statement: $i0 = 31 * $i6 
(define-const var2941 String (logMessage/2066159914 var2113)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (= var2941 null-String))) ; Cond: $r3 != null 
(define-const var2709 String (logMessage/2066159914 var2113)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert true)
(define-const var2758 Int (hashCode/-467973558 var2709)) ; Statement: $i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3132 Int (+ var1102 var2758)) ; Statement: $i5 = $i0 + $i8 
(define-const var389 Int (* 31 var3132)) ; Statement: $i1 = 31 * $i5 
(define-const var1545 String (logName/2066159914 var2113)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (= var1545 null-String))) ; Cond: $r5 != null 
(define-const var3993 String (logName/2066159914 var2113)) ; Statement: $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert true)
(define-const var3970 Int (hashCode/-467973558 var3993)) ; Statement: $i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var679 Int (+ var389 var3970)) ; Statement: $i4 = $i1 + $i9 
(define-const var307 Int (* 31 var679)) ; Statement: $i2 = 31 * $i4 
(define-const var342 String (logThread/2066159914 var2113)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (= var342 null-String))) ; Cond: $r7 != null 
(define-const var2378 String (logThread/2066159914 var2113)) ; Statement: $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert true)
(define-const var2757 Int (hashCode/-467973558 var2378)) ; Statement: $i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var1029 Int (+ var307 var2757)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var1157=org.apache.dubbo.common.utils.Log, var2113=r0, var117=org.apache.dubbo.common.logger.Level, var1276=$r1, var3725=$i7, var499=$i6, var1102=$i0, var2941=$r3, var3752=null_type, var2709=$r4, var2758=$i8, var3132=$i5, var389=$i1, var1545=$r5, var3993=$r6, var3970=$i9, var679=$i4, var307=$i2, var342=$r7, var2378=$r8, var2757=$i10, var1029=$i3}
; {org.apache.dubbo.common.utils.Log=var1157, r0=var2113, org.apache.dubbo.common.logger.Level=var117, $r1=var1276, $i7=var3725, $i6=var499, $i0=var1102, $r3=var2941, null_type=var3752, $r4=var2709, $i8=var2758, $i5=var3132, $i1=var389, $r5=var1545, $r6=var3993, $i9=var3970, $i4=var679, $i2=var307, $r7=var342, $r8=var2378, $i10=var2757, $i3=var1029}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 3}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = 0;	goto [?= $i6 = 31 + $i7];	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>();	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i10;	return $i3
;block_num 9