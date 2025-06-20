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

(declare-sort var3903 0)
(declare-sort var306 0)
(declare-sort var2493 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideWithConfigurator/349125161 (var3903 var306) var306)
(declare-fun hasParameter/1395508799 (var306 String) Bool)
(declare-fun getAnyMethodParameter/748481455 (var306 String) String)
(declare-fun getPath/898047937 (var306) String)
(declare-fun getProtocol/491749358 (var306) String)
(declare-const null-var3903 var3903)
(declare-const null-var306 var306)
(declare-const null-String String)
(declare-const var3930 var3903) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var3930 null-var3903)))
(declare-const var1472 var306) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1472 null-var306)))
(define-const var1096 Bool false) ; Statement: $z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert (not (= (ite var1096 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3200 var306 (overrideWithConfigurator/349125161 var3930 var1472)) ; Statement: r14 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r13) 
 ; Statement: goto [?= $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock")] 
(assert true) ; Non Conditional
(assert true)
(define-const var896 Bool (hasParameter/1395508799 var3200 "mock")) ; Statement: $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock") 
 ; Statement: if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert (not (not (= (ite var896 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(assert true)
(define-const var1247 String (getAnyMethodParameter/748481455 var3200 "mock")) ; Statement: $r12 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getAnyMethodParameter(java.lang.String)>("mock") 
 ; Statement: if $r12 == null goto $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (= var1247 null-String)) ; Cond: $r12 == null 
(assert true)
(define-const var576 String (getPath/898047937 var3200)) ; Statement: $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: if $r17 == null goto $r9 = "dubbo" 
(assert (= var576 null-String)) ; Cond: $r17 == null 
(define-const var2959 String "dubbo") ; Statement: $r9 = "dubbo" 
(assert true)
(define-const var2765 String (getProtocol/491749358 var3200)) ; Statement: $r8 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var3145 Bool (= var2959 var2765)) ; Statement: $z2 = virtualinvoke $r9.<java.lang.String: boolean equals(java.lang.Object)>($r8) 
 ; Statement: if $z2 == 0 goto return r14 
(assert (= (ite var3145 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r14 
(check-sat)
; {overrideWithConfigurator/349125161=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL), hasParameter/1395508799=([org.apache.dubbo.common.URL, java.lang.String], boolean), getAnyMethodParameter/748481455=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var3903=org.apache.dubbo.registry.integration.RegistryDirectory, var3930=r0, var306=org.apache.dubbo.common.URL, var1472=r13, var1096=$z0, var3200=r14, var896=$z1, var1247=$r12, var2493=null_type, var576=$r17, var2959=$r9, var2765=$r8, var3145=$z2}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var3903, r0=var3930, org.apache.dubbo.common.URL=var306, r13=var1472, $z0=var1096, r14=var3200, $z1=var896, $r12=var1247, null_type=var2493, $r17=var576, $r9=var2959, $r8=var2765, $z2=var3145}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r13 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	r14 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r13);	goto [?= $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock")];	$z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock");	if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	$r12 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getAnyMethodParameter(java.lang.String)>("mock");	if $r12 == null goto $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	if $r17 == null goto $r9 = "dubbo";	$r9 = "dubbo";	$r8 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z2 = virtualinvoke $r9.<java.lang.String: boolean equals(java.lang.Object)>($r8);	if $z2 == 0 goto return r14;	return r14
;block_num 7