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

(declare-sort var3141 0)
(declare-sort var2626 0)
(declare-sort var646 0)
(declare-sort var437 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRegistryUrl/150982904 (var646) var2626)
(declare-fun equals/703406941 (var2626 var437) Bool)
(declare-fun cast-from-var2626-to-var437 (var2626) var437)
(declare-fun getProviderUrl/-1489662036 (var646) var2626)
(declare-fun getProtocol/491749358 (var2626) String)
(declare-fun getRegisterUrl/1216120729 (var3141) var2626)
(declare-const null-var3141 var3141)
(declare-const null-var2626 var2626)
(declare-const null-var646 var646)
(declare-const var3490 var3141) ; Statement: r4 := @this: org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper 
(assert (not (= var3490 null-var3141)))
(declare-const var1486 var2626) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1486 null-var2626)))
(declare-const var1086 var646) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL 
(assert (not (= var1086 null-var646)))
(assert true)
(define-const var2831 var2626 (getRegistryUrl/150982904 var1086)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL: org.apache.dubbo.common.URL getRegistryUrl()>() 
(assert true)
(define-const var3800 Bool (equals/703406941 var2831 (cast-from-var2626-to-var437 var1486))) ; Statement: $z0 = virtualinvoke $r2.<org.apache.dubbo.common.URL: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (not (= (ite var3800 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var49 var2626 (getProviderUrl/-1489662036 var1086)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL: org.apache.dubbo.common.URL getProviderUrl()>() 
(assert true)
(define-const var3014 String (getProtocol/491749358 var49)) ; Statement: $r7 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2481 var2626 (getRegisterUrl/1216120729 var3490)) ; Statement: $r5 = virtualinvoke r4.<org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper: org.apache.dubbo.common.URL getRegisterUrl()>() 
(assert true)
(define-const var987 String (getProtocol/491749358 var2481)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1628 Bool (= var3014 var987)) ; Statement: $z1 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>($r6) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var1628 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3847 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getRegistryUrl/150982904=([org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL], org.apache.dubbo.common.URL), equals/703406941=([org.apache.dubbo.common.URL, java.lang.Object], boolean), cast-from-var2626-to-var437=([org.apache.dubbo.common.URL], java.lang.Object), getProviderUrl/-1489662036=([org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getRegisterUrl/1216120729=([org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper], org.apache.dubbo.common.URL)}
; {var3141=org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper, var3490=r4, var2626=org.apache.dubbo.common.URL, var1486=r1, var646=org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL, var1086=r0, var2831=$r2, var437=java.lang.Object, var3800=$z0, var49=$r3, var3014=$r7, var2481=$r5, var987=$r6, var1628=$z1, var3847=$z2}
; {org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper=var3141, r4=var3490, org.apache.dubbo.common.URL=var2626, r1=var1486, org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL=var646, r0=var1086, $r2=var2831, java.lang.Object=var437, $z0=var3800, $r3=var49, $r7=var3014, $r5=var2481, $r6=var987, $z1=var1628, $z2=var3847}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper;	r1 := @parameter0: org.apache.dubbo.common.URL;	r0 := @parameter1: org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL;	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL: org.apache.dubbo.common.URL getRegistryUrl()>();	$z0 = virtualinvoke $r2.<org.apache.dubbo.common.URL: boolean equals(java.lang.Object)>(r1);	if $z0 == 0 goto $z2 = 0;	$r3 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel$RegisterStatedURL: org.apache.dubbo.common.URL getProviderUrl()>();	$r7 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r5 = virtualinvoke r4.<org.apache.dubbo.registry.integration.RegistryProtocol$ExporterChangeableWrapper: org.apache.dubbo.common.URL getRegisterUrl()>();	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z1 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>($r6);	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 4