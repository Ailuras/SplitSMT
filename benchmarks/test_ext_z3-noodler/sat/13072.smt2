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

(declare-sort var3353 0)
(declare-sort var2737 0)
(declare-sort var1503 0)
(declare-sort var1941 0)
(declare-sort var3274 0)
(declare-sort var3930 0)
(declare-sort var316 0)
(declare-sort var33 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun dubboCertManager/843708561 (var3353) var1503)
(declare-fun generateCert/1956075373 (var1503) var1941)
(declare-fun var3274-init () var3274)
(declare-fun getCertificate/1752772715 (var1941) String)
(declare-fun getBytes/-163691139 (String var3930) (Array Int Int))
(declare-fun getPrivateKey/-1412929188 (var1941) String)
(declare-fun getTrustCerts/-435626495 (var1941) String)
(declare-fun <init>/1944697712 (var3274 (Array Int Int) (Array Int Int) (Array Int Int) var33) void)
(declare-const null-var3353 var3353)
(declare-const null-var2737 var2737)
(declare-const null-var1941 var1941)
(declare-const var316-UTF_8 var3930)
(declare-const var33-NONE var33)
(declare-const var2621 var3353) ; Statement: r0 := @this: org.apache.dubbo.security.cert.DubboCertProvider 
(assert (not (= var2621 null-var3353)))
(declare-const var1302 var2737) ; Statement: r14 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1302 null-var2737)))
(define-const var3608 var1503 (dubboCertManager/843708561 var2621)) ; Statement: $r1 = r0.<org.apache.dubbo.security.cert.DubboCertProvider: org.apache.dubbo.security.cert.DubboCertManager dubboCertManager> 
(assert true)
(define-const var1582 var1941 (generateCert/1956075373 var3608)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.security.cert.CertPair generateCert()>() 
 ; Statement: if r2 != null goto $r3 = new org.apache.dubbo.common.ssl.ProviderCert 
(assert (not (= var1582 null-var1941))) ; Cond: r2 != null 
(define-const var1696 var3274 var3274-init) ; Statement: $r3 = new org.apache.dubbo.common.ssl.ProviderCert 
(assert true)
(define-const var3786 String (getCertificate/1752772715 var1582)) ; Statement: $r5 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getCertificate()>() 
(define-const var1823 var3930 var316-UTF_8) ; Statement: $r4 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var2056 (Array Int Int) (getBytes/-163691139 var3786 var1823)) ; Statement: $r13 = virtualinvoke $r5.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r4) 
(assert true)
(define-const var2296 String (getPrivateKey/-1412929188 var1582)) ; Statement: $r7 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getPrivateKey()>() 
(define-const var195 var3930 var316-UTF_8) ; Statement: $r6 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var3713 (Array Int Int) (getBytes/-163691139 var2296 var195)) ; Statement: $r12 = virtualinvoke $r7.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r6) 
(assert true)
(define-const var1552 String (getTrustCerts/-435626495 var1582)) ; Statement: $r9 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getTrustCerts()>() 
(define-const var2138 var3930 var316-UTF_8) ; Statement: $r8 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var2391 (Array Int Int) (getBytes/-163691139 var1552 var2138)) ; Statement: $r11 = virtualinvoke $r9.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r8) 
(define-const var3256 var33 var33-NONE) ; Statement: $r10 = <org.apache.dubbo.common.ssl.AuthPolicy: org.apache.dubbo.common.ssl.AuthPolicy NONE> 
(assert true)
;(assert (<init>/1944697712 var1696 var2056 var3713 var2391 var3256)) ; Statement: specialinvoke $r3.<org.apache.dubbo.common.ssl.ProviderCert: void <init>(byte[],byte[],byte[],org.apache.dubbo.common.ssl.AuthPolicy)>($r13, $r12, $r11, $r10) 

