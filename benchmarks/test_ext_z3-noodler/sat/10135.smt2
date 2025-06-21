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

(declare-sort var2178 0)
(declare-sort var3623 0)
(declare-sort var1991 0)
(declare-sort var2424 0)
(declare-sort var1029 0)
(declare-sort var3636 0)
(declare-sort var142 0)
(declare-sort var3086 0)
(declare-sort var720 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toUrl/-1448586236 (var3623) var2424)
(declare-fun getProtocol/491749358 (var2424) String)
(declare-fun applicationModel/2105784089 (var2178) var1029)
(declare-fun getCurrentConfig/-1054894291 (var1029) var3636)
(declare-fun getName/922463553 (var3636) String)
(declare-fun addParameterIfAbsent/-944034303 (var2424 String String) var2424)
(declare-fun getEnableFileCache/573153134 (var3636) var142)
(declare-fun String_valueOf/-333372740 (var3086) String)
(declare-fun cast-from-var142-to-var3086 (var142) var3086)
(declare-fun var1991_getMetadataReport/-406227020 (var1991 var2424) var720)
(declare-const null-var2178 var2178)
(declare-const null-var3623 var3623)
(declare-const null-var1991 var1991)
(declare-const null-var720 var720)
(declare-const var2703 var2178) ; Statement: r3 := @this: org.apache.dubbo.metadata.report.MetadataReportInstance 
(assert (not (= var2703 null-var2178)))
(declare-const var1541 var3623) ; Statement: r0 := @parameter0: org.apache.dubbo.config.MetadataReportConfig 
(assert (not (= var1541 null-var3623)))
(declare-const var1609 var1991) ; Statement: r11 := @parameter1: org.apache.dubbo.metadata.report.MetadataReportFactory 
(assert (not (= var1609 null-var1991)))
(assert true)
(define-const var3918 var2424 (toUrl/-1448586236 var1541)) ; Statement: r23 = virtualinvoke r0.<org.apache.dubbo.config.MetadataReportConfig: org.apache.dubbo.common.URL toUrl()>() 
(define-const var1302 String "metadata") ; Statement: $r2 = "metadata" 
(assert true)
(define-const var921 String (getProtocol/491749358 var3918)) ; Statement: $r1 = virtualinvoke r23.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2621 Bool (= var1302 var921)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.metadata.report.MetadataReportInstance: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (= (ite var2621 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1987 var1029 (applicationModel/2105784089 var2703)) ; Statement: $r4 = r3.<org.apache.dubbo.metadata.report.MetadataReportInstance: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var324 var3636 (getCurrentConfig/-1054894291 var1987)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.ApplicationConfig getCurrentConfig()>() 
(assert true)
(define-const var3591 String (getName/922463553 var324)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>() 
(assert true)
(define-const var1932 var2424 (addParameterIfAbsent/-944034303 var3918 "application" var3591)) ; Statement: $r20 = virtualinvoke r23.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameterIfAbsent(java.lang.String,java.lang.String)>("application", $r6) 
(define-const var2077 var1029 (applicationModel/2105784089 var2703)) ; Statement: $r7 = r3.<org.apache.dubbo.metadata.report.MetadataReportInstance: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var3320 var3636 (getCurrentConfig/-1054894291 var2077)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.ApplicationConfig getCurrentConfig()>() 
(assert true)
(define-const var105 var142 (getEnableFileCache/573153134 var3320)) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.config.ApplicationConfig: java.lang.Boolean getEnableFileCache()>() 
(define-const var1131 String (String_valueOf/-333372740 (cast-from-var142-to-var3086 var105))) ; Statement: $r10 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r9) 
(assert true)
(define-const var1742 var2424 (addParameterIfAbsent/-944034303 var1932 "file-cache" var1131)) ; Statement: $r21 = virtualinvoke $r20.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameterIfAbsent(java.lang.String,java.lang.String)>("file-cache", $r10) 
(define-const var1913 var720 (var1991_getMetadataReport/-406227020 var1609 var1742)) ; Statement: $r22 = interfaceinvoke r11.<org.apache.dubbo.metadata.report.MetadataReportFactory: org.apache.dubbo.metadata.report.MetadataReport getMetadataReport(org.apache.dubbo.common.URL)>($r21) 
 ; Statement: if $r22 == null goto return 
(assert (= var1913 null-var720)) ; Cond: $r22 == null 
 ; Statement: return 
(check-sat)
; {toUrl/-1448586236=([org.apache.dubbo.config.MetadataReportConfig], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), applicationModel/2105784089=([org.apache.dubbo.metadata.report.MetadataReportInstance], org.apache.dubbo.rpc.model.ApplicationModel), getCurrentConfig/-1054894291=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.ApplicationConfig), getName/922463553=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), addParameterIfAbsent/-944034303=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), getEnableFileCache/573153134=([org.apache.dubbo.config.ApplicationConfig], java.lang.Boolean), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var142-to-var3086=([java.lang.Boolean], java.lang.Object), var1991_getMetadataReport/-406227020=([org.apache.dubbo.metadata.report.MetadataReportFactory, org.apache.dubbo.common.URL], org.apache.dubbo.metadata.report.MetadataReport)}
; {var2178=org.apache.dubbo.metadata.report.MetadataReportInstance, var2703=r3, var3623=org.apache.dubbo.config.MetadataReportConfig, var1541=r0, var1991=org.apache.dubbo.metadata.report.MetadataReportFactory, var1609=r11, var2424=org.apache.dubbo.common.URL, var3918=r23, var1302=$r2, var921=$r1, var2621=$z0, var1029=org.apache.dubbo.rpc.model.ApplicationModel, var1987=$r4, var3636=org.apache.dubbo.config.ApplicationConfig, var324=$r5, var3591=$r6, var1932=$r20, var2077=$r7, var3320=$r8, var142=java.lang.Boolean, var105=$r9, var3086=java.lang.Object, var1131=$r10, var1742=$r21, var720=org.apache.dubbo.metadata.report.MetadataReport, var1913=$r22}
; {org.apache.dubbo.metadata.report.MetadataReportInstance=var2178, r3=var2703, org.apache.dubbo.config.MetadataReportConfig=var3623, r0=var1541, org.apache.dubbo.metadata.report.MetadataReportFactory=var1991, r11=var1609, org.apache.dubbo.common.URL=var2424, r23=var3918, $r2=var1302, $r1=var921, $z0=var2621, org.apache.dubbo.rpc.model.ApplicationModel=var1029, $r4=var1987, org.apache.dubbo.config.ApplicationConfig=var3636, $r5=var324, $r6=var3591, $r20=var1932, $r7=var2077, $r8=var3320, java.lang.Boolean=var142, $r9=var105, java.lang.Object=var3086, $r10=var1131, $r21=var1742, org.apache.dubbo.metadata.report.MetadataReport=var720, $r22=var1913}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.metadata.report.MetadataReportInstance;	r0 := @parameter0: org.apache.dubbo.config.MetadataReportConfig;	r11 := @parameter1: org.apache.dubbo.metadata.report.MetadataReportFactory;	r23 = virtualinvoke r0.<org.apache.dubbo.config.MetadataReportConfig: org.apache.dubbo.common.URL toUrl()>();	$r2 = "metadata";	$r1 = virtualinvoke r23.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r4 = r3.<org.apache.dubbo.metadata.report.MetadataReportInstance: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r4 = r3.<org.apache.dubbo.metadata.report.MetadataReportInstance: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.ApplicationConfig getCurrentConfig()>();	$r6 = virtualinvoke $r5.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>();	$r20 = virtualinvoke r23.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameterIfAbsent(java.lang.String,java.lang.String)>("application", $r6);	$r7 = r3.<org.apache.dubbo.metadata.report.MetadataReportInstance: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.ApplicationConfig getCurrentConfig()>();	$r9 = virtualinvoke $r8.<org.apache.dubbo.config.ApplicationConfig: java.lang.Boolean getEnableFileCache()>();	$r10 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r9);	$r21 = virtualinvoke $r20.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameterIfAbsent(java.lang.String,java.lang.String)>("file-cache", $r10);	$r22 = interfaceinvoke r11.<org.apache.dubbo.metadata.report.MetadataReportFactory: org.apache.dubbo.metadata.report.MetadataReport getMetadataReport(org.apache.dubbo.common.URL)>($r21);	if $r22 == null goto return;	return
;block_num 3