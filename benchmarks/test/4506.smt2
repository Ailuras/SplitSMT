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

(declare-sort var292 0)
(declare-sort var1882 0)
(declare-sort var2856 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var292) var1882)
(declare-fun logMessage/2066159914 (var292) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logName/2066159914 (var292) String)
(declare-fun logThread/2066159914 (var292) String)
(declare-const null-var292 var292)
(declare-const null-var1882 var1882)
(declare-const null-String String)
(declare-const var600 var292) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var600 null-var292)))
(define-const var632 var1882 (logLevel/2066159914 var600)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (not (= var632 null-var1882)))) ; Negate: Cond: $r1 != null  
(define-const var2060 Int 0) ; Statement: $i7 = 0 
 ; Statement: goto [?= $i6 = 31 + $i7] 
(assert true) ; Non Conditional
(define-const var3278 Int (+ 31 var2060)) ; Statement: $i6 = 31 + $i7 
(define-const var742 Int (* 31 var3278)) ; Statement: $i0 = 31 * $i6 
(define-const var2717 String (logMessage/2066159914 var600)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (= var2717 null-String))) ; Cond: $r3 != null 
(define-const var3935 String (logMessage/2066159914 var600)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert true)
(define-const var3606 Int (hashCode/-467973558 var3935)) ; Statement: $i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var373 Int (+ var742 var3606)) ; Statement: $i5 = $i0 + $i8 
(define-const var2608 Int (* 31 var373)) ; Statement: $i1 = 31 * $i5 
(define-const var2991 String (logName/2066159914 var600)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (not (= var2991 null-String)))) ; Negate: Cond: $r5 != null  
(define-const var2754 Int 0) ; Statement: $i9 = 0 
 ; Statement: goto [?= $i4 = $i1 + $i9] 
(assert true) ; Non Conditional
(define-const var1221 Int (+ var2608 var2754)) ; Statement: $i4 = $i1 + $i9 
(define-const var2083 Int (* 31 var1221)) ; Statement: $i2 = 31 * $i4 
(define-const var485 String (logThread/2066159914 var600)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (not (= var485 null-String)))) ; Negate: Cond: $r7 != null  
(define-const var2746 Int 0) ; Statement: $i10 = 0 
 ; Statement: goto [?= $i3 = $i2 + $i10] 
(assert true) ; Non Conditional
(define-const var1219 Int (+ var2083 var2746)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var292=org.apache.dubbo.common.utils.Log, var600=r0, var1882=org.apache.dubbo.common.logger.Level, var632=$r1, var2060=$i7, var3278=$i6, var742=$i0, var2717=$r3, var2856=null_type, var3935=$r4, var3606=$i8, var373=$i5, var2608=$i1, var2991=$r5, var2754=$i9, var1221=$i4, var2083=$i2, var485=$r7, var2746=$i10, var1219=$i3}
; {org.apache.dubbo.common.utils.Log=var292, r0=var600, org.apache.dubbo.common.logger.Level=var1882, $r1=var632, $i7=var2060, $i6=var3278, $i0=var742, $r3=var2717, null_type=var2856, $r4=var3935, $i8=var3606, $i5=var373, $i1=var2608, $r5=var2991, $i9=var2754, $i4=var1221, $i2=var2083, $r7=var485, $i10=var2746, $i3=var1219}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = 0;	goto [?= $i6 = 31 + $i7];	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = 0;	goto [?= $i4 = $i1 + $i9];	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = 0;	goto [?= $i3 = $i2 + $i10];	$i3 = $i2 + $i10;	return $i3
;block_num 9