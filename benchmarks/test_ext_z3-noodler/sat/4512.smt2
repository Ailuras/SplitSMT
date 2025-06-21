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

(declare-sort var1701 0)
(declare-sort var3849 0)
(declare-sort var30 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var1701) var3849)
(declare-fun logMessage/2066159914 (var1701) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logName/2066159914 (var1701) String)
(declare-fun logThread/2066159914 (var1701) String)
(declare-const null-var1701 var1701)
(declare-const null-var3849 var3849)
(declare-const null-String String)
(declare-const var2627 var1701) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2627 null-var1701)))
(define-const var3997 var3849 (logLevel/2066159914 var2627)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (not (= var3997 null-var3849)))) ; Negate: Cond: $r1 != null  
(define-const var2680 Int 0) ; Statement: $i7 = 0 
 ; Statement: goto [?= $i6 = 31 + $i7] 
(assert true) ; Non Conditional
(define-const var2549 Int (+ 31 var2680)) ; Statement: $i6 = 31 + $i7 
(define-const var3801 Int (* 31 var2549)) ; Statement: $i0 = 31 * $i6 
(define-const var2583 String (logMessage/2066159914 var2627)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (= var2583 null-String))) ; Cond: $r3 != null 
(define-const var3992 String (logMessage/2066159914 var2627)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert true)
(define-const var713 Int (hashCode/-467973558 var3992)) ; Statement: $i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2498 Int (+ var3801 var713)) ; Statement: $i5 = $i0 + $i8 
(define-const var2130 Int (* 31 var2498)) ; Statement: $i1 = 31 * $i5 
(define-const var3570 String (logName/2066159914 var2627)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (not (= var3570 null-String)))) ; Negate: Cond: $r5 != null  
(define-const var3543 Int 0) ; Statement: $i9 = 0 
 ; Statement: goto [?= $i4 = $i1 + $i9] 
(assert true) ; Non Conditional
(define-const var532 Int (+ var2130 var3543)) ; Statement: $i4 = $i1 + $i9 
(define-const var3886 Int (* 31 var532)) ; Statement: $i2 = 31 * $i4 
(define-const var3935 String (logThread/2066159914 var2627)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (= var3935 null-String))) ; Cond: $r7 != null 
(define-const var1218 String (logThread/2066159914 var2627)) ; Statement: $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert true)
(define-const var1549 Int (hashCode/-467973558 var1218)) ; Statement: $i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3674 Int (+ var3886 var1549)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var1701=org.apache.dubbo.common.utils.Log, var2627=r0, var3849=org.apache.dubbo.common.logger.Level, var3997=$r1, var2680=$i7, var2549=$i6, var3801=$i0, var2583=$r3, var30=null_type, var3992=$r4, var713=$i8, var2498=$i5, var2130=$i1, var3570=$r5, var3543=$i9, var532=$i4, var3886=$i2, var3935=$r7, var1218=$r8, var1549=$i10, var3674=$i3}
; {org.apache.dubbo.common.utils.Log=var1701, r0=var2627, org.apache.dubbo.common.logger.Level=var3849, $r1=var3997, $i7=var2680, $i6=var2549, $i0=var3801, $r3=var2583, null_type=var30, $r4=var3992, $i8=var713, $i5=var2498, $i1=var2130, $r5=var3570, $i9=var3543, $i4=var532, $i2=var3886, $r7=var3935, $r8=var1218, $i10=var1549, $i3=var3674}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = 0;	goto [?= $i6 = 31 + $i7];	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = 0;	goto [?= $i4 = $i1 + $i9];	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i10;	return $i3
;block_num 9