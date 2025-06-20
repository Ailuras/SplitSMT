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

(declare-sort var2091 0)
(declare-sort var1946 0)
(declare-sort var303 0)
(declare-sort var893 0)
(declare-sort var283 0)
(declare-sort var885 0)
(declare-sort var1947 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun dubboCertManager/843708561 (var2091) var303)
(declare-fun generateCert/1956075373 (var303) var893)
(declare-fun var283-init () var283)
(declare-fun getCertificate/1752772715 (var893) String)
(declare-fun getBytes/-163691139 (String var885) (Array Int Int))
(declare-fun getPrivateKey/-1412929188 (var893) String)
(declare-fun getTrustCerts/-435626495 (var893) String)
(declare-fun <init>/1932669678 (var283 (Array Int Int) (Array Int Int) (Array Int Int)) void)
(declare-const null-var2091 var2091)
(declare-const null-var1946 var1946)
(declare-const null-var893 var893)
(declare-const var1947-UTF_8 var885)
(declare-const var1377 var2091) ; Statement: r0 := @this: org.apache.dubbo.security.cert.DubboCertProvider 
(assert (not (= var1377 null-var2091)))
(declare-const var1103 var1946) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1103 null-var1946)))
(define-const var1175 var303 (dubboCertManager/843708561 var1377)) ; Statement: $r1 = r0.<org.apache.dubbo.security.cert.DubboCertProvider: org.apache.dubbo.security.cert.DubboCertManager dubboCertManager> 
(assert true)
(define-const var360 var893 (generateCert/1956075373 var1175)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.security.cert.CertPair generateCert()>() 
 ; Statement: if r2 != null goto $r3 = new org.apache.dubbo.common.ssl.Cert 
(assert (not (= var360 null-var893))) ; Cond: r2 != null 
(define-const var3240 var283 var283-init) ; Statement: $r3 = new org.apache.dubbo.common.ssl.Cert 
(assert true)
(define-const var3446 String (getCertificate/1752772715 var360)) ; Statement: $r5 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getCertificate()>() 
(define-const var3246 var885 var1947-UTF_8) ; Statement: $r4 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var1745 (Array Int Int) (getBytes/-163691139 var3446 var3246)) ; Statement: $r12 = virtualinvoke $r5.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r4) 
(assert true)
(define-const var867 String (getPrivateKey/-1412929188 var360)) ; Statement: $r7 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getPrivateKey()>() 
(define-const var1764 var885 var1947-UTF_8) ; Statement: $r6 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var3534 (Array Int Int) (getBytes/-163691139 var867 var1764)) ; Statement: $r11 = virtualinvoke $r7.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r6) 
(assert true)
(define-const var2109 String (getTrustCerts/-435626495 var360)) ; Statement: $r9 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getTrustCerts()>() 
(define-const var3782 var885 var1947-UTF_8) ; Statement: $r8 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var258 (Array Int Int) (getBytes/-163691139 var2109 var3782)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r8) 
(assert true)
;(assert (<init>/1932669678 var3240 var1745 var3534 var258)) ; Statement: specialinvoke $r3.<org.apache.dubbo.common.ssl.Cert: void <init>(byte[],byte[],byte[])>($r12, $r11, $r10) 

(declare-const var3240!1 var283)
(declare-const var1745!1 (Array Int Int))
(declare-const var3534!1 (Array Int Int))
(declare-const var258!1 (Array Int Int))
 ; Statement: return $r3 
(check-sat)
; {dubboCertManager/843708561=([org.apache.dubbo.security.cert.DubboCertProvider], org.apache.dubbo.security.cert.DubboCertManager), generateCert/1956075373=([org.apache.dubbo.security.cert.DubboCertManager], org.apache.dubbo.security.cert.CertPair), var283-init=([], org.apache.dubbo.common.ssl.Cert), getCertificate/1752772715=([org.apache.dubbo.security.cert.CertPair], java.lang.String), getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), getPrivateKey/-1412929188=([org.apache.dubbo.security.cert.CertPair], java.lang.String), getTrustCerts/-435626495=([org.apache.dubbo.security.cert.CertPair], java.lang.String), <init>/1932669678=([org.apache.dubbo.common.ssl.Cert, byte[], byte[], byte[]], void)}
; {var2091=org.apache.dubbo.security.cert.DubboCertProvider, var1377=r0, var1946=org.apache.dubbo.common.URL, var1103=r13, var303=org.apache.dubbo.security.cert.DubboCertManager, var1175=$r1, var893=org.apache.dubbo.security.cert.CertPair, var360=r2, var283=org.apache.dubbo.common.ssl.Cert, var3240=$r3, var3446=$r5, var885=java.nio.charset.Charset, var1947=java.nio.charset.StandardCharsets, var3246=$r4, var1745=$r12, var867=$r7, var1764=$r6, var3534=$r11, var2109=$r9, var3782=$r8, var258=$r10}
; {org.apache.dubbo.security.cert.DubboCertProvider=var2091, r0=var1377, org.apache.dubbo.common.URL=var1946, r13=var1103, org.apache.dubbo.security.cert.DubboCertManager=var303, $r1=var1175, org.apache.dubbo.security.cert.CertPair=var893, r2=var360, org.apache.dubbo.common.ssl.Cert=var283, $r3=var3240, $r5=var3446, java.nio.charset.Charset=var885, java.nio.charset.StandardCharsets=var1947, $r4=var3246, $r12=var1745, $r7=var867, $r6=var1764, $r11=var3534, $r9=var2109, $r8=var3782, $r10=var258}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>;	<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>;	<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 3}
;stmts r0 := @this: org.apache.dubbo.security.cert.DubboCertProvider;	r13 := @parameter0: org.apache.dubbo.common.URL;	$r1 = r0.<org.apache.dubbo.security.cert.DubboCertProvider: org.apache.dubbo.security.cert.DubboCertManager dubboCertManager>;	r2 = virtualinvoke $r1.<org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.security.cert.CertPair generateCert()>();	if r2 != null goto $r3 = new org.apache.dubbo.common.ssl.Cert;	$r3 = new org.apache.dubbo.common.ssl.Cert;	$r5 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getCertificate()>();	$r4 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r12 = virtualinvoke $r5.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r4);	$r7 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getPrivateKey()>();	$r6 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r11 = virtualinvoke $r7.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r6);	$r9 = virtualinvoke r2.<org.apache.dubbo.security.cert.CertPair: java.lang.String getTrustCerts()>();	$r8 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r10 = virtualinvoke $r9.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r8);	specialinvoke $r3.<org.apache.dubbo.common.ssl.Cert: void <init>(byte[],byte[],byte[])>($r12, $r11, $r10);	return $r3
;block_num 2