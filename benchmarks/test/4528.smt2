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

(declare-sort var2019 0)
(declare-sort var2278 0)
(declare-sort var1193 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var2019) var2278)
(declare-fun logMessage/2066159914 (var2019) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logName/2066159914 (var2019) String)
(declare-fun logThread/2066159914 (var2019) String)
(declare-const null-var2019 var2019)
(declare-const null-var2278 var2278)
(declare-const null-String String)
(declare-const var351 var2019) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var351 null-var2019)))
(define-const var3622 var2278 (logLevel/2066159914 var351)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (not (= var3622 null-var2278)))) ; Negate: Cond: $r1 != null  
(define-const var3142 Int 0) ; Statement: $i7 = 0 
 ; Statement: goto [?= $i6 = 31 + $i7] 
(assert true) ; Non Conditional
(define-const var362 Int (+ 31 var3142)) ; Statement: $i6 = 31 + $i7 
(define-const var2680 Int (* 31 var362)) ; Statement: $i0 = 31 * $i6 
(define-const var1578 String (logMessage/2066159914 var351)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (= var1578 null-String))) ; Cond: $r3 != null 
(define-const var3433 String (logMessage/2066159914 var351)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert true)
(define-const var837 Int (hashCode/-467973558 var3433)) ; Statement: $i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2743 Int (+ var2680 var837)) ; Statement: $i5 = $i0 + $i8 
(define-const var1163 Int (* 31 var2743)) ; Statement: $i1 = 31 * $i5 
(define-const var3610 String (logName/2066159914 var351)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (= var3610 null-String))) ; Cond: $r5 != null 
(define-const var3733 String (logName/2066159914 var351)) ; Statement: $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert true)
(define-const var1406 Int (hashCode/-467973558 var3733)) ; Statement: $i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2275 Int (+ var1163 var1406)) ; Statement: $i4 = $i1 + $i9 
(define-const var369 Int (* 31 var2275)) ; Statement: $i2 = 31 * $i4 
(define-const var3388 String (logThread/2066159914 var351)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (not (= var3388 null-String)))) ; Negate: Cond: $r7 != null  
(define-const var994 Int 0) ; Statement: $i10 = 0 
 ; Statement: goto [?= $i3 = $i2 + $i10] 
(assert true) ; Non Conditional
(define-const var106 Int (+ var369 var994)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var2019=org.apache.dubbo.common.utils.Log, var351=r0, var2278=org.apache.dubbo.common.logger.Level, var3622=$r1, var3142=$i7, var362=$i6, var2680=$i0, var1578=$r3, var1193=null_type, var3433=$r4, var837=$i8, var2743=$i5, var1163=$i1, var3610=$r5, var3733=$r6, var1406=$i9, var2275=$i4, var369=$i2, var3388=$r7, var994=$i10, var106=$i3}
; {org.apache.dubbo.common.utils.Log=var2019, r0=var351, org.apache.dubbo.common.logger.Level=var2278, $r1=var3622, $i7=var3142, $i6=var362, $i0=var2680, $r3=var1578, null_type=var1193, $r4=var3433, $i8=var837, $i5=var2743, $i1=var1163, $r5=var3610, $r6=var3733, $i9=var1406, $i4=var2275, $i2=var369, $r7=var3388, $i10=var994, $i3=var106}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = 0;	goto [?= $i6 = 31 + $i7];	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>();	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = 0;	goto [?= $i3 = $i2 + $i10];	$i3 = $i2 + $i10;	return $i3
;block_num 9