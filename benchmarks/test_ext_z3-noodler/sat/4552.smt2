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

(declare-sort var3181 0)
(declare-sort var3076 0)
(declare-sort var3129 0)
(declare-sort var3411 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var3181) var3076)
(declare-fun hashCode/385986394 (var3129) Int)
(declare-fun cast-from-var3076-to-var3129 (var3076) var3129)
(declare-fun logMessage/2066159914 (var3181) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logName/2066159914 (var3181) String)
(declare-fun logThread/2066159914 (var3181) String)
(declare-const null-var3181 var3181)
(declare-const null-var3076 var3076)
(declare-const null-String String)
(declare-const var2468 var3181) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2468 null-var3181)))
(define-const var1084 var3076 (logLevel/2066159914 var2468)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (= var1084 null-var3076))) ; Cond: $r1 != null 
(define-const var2745 var3076 (logLevel/2066159914 var2468)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert true)
(define-const var2276 Int (hashCode/385986394 (cast-from-var3076-to-var3129 var2745))) ; Statement: $i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2460 Int (+ 31 var2276)) ; Statement: $i6 = 31 + $i7 
(define-const var110 Int (* 31 var2460)) ; Statement: $i0 = 31 * $i6 
(define-const var2201 String (logMessage/2066159914 var2468)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (= var2201 null-String))) ; Cond: $r3 != null 
(define-const var1618 String (logMessage/2066159914 var2468)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert true)
(define-const var1459 Int (hashCode/-467973558 var1618)) ; Statement: $i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3410 Int (+ var110 var1459)) ; Statement: $i5 = $i0 + $i8 
(define-const var411 Int (* 31 var3410)) ; Statement: $i1 = 31 * $i5 
(define-const var2258 String (logName/2066159914 var2468)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (not (= var2258 null-String)))) ; Negate: Cond: $r5 != null  
(define-const var2420 Int 0) ; Statement: $i9 = 0 
 ; Statement: goto [?= $i4 = $i1 + $i9] 
(assert true) ; Non Conditional
(define-const var1691 Int (+ var411 var2420)) ; Statement: $i4 = $i1 + $i9 
(define-const var1827 Int (* 31 var1691)) ; Statement: $i2 = 31 * $i4 
(define-const var1758 String (logThread/2066159914 var2468)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (not (= var1758 null-String)))) ; Negate: Cond: $r7 != null  
(define-const var3735 Int 0) ; Statement: $i10 = 0 
 ; Statement: goto [?= $i3 = $i2 + $i10] 
(assert true) ; Non Conditional
(define-const var1843 Int (+ var1827 var3735)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), hashCode/385986394=([java.lang.Enum], int), cast-from-var3076-to-var3129=([org.apache.dubbo.common.logger.Level], java.lang.Enum), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var3181=org.apache.dubbo.common.utils.Log, var2468=r0, var3076=org.apache.dubbo.common.logger.Level, var1084=$r1, var2745=$r2, var3129=java.lang.Enum, var2276=$i7, var2460=$i6, var110=$i0, var2201=$r3, var3411=null_type, var1618=$r4, var1459=$i8, var3410=$i5, var411=$i1, var2258=$r5, var2420=$i9, var1691=$i4, var1827=$i2, var1758=$r7, var3735=$i10, var1843=$i3}
; {org.apache.dubbo.common.utils.Log=var3181, r0=var2468, org.apache.dubbo.common.logger.Level=var3076, $r1=var1084, $r2=var2745, java.lang.Enum=var3129, $i7=var2276, $i6=var2460, $i0=var110, $r3=var2201, null_type=var3411, $r4=var1618, $i8=var1459, $i5=var3410, $i1=var411, $r5=var2258, $i9=var2420, $i4=var1691, $i2=var1827, $r7=var1758, $i10=var3735, $i3=var1843}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>();	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = 0;	goto [?= $i4 = $i1 + $i9];	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = 0;	goto [?= $i3 = $i2 + $i10];	$i3 = $i2 + $i10;	return $i3
;block_num 9