(declare-const var1696!1 var3274)
(declare-const var2056!1 (Array Int Int))
(declare-const var3713!1 (Array Int Int))
(declare-const var2391!1 (Array Int Int))
(declare-const var3256!1 var33)
 ; Statement: return $r3 
(check-sat)
; {dubboCertManager/843708561=([org.apache.dubbo.security.cert.DubboCertProvider], org.apache.dubbo.security.cert.DubboCertManager), generateCert/1956075373=([org.apache.dubbo.security.cert.DubboCertManager], org.apache.dubbo.security.cert.CertPair), var3274-init=([], org.apache.dubbo.common.ssl.ProviderCert), getCertificate/1752772715=([org.apache.dubbo.security.cert.CertPair], java.lang.String), getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), getPrivateKey/-1412929188=([org.apache.dubbo.security.cert.CertPair], java.lang.String), getTrustCerts/-435626495=([org.apache.dubbo.security.cert.CertPair], java.lang.String), <init>/1944697712=([org.apache.dubbo.common.ssl.ProviderCert, byte[], byte[], byte[], org.apache.dubbo.common.ssl.AuthPolicy], void)}
; {var3353=org.apache.dubbo.security.cert.DubboCertProvider, var2621=r0, var2737=org.apache.dubbo.common.URL, var1302=r14, var1503=org.apache.dubbo.security.cert.DubboCertManager, var3608=$r1, var1941=org.apache.dubbo.security.cert.CertPair, var1582=r2, var3274=org.apache.dubbo.common.ssl.ProviderCert, var1696=$r3, var3786=$r5, var3930=java.nio.charset.Charset, var316=java.nio.charset.StandardCharsets, var1823=$r4, var2056=$r13, var2296=$r7, var195=$r6, var3713=$r12, var1552=$r9, var2138=$r8, var2391=$r11, var33=org.apache.dubbo.common.ssl.AuthPolicy, var3256=$r10}
; {org.apache.dubbo.security.cert.DubboCertProvider=var3353, r0=var2621, org.apache.dubbo.common.URL=var2737, r14=var1302, org.apache.dubbo.security.cert.DubboCertManager=var1503, $r1=var3608, org.apache.dubbo.security.cert.CertPair=var1941, r2=var1582, org.apache.dubbo.common.ssl.ProviderCert=var3274, $r3=var1696, $r5=var3786, java.nio.charset.Charset=var3930, java.nio.charset.StandardCharsets=var316, $r4=var1823, $r13=var2056, $r7=var2296, $r6=var195, $r12=var3713, $r9=var1552, $r8=var2138, $r11=var2391, org.apache.dubbo.common.ssl.AuthPolicy=var33, $r10=var3256}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>;	<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>;	<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 3}
;stmts r0 := @this: org.apache.dubbo.security.cert.DubboCertProvider;	r14 := @parameter0: org.apache.dubbo.common.URL;	$r1 = r0.<org.apache.dubbo.security.cert.DubboCertProvider: org.apache.dubbo.security.cert.DubboCertManager dubboCertManager>;	r2 = virtualinvoke $r1.<org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.security.cert.CertPair generateCert()>();	if r2 != null goto $r3 = new org.apache.dubbo.common.ssl.ProviderCert;	$r3 = new org.apache.dubbo.common.ssl.ProviderCert;	$r5 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getCertificate()>();	$r4 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r13 = virtualinvoke $r5.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r4);	$r7 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getPrivateKey()>();	$r6 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r12 = virtualinvoke $r7.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r6);	$r9 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getTrustCerts()>();	$r8 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r11 = virtualinvoke $r9.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r8);	$r10 = <org.apache.dubbo.common.ssl.AuthPolicy: org.apache.dubbo.common.ssl.AuthPolicy NONE>;	specialinvoke $r3.<org.apache.dubbo.common.ssl.ProviderCert: void <init>(byte[],byte[],byte[],org.apache.dubbo.common.ssl.AuthPolicy)>($r13, $r12, $r11, $r10);	return $r3
;block_num 2