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

(declare-sort var2668 0)
(declare-sort var1356 0)
(declare-sort var3345 0)
(declare-sort var2225 0)
(declare-sort var2639 0)
(declare-sort var2801 0)
(declare-sort var3104 0)
(declare-sort var692 0)
(declare-sort var3134 0)
(declare-sort var1571 0)
(declare-sort var3282 0)
(declare-sort var2088 0)
(declare-sort var2720 0)
(declare-sort var3382 0)
(declare-sort var1981 0)
(declare-sort var3874 0)
(declare-sort var149 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun certConfig/617236749 (var2668) var3345)
(declare-fun getOidcTokenPath/-491820027 (var3345) String)
(declare-fun var2225_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var2639-init () var2639)
(declare-fun <init>/1366563672 (var2639) void)
(declare-fun var3104_of/1830849380 (String var2801) var3104)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var692-init () var692)
(declare-fun <init>/1094691745 (var692 String) void)
(declare-fun var3134_read/1644483142 (var1571) String)
(declare-fun cast-from-var692-to-var1571 (var692) var1571)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun put/1370092758 (var2639 var3104 var3282) void)
(declare-fun cast-from-String-to-var3282 (String) var3282)
(declare-fun arr-var2088-init () (Array Int var2088))
(declare-fun var2720_newAttachHeadersInterceptor/710264778 (var2639) var2088)
(declare-fun withInterceptors/2057365268 (var1981 (Array Int var2088)) var3382)
(declare-fun cast-from-var1356-to-var1981 (var1356) var1981)
(declare-fun cast-from-var3382-to-var1356 (var3382) var1356)
(declare-fun var149_info/484404803 (var149 String) void)
(declare-fun cast-from-var3874-to-var149 (var3874) var149)
(declare-const null-var2668 var2668)
(declare-const null-var1356 var1356)
(declare-const var2639-ASCII_STRING_MARSHALLER var2801)
(declare-const null-__Array__Int__var2088__ (Array Int var2088))
(declare-const var2668-logger var3874)
(declare-const var544 var2668) ; Statement: r0 := @this: org.apache.dubbo.security.cert.DubboCertManager 
(assert (not (= var544 null-var2668)))
(declare-const var3882 var1356) ; Statement: r26 := @parameter0: org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub 
(assert (not (= var3882 null-var1356)))
(define-const var2921 var3345 (certConfig/617236749 var544)) ; Statement: $r1 = r0.<org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.security.cert.CertConfig certConfig> 
(assert true)
(define-const var3064 String (getOidcTokenPath/-491820027 var2921)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.security.cert.CertConfig: java.lang.String getOidcTokenPath()>() 
(define-const var1646 Bool (var2225_isNotEmpty/-1251449450 var3064)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (not (= (ite var1646 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3291 var2639 var2639-init) ; Statement: $r4 = new io.grpc.Metadata 
(assert true)
;(assert (<init>/1366563672 var3291)) ; Statement: specialinvoke $r4.<io.grpc.Metadata: void <init>()>() 

(declare-const var3291!1 var2639)
(define-const var3849 var2801 var2639-ASCII_STRING_MARSHALLER) ; Statement: $r5 = <io.grpc.Metadata: io.grpc.Metadata$AsciiMarshaller ASCII_STRING_MARSHALLER> 
(define-const var2091 var3104 (var3104_of/1830849380 "authorization" var3849)) ; Statement: r6 = staticinvoke <io.grpc.Metadata$Key: io.grpc.Metadata$Key of(java.lang.String,io.grpc.Metadata$AsciiMarshaller)>("authorization", $r5) 
(define-const var2563 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2563)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2563!1 String)
(assert (= var2563!1 ""))
(assert true)
(define-const var902 String (append/672562846 var2563!1 "Bearer ")) ; Statement: $r14 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Bearer ") 
(declare-const var2563!2 String)
(assert (= var2563!2 (str.++ var2563!1 "Bearer ")))
(define-const var1121 var692 var692-init) ; Statement: $r8 = new java.io.FileReader 
(assert true)
;(assert (<init>/1094691745 var1121 var3064)) ; Statement: specialinvoke $r8.<java.io.FileReader: void <init>(java.lang.String)>(r2) 

(declare-const var1121!1 var692)
(declare-const var3064!1 String)
(define-const var3598 String (var3134_read/1644483142 (cast-from-var692-to-var1571 var1121!1))) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.IOUtils: java.lang.String read(java.io.Reader)>($r8) 
(assert true)
(define-const var987 String (replace/2138489945 var3598 (cast-from-String-to-String "\n") (cast-from-String-to-String ""))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", "") 
(assert true)
(define-const var11 String (replace/2138489945 var987 (cast-from-String-to-String "\t") (cast-from-String-to-String ""))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\t", "") 
(assert true)
(define-const var3818 String (replace/2138489945 var11 (cast-from-String-to-String "\r") (cast-from-String-to-String ""))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r", "") 
(assert true)
(define-const var2846 String (trim/-847153721 var3818)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var364 String (append/672562846 var902 var2846)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var902!1 String)
(assert (= var902!1 (str.++ var902 var2846)))
(assert true)
(define-const var3829 String (toString/-2075883882 var364)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (put/1370092758 var3291!1 var2091 (cast-from-String-to-var3282 var3829))) ; Statement: virtualinvoke $r4.<io.grpc.Metadata: void put(io.grpc.Metadata$Key,java.lang.Object)>(r6, $r16) 

(declare-const var3291!2 var2639)
(declare-const var2091!1 var3104)
(declare-const var3829!1 String)
(define-const var1477 (Array Int var2088) arr-var2088-init) ; Statement: $r17 = newarray (io.grpc.ClientInterceptor)[1] 
(define-const var3666 var2088 (var2720_newAttachHeadersInterceptor/710264778 var3291!2)) ; Statement: $r18 = staticinvoke <io.grpc.stub.MetadataUtils: io.grpc.ClientInterceptor newAttachHeadersInterceptor(io.grpc.Metadata)>($r4) 
(declare-const var1477!1 (Array Int var2088))
(assert (not (= var1477!1 null-__Array__Int__var2088__)))
(assert (= (select var1477!1 0) var3666)) ; Statement: $r17[0] = $r18 
(assert true)
(define-const var1412 var3382 (withInterceptors/2057365268 (cast-from-var1356-to-var1981 var3882) var1477!1)) ; Statement: $r19 = virtualinvoke r26.<org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub: io.grpc.stub.AbstractStub withInterceptors(io.grpc.ClientInterceptor[])>($r17) 
(define-const var3882!1 var1356 (cast-from-var3382-to-var1356 var1412)) ; Statement: r26 = (org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub) $r19 
(define-const var1862 var3874 var2668-logger) ; Statement: $r21 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2903 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2903)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2903!1 String)
(assert (= var2903!1 ""))
(assert true)
(define-const var2499 String (append/672562846 var2903!1 "Use oidc token from ")) ; Statement: $r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Use oidc token from ") 
(declare-const var2903!2 String)
(assert (= var2903!2 (str.++ var2903!1 "Use oidc token from ")))
(assert true)
(define-const var2873 String (append/672562846 var2499 var3064!1)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2499!1 String)
(assert (= var2499!1 (str.++ var2499 var3064!1)))
(assert true)
(define-const var2993 String (append/672562846 var2873 " to connect to Dubbo Certificate Authority.")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to connect to Dubbo Certificate Authority.") 
(declare-const var2873!1 String)
(assert (= var2873!1 (str.++ var2873 " to connect to Dubbo Certificate Authority.")))
(assert true)
(define-const var2003 String (toString/-2075883882 var2993)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var149_info/484404803 (cast-from-var3874-to-var149 var1862) var2003)) ; Statement: interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r25) 

(declare-const var1862!1 var3874)
(declare-const var2003!1 String)
 ; Statement: goto [?= return r26] 
(assert true) ; Non Conditional
 ; Statement: return r26 
(check-sat)
; {certConfig/617236749=([org.apache.dubbo.security.cert.DubboCertManager], org.apache.dubbo.security.cert.CertConfig), getOidcTokenPath/-491820027=([org.apache.dubbo.security.cert.CertConfig], java.lang.String), var2225_isNotEmpty/-1251449450=([java.lang.String], boolean), var2639-init=([], io.grpc.Metadata), <init>/1366563672=([io.grpc.Metadata], void), var3104_of/1830849380=([java.lang.String, io.grpc.Metadata$AsciiMarshaller], io.grpc.Metadata$Key), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var692-init=([], java.io.FileReader), <init>/1094691745=([java.io.FileReader, java.lang.String], void), var3134_read/1644483142=([java.io.Reader], java.lang.String), cast-from-var692-to-var1571=([java.io.FileReader], java.io.Reader), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), trim/-847153721=([java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), put/1370092758=([io.grpc.Metadata, io.grpc.Metadata$Key, java.lang.Object], void), cast-from-String-to-var3282=([java.lang.String], java.lang.Object), arr-var2088-init=([], io.grpc.ClientInterceptor[]), var2720_newAttachHeadersInterceptor/710264778=([io.grpc.Metadata], io.grpc.ClientInterceptor), withInterceptors/2057365268=([io.grpc.stub.AbstractBlockingStub, io.grpc.ClientInterceptor[]], io.grpc.stub.AbstractStub), cast-from-var1356-to-var1981=([org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub], io.grpc.stub.AbstractBlockingStub), cast-from-var3382-to-var1356=([io.grpc.stub.AbstractStub], org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub), var149_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var3874-to-var149=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var2668=org.apache.dubbo.security.cert.DubboCertManager, var544=r0, var1356=org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub, var3882=r26, var3345=org.apache.dubbo.security.cert.CertConfig, var2921=$r1, var3064=r2, var2225=org.apache.dubbo.common.utils.StringUtils, var1646=$z0, var2639=io.grpc.Metadata, var3291=$r4, var2801=io.grpc.Metadata$AsciiMarshaller, var3849=$r5, var3104=io.grpc.Metadata$Key, var2091=r6, var2563=$r7, var902=$r14, var692=java.io.FileReader, var1121=$r8, var3134=org.apache.dubbo.common.utils.IOUtils, var1571=java.io.Reader, var3598=$r9, var987=$r10, var11=$r11, var3818=$r12, var2846=$r13, var364=$r15, var3829=$r16, var3282=java.lang.Object, var2088=io.grpc.ClientInterceptor, var1477=$r17, var2720=io.grpc.stub.MetadataUtils, var3666=$r18, var3382=io.grpc.stub.AbstractStub, var1981=io.grpc.stub.AbstractBlockingStub, var1412=$r19, var3874=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1862=$r21, var2903=$r20, var2499=$r22, var2873=$r23, var2993=$r24, var2003=$r25, var149=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.security.cert.DubboCertManager=var2668, r0=var544, org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub=var1356, r26=var3882, org.apache.dubbo.security.cert.CertConfig=var3345, $r1=var2921, r2=var3064, org.apache.dubbo.common.utils.StringUtils=var2225, $z0=var1646, io.grpc.Metadata=var2639, $r4=var3291, io.grpc.Metadata$AsciiMarshaller=var2801, $r5=var3849, io.grpc.Metadata$Key=var3104, r6=var2091, $r7=var2563, $r14=var902, java.io.FileReader=var692, $r8=var1121, org.apache.dubbo.common.utils.IOUtils=var3134, java.io.Reader=var1571, $r9=var3598, $r10=var987, $r11=var11, $r12=var3818, $r13=var2846, $r15=var364, $r16=var3829, java.lang.Object=var3282, io.grpc.ClientInterceptor=var2088, $r17=var1477, io.grpc.stub.MetadataUtils=var2720, $r18=var3666, io.grpc.stub.AbstractStub=var3382, io.grpc.stub.AbstractBlockingStub=var1981, $r19=var1412, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3874, $r21=var1862, $r20=var2903, $r22=var2499, $r23=var2873, $r24=var2993, $r25=var2003, org.apache.dubbo.common.logger.Logger=var149}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 3,"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.security.cert.DubboCertManager;	r26 := @parameter0: org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub;	$r1 = r0.<org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.security.cert.CertConfig certConfig>;	r2 = virtualinvoke $r1.<org.apache.dubbo.security.cert.CertConfig: java.lang.String getOidcTokenPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = new io.grpc.Metadata;	specialinvoke $r4.<io.grpc.Metadata: void <init>()>();	$r5 = <io.grpc.Metadata: io.grpc.Metadata$AsciiMarshaller ASCII_STRING_MARSHALLER>;	r6 = staticinvoke <io.grpc.Metadata$Key: io.grpc.Metadata$Key of(java.lang.String,io.grpc.Metadata$AsciiMarshaller)>("authorization", $r5);	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Bearer ");	$r8 = new java.io.FileReader;	specialinvoke $r8.<java.io.FileReader: void <init>(java.lang.String)>(r2);	$r9 = staticinvoke <org.apache.dubbo.common.utils.IOUtils: java.lang.String read(java.io.Reader)>($r8);	$r10 = virtualinvoke $r9.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", "");	$r11 = virtualinvoke $r10.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\t", "");	$r12 = virtualinvoke $r11.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r", "");	$r13 = virtualinvoke $r12.<java.lang.String: java.lang.String trim()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r4.<io.grpc.Metadata: void put(io.grpc.Metadata$Key,java.lang.Object)>(r6, $r16);	$r17 = newarray (io.grpc.ClientInterceptor)[1];	$r18 = staticinvoke <io.grpc.stub.MetadataUtils: io.grpc.ClientInterceptor newAttachHeadersInterceptor(io.grpc.Metadata)>($r4);	$r17[0] = $r18;	$r19 = virtualinvoke r26.<org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub: io.grpc.stub.AbstractStub withInterceptors(io.grpc.ClientInterceptor[])>($r17);	r26 = (org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub) $r19;	$r21 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Use oidc token from ");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to connect to Dubbo Certificate Authority.");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r25);	goto [?= return r26];	return r26
;block_num 3