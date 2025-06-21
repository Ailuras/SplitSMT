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

(declare-sort var1428 0)
(declare-sort var3499 0)
(declare-sort var1485 0)
(declare-sort var1562 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1485_getVersion/310196261 () String)
(declare-fun var1562_getLocalHost/-1653363627 () String)
(declare-fun getErrorUrl/1849156447 (var1428 String) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1428 var1428)
(declare-const null-String String)
(declare-const var2650 var1428) ; Statement: r16 := @this: org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger 
(assert (not (= var2650 null-var1428)))
(declare-const var2123 String) ; Statement: r10 := @parameter0: java.lang.String 
(assert (not (= var2123 null-String)))
(declare-const var2605 String) ; Statement: r13 := @parameter1: java.lang.String 
(assert (not (= var2605 null-String)))
(declare-const var2812 String) ; Statement: r20 := @parameter2: java.lang.String 
(assert (not (= var2812 null-String)))
(declare-const var1042 String) ; Statement: r1 := @parameter3: java.lang.String 
(assert (not (= var1042 null-String)))
(define-const var3085 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3085)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3085!1 String)
(assert (= var3085!1 ""))
(assert true)
(define-const var1143 String (append/672562846 var3085!1 " [DUBBO] ")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" [DUBBO] ") 
(declare-const var3085!2 String)
(assert (= var3085!2 (str.++ var3085!1 " [DUBBO] ")))
(assert true)
(define-const var841 String (append/672562846 var1143 var1042)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1143!1 String)
(assert (= var1143!1 (str.++ var1143 var1042)))
(assert true)
(define-const var3347 String (append/672562846 var841 ", dubbo version: ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", dubbo version: ") 
(declare-const var841!1 String)
(assert (= var841!1 (str.++ var841 ", dubbo version: ")))
(define-const var2044 String var1485_getVersion/310196261) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>() 
(assert true)
(define-const var2071 String (append/672562846 var3347 var2044)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3347!1 String)
(assert (= var3347!1 (str.++ var3347 var2044)))
(assert true)
(define-const var3825 String (append/672562846 var2071 ", current host: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", current host: ") 
(declare-const var2071!1 String)
(assert (= var2071!1 (str.++ var2071 ", current host: ")))
(define-const var566 String var1562_getLocalHost/-1653363627) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(assert true)
(define-const var2001 String (append/672562846 var3825 var566)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3825!1 String)
(assert (= var3825!1 (str.++ var3825 var566)))
(assert true)
(define-const var3923 String (append/672562846 var2001 ", error code: ")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", error code: ") 
(declare-const var2001!1 String)
(assert (= var2001!1 (str.++ var2001 ", error code: ")))
(assert true)
(define-const var2335 String (append/672562846 var3923 var2123)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10) 
(declare-const var3923!1 String)
(assert (= var3923!1 (str.++ var3923 var2123)))
(assert true)
(define-const var2932 String (append/672562846 var2335 ". This may be caused by ")) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". This may be caused by ") 
(declare-const var2335!1 String)
(assert (= var2335!1 (str.++ var2335 ". This may be caused by ")))
(assert true)
(define-const var2696 String (append/672562846 var2932 var2605)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r13) 
(declare-const var2932!1 String)
(assert (= var2932!1 (str.++ var2932 var2605)))
(assert true)
(define-const var1573 String (append/672562846 var2696 ", go to ")) ; Statement: $r18 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", go to ") 
(declare-const var2696!1 String)
(assert (= var2696!1 (str.++ var2696 ", go to ")))
(assert true)
(define-const var1368 String (getErrorUrl/1849156447 var2650 var2123)) ; Statement: $r17 = specialinvoke r16.<org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger: java.lang.String getErrorUrl(java.lang.String)>(r10) 
(assert true)
(define-const var2832 String (append/672562846 var1573 var1368)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var1573!1 String)
(assert (= var1573!1 (str.++ var1573 var1368)))
(assert true)
(define-const var1180 String (append/672562846 var2832 " to find instructions. ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to find instructions. ") 
(declare-const var2832!1 String)
(assert (= var2832!1 (str.++ var2832 " to find instructions. ")))
(assert true)
(define-const var303 String (append/672562846 var1180 var2812)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r20) 
(declare-const var1180!1 String)
(assert (= var1180!1 (str.++ var1180 var2812)))
(assert true)
(define-const var2070 String (toString/-2075883882 var303)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r23 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1485_getVersion/310196261=([], java.lang.String), var1562_getLocalHost/-1653363627=([], java.lang.String), getErrorUrl/1849156447=([org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger, java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1428=org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger, var2650=r16, var2123=r10, var3499=null_type, var2605=r13, var2812=r20, var1042=r1, var3085=$r0, var1143=$r2, var841=$r3, var3347=$r5, var1485=org.apache.dubbo.common.Version, var2044=$r4, var2071=$r6, var3825=$r8, var1562=org.apache.dubbo.common.utils.NetUtils, var566=$r7, var2001=$r9, var3923=$r11, var2335=$r12, var2932=$r14, var2696=$r15, var1573=$r18, var1368=$r17, var2832=$r19, var1180=$r21, var303=$r22, var2070=$r23}
; {org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger=var1428, r16=var2650, r10=var2123, null_type=var3499, r13=var2605, r20=var2812, r1=var1042, $r0=var3085, $r2=var1143, $r3=var841, $r5=var3347, org.apache.dubbo.common.Version=var1485, $r4=var2044, $r6=var2071, $r8=var3825, org.apache.dubbo.common.utils.NetUtils=var1562, $r7=var566, $r9=var2001, $r11=var3923, $r12=var2335, $r14=var2932, $r15=var2696, $r18=var1573, $r17=var1368, $r19=var2832, $r21=var1180, $r22=var303, $r23=var2070}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 14,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r16 := @this: org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger;	r10 := @parameter0: java.lang.String;	r13 := @parameter1: java.lang.String;	r20 := @parameter2: java.lang.String;	r1 := @parameter3: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" [DUBBO] ");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", dubbo version: ");	$r4 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", current host: ");	$r7 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", error code: ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10);	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". This may be caused by ");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r13);	$r18 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", go to ");	$r17 = specialinvoke r16.<org.apache.dubbo.common.logger.support.FailsafeErrorTypeAwareLogger: java.lang.String getErrorUrl(java.lang.String)>(r10);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to find instructions. ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	return $r23
;block_num 1