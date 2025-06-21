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

(declare-sort var2211 0)
(declare-sort var1824 0)
(declare-sort var3885 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var2211) var1824)
(declare-fun logMessage/2066159914 (var2211) String)
(declare-fun logName/2066159914 (var2211) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun logThread/2066159914 (var2211) String)
(declare-const null-var2211 var2211)
(declare-const null-var1824 var1824)
(declare-const null-String String)
(declare-const var2565 var2211) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var2565 null-var2211)))
(define-const var1191 var1824 (logLevel/2066159914 var2565)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (not (= var1191 null-var1824)))) ; Negate: Cond: $r1 != null  
(define-const var2921 Int 0) ; Statement: $i7 = 0 
 ; Statement: goto [?= $i6 = 31 + $i7] 
(assert true) ; Non Conditional
(define-const var2990 Int (+ 31 var2921)) ; Statement: $i6 = 31 + $i7 
(define-const var1871 Int (* 31 var2990)) ; Statement: $i0 = 31 * $i6 
(define-const var3982 String (logMessage/2066159914 var2565)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (not (= var3982 null-String)))) ; Negate: Cond: $r3 != null  
(define-const var239 Int 0) ; Statement: $i8 = 0 
 ; Statement: goto [?= $i5 = $i0 + $i8] 
(assert true) ; Non Conditional
(define-const var2668 Int (+ var1871 var239)) ; Statement: $i5 = $i0 + $i8 
(define-const var3232 Int (* 31 var2668)) ; Statement: $i1 = 31 * $i5 
(define-const var470 String (logName/2066159914 var2565)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (= var470 null-String))) ; Cond: $r5 != null 
(define-const var3371 String (logName/2066159914 var2565)) ; Statement: $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert true)
(define-const var3652 Int (hashCode/-467973558 var3371)) ; Statement: $i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2590 Int (+ var3232 var3652)) ; Statement: $i4 = $i1 + $i9 
(define-const var2390 Int (* 31 var2590)) ; Statement: $i2 = 31 * $i4 
(define-const var578 String (logThread/2066159914 var2565)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (not (= var578 null-String)))) ; Negate: Cond: $r7 != null  
(define-const var1891 Int 0) ; Statement: $i10 = 0 
 ; Statement: goto [?= $i3 = $i2 + $i10] 
(assert true) ; Non Conditional
(define-const var2615 Int (+ var2390 var1891)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), hashCode/-467973558=([java.lang.String], int), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var2211=org.apache.dubbo.common.utils.Log, var2565=r0, var1824=org.apache.dubbo.common.logger.Level, var1191=$r1, var2921=$i7, var2990=$i6, var1871=$i0, var3982=$r3, var3885=null_type, var239=$i8, var2668=$i5, var3232=$i1, var470=$r5, var3371=$r6, var3652=$i9, var2590=$i4, var2390=$i2, var578=$r7, var1891=$i10, var2615=$i3}
; {org.apache.dubbo.common.utils.Log=var2211, r0=var2565, org.apache.dubbo.common.logger.Level=var1824, $r1=var1191, $i7=var2921, $i6=var2990, $i0=var1871, $r3=var3982, null_type=var3885, $i8=var239, $i5=var2668, $i1=var3232, $r5=var470, $r6=var3371, $i9=var3652, $i4=var2590, $i2=var2390, $r7=var578, $i10=var1891, $i3=var2615}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = 0;	goto [?= $i6 = 31 + $i7];	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = 0;	goto [?= $i5 = $i0 + $i8];	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = virtualinvoke $r6.<java.lang.String: int hashCode()>();	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = 0;	goto [?= $i3 = $i2 + $i10];	$i3 = $i2 + $i10;	return $i3
;block_num 9