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

(declare-sort var2515 0)
(declare-sort var2924 0)
(declare-sort var2875 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1716143610 (var2515) var2875)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var2924) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2875_error/377575788 (var2875 String String String String var2924) void)
(declare-const null-var2515 var2515)
(declare-const null-var2924 var2924)
(declare-const var2625 var2515) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry 
(assert (not (= var2625 null-var2515)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var92 var2924) ; Statement: $r8 := @caughtexception 
(assert (not (= var92 null-var2924)))
(define-const var2899 var2875 (logger/-1716143610 var2625)) ; Statement: $r10 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3684 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3684)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3684!1 String)
(assert (= var3684!1 ""))
(assert true)
(define-const var3707 String (append/672562846 var3684!1 "Unexpected error occur at failed retry, cause: ")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected error occur at failed retry, cause: ") 
(declare-const var3684!2 String)
(assert (= var3684!2 (str.++ var3684!1 "Unexpected error occur at failed retry, cause: ")))
(assert true)
(define-const var1780 String (getMessage/849299655 var92)) ; Statement: $r11 = virtualinvoke $r8.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1425 String (append/672562846 var3707 var1780)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3707!1 String)
(assert (= var3707!1 (str.++ var3707 var1780)))
(assert true)
(define-const var3627 String (toString/-2075883882 var1425)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2875_error/377575788 var2899 "0-12" "" "" var3627 var92)) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-12", "", "", $r14, $r8) 

(declare-const var2899!1 var2875)
(declare-const var545 String)
(declare-const var222 String)
(declare-const var222!1 String)
(declare-const var3627!1 String)
(declare-const var92!1 var2924)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {logger/-1716143610=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2875_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var2515=org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry, var2625=r0, var2924=java.lang.Throwable, var92=$r8, var2875=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2899=$r10, var3684=$r9, var3707=$r12, var1780=$r11, var1425=$r13, var3627=$r14, var545="0-12", var222=""}
; {org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry=var2515, r0=var2625, java.lang.Throwable=var2924, $r8=var92, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2875, $r10=var2899, $r9=var3684, $r12=var3707, $r11=var1780, $r13=var1425, $r14=var3627, "0-12"=var545, ""=var222}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry;	$r8 := @caughtexception;	$r10 = r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected error occur at failed retry, cause: ");	$r11 = virtualinvoke $r8.<java.lang.Throwable: java.lang.String getMessage()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-12", "", "", $r14, $r8);	return
;block_num 3