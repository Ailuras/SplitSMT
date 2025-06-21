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

(declare-sort var3184 0)
(declare-sort var500 0)
(declare-sort var3213 0)
(declare-sort var3612 0)
(declare-sort var863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3213_checkFileNameExist/-530515869 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var3612) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var863_warn/126438324 (var863 String String String String var3612) void)
(declare-const null-var3184 var3184)
(declare-const null-String String)
(declare-const null-var3612 var3612)
(declare-const var3213-logger var863)
(declare-const var3488 var3184) ; Statement: r3 := @parameter0: java.util.Set 
(assert (not (= var3488 null-var3184)))
(declare-const var3328 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3328 null-String)))
(define-const var1685 Bool (var3213_checkFileNameExist/-530515869 var3328)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean checkFileNameExist(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.util.LinkedList 
(assert (not (= (ite var1685 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var3739 var3612) ; Statement: $r13 := @caughtexception 
(assert (not (= var3739 null-var3612)))
(define-const var1579 var863 var3213-logger) ; Statement: $r15 = <org.apache.dubbo.common.utils.ConfigUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var402 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var402)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var402!1 String)
(assert (= var402!1 ""))
(assert true)
(define-const var1564 String (append/672562846 var402!1 "Failed to load ")) ; Statement: $r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to load ") 
(declare-const var402!2 String)
(assert (= var402!2 (str.++ var402!1 "Failed to load ")))
(assert true)
(define-const var3584 String (append/672562846 var1564 var3328)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1564!1 String)
(assert (= var1564!1 (str.++ var1564 var3328)))
(assert true)
(define-const var2077 String (append/672562846 var3584 " file from ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" file from ") 
(declare-const var3584!1 String)
(assert (= var3584!1 (str.++ var3584 " file from ")))
(assert true)
(define-const var3049 String (append/672562846 var2077 var3328)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2077!1 String)
(assert (= var2077!1 (str.++ var2077 var3328)))
(assert true)
(define-const var3755 String (append/672562846 var3049 "(ignore this file): ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(ignore this file): ") 
(declare-const var3049!1 String)
(assert (= var3049!1 (str.++ var3049 "(ignore this file): ")))
(assert true)
(define-const var2454 String (getMessage/849299655 var3739)) ; Statement: $r20 = virtualinvoke $r13.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3094 String (append/672562846 var3755 var2454)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20) 
(declare-const var3755!1 String)
(assert (= var3755!1 (str.++ var3755 var2454)))
(assert true)
(define-const var2792 String (toString/-2075883882 var3094)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var863_warn/126438324 var1579 "0-22" "" "" var2792 var3739)) ; Statement: interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-22", "", "", $r23, $r13) 

(declare-const var1579!1 var863)
(declare-const var674 String)
(declare-const var3552 String)
(declare-const var3552!1 String)
(declare-const var2792!1 String)
(declare-const var3739!1 var3612)
(assert true) ; Non Conditional
 ; Statement: return "" 
(check-sat)
; {var3213_checkFileNameExist/-530515869=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var863_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var3184=java.util.Set, var3488=r3, var3328=r0, var500=null_type, var3213=org.apache.dubbo.common.utils.ConfigUtils, var1685=$z0, var3612=java.lang.Throwable, var3739=$r13, var863=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1579=$r15, var402=$r14, var1564=$r16, var3584=$r17, var2077=$r18, var3049=$r19, var3755=$r21, var2454=$r20, var3094=$r22, var2792=$r23, var674="0-22", var3552=""}
; {java.util.Set=var3184, r3=var3488, r0=var3328, null_type=var500, org.apache.dubbo.common.utils.ConfigUtils=var3213, $z0=var1685, java.lang.Throwable=var3612, $r13=var3739, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var863, $r15=var1579, $r14=var402, $r16=var1564, $r17=var3584, $r18=var2077, $r19=var3049, $r21=var3755, $r20=var2454, $r22=var3094, $r23=var2792, "0-22"=var674, ""=var3552}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: java.util.Set;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean checkFileNameExist(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = new java.util.LinkedList;	$r13 := @caughtexception;	$r15 = <org.apache.dubbo.common.utils.ConfigUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to load ");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" file from ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(ignore this file): ");	$r20 = virtualinvoke $r13.<java.lang.Throwable: java.lang.String getMessage()>();	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-22", "", "", $r23, $r13);	return ""
;block_num 3