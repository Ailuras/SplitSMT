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

(declare-sort var3728 0)
(declare-sort var529 0)
(declare-sort var426 0)
(declare-sort var2968 0)
(declare-sort var1869 0)
(declare-sort var2241 0)
(declare-sort var3592 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCaCertPath/-1887476343 (var529) String)
(declare-fun getRemoteAddress/-1167139716 (var529) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2968_info/484404803 (var2968 String) void)
(declare-fun cast-from-var426-to-var2968 (var426) var2968)
(declare-fun var426_error/377575788 (var426 String String String String var2241) void)
(declare-fun cast-from-var1869-to-var2241 (var1869) var2241)
(declare-fun var3592-init () var3592)
(declare-fun <init>/-1645845558 (var3592 var2241) void)
(declare-const null-var3728 var3728)
(declare-const null-var529 var529)
(declare-const var3728-logger var426)
(declare-const null-var1869 var1869)
(declare-const var1303 var3728) ; Statement: r11 := @this: org.apache.dubbo.security.cert.DubboCertManager 
(assert (not (= var1303 null-var3728)))
(declare-const var371 var529) ; Statement: r0 := @parameter0: org.apache.dubbo.security.cert.CertConfig 
(assert (not (= var371 null-var529)))
(assert true)
(define-const var3811 String (getCaCertPath/-1887476343 var371)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.security.cert.CertConfig: java.lang.String getCaCertPath()>() 
(assert true)
(define-const var377 String (getRemoteAddress/-1167139716 var371)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.security.cert.CertConfig: java.lang.String getRemoteAddress()>() 
(define-const var1340 var426 var3728-logger) ; Statement: $r4 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1700 String String-init) ; Statement: $r29 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1700)) ; Statement: specialinvoke $r29.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1700!1 String)
(assert (= var1700!1 ""))
(assert true)
(define-const var2158 String (append/672562846 var1700!1 "Try to connect to Dubbo Cert Authority server: ")) ; Statement: $r5 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Try to connect to Dubbo Cert Authority server: ") 
(declare-const var1700!2 String)
(assert (= var1700!2 (str.++ var1700!1 "Try to connect to Dubbo Cert Authority server: ")))
(assert true)
(define-const var677 String (append/672562846 var2158 var377)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2158!1 String)
(assert (= var2158!1 (str.++ var2158 var377)))
(assert true)
(define-const var1726 String (append/672562846 var677 ", caCertPath: ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", caCertPath: ") 
(declare-const var677!1 String)
(assert (= var677!1 (str.++ var677 ", caCertPath: ")))
(assert true)
(define-const var3492 String (append/672562846 var1726 var377)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1726!1 String)
(assert (= var1726!1 (str.++ var1726 var377)))
(assert true)
(define-const var1076 String (toString/-2075883882 var3492)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2968_info/484404803 (cast-from-var426-to-var2968 var1340) var1076)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r9) 

(declare-const var1340!1 var426)
(declare-const var1076!1 String)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1709 var1869) ; Statement: $r26 := @caughtexception 
(assert (not (= var1709 null-var1869)))
(define-const var1054 var426 var3728-logger) ; Statement: $r27 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var426_error/377575788 var1054 "5-41" "" "" "Failed to load SSL cert file." (cast-from-var1869-to-var2241 var1709))) ; Statement: interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-41", "", "", "Failed to load SSL cert file.", $r26) 

(declare-const var1054!1 var426)
(declare-const var673 String)
(declare-const var2084 String)
(declare-const var2084!1 String)
(declare-const var3797 String)
(declare-const var1709!1 var1869)
(define-const var3585 var3592 var3592-init) ; Statement: $r31 = new java.lang.RuntimeException 
(assert true)
;(assert (<init>/-1645845558 var3585 (cast-from-var1869-to-var2241 var1709!1))) ; Statement: specialinvoke $r31.<java.lang.RuntimeException: void <init>(java.lang.Throwable)>($r26) 

(declare-const var3585!1 var3592)
(declare-const var1709!2 var1869)
 ; Statement: throw $r31 
(check-sat)
; {getCaCertPath/-1887476343=([org.apache.dubbo.security.cert.CertConfig], java.lang.String), getRemoteAddress/-1167139716=([org.apache.dubbo.security.cert.CertConfig], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2968_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var426-to-var2968=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var426_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var1869-to-var2241=([java.lang.Exception], java.lang.Throwable), var3592-init=([], java.lang.RuntimeException), <init>/-1645845558=([java.lang.RuntimeException, java.lang.Throwable], void)}
; {var3728=org.apache.dubbo.security.cert.DubboCertManager, var1303=r11, var529=org.apache.dubbo.security.cert.CertConfig, var371=r0, var3811=r1, var377=r2, var426=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1340=$r4, var1700=$r29, var2158=$r5, var677=$r6, var1726=$r7, var3492=$r8, var1076=$r9, var2968=org.apache.dubbo.common.logger.Logger, var1869=java.lang.Exception, var1709=$r26, var1054=$r27, var2241=java.lang.Throwable, var673="5-41", var2084="", var3797="Failed to load SSL cert file.", var3592=java.lang.RuntimeException, var3585=$r31}
; {org.apache.dubbo.security.cert.DubboCertManager=var3728, r11=var1303, org.apache.dubbo.security.cert.CertConfig=var529, r0=var371, r1=var3811, r2=var377, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var426, $r4=var1340, $r29=var1700, $r5=var2158, $r6=var677, $r7=var1726, $r8=var3492, $r9=var1076, org.apache.dubbo.common.logger.Logger=var2968, java.lang.Exception=var1869, $r26=var1709, $r27=var1054, java.lang.Throwable=var2241, "5-41"=var673, ""=var2084, "Failed to load SSL cert file."=var3797, java.lang.RuntimeException=var3592, $r31=var3585}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r11 := @this: org.apache.dubbo.security.cert.DubboCertManager;	r0 := @parameter0: org.apache.dubbo.security.cert.CertConfig;	r1 = virtualinvoke r0.<org.apache.dubbo.security.cert.CertConfig: java.lang.String getCaCertPath()>();	r2 = virtualinvoke r0.<org.apache.dubbo.security.cert.CertConfig: java.lang.String getRemoteAddress()>();	$r4 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r29 = new java.lang.StringBuilder;	specialinvoke $r29.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Try to connect to Dubbo Cert Authority server: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", caCertPath: ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r9);	$r26 := @caughtexception;	$r27 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-41", "", "", "Failed to load SSL cert file.", $r26);	$r31 = new java.lang.RuntimeException;	specialinvoke $r31.<java.lang.RuntimeException: void <init>(java.lang.Throwable)>($r26);	throw $r31
;block_num 2