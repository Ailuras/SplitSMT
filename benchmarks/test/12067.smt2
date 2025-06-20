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

(declare-sort var2908 0)
(declare-sort var558 0)
(declare-sort var2636 0)
(declare-sort var2213 0)
(declare-sort var239 0)
(declare-sort var91 0)
(declare-sort var983 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1923175899 (var239) var2213)
(declare-fun cast-from-var2908-to-var239 (var2908) var239)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var91) String)
(declare-fun cast-from-var558-to-var91 (var558) var91)
(declare-fun getMessage/849299655 (var2636) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2213_error/377575788 (var2213 String String String String var2636) void)
(declare-fun var983-init () var983)
(declare-fun <init>/1642269841 (var983 String var2636) void)
(declare-const null-var2908 var2908)
(declare-const null-var558 var558)
(declare-const null-var2636 var2636)
(declare-const var952 var2908) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport 
(assert (not (= var952 null-var2908)))
(declare-const var3314 var558) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier 
(assert (not (= var3314 null-var558)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2794 var2636) ; Statement: $r7 := @caughtexception 
(assert (not (= var2794 null-var2636)))
(define-const var2910 var2213 (logger/-1923175899 (cast-from-var2908-to-var239 var952))) ; Statement: $r9 = r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2544 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2544)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2544!1 String)
(assert (= var2544!1 ""))
(assert true)
(define-const var404 String (append/672562846 var2544!1 "Failed to get ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to get ") 
(declare-const var2544!2 String)
(assert (= var2544!2 (str.++ var2544!1 "Failed to get ")))
(assert true)
(define-const var1676 String (append/-1031950772 var404 (cast-from-var558-to-var91 var3314))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var404!1 String)
(assert (str.prefixof var404 var404!1))
(assert true)
(define-const var1287 String (append/672562846 var1676 " from nacos , cause: ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from nacos , cause: ") 
(declare-const var1676!1 String)
(assert (= var1676!1 (str.++ var1676 " from nacos , cause: ")))
(assert true)
(define-const var1651 String (getMessage/849299655 var2794)) ; Statement: $r12 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var2217 String (append/672562846 var1287 var1651)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var1287!1 String)
(assert (= var1287!1 (str.++ var1287 var1651)))
(assert true)
(define-const var3223 String (toString/-2075883882 var2217)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2213_error/377575788 var2910 "1-37" "" "" var3223 var2794)) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-37", "", "", $r15, $r7) 

(declare-const var2910!1 var2213)
(declare-const var3119 String)
(declare-const var2679 String)
(declare-const var2679!1 String)
(declare-const var3223!1 String)
(declare-const var2794!1 var2636)
(define-const var3878 var983 var983-init) ; Statement: $r16 = new java.lang.RuntimeException 
(define-const var1344 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1344)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1344!1 String)
(assert (= var1344!1 ""))
(assert true)
(define-const var1562 String (append/672562846 var1344!1 "Failed to get ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to get ") 
(declare-const var1344!2 String)
(assert (= var1344!2 (str.++ var1344!1 "Failed to get ")))
(assert true)
(define-const var667 String (append/-1031950772 var1562 (cast-from-var558-to-var91 var3314))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var1562!1 String)
(assert (str.prefixof var1562 var1562!1))
(assert true)
(define-const var3530 String (append/672562846 var667 " from nacos , cause: ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from nacos , cause: ") 
(declare-const var667!1 String)
(assert (= var667!1 (str.++ var667 " from nacos , cause: ")))
(assert true)
(define-const var2417 String (getMessage/849299655 var2794!1)) ; Statement: $r20 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var71 String (append/672562846 var3530 var2417)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20) 
(declare-const var3530!1 String)
(assert (= var3530!1 (str.++ var3530 var2417)))
(assert true)
(define-const var1507 String (toString/-2075883882 var71)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1642269841 var3878 var1507 var2794!1)) ; Statement: specialinvoke $r16.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r23, $r7) 

(declare-const var3878!1 var983)
(declare-const var1507!1 String)
(declare-const var2794!2 var2636)
 ; Statement: throw $r16 
(check-sat)
; {logger/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), cast-from-var2908-to-var239=([org.apache.dubbo.metadata.store.nacos.NacosMetadataReport], org.apache.dubbo.metadata.report.support.AbstractMetadataReport), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var558-to-var91=([org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2213_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var983-init=([], java.lang.RuntimeException), <init>/1642269841=([java.lang.RuntimeException, java.lang.String, java.lang.Throwable], void)}
; {var2908=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, var952=r0, var558=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var3314=r1, var2636=java.lang.Throwable, var2794=$r7, var2213=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var239=org.apache.dubbo.metadata.report.support.AbstractMetadataReport, var2910=$r9, var2544=$r8, var404=$r10, var91=java.lang.Object, var1676=$r11, var1287=$r13, var1651=$r12, var2217=$r14, var3223=$r15, var3119="1-37", var2679="", var983=java.lang.RuntimeException, var3878=$r16, var1344=$r17, var1562=$r18, var667=$r19, var3530=$r21, var2417=$r20, var71=$r22, var1507=$r23}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport=var2908, r0=var952, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var558, r1=var3314, java.lang.Throwable=var2636, $r7=var2794, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2213, org.apache.dubbo.metadata.report.support.AbstractMetadataReport=var239, $r9=var2910, $r8=var2544, $r10=var404, java.lang.Object=var91, $r11=var1676, $r13=var1287, $r12=var1651, $r14=var2217, $r15=var3223, "1-37"=var3119, ""=var2679, java.lang.RuntimeException=var983, $r16=var3878, $r17=var1344, $r18=var1562, $r19=var667, $r21=var3530, $r20=var2417, $r22=var71, $r23=var1507}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier;	$r7 := @caughtexception;	$r9 = r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to get ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from nacos , cause: ");	$r12 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-37", "", "", $r15, $r7);	$r16 = new java.lang.RuntimeException;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to get ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from nacos , cause: ");	$r20 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>();	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r16.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r23, $r7);	throw $r16
;block_num 2