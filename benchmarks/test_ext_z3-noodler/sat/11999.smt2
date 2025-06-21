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

(declare-sort var3836 0)
(declare-sort var2491 0)
(declare-sort var289 0)
(declare-sort var3446 0)
(declare-sort var3186 0)
(declare-sort var3085 0)
(declare-sort var3187 0)
(declare-sort var3105 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1923175899 (var3085) var3186)
(declare-fun cast-from-var3836-to-var3085 (var3836) var3085)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3187) String)
(declare-fun cast-from-var2491-to-var3187 (var2491) var3187)
(declare-fun getMessage/849299655 (var3446) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3186_error/377575788 (var3186 String String String String var3446) void)
(declare-fun var3105-init () var3105)
(declare-fun <init>/1642269841 (var3105 String var3446) void)
(declare-const null-var3836 var3836)
(declare-const null-var2491 var2491)
(declare-const null-String String)
(declare-const null-var3446 var3446)
(declare-const var1602 var3836) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport 
(assert (not (= var1602 null-var3836)))
(declare-const var3921 var2491) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier 
(assert (not (= var3921 null-var2491)))
(declare-const var1214 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var1214 null-String)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2064 var3446) ; Statement: $r8 := @caughtexception 
(assert (not (= var2064 null-var3446)))
(define-const var67 var3186 (logger/-1923175899 (cast-from-var3836-to-var3085 var1602))) ; Statement: $r10 = r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1589 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1589)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1589!1 String)
(assert (= var1589!1 ""))
(assert true)
(define-const var26 String (append/672562846 var1589!1 "Failed to put ")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put ") 
(declare-const var1589!2 String)
(assert (= var1589!2 (str.++ var1589!1 "Failed to put ")))
(assert true)
(define-const var2955 String (append/-1031950772 var26 (cast-from-var2491-to-var3187 var3921))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var26!1 String)
(assert (str.prefixof var26 var26!1))
(assert true)
(define-const var1739 String (append/672562846 var2955 " to nacos ")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ") 
(declare-const var2955!1 String)
(assert (= var2955!1 (str.++ var2955 " to nacos ")))
(assert true)
(define-const var56 String (append/672562846 var1739 var1214)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var1739!1 String)
(assert (= var1739!1 (str.++ var1739 var1214)))
(assert true)
(define-const var991 String (append/672562846 var56 ", cause: ")) ; Statement: $r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var56!1 String)
(assert (= var56!1 (str.++ var56 ", cause: ")))
(assert true)
(define-const var852 String (getMessage/849299655 var2064)) ; Statement: $r15 = virtualinvoke $r8.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var493 String (append/672562846 var991 var852)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var991!1 String)
(assert (= var991!1 (str.++ var991 var852)))
(assert true)
(define-const var1988 String (toString/-2075883882 var493)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3186_error/377575788 var67 "1-37" "" "" var1988 var2064)) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-37", "", "", $r18, $r8) 

(declare-const var67!1 var3186)
(declare-const var1599 String)
(declare-const var2436 String)
(declare-const var2436!1 String)
(declare-const var1988!1 String)
(declare-const var2064!1 var3446)
(define-const var2809 var3105 var3105-init) ; Statement: $r19 = new java.lang.RuntimeException 
(define-const var2321 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2321)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2321!1 String)
(assert (= var2321!1 ""))
(assert true)
(define-const var526 String (append/672562846 var2321!1 "Failed to put ")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put ") 
(declare-const var2321!2 String)
(assert (= var2321!2 (str.++ var2321!1 "Failed to put ")))
(assert true)
(define-const var2028 String (append/-1031950772 var526 (cast-from-var2491-to-var3187 var3921))) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var526!1 String)
(assert (str.prefixof var526 var526!1))
(assert true)
(define-const var992 String (append/672562846 var2028 " to nacos ")) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ") 
(declare-const var2028!1 String)
(assert (= var2028!1 (str.++ var2028 " to nacos ")))
(assert true)
(define-const var149 String (append/672562846 var992 var1214)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var992!1 String)
(assert (= var992!1 (str.++ var992 var1214)))
(assert true)
(define-const var3380 String (append/672562846 var149 ", cause: ")) ; Statement: $r26 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var149!1 String)
(assert (= var149!1 (str.++ var149 ", cause: ")))
(assert true)
(define-const var946 String (getMessage/849299655 var2064!1)) ; Statement: $r25 = virtualinvoke $r8.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var2394 String (append/672562846 var3380 var946)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var3380!1 String)
(assert (= var3380!1 (str.++ var3380 var946)))
(assert true)
(define-const var1648 String (toString/-2075883882 var2394)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1642269841 var2809 var1648 var2064!1)) ; Statement: specialinvoke $r19.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r28, $r8) 

(declare-const var2809!1 var3105)
(declare-const var1648!1 String)
(declare-const var2064!2 var3446)
 ; Statement: throw $r19 
(check-sat)
; {logger/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), cast-from-var3836-to-var3085=([org.apache.dubbo.metadata.store.nacos.NacosMetadataReport], org.apache.dubbo.metadata.report.support.AbstractMetadataReport), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2491-to-var3187=([org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3186_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var3105-init=([], java.lang.RuntimeException), <init>/1642269841=([java.lang.RuntimeException, java.lang.String, java.lang.Throwable], void)}
; {var3836=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, var1602=r0, var2491=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var3921=r1, var1214=r4, var289=null_type, var3446=java.lang.Throwable, var2064=$r8, var3186=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3085=org.apache.dubbo.metadata.report.support.AbstractMetadataReport, var67=$r10, var1589=$r9, var26=$r11, var3187=java.lang.Object, var2955=$r12, var1739=$r13, var56=$r14, var991=$r16, var852=$r15, var493=$r17, var1988=$r18, var1599="1-37", var2436="", var3105=java.lang.RuntimeException, var2809=$r19, var2321=$r20, var526=$r21, var2028=$r22, var992=$r23, var149=$r24, var3380=$r26, var946=$r25, var2394=$r27, var1648=$r28}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport=var3836, r0=var1602, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var2491, r1=var3921, r4=var1214, null_type=var289, java.lang.Throwable=var3446, $r8=var2064, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3186, org.apache.dubbo.metadata.report.support.AbstractMetadataReport=var3085, $r10=var67, $r9=var1589, $r11=var26, java.lang.Object=var3187, $r12=var2955, $r13=var1739, $r14=var56, $r16=var991, $r15=var852, $r17=var493, $r18=var1988, "1-37"=var1599, ""=var2436, java.lang.RuntimeException=var3105, $r19=var2809, $r20=var2321, $r21=var526, $r22=var2028, $r23=var992, $r24=var149, $r26=var3380, $r25=var946, $r27=var2394, $r28=var1648}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier;	r4 := @parameter1: java.lang.String;	$r8 := @caughtexception;	$r10 = r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r15 = virtualinvoke $r8.<java.lang.Throwable: java.lang.String getMessage()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-37", "", "", $r18, $r8);	$r19 = new java.lang.RuntimeException;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to put ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ");	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r26 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r25 = virtualinvoke $r8.<java.lang.Throwable: java.lang.String getMessage()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r19.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r28, $r8);	throw $r19
;block_num 2