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

(declare-sort var1021 0)
(declare-sort var3482 0)
(declare-sort var3557 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var1021) var3482)
(declare-fun logMessage/2066159914 (var1021) String)
(declare-fun logName/2066159914 (var1021) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logThread/2066159914 (var1021) String)
(declare-const null-var1021 var1021)
(declare-const null-var3482 var3482)
(declare-const null-String String)
(declare-const var2655 var1021) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2655 null-var1021)))
(define-const var2446 var3482 (logLevel/2066159914 var2655)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (not (= var2446 null-var3482)))) ; Negate: Cond: $r1 != null  
(define-const var2267 Int 0) ; Statement: $i7 = 0 
 ; Statement: goto [?= $i6 = 31 + $i7] 
(assert true) ; Non Conditional
(define-const var786 Int (+ 31 var2267)) ; Statement: $i6 = 31 + $i7 
(define-const var2074 Int (* 31 var786)) ; Statement: $i0 = 31 * $i6 
(define-const var1813 String (logMessage/2066159914 var2655)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (not (= var1813 null-String)))) ; Negate: Cond: $r3 != null  
(define-const var2268 Int 0) ; Statement: $i8 = 0 
 ; Statement: goto [?= $i5 = $i0 + $i8] 
(assert true) ; Non Conditional
(define-const var733 Int (+ var2074 var2268)) ; Statement: $i5 = $i0 + $i8 
(define-const var550 Int (* 31 var733)) ; Statement: $i1 = 31 * $i5 
(define-const var2632 String (logName/2066159914 var2655)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (= var2632 null-String))) ; Cond: $r5 != null 
(define-const var1829 String (logName/2066159914 var2655)) ; Statement: $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert true)
(define-const var2531 Int (hashCode/-467973558 var1829)) ; Statement: $i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var1241 Int (+ var550 var2531)) ; Statement: $i4 = $i1 + $i9 
(define-const var3961 Int (* 31 var1241)) ; Statement: $i2 = 31 * $i4 
(define-const var2258 String (logThread/2066159914 var2655)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (= var2258 null-String))) ; Cond: $r7 != null 
(define-const var3449 String (logThread/2066159914 var2655)) ; Statement: $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert true)
(define-const var1344 Int (hashCode/-467973558 var3449)) ; Statement: $i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var3965 Int (+ var3961 var1344)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var1021=org.apache.dubbo.common.utils.Log, var2655=r0, var3482=org.apache.dubbo.common.logger.Level, var2446=$r1, var2267=$i7, var786=$i6, var2074=$i0, var1813=$r3, var3557=null_type, var2268=$i8, var733=$i5, var550=$i1, var2632=$r5, var1829=$r6, var2531=$i9, var1241=$i4, var3961=$i2, var2258=$r7, var3449=$r8, var1344=$i10, var3965=$i3}
; {org.apache.dubbo.common.utils.Log=var1021, r0=var2655, org.apache.dubbo.common.logger.Level=var3482, $r1=var2446, $i7=var2267, $i6=var786, $i0=var2074, $r3=var1813, null_type=var3557, $i8=var2268, $i5=var733, $i1=var550, $r5=var2632, $r6=var1829, $i9=var2531, $i4=var1241, $i2=var3961, $r7=var2258, $r8=var3449, $i10=var1344, $i3=var3965}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = 0;	goto [?= $i6 = 31 + $i7];	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = 0;	goto [?= $i5 = $i0 + $i8];	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>();	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = virtualinvoke $r8.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i10;	return $i3
;block_num 9