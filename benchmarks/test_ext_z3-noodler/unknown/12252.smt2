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

(declare-sort var3492 0)
(declare-sort var1071 0)
(declare-sort var2666 0)
(declare-sort var3062 0)
(declare-sort var3865 0)
(declare-sort var1690 0)
(declare-sort var1547 0)
(declare-sort var2710 0)
(declare-sort var3836 0)
(declare-sort var1155 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1923175899 (var3492) var3062)
(declare-fun failedReports/-1923175899 (var3492) var1690)
(declare-fun var1690_put/1464166817 (var1690 var1547 var1547) var1547)
(declare-fun cast-from-var1071-to-var1547 (var1071) var1547)
(declare-fun cast-from-var2666-to-var1547 (var2666) var1547)
(declare-fun metadataReportRetry/-1923175899 (var3492) var2710)
(declare-fun startRetryTask/1757573846 (var2710) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1547) String)
(declare-fun getMessage/849299655 (var3836) String)
(declare-fun cast-from-var3865-to-var3836 (var3865) var3836)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3062_error/377575788 (var3062 String String String String var3836) void)
(declare-fun var1155_valueOf/1602327315 (Bool) var1155)
(declare-const null-var3492 var3492)
(declare-const null-var1071 var1071)
(declare-const null-var2666 var2666)
(declare-const null-var3865 var3865)
(declare-const var2982 var3492) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport 
(assert (not (= var2982 null-var3492)))
(declare-const var652 var1071) ; Statement: r2 := @parameter0: org.apache.dubbo.metadata.report.identifier.MetadataIdentifier 
(assert (not (= var652 null-var1071)))
(declare-const var1842 var2666) ; Statement: r3 := @parameter1: org.apache.dubbo.metadata.definition.model.ServiceDefinition 
(assert (not (= var1842 null-var2666)))
(define-const var3894 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(assert true) ; Non Conditional
(define-const var1257 var3062 (logger/-1923175899 var2982)) ; Statement: $r1 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1026 var3865) ; Statement: $r15 := @caughtexception 
(assert (not (= var1026 null-var3865)))
(define-const var2161 var1690 (failedReports/-1923175899 var2982)) ; Statement: $r16 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map failedReports> 
;(assert (var1690_put/1464166817 var2161 (cast-from-var1071-to-var1547 var652) (cast-from-var2666-to-var1547 var1842))) ; Statement: interfaceinvoke $r16.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, r3) 

(declare-const var2161!1 var1690)
(declare-const var652!1 var1071)
(declare-const var1842!1 var2666)
(define-const var626 var2710 (metadataReportRetry/-1923175899 var2982)) ; Statement: $r17 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry metadataReportRetry> 
(assert true)
;(assert (startRetryTask/1757573846 var626)) ; Statement: virtualinvoke $r17.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: void startRetryTask()>() 

(declare-const var626!1 var2710)
(define-const var824 var3062 (logger/-1923175899 var2982)) ; Statement: $r19 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1000 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1000)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1000!1 String)
(assert (= var1000!1 ""))
(assert true)
(define-const var3310 String (append/672562846 var1000!1 "Failed to put provider metadata ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put provider metadata ") 
(declare-const var1000!2 String)
(assert (= var1000!2 (str.++ var1000!1 "Failed to put provider metadata ")))
(assert true)
(define-const var1040 String (append/-1031950772 var3310 (cast-from-var1071-to-var1547 var652!1))) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var3310!1 String)
(assert (str.prefixof var3310 var3310!1))
(assert true)
(define-const var2954 String (append/672562846 var1040 " in  ")) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in  ") 
(declare-const var1040!1 String)
(assert (= var1040!1 (str.++ var1040 " in  ")))
(assert true)
(define-const var3665 String (append/-1031950772 var2954 (cast-from-var2666-to-var1547 var1842!1))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var2954!1 String)
(assert (str.prefixof var2954 var2954!1))
(assert true)
(define-const var1709 String (append/672562846 var3665 ", cause: ")) ; Statement: $r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3665!1 String)
(assert (= var3665!1 (str.++ var3665 ", cause: ")))
(assert true)
(define-const var904 String (getMessage/849299655 (cast-from-var3865-to-var3836 var1026))) ; Statement: $r24 = virtualinvoke $r15.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var3409 String (append/672562846 var1709 var904)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24) 
(declare-const var1709!1 String)
(assert (= var1709!1 (str.++ var1709 var904)))
(assert true)
(define-const var1016 String (toString/-2075883882 var3409)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3062_error/377575788 var824 "3-2" "" "" var1016 (cast-from-var3865-to-var3836 var1026))) ; Statement: interfaceinvoke $r19.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-2", "", "", $r27, $r15) 

