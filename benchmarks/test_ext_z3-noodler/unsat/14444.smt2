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

(declare-sort var3222 0)
(declare-sort var2566 0)
(declare-sort var92 0)
(declare-sort var550 0)
(declare-sort var408 0)
(declare-sort var1714 0)
(declare-sort var3160 0)
(declare-sort var2777 0)
(declare-sort var2615 0)
(declare-sort var1586 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var408_selectInstance/-553633887 (var2566) var550)
(declare-fun var1714_getMetadataStorageType/-53761051 (var550) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var550_getAddress/1858264696 (var550) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3160_error/377575788 (var3160 String String String String var2615) void)
(declare-fun cast-from-var2777-to-var2615 (var2777) var2615)
(declare-const null-String String)
(declare-const null-var2566 var2566)
(declare-const null-var92 var92)
(declare-const var408-logger var3160)
(declare-const null-var2777 var2777)
(declare-const null-var1586 var1586)
(declare-const var970 String) ; Statement: r6 := @parameter0: java.lang.String 
(assert (not (= var970 null-String)))
(declare-const var224 var2566) ; Statement: r0 := @parameter1: java.util.List 
(assert (not (= var224 null-var2566)))
(declare-const var3408 var92) ; Statement: r7 := @parameter2: org.apache.dubbo.metadata.report.MetadataReport 
(assert (not (= var3408 null-var92)))
(define-const var57 var550 (var408_selectInstance/-553633887 var224)) ; Statement: r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.registry.client.ServiceInstance selectInstance(java.util.List)>(r0) 
(define-const var3369 String (var1714_getMetadataStorageType/-53761051 var57)) ; Statement: r2 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getMetadataStorageType(org.apache.dubbo.registry.client.ServiceInstance)>(r1) 
(define-const var55 var3160 var408-logger) ; Statement: $r3 = <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var275 var2777) ; Statement: $r16 := @caughtexception 
(assert (not (= var275 null-var2777)))
(define-const var2019 var3160 var408-logger) ; Statement: $r18 = <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2684 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2684)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2684!1 String)
(assert (= var2684!1 ""))
(assert true)
(define-const var1236 String (append/672562846 var2684!1 "Failed to get app metadata for revision ")) ; Statement: $r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to get app metadata for revision ") 
(declare-const var2684!2 String)
(assert (= var2684!2 (str.++ var2684!1 "Failed to get app metadata for revision ")))
(assert true)
(define-const var2589 String (append/672562846 var1236 var970)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6) 
(declare-const var1236!1 String)
(assert (= var1236!1 (str.++ var1236 var970)))
(assert true)
(define-const var320 String (append/672562846 var2589 " for type ")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" for type ") 
(declare-const var2589!1 String)
(assert (= var2589!1 (str.++ var2589 " for type ")))
(assert true)
(define-const var3163 String (append/672562846 var320 var3369)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var320!1 String)
(assert (= var320!1 (str.++ var320 var3369)))
(assert true)
(define-const var3566 String (append/672562846 var3163 " from instance ")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from instance ") 
(declare-const var3163!1 String)
(assert (= var3163!1 (str.++ var3163 " from instance ")))
(define-const var1306 String (var550_getAddress/1858264696 var57)) ; Statement: $r23 = interfaceinvoke r1.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getAddress()>() 
(assert true)
(define-const var1879 String (append/672562846 var3566 var1306)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var3566!1 String)
(assert (= var3566!1 (str.++ var3566 var1306)))
(assert true)
(define-const var1640 String (toString/-2075883882 var1879)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3160_error/377575788 var2019 "1-39" "" "" var1640 (cast-from-var2777-to-var2615 var275))) ; Statement: interfaceinvoke $r18.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-39", "", "", $r26, $r16) 

(declare-const var2019!1 var3160)
(declare-const var2505 String)
(declare-const var1512 String)
(declare-const var1512!1 String)
(declare-const var1640!1 String)
(declare-const var275!1 var2777)
(define-const var2580 var1586 null-var1586) ; Statement: r28 = null 
(assert true) ; Non Conditional
 ; Statement: if r28 != null goto return r28 
(assert (not (= var2580 null-var1586))) ; Cond: r28 != null 
 ; Statement: return r28 
(check-sat)
; {var408_selectInstance/-553633887=([java.util.List], org.apache.dubbo.registry.client.ServiceInstance), var1714_getMetadataStorageType/-53761051=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var550_getAddress/1858264696=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3160_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var2777-to-var2615=([java.lang.Exception], java.lang.Throwable)}
; {var970=r6, var3222=null_type, var2566=java.util.List, var224=r0, var92=org.apache.dubbo.metadata.report.MetadataReport, var3408=r7, var550=org.apache.dubbo.registry.client.ServiceInstance, var408=org.apache.dubbo.registry.client.metadata.MetadataUtils, var57=r1, var1714=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils, var3369=r2, var3160=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var55=$r3, var2777=java.lang.Exception, var275=$r16, var2019=$r18, var2684=$r17, var1236=$r19, var2589=$r20, var320=$r21, var3163=$r22, var3566=$r24, var1306=$r23, var1879=$r25, var1640=$r26, var2615=java.lang.Throwable, var2505="1-39", var1512="", var1586=org.apache.dubbo.metadata.MetadataInfo, var2580=r28}
; {r6=var970, null_type=var3222, java.util.List=var2566, r0=var224, org.apache.dubbo.metadata.report.MetadataReport=var92, r7=var3408, org.apache.dubbo.registry.client.ServiceInstance=var550, org.apache.dubbo.registry.client.metadata.MetadataUtils=var408, r1=var57, org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils=var1714, r2=var3369, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3160, $r3=var55, java.lang.Exception=var2777, $r16=var275, $r18=var2019, $r17=var2684, $r19=var1236, $r20=var2589, $r21=var320, $r22=var3163, $r24=var3566, $r23=var1306, $r25=var1879, $r26=var1640, java.lang.Throwable=var2615, "1-39"=var2505, ""=var1512, org.apache.dubbo.metadata.MetadataInfo=var1586, r28=var2580}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @parameter0: java.lang.String;	r0 := @parameter1: java.util.List;	r7 := @parameter2: org.apache.dubbo.metadata.report.MetadataReport;	r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.registry.client.ServiceInstance selectInstance(java.util.List)>(r0);	r2 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getMetadataStorageType(org.apache.dubbo.registry.client.ServiceInstance)>(r1);	$r3 = <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r16 := @caughtexception;	$r18 = <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to get app metadata for revision ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" for type ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from instance ");	$r23 = interfaceinvoke r1.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getAddress()>();	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r18.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-39", "", "", $r26, $r16);	r28 = null;	if r28 != null goto return r28;	return r28
;block_num 4