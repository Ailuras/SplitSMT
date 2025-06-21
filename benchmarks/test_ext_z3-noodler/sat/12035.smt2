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

(declare-sort var562 0)
(declare-sort var682 0)
(declare-sort var2009 0)
(declare-sort var3337 0)
(declare-sort var2209 0)
(declare-sort var2942 0)
(declare-sort var1761 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1923175899 (var2209) var3337)
(declare-fun cast-from-var562-to-var2209 (var562) var2209)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2942) String)
(declare-fun cast-from-var682-to-var2942 (var682) var2942)
(declare-fun getMessage/849299655 (var2009) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3337_error/377575788 (var3337 String String String String var2009) void)
(declare-fun var1761-init () var1761)
(declare-fun <init>/1642269841 (var1761 String var2009) void)
(declare-const null-var562 var562)
(declare-const null-var682 var682)
(declare-const null-var2009 var2009)
(declare-const var3003 var562) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport 
(assert (not (= var3003 null-var562)))
(declare-const var1798 var682) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier 
(assert (not (= var1798 null-var682)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1191 var2009) ; Statement: $r7 := @caughtexception 
(assert (not (= var1191 null-var2009)))
(define-const var1869 var3337 (logger/-1923175899 (cast-from-var562-to-var2209 var3003))) ; Statement: $r9 = r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2963 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2963)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2963!1 String)
(assert (= var2963!1 ""))
(assert true)
(define-const var2523 String (append/672562846 var2963!1 "Failed to remove ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to remove ") 
(declare-const var2963!2 String)
(assert (= var2963!2 (str.++ var2963!1 "Failed to remove ")))
(assert true)
(define-const var781 String (append/-1031950772 var2523 (cast-from-var682-to-var2942 var1798))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2523!1 String)
(assert (str.prefixof var2523 var2523!1))
(assert true)
(define-const var729 String (append/672562846 var781 " from nacos , cause: ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from nacos , cause: ") 
(declare-const var781!1 String)
(assert (= var781!1 (str.++ var781 " from nacos , cause: ")))
(assert true)
(define-const var2907 String (getMessage/849299655 var1191)) ; Statement: $r12 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1778 String (append/672562846 var729 var2907)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var729!1 String)
(assert (= var729!1 (str.++ var729 var2907)))
(assert true)
(define-const var2308 String (toString/-2075883882 var1778)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3337_error/377575788 var1869 "1-37" "" "" var2308 var1191)) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-37", "", "", $r15, $r7) 

(declare-const var1869!1 var3337)
(declare-const var3000 String)
(declare-const var3399 String)
(declare-const var3399!1 String)
(declare-const var2308!1 String)
(declare-const var1191!1 var2009)
(define-const var3344 var1761 var1761-init) ; Statement: $r16 = new java.lang.RuntimeException 
(define-const var3415 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3415)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3415!1 String)
(assert (= var3415!1 ""))
(assert true)
(define-const var2674 String (append/672562846 var3415!1 "Failed to remove ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to remove ") 
(declare-const var3415!2 String)
(assert (= var3415!2 (str.++ var3415!1 "Failed to remove ")))
(assert true)
(define-const var1421 String (append/-1031950772 var2674 (cast-from-var682-to-var2942 var1798))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2674!1 String)
(assert (str.prefixof var2674 var2674!1))
(assert true)
(define-const var1982 String (append/672562846 var1421 " from nacos , cause: ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from nacos , cause: ") 
(declare-const var1421!1 String)
(assert (= var1421!1 (str.++ var1421 " from nacos , cause: ")))
(assert true)
(define-const var2180 String (getMessage/849299655 var1191!1)) ; Statement: $r20 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var693 String (append/672562846 var1982 var2180)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20) 
(declare-const var1982!1 String)
(assert (= var1982!1 (str.++ var1982 var2180)))
(assert true)
(define-const var2984 String (toString/-2075883882 var693)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1642269841 var3344 var2984 var1191!1)) ; Statement: specialinvoke $r16.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r23, $r7) 

(declare-const var3344!1 var1761)
(declare-const var2984!1 String)
(declare-const var1191!2 var2009)
 ; Statement: throw $r16 
(check-sat)
; {logger/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), cast-from-var562-to-var2209=([org.apache.dubbo.metadata.store.nacos.NacosMetadataReport], org.apache.dubbo.metadata.report.support.AbstractMetadataReport), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var682-to-var2942=([org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3337_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var1761-init=([], java.lang.RuntimeException), <init>/1642269841=([java.lang.RuntimeException, java.lang.String, java.lang.Throwable], void)}
; {var562=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, var3003=r0, var682=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var1798=r1, var2009=java.lang.Throwable, var1191=$r7, var3337=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2209=org.apache.dubbo.metadata.report.support.AbstractMetadataReport, var1869=$r9, var2963=$r8, var2523=$r10, var2942=java.lang.Object, var781=$r11, var729=$r13, var2907=$r12, var1778=$r14, var2308=$r15, var3000="1-37", var3399="", var1761=java.lang.RuntimeException, var3344=$r16, var3415=$r17, var2674=$r18, var1421=$r19, var1982=$r21, var2180=$r20, var693=$r22, var2984=$r23}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport=var562, r0=var3003, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var682, r1=var1798, java.lang.Throwable=var2009, $r7=var1191, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3337, org.apache.dubbo.metadata.report.support.AbstractMetadataReport=var2209, $r9=var1869, $r8=var2963, $r10=var2523, java.lang.Object=var2942, $r11=var781, $r13=var729, $r12=var2907, $r14=var1778, $r15=var2308, "1-37"=var3000, ""=var3399, java.lang.RuntimeException=var1761, $r16=var3344, $r17=var3415, $r18=var2674, $r19=var1421, $r21=var1982, $r20=var2180, $r22=var693, $r23=var2984}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier;	$r7 := @caughtexception;	$r9 = r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to remove ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from nacos , cause: ");	$r12 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-37", "", "", $r15, $r7);	$r16 = new java.lang.RuntimeException;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to remove ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from nacos , cause: ");	$r20 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>();	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r16.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r23, $r7);	throw $r16
;block_num 2