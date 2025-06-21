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

(declare-sort var3949 0)
(declare-sort var499 0)
(declare-sort var3316 0)
(declare-sort var3270 0)
(declare-sort var253 0)
(declare-sort var509 0)
(declare-sort var3152 0)
(declare-sort var3359 0)
(declare-sort var364 0)
(declare-sort var1447 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun failedReports/-1923175899 (var3949) var253)
(declare-fun var253_put/1464166817 (var253 var509 var509) var509)
(declare-fun cast-from-var499-to-var509 (var499) var509)
(declare-fun cast-from-var3316-to-var509 (var3316) var509)
(declare-fun metadataReportRetry/-1923175899 (var3949) var3152)
(declare-fun startRetryTask/1757573846 (var3152) void)
(declare-fun logger/-1923175899 (var3949) var3359)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var509) String)
(declare-fun getMessage/849299655 (var364) String)
(declare-fun cast-from-var3270-to-var364 (var3270) var364)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3359_error/377575788 (var3359 String String String String var364) void)
(declare-fun var1447_valueOf/1602327315 (Bool) var1447)
(declare-const null-var3949 var3949)
(declare-const null-var499 var499)
(declare-const null-var3316 var3316)
(declare-const null-var3270 var3270)
(declare-const var1325 var3949) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport 
(assert (not (= var1325 null-var3949)))
(declare-const var2522 var499) ; Statement: r2 := @parameter0: org.apache.dubbo.metadata.report.identifier.MetadataIdentifier 
(assert (not (= var2522 null-var499)))
(declare-const var2620 var3316) ; Statement: r3 := @parameter1: org.apache.dubbo.metadata.definition.model.ServiceDefinition 
(assert (not (= var2620 null-var3316)))
(define-const var705 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2524 var3270) ; Statement: $r15 := @caughtexception 
(assert (not (= var2524 null-var3270)))
(define-const var158 var253 (failedReports/-1923175899 var1325)) ; Statement: $r16 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map failedReports> 
;(assert (var253_put/1464166817 var158 (cast-from-var499-to-var509 var2522) (cast-from-var3316-to-var509 var2620))) ; Statement: interfaceinvoke $r16.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, r3) 

(declare-const var158!1 var253)
(declare-const var2522!1 var499)
(declare-const var2620!1 var3316)
(define-const var1706 var3152 (metadataReportRetry/-1923175899 var1325)) ; Statement: $r17 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry metadataReportRetry> 
(assert true)
;(assert (startRetryTask/1757573846 var1706)) ; Statement: virtualinvoke $r17.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: void startRetryTask()>() 

(declare-const var1706!1 var3152)
(define-const var2749 var3359 (logger/-1923175899 var1325)) ; Statement: $r19 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2967 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2967)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2967!1 String)
(assert (= var2967!1 ""))
(assert true)
(define-const var2763 String (append/672562846 var2967!1 "Failed to put provider metadata ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put provider metadata ") 
(declare-const var2967!2 String)
(assert (= var2967!2 (str.++ var2967!1 "Failed to put provider metadata ")))
(assert true)
(define-const var3222 String (append/-1031950772 var2763 (cast-from-var499-to-var509 var2522!1))) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var2763!1 String)
(assert (str.prefixof var2763 var2763!1))
(assert true)
(define-const var1201 String (append/672562846 var3222 " in  ")) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in  ") 
(declare-const var3222!1 String)
(assert (= var3222!1 (str.++ var3222 " in  ")))
(assert true)
(define-const var507 String (append/-1031950772 var1201 (cast-from-var3316-to-var509 var2620!1))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var1201!1 String)
(assert (str.prefixof var1201 var1201!1))
(assert true)
(define-const var607 String (append/672562846 var507 ", cause: ")) ; Statement: $r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var507!1 String)
(assert (= var507!1 (str.++ var507 ", cause: ")))
(assert true)
(define-const var1304 String (getMessage/849299655 (cast-from-var3270-to-var364 var2524))) ; Statement: $r24 = virtualinvoke $r15.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var490 String (append/672562846 var607 var1304)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24) 
(declare-const var607!1 String)
(assert (= var607!1 (str.++ var607 var1304)))
(assert true)
(define-const var3441 String (toString/-2075883882 var490)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3359_error/377575788 var2749 "3-2" "" "" var3441 (cast-from-var3270-to-var364 var2524))) ; Statement: interfaceinvoke $r19.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-2", "", "", $r27, $r15) 

