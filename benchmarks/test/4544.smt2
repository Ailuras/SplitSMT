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

(declare-sort var1631 0)
(declare-sort var2191 0)
(declare-sort var2790 0)
(declare-sort var770 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logLevel/2066159914 (var1631) var2191)
(declare-fun hashCode/385986394 (var2790) Int)
(declare-fun cast-from-var2191-to-var2790 (var2191) var2790)
(declare-fun logMessage/2066159914 (var1631) String)
(declare-fun logName/2066159914 (var1631) String)
(declare-fun logThread/2066159914 (var1631) String)
(declare-const null-var1631 var1631)
(declare-const null-var2191 var2191)
(declare-const null-String String)
(declare-const var1014 var1631) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Log 
(assert (not (= var1014 null-var1631)))
(define-const var767 var2191 (logLevel/2066159914 var1014)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert (not (= var767 null-var2191))) ; Cond: $r1 != null 
(define-const var731 var2191 (logLevel/2066159914 var1014)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel> 
(assert true)
(define-const var244 Int (hashCode/385986394 (cast-from-var2191-to-var2790 var731))) ; Statement: $i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>() 
(assert true) ; Non Conditional
(define-const var2375 Int (+ 31 var244)) ; Statement: $i6 = 31 + $i7 
(define-const var3388 Int (* 31 var2375)) ; Statement: $i0 = 31 * $i6 
(define-const var1544 String (logMessage/2066159914 var1014)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage> 
(assert (not (not (= var1544 null-String)))) ; Negate: Cond: $r3 != null  
(define-const var2617 Int 0) ; Statement: $i8 = 0 
 ; Statement: goto [?= $i5 = $i0 + $i8] 
(assert true) ; Non Conditional
(define-const var2370 Int (+ var3388 var2617)) ; Statement: $i5 = $i0 + $i8 
(define-const var2598 Int (* 31 var2370)) ; Statement: $i1 = 31 * $i5 
(define-const var929 String (logName/2066159914 var1014)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
 ; Statement: if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName> 
(assert (not (not (= var929 null-String)))) ; Negate: Cond: $r5 != null  
(define-const var3016 Int 0) ; Statement: $i9 = 0 
 ; Statement: goto [?= $i4 = $i1 + $i9] 
(assert true) ; Non Conditional
(define-const var1789 Int (+ var2598 var3016)) ; Statement: $i4 = $i1 + $i9 
(define-const var3969 Int (* 31 var1789)) ; Statement: $i2 = 31 * $i4 
(define-const var2340 String (logThread/2066159914 var1014)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
 ; Statement: if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread> 
(assert (not (not (= var2340 null-String)))) ; Negate: Cond: $r7 != null  
(define-const var2500 Int 0) ; Statement: $i10 = 0 
 ; Statement: goto [?= $i3 = $i2 + $i10] 
(assert true) ; Non Conditional
(define-const var3373 Int (+ var3969 var2500)) ; Statement: $i3 = $i2 + $i10 
 ; Statement: return $i3 
(check-sat)
; {logLevel/2066159914=([org.apache.dubbo.common.utils.Log], org.apache.dubbo.common.logger.Level), hashCode/385986394=([java.lang.Enum], int), cast-from-var2191-to-var2790=([org.apache.dubbo.common.logger.Level], java.lang.Enum), logMessage/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logName/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String), logThread/2066159914=([org.apache.dubbo.common.utils.Log], java.lang.String)}
; {var1631=org.apache.dubbo.common.utils.Log, var1014=r0, var2191=org.apache.dubbo.common.logger.Level, var767=$r1, var731=$r2, var2790=java.lang.Enum, var244=$i7, var2375=$i6, var3388=$i0, var1544=$r3, var770=null_type, var2617=$i8, var2370=$i5, var2598=$i1, var929=$r5, var3016=$i9, var1789=$i4, var3969=$i2, var2340=$r7, var2500=$i10, var3373=$i3}
; {org.apache.dubbo.common.utils.Log=var1631, r0=var1014, org.apache.dubbo.common.logger.Level=var2191, $r1=var767, $r2=var731, java.lang.Enum=var2790, $i7=var244, $i6=var2375, $i0=var3388, $r3=var1544, null_type=var770, $i8=var2617, $i5=var2370, $i1=var2598, $r5=var929, $i9=var3016, $i4=var1789, $i2=var3969, $r7=var2340, $i10=var2500, $i3=var3373}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.utils.Log;	$r1 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$r2 = r0.<org.apache.dubbo.common.utils.Log: org.apache.dubbo.common.logger.Level logLevel>;	$i7 = virtualinvoke $r2.<org.apache.dubbo.common.logger.Level: int hashCode()>();	$i6 = 31 + $i7;	$i0 = 31 * $i6;	$r3 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logMessage>;	$i8 = 0;	goto [?= $i5 = $i0 + $i8];	$i5 = $i0 + $i8;	$i1 = 31 * $i5;	$r5 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	if $r5 != null goto $r6 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logName>;	$i9 = 0;	goto [?= $i4 = $i1 + $i9];	$i4 = $i1 + $i9;	$i2 = 31 * $i4;	$r7 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	if $r7 != null goto $r8 = r0.<org.apache.dubbo.common.utils.Log: java.lang.String logThread>;	$i10 = 0;	goto [?= $i3 = $i2 + $i10];	$i3 = $i2 + $i10;	return $i3
;block_num 9