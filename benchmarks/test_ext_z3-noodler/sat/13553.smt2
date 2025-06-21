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

(declare-sort var1582 0)
(declare-sort var3790 0)
(declare-sort var3454 0)
(declare-sort var2576 0)
(declare-sort var3157 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun certConfig/617236749 (var1582) var3454)
(declare-fun getOidcTokenPath/-491820027 (var3454) String)
(declare-fun var2576_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3157_warn/1431914100 (var3157 String String String String) void)
(declare-const null-var1582 var1582)
(declare-const null-var3790 var3790)
(declare-const var1582-logger var3157)
(declare-const var2077 var1582) ; Statement: r0 := @this: org.apache.dubbo.security.cert.DubboCertManager 
(assert (not (= var2077 null-var1582)))
(declare-const var558 var3790) ; Statement: r26 := @parameter0: org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub 
(assert (not (= var558 null-var3790)))
(define-const var719 var3454 (certConfig/617236749 var2077)) ; Statement: $r1 = r0.<org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.security.cert.CertConfig certConfig> 
(assert true)
(define-const var1358 String (getOidcTokenPath/-491820027 var719)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.security.cert.CertConfig: java.lang.String getOidcTokenPath()>() 
(define-const var2001 Bool (var2576_isNotEmpty/-1251449450 var1358)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= (ite var2001 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3370 var3157 var1582-logger) ; Statement: $r3 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3157_warn/1431914100 var3370 "5-43" "" "" "Use insecure connection to connect to Dubbo Certificate Authority. Reason: No oidc token is provided.")) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-43", "", "", "Use insecure connection to connect to Dubbo Certificate Authority. Reason: No oidc token is provided.") 

(declare-const var3370!1 var3157)
(declare-const var2169 String)
(declare-const var2119 String)
(declare-const var2119!1 String)
(declare-const var704 String)
(assert true) ; Non Conditional
 ; Statement: return r26 
(check-sat)
; {certConfig/617236749=([org.apache.dubbo.security.cert.DubboCertManager], org.apache.dubbo.security.cert.CertConfig), getOidcTokenPath/-491820027=([org.apache.dubbo.security.cert.CertConfig], java.lang.String), var2576_isNotEmpty/-1251449450=([java.lang.String], boolean), var3157_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var1582=org.apache.dubbo.security.cert.DubboCertManager, var2077=r0, var3790=org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub, var558=r26, var3454=org.apache.dubbo.security.cert.CertConfig, var719=$r1, var1358=r2, var2576=org.apache.dubbo.common.utils.StringUtils, var2001=$z0, var3157=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3370=$r3, var2169="5-43", var2119="", var704="Use insecure connection to connect to Dubbo Certificate Authority. Reason: No oidc token is provided."}
; {org.apache.dubbo.security.cert.DubboCertManager=var1582, r0=var2077, org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub=var3790, r26=var558, org.apache.dubbo.security.cert.CertConfig=var3454, $r1=var719, r2=var1358, org.apache.dubbo.common.utils.StringUtils=var2576, $z0=var2001, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3157, $r3=var3370, "5-43"=var2169, ""=var2119, "Use insecure connection to connect to Dubbo Certificate Authority. Reason: No oidc token is provided."=var704}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.security.cert.DubboCertManager;	r26 := @parameter0: org.apache.dubbo.auth.v1alpha1.DubboCertificateServiceGrpc$DubboCertificateServiceBlockingStub;	$r1 = r0.<org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.security.cert.CertConfig certConfig>;	r2 = virtualinvoke $r1.<org.apache.dubbo.security.cert.CertConfig: java.lang.String getOidcTokenPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r3 = <org.apache.dubbo.security.cert.DubboCertManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-43", "", "", "Use insecure connection to connect to Dubbo Certificate Authority. Reason: No oidc token is provided.");	return r26
;block_num 3