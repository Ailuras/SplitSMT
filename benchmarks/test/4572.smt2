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

(declare-sort var743 0)
(declare-sort var632 0)
(declare-sort var2648 0)
(declare-sort var2845 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var743) var632)
(declare-fun hashCode/385986394 (var2648) Int)
(declare-fun cast-from-var632-to-var2648 (var632) var2648)
(declare-fun logMessage/2066159914 (var743) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logName/2066159914 (var743) String)
(declare-fun logThread/2066159914 (var743) String)
(declare-const null-var743 var743)
(declare-const null-var632 var632)
(declare-const null-String String)
(declare-const var1288 var743) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var1288 null-var743)))
(define-const var3638 var632 (logLevel/2066159914 var1288)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (= var3638 null-var632))) ; Cond: $r1 != null 
(define-const var2204 var632 (logLevel/2066159914 var1288)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert true)
(define-const var3802 Int (hashCode/385986394 (cast-from-var632-to-var2648 var2204))) ; Statement: $i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2964 Int (+ 31 var3802)) ; Statement: $i6 = 31 + $i7 
(define-const var2657 Int (* 31 var2964)) ; Statement: $i0 = 31 * $i6 
(define-const var1574 String (logMessage/2066159914 var1288)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (= var1574 null-String))) ; Cond: $r3 != null 
(define-const var1569 String (logMessage/2066159914 var1288)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert true)
(define-const var1357 Int (hashCode/-467973558 var1569)) ; Statement: $i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var1726 Int (+ var2657 var1357)) ; Statement: $i5 = $i0 + $i8 
(define-const var181 Int (* 31 var1726)) ; Statement: $i1 = 31 * $i5 
(define-const var374 String (logName/2066159914 var1288)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (= var374 null-String))) ; Cond: $r5 != null 
(define-const var434 String (logName/2066159914 var1288)) ; Statement: $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert true)
(define-const var663 Int (hashCode/-467973558 var434)) ; Statement: $i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3317 Int (+ var181 var663)) ; Statement: $i4 = $i1 + $i9 
(define-const var136 Int (* 31 var3317)) ; Statement: $i2 = 31 * $i4 
(define-const var2795 String (logThread/2066159914 var1288)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (= var2795 null-String))) ; Cond: $r7 != null 
(define-const var1381 String (logThread/2066159914 var1288)) ; Statement: $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert true)
(define-const var183 Int (hashCode/-467973558 var1381)) ; Statement: $i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var1443 Int (+ var136 var183)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), hashCode/385986394=([java.lang.Enum], int), cast-from-var632-to-var2648=([org.apache.dubbo.common.logger.Level], java.lang.Enum), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var743=org.apache.dubbo.common.utils.Log, var1288=r0, var632=org.apache.dubbo.common.logger.Level, var3638=$r1, var2204=$r2, var2648=java.lang.Enum, var3802=$i7, var2964=$i6, var2657=$i0, var1574=$r3, var2845=null_type, var1569=$r4, var1357=$i8, var1726=$i5, var181=$i1, var374=$r5, var434=$r6, var663=$i9, var3317=$i4, var136=$i2, var2795=$r7, var1381=$r8, var183=$i10, var1443=$i3}
; {org.apache.dubbo.common.utils.Log=var743, r0=var1288, org.apache.dubbo.common.logger.Level=var632, $r1=var3638, $r2=var2204, java.lang.Enum=var2648, $i7=var3802, $i6=var2964, $i0=var2657, $r3=var1574, null_type=var2845, $r4=var1569, $i8=var1357, $i5=var1726, $i1=var181, $r5=var374, $r6=var434, $i9=var663, $i4=var3317, $i2=var136, $r7=var2795, $r8=var1381, $i10=var183, $i3=var1443}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 3}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>();	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>();	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i10;	return $i3
;block_num 9