(declare-const var824!1 var3062)
(declare-const var552 String)
(declare-const var2973 String)
(declare-const var2973!1 String)
(declare-const var1016!1 String)
(declare-const var1026!1 var3865)
(define-const var3894!1 Bool (ite (= 1 0) true false)) ; Statement: z2 = 0 
(assert true) ; Non Conditional
(define-const var1713 var1155 (var1155_valueOf/1602327315 var3894!1)) ; Statement: $r6 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(z2) 
 ; Statement: return $r6 
(check-sat)
; {logger/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), failedReports/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.Map), var1690_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var1071-to-var1547=([org.apache.dubbo.metadata.report.identifier.MetadataIdentifier], java.lang.Object), cast-from-var2666-to-var1547=([org.apache.dubbo.metadata.definition.model.ServiceDefinition], java.lang.Object), metadataReportRetry/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry), startRetryTask/1757573846=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3865-to-var3836=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3062_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var1155_valueOf/1602327315=([boolean], java.lang.Boolean)}
; {var3492=org.apache.dubbo.metadata.report.support.AbstractMetadataReport, var2982=r0, var1071=org.apache.dubbo.metadata.report.identifier.MetadataIdentifier, var652=r2, var2666=org.apache.dubbo.metadata.definition.model.ServiceDefinition, var1842=r3, var3894=z2, var3062=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1257=$r1, var3865=java.lang.Exception, var1026=$r15, var1690=java.util.Map, var2161=$r16, var1547=java.lang.Object, var2710=org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry, var626=$r17, var824=$r19, var1000=$r18, var3310=$r20, var1040=$r21, var2954=$r22, var3665=$r23, var1709=$r25, var3836=java.lang.Throwable, var904=$r24, var3409=$r26, var1016=$r27, var552="3-2", var2973="", var1155=java.lang.Boolean, var1713=$r6}
; {org.apache.dubbo.metadata.report.support.AbstractMetadataReport=var3492, r0=var2982, org.apache.dubbo.metadata.report.identifier.MetadataIdentifier=var1071, r2=var652, org.apache.dubbo.metadata.definition.model.ServiceDefinition=var2666, r3=var1842, z2=var3894, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3062, $r1=var1257, java.lang.Exception=var3865, $r15=var1026, java.util.Map=var1690, $r16=var2161, java.lang.Object=var1547, org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry=var2710, $r17=var626, $r19=var824, $r18=var1000, $r20=var3310, $r21=var1040, $r22=var2954, $r23=var3665, $r25=var1709, java.lang.Throwable=var3836, $r24=var904, $r26=var3409, $r27=var1016, "3-2"=var552, ""=var2973, java.lang.Boolean=var1155, $r6=var1713}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport;	r2 := @parameter0: org.apache.dubbo.metadata.report.identifier.MetadataIdentifier;	r3 := @parameter1: org.apache.dubbo.metadata.definition.model.ServiceDefinition;	z2 = 1;	$r1 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 := @caughtexception;	$r16 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map failedReports>;	interfaceinvoke $r16.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, r3);	$r17 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry metadataReportRetry>;	virtualinvoke $r17.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: void startRetryTask()>();	$r19 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put provider metadata ");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in  ");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r24 = virtualinvoke $r15.<java.lang.Exception: java.lang.String getMessage()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r19.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("3-2", "", "", $r27, $r15);	z2 = 0;	$r6 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(z2);	return $r6
;block_num 4