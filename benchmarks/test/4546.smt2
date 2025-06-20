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

(declare-sort var1189 0)
(declare-sort var2639 0)
(declare-sort var453 0)
(declare-sort var238 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var1189) var2639)
(declare-fun hashCode/385986394 (var453) Int)
(declare-fun cast-from-var2639-to-var453 (var2639) var453)
(declare-fun logMessage/2066159914 (var1189) String)
(declare-fun logName/2066159914 (var1189) String)
(declare-fun logThread/2066159914 (var1189) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-const null-var1189 var1189)
(declare-const null-var2639 var2639)
(declare-const null-String String)
(declare-const var2839 var1189) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2839 null-var1189)))
(define-const var1301 var2639 (logLevel/2066159914 var2839)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (= var1301 null-var2639))) ; Cond: $r1 != null 
(define-const var3675 var2639 (logLevel/2066159914 var2839)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert true)
(define-const var367 Int (hashCode/385986394 (cast-from-var2639-to-var453 var3675))) ; Statement: $i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var1213 Int (+ 31 var367)) ; Statement: $i6 = 31 + $i7 
(define-const var2728 Int (* 31 var1213)) ; Statement: $i0 = 31 * $i6 
(define-const var708 String (logMessage/2066159914 var2839)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (not (= var708 null-String)))) ; Negate: Cond: $r3 != null  
(define-const var2088 Int 0) ; Statement: $i8 = 0 
 ; Statement: goto [?= $i5 = $i0 + $i8] 
(assert true) ; Non Conditional
(define-const var2500 Int (+ var2728 var2088)) ; Statement: $i5 = $i0 + $i8 
(define-const var2080 Int (* 31 var2500)) ; Statement: $i1 = 31 * $i5 
(define-const var606 String (logName/2066159914 var2839)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (not (= var606 null-String)))) ; Negate: Cond: $r5 != null  
(define-const var894 Int 0) ; Statement: $i9 = 0 
 ; Statement: goto [?= $i4 = $i1 + $i9] 
(assert true) ; Non Conditional
(define-const var3643 Int (+ var2080 var894)) ; Statement: $i4 = $i1 + $i9 
(define-const var2139 Int (* 31 var3643)) ; Statement: $i2 = 31 * $i4 
(define-const var3552 String (logThread/2066159914 var2839)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (= var3552 null-String))) ; Cond: $r7 != null 
(define-const var3303 String (logThread/2066159914 var2839)) ; Statement: $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert true)
(define-const var2908 Int (hashCode/-467973558 var3303)) ; Statement: $i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2944 Int (+ var2139 var2908)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), hashCode/385986394=([java.lang.Enum], int), cast-from-var2639-to-var453=([org.apache.dubbo.common.logger.Level], java.lang.Enum), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int)}
; {var1189=org.apache.dubbo.common.utils.Log, var2839=r0, var2639=org.apache.dubbo.common.logger.Level, var1301=$r1, var3675=$r2, var453=java.lang.Enum, var367=$i7, var1213=$i6, var2728=$i0, var708=$r3, var238=null_type, var2088=$i8, var2500=$i5, var2080=$i1, var606=$r5, var894=$i9, var3643=$i4, var2139=$i2, var3552=$r7, var3303=$r8, var2908=$i10, var2944=$i3}
; {org.apache.dubbo.common.utils.Log=var1189, r0=var2839, org.apache.dubbo.common.logger.Level=var2639, $r1=var1301, $r2=var3675, java.lang.Enum=var453, $i7=var367, $i6=var1213, $i0=var2728, $r3=var708, null_type=var238, $i8=var2088, $i5=var2500, $i1=var2080, $r5=var606, $i9=var894, $i4=var3643, $i2=var2139, $r7=var3552, $r8=var3303, $i10=var2908, $i3=var2944}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>();	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = 0;	goto [?= $i5 = $i0 + $i8];	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = 0;	goto [?= $i4 = $i1 + $i9];	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i10;	return $i3
;block_num 9