(declare-const var2749!1 var3359)
(declare-const var3841 String)
(declare-const var767 String)
(declare-const var767!1 String)
(declare-const var3441!1 String)
(declare-const var2524!1 var3270)
(define-const var705!1 Bool (ite (= 1 0) true false)) ; Statement: z2 = 0 
(assert true) ; Non Conditional
(define-const var1452 var1447 (var1447_valueOf/1602327315 var705!1)) ; Statement: $r6 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(z2) 
 ; Statement: return $r6 
(check-sat)
; {failedReports/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.Map), var253_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var499-to-var509=([org.apache.dubbo.metadata.report.identifier.MetadataIdentifier], java.lang.Object), cast-from-var3316-to-var509=([org.apache.dubbo.metadata.definition.model.ServiceDefinition], java.lang.Object), metadataReportRetry/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry), startRetryTask/1757573846=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry], void), logger/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3270-to-var364=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3359_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var1447_valueOf/1602327315=([boolean], java.lang.Boolean)}
; {var3949=org.apache.dubbo.metadata.report.support.AbstractMetadataReport, var1325=r0, var499=org.apache.dubbo.metadata.report.identifier.MetadataIdentifier, var2522=r2, var3316=org.apache.dubbo.metadata.definition.model.ServiceDefinition, var2620=r3, var705=z2, var3270=java.lang.Exception, var2524=$r15, var253=java.util.Map, var158=$r16, var509=java.lang.Object, var3152=org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry, var1706=$r17, var3359=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2749=$r19, var2967=$r18, var2763=$r20, var3222=$r21, var1201=$r22, var507=$r23, var607=$r25, var364=java.lang.Throwable, var1304=$r24, var490=$r26, var3441=$r27, var3841="3-2", var767="", var1447=java.lang.Boolean, var1452=$r6}
; {org.apache.dubbo.metadata.report.support.AbstractMetadataReport=var3949, r0=var1325, org.apache.dubbo.metadata.report.identifier.MetadataIdentifier=var499, r2=var2522, org.apache.dubbo.metadata.definition.model.ServiceDefinition=var3316, r3=var2620, z2=var705, java.lang.Exception=var3270, $r15=var2524, java.util.Map=var253, $r16=var158, java.lang.Object=var509, org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry=var3152, $r17=var1706, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3359, $r19=var2749, $r18=var2967, $r20=var2763, $r21=var3222, $r22=var1201, $r23=var507, $r25=var607, java.lang.Throwable=var364, $r24=var1304, $r26=var490, $r27=var3441, "3-2"=var3841, ""=var767, java.lang.Boolean=var1447, $r6=var1452}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport;	r2 := @parameter0: org.apache.dubbo.metadata.report.identifier.MetadataIdentifier;	r3 := @parameter1: org.apache.dubbo.metadata.definition.model.ServiceDefinition;	z2 = 1;	$r15 := @caughtexception;	$r16 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map failedReports>;	interfaceinvoke $r16.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, r3);	$r17 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry metadataReportRetry>;	virtualinvoke $r17.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: void startRetryTask()>();	$r19 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put provider metadata ");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in  ");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r24 = virtualinvoke $r15.<java.lang.Exception: java.lang.String getMessage()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r19.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-2", "", "", $r27, $r15);	z2 = 0;	$r6 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(z2);	return $r6
;block_num 3