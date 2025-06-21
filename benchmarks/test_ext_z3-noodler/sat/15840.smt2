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

(declare-sort var3791 0)
(declare-sort var751 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var751) String)
(declare-fun addParameter/-1629709269 (var751 String String) var751)
(declare-fun setProtocol/-9870350 (var751 String) var751)
(declare-const null-var3791 var3791)
(declare-const null-var751 var751)
(declare-const var2587 var3791) ; Statement: r6 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var2587 null-var3791)))
(declare-const var1920 var751) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1920 null-var751)))
(define-const var1081 String "service-discovery-registry") ; Statement: $r2 = "service-discovery-registry" 
(assert true)
(define-const var153 String (getProtocol/491749358 var1920)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2021 Bool (= var1081 var153)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert (= (ite var2021 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1260 String (getProtocol/491749358 var1920)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1339 var751 (addParameter/-1629709269 var1920 "registry" var1260)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("registry", $r3) 
(assert true)
(define-const var3872 var751 (setProtocol/-9870350 var1339 "service-discovery-registry")) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setProtocol(java.lang.String)>("service-discovery-registry") 
 ; Statement: return $r5 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), setProtocol/-9870350=([org.apache.dubbo.common.URL, java.lang.String], org.apache.dubbo.common.URL)}
; {var3791=org.apache.dubbo.registry.integration.RegistryProtocol, var2587=r6, var751=org.apache.dubbo.common.URL, var1920=r0, var1081=$r2, var153=$r1, var2021=$z0, var1260=$r3, var1339=$r4, var3872=$r5}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var3791, r6=var2587, org.apache.dubbo.common.URL=var751, r0=var1920, $r2=var1081, $r1=var153, $z0=var2021, $r3=var1260, $r4=var1339, $r5=var3872}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "service-discovery-registry";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("registry", $r3);	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setProtocol(java.lang.String)>("service-discovery-registry");	return $r5
;block_num 2