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

(declare-sort var299 0)
(declare-sort var377 0)
(declare-sort var546 0)
(declare-sort var3858 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var299) var377)
(declare-fun hashCode/385986394 (var546) Int)
(declare-fun cast-from-var377-to-var546 (var377) var546)
(declare-fun logMessage/2066159914 (var299) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logName/2066159914 (var299) String)
(declare-fun logThread/2066159914 (var299) String)
(declare-const null-var299 var299)
(declare-const null-var377 var377)
(declare-const null-String String)
(declare-const var3660 var299) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var3660 null-var299)))
(define-const var265 var377 (logLevel/2066159914 var3660)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (= var265 null-var377))) ; Cond: $r1 != null 
(define-const var2531 var377 (logLevel/2066159914 var3660)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert true)
(define-const var1656 Int (hashCode/385986394 (cast-from-var377-to-var546 var2531))) ; Statement: $i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2315 Int (+ 31 var1656)) ; Statement: $i6 = 31 + $i7 
(define-const var2681 Int (* 31 var2315)) ; Statement: $i0 = 31 * $i6 
(define-const var3795 String (logMessage/2066159914 var3660)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (= var3795 null-String))) ; Cond: $r3 != null 
(define-const var2225 String (logMessage/2066159914 var3660)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert true)
(define-const var1118 Int (hashCode/-467973558 var2225)) ; Statement: $i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var647 Int (+ var2681 var1118)) ; Statement: $i5 = $i0 + $i8 
(define-const var92 Int (* 31 var647)) ; Statement: $i1 = 31 * $i5 
(define-const var3043 String (logName/2066159914 var3660)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (not (= var3043 null-String)))) ; Negate: Cond: $r5 != null  
(define-const var2720 Int 0) ; Statement: $i9 = 0 
 ; Statement: goto [?= $i4 = $i1 + $i9] 
(assert true) ; Non Conditional
(define-const var1122 Int (+ var92 var2720)) ; Statement: $i4 = $i1 + $i9 
(define-const var2256 Int (* 31 var1122)) ; Statement: $i2 = 31 * $i4 
(define-const var747 String (logThread/2066159914 var3660)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (= var747 null-String))) ; Cond: $r7 != null 
(define-const var2179 String (logThread/2066159914 var3660)) ; Statement: $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert true)
(define-const var1552 Int (hashCode/-467973558 var2179)) ; Statement: $i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3462 Int (+ var2256 var1552)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), hashCode/385986394=([java.lang.Enum], int), cast-from-var377-to-var546=([org.apache.dubbo.common.logger.Level], java.lang.Enum), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var299=org.apache.dubbo.common.utils.Log, var3660=r0, var377=org.apache.dubbo.common.logger.Level, var265=$r1, var2531=$r2, var546=java.lang.Enum, var1656=$i7, var2315=$i6, var2681=$i0, var3795=$r3, var3858=null_type, var2225=$r4, var1118=$i8, var647=$i5, var92=$i1, var3043=$r5, var2720=$i9, var1122=$i4, var2256=$i2, var747=$r7, var2179=$r8, var1552=$i10, var3462=$i3}
; {org.apache.dubbo.common.utils.Log=var299, r0=var3660, org.apache.dubbo.common.logger.Level=var377, $r1=var265, $r2=var2531, java.lang.Enum=var546, $i7=var1656, $i6=var2315, $i0=var2681, $r3=var3795, null_type=var3858, $r4=var2225, $i8=var1118, $i5=var647, $i1=var92, $r5=var3043, $i9=var2720, $i4=var1122, $i2=var2256, $r7=var747, $r8=var2179, $i10=var1552, $i3=var3462}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>();	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = 0;	goto [?= $i4 = $i1 + $i9];	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i10;	return $i3
;block_num 9