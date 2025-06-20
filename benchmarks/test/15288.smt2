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

(declare-sort var3400 0)
(declare-sort var1759 0)
(declare-sort var2831 0)
(declare-sort var1880 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRegistryUrl/150982904 (var2831) var1759)
(declare-fun equals/703406941 (var1759 var1880) Bool)
(declare-fun cast-from-var1759-to-var1880 (var1759) var1880)
(declare-fun getProviderUrl/-1489662036 (var2831) var1759)
(declare-fun getProtocol/491749358 (var1759) String)
(declare-fun getRegisterUrl/1216120729 (var3400) var1759)
(declare-const null-var3400 var3400)
(declare-const null-var1759 var1759)
(declare-const null-var2831 var2831)
(declare-const var1000 var3400) ; Statement: r4 := @this: org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper 
(assert (not (= var1000 null-var3400)))
(declare-const var2673 var1759) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2673 null-var1759)))
(declare-const var1234 var2831) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL 
(assert (not (= var1234 null-var2831)))
(assert true)
(define-const var1227 var1759 (getRegistryUrl/150982904 var1234)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL: org.apache.dubbo.common.URL getRegistryUrl()>() 
(assert true)
(define-const var948 Bool (equals/703406941 var1227 (cast-from-var1759-to-var1880 var2673))) ; Statement: $z0 = virtualinvoke $r2.<org.apache.dubbo.common.URL: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (not (= (ite var948 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3603 var1759 (getProviderUrl/-1489662036 var1234)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL: org.apache.dubbo.common.URL getProviderUrl()>() 
(assert true)
(define-const var337 String (getProtocol/491749358 var3603)) ; Statement: $r7 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var3312 var1759 (getRegisterUrl/1216120729 var1000)) ; Statement: $r5 = virtualinvoke r4.<org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper: org.apache.dubbo.common.URL getRegisterUrl()>() 
(assert true)
(define-const var3128 String (getProtocol/491749358 var3312)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1920 Bool (= var337 var3128)) ; Statement: $z1 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>($r6) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (not (= (ite var1920 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var1537 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getRegistryUrl/150982904=([org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL], org.apache.dubbo.common.URL), equals/703406941=([org.apache.dubbo.common.URL, java.lang.Object], boolean), cast-from-var1759-to-var1880=([org.apache.dubbo.common.URL], java.lang.Object), getProviderUrl/-1489662036=([org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getRegisterUrl/1216120729=([org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper], org.apache.dubbo.common.URL)}
; {var3400=org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper, var1000=r4, var1759=org.apache.dubbo.common.URL, var2673=r1, var2831=org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL, var1234=r0, var1227=$r2, var1880=java.lang.Object, var948=$z0, var3603=$r3, var337=$r7, var3312=$r5, var3128=$r6, var1920=$z1, var1537=$z2}
; {org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper=var3400, r4=var1000, org.apache.dubbo.common.URL=var1759, r1=var2673, org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL=var2831, r0=var1234, $r2=var1227, java.lang.Object=var1880, $z0=var948, $r3=var3603, $r7=var337, $r5=var3312, $r6=var3128, $z1=var1920, $z2=var1537}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper;	r1 := @parameter0: org.apache.dubbo.common.URL;	r0 := @parameter1: org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL;	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL: org.apache.dubbo.common.URL getRegistryUrl()>();	$z0 = virtualinvoke $r2.<org.apache.dubbo.common.URL: boolean equals(java.lang.Object)>(r1);	if $z0 == 0 goto $z2 = 0;	$r3 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL: org.apache.dubbo.common.URL getProviderUrl()>();	$r7 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r5 = virtualinvoke r4.<org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper: org.apache.dubbo.common.URL getRegisterUrl()>();	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z1 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>($r6);	if $z1 == 0 goto $z2 = 0;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 4