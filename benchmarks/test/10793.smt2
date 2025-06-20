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

(declare-sort var884 0)
(declare-sort var1667 0)
(declare-sort var2026 0)
(declare-sort var2971 0)
(declare-sort var1712 0)
(declare-sort var1887 0)
(declare-sort var82 0)
(declare-sort var744 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun failedReports/-1923175899 (var884) var2026)
(declare-fun var2026_put/1464166817 (var2026 var1712 var1712) var1712)
(declare-fun cast-from-var1667-to-var1712 (var1667) var1712)
(declare-fun cast-from-var2026-to-var1712 (var2026) var1712)
(declare-fun metadataReportRetry/-1923175899 (var884) var1887)
(declare-fun startRetryTask/1757573846 (var1887) void)
(declare-fun logger/-1923175899 (var884) var82)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1712) String)
(declare-fun getMessage/849299655 (var744) String)
(declare-fun cast-from-var2971-to-var744 (var2971) var744)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var82_error/377575788 (var82 String String String String var744) void)
(declare-const null-var884 var884)
(declare-const null-var1667 var1667)
(declare-const null-var2026 var2026)
(declare-const null-var2971 var2971)
(declare-const var1701 var884) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport 
(assert (not (= var1701 null-var884)))
(declare-const var3617 var1667) ; Statement: r2 := @parameter0: org.apache.dubbo.metadata.report.identifier.MetadataIdentifier 
(assert (not (= var3617 null-var1667)))
(declare-const var3082 var2026) ; Statement: r3 := @parameter1: java.util.Map 
(assert (not (= var3082 null-var2026)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2258 var2971) ; Statement: $r14 := @caughtexception 
(assert (not (= var2258 null-var2971)))
(define-const var691 var2026 (failedReports/-1923175899 var1701)) ; Statement: $r15 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map failedReports> 
;(assert (var2026_put/1464166817 var691 (cast-from-var1667-to-var1712 var3617) (cast-from-var2026-to-var1712 var3082))) ; Statement: interfaceinvoke $r15.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, r3) 

(declare-const var691!1 var2026)
(declare-const var3617!1 var1667)
(declare-const var3082!1 var2026)
(define-const var1071 var1887 (metadataReportRetry/-1923175899 var1701)) ; Statement: $r16 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry metadataReportRetry> 
(assert true)
;(assert (startRetryTask/1757573846 var1071)) ; Statement: virtualinvoke $r16.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: void startRetryTask()>() 

(declare-const var1071!1 var1887)
(define-const var1174 var82 (logger/-1923175899 var1701)) ; Statement: $r18 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2228 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2228)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2228!1 String)
(assert (= var2228!1 ""))
(assert true)
(define-const var736 String (append/672562846 var2228!1 "Failed to put consumer metadata ")) ; Statement: $r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put consumer metadata ") 
(declare-const var2228!2 String)
(assert (= var2228!2 (str.++ var2228!1 "Failed to put consumer metadata ")))
(assert true)
(define-const var1845 String (append/-1031950772 var736 (cast-from-var1667-to-var1712 var3617!1))) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var736!1 String)
(assert (str.prefixof var736 var736!1))
(assert true)
(define-const var3456 String (append/672562846 var1845 ";  ")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";  ") 
(declare-const var1845!1 String)
(assert (= var1845!1 (str.++ var1845 ";  ")))
(assert true)
(define-const var3578 String (append/-1031950772 var3456 (cast-from-var2026-to-var1712 var3082!1))) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var3456!1 String)
(assert (str.prefixof var3456 var3456!1))
(assert true)
(define-const var2714 String (append/672562846 var3578 ", cause: ")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3578!1 String)
(assert (= var3578!1 (str.++ var3578 ", cause: ")))
(assert true)
(define-const var3633 String (getMessage/849299655 (cast-from-var2971-to-var744 var2258))) ; Statement: $r23 = virtualinvoke $r14.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var1644 String (append/672562846 var2714 var3633)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var2714!1 String)
(assert (= var2714!1 (str.++ var2714 var3633)))
(assert true)
(define-const var3457 String (toString/-2075883882 var1644)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var82_error/377575788 var1174 "3-2" "" "" var3457 (cast-from-var2971-to-var744 var2258))) ; Statement: interfaceinvoke $r18.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-2", "", "", $r26, $r14) 

(declare-const var1174!1 var82)
(declare-const var3200 String)
(declare-const var3354 String)
(declare-const var3354!1 String)
(declare-const var3457!1 String)
(declare-const var2258!1 var2971)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {failedReports/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.Map), var2026_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var1667-to-var1712=([org.apache.dubbo.metadata.report.identifier.MetadataIdentifier], java.lang.Object), cast-from-var2026-to-var1712=([java.util.Map], java.lang.Object), metadataReportRetry/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry), startRetryTask/1757573846=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry], void), logger/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2971-to-var744=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var82_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var884=org.apache.dubbo.metadata.report.support.AbstractMetadataReport, var1701=r0, var1667=org.apache.dubbo.metadata.report.identifier.MetadataIdentifier, var3617=r2, var2026=java.util.Map, var3082=r3, var2971=java.lang.Exception, var2258=$r14, var691=$r15, var1712=java.lang.Object, var1887=org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry, var1071=$r16, var82=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1174=$r18, var2228=$r17, var736=$r19, var1845=$r20, var3456=$r21, var3578=$r22, var2714=$r24, var744=java.lang.Throwable, var3633=$r23, var1644=$r25, var3457=$r26, var3200="3-2", var3354=""}
; {org.apache.dubbo.metadata.report.support.AbstractMetadataReport=var884, r0=var1701, org.apache.dubbo.metadata.report.identifier.MetadataIdentifier=var1667, r2=var3617, java.util.Map=var2026, r3=var3082, java.lang.Exception=var2971, $r14=var2258, $r15=var691, java.lang.Object=var1712, org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry=var1887, $r16=var1071, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var82, $r18=var1174, $r17=var2228, $r19=var736, $r20=var1845, $r21=var3456, $r22=var3578, $r24=var2714, java.lang.Throwable=var744, $r23=var3633, $r25=var1644, $r26=var3457, "3-2"=var3200, ""=var3354}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport;	r2 := @parameter0: org.apache.dubbo.metadata.report.identifier.MetadataIdentifier;	r3 := @parameter1: java.util.Map;	$r14 := @caughtexception;	$r15 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map failedReports>;	interfaceinvoke $r15.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, r3);	$r16 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry metadataReportRetry>;	virtualinvoke $r16.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: void startRetryTask()>();	$r18 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put consumer metadata ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(";  ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r23 = virtualinvoke $r14.<java.lang.Exception: java.lang.String getMessage()>();	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r18.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-2", "", "", $r26, $r14);	return
;block_num 3