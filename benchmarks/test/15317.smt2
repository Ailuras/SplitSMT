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

(declare-sort var1054 0)
(declare-sort var2421 0)
(declare-sort var3275 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideWithConfigurator/349125161 (var1054 var2421) var2421)
(declare-fun hasParameter/1395508799 (var2421 String) Bool)
(declare-fun removeParameter/-1301002585 (var2421 String) var2421)
(declare-fun getPath/898047937 (var2421) String)
(declare-fun getProtocol/491749358 (var2421) String)
(declare-const null-var1054 var1054)
(declare-const null-var2421 var2421)
(declare-const null-String String)
(declare-const var2071 var1054) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var2071 null-var1054)))
(declare-const var2723 var2421) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2723 null-var2421)))
(define-const var3339 Bool false) ; Statement: $z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert (not (= (ite var3339 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3966 var2421 (overrideWithConfigurator/349125161 var2071 var2723)) ; Statement: r14 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r13) 
 ; Statement: goto [?= $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock")] 
(assert true) ; Non Conditional
(assert true)
(define-const var3466 Bool (hasParameter/1395508799 var3966 "mock")) ; Statement: $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock") 
 ; Statement: if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert (not (= (ite var3466 1 0) 0))) ; Cond: $z1 != 0 
(assert true)
(define-const var3966!1 var2421 (removeParameter/-1301002585 var3966 "mock")) ; Statement: r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert true) ; Non Conditional
(assert true)
(define-const var2152 String (getPath/898047937 var3966!1)) ; Statement: $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: if $r17 == null goto $r9 = "dubbo" 
(assert (= var2152 null-String)) ; Cond: $r17 == null 
(define-const var3545 String "dubbo") ; Statement: $r9 = "dubbo" 
(assert true)
(define-const var1741 String (getProtocol/491749358 var3966!1)) ; Statement: $r8 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2296 Bool (= var3545 var1741)) ; Statement: $z2 = virtualinvoke $r9.<java.lang.String: boolean equals(java.lang.Object)>($r8) 
 ; Statement: if $z2 == 0 goto return r14 
(assert (= (ite var2296 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r14 
(check-sat)
; {overrideWithConfigurator/349125161=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL), hasParameter/1395508799=([org.apache.dubbo.common.URL, java.lang.String], boolean), removeParameter/-1301002585=([org.apache.dubbo.common.URL, java.lang.String], org.apache.dubbo.common.URL), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1054=org.apache.dubbo.registry.integration.RegistryDirectory, var2071=r0, var2421=org.apache.dubbo.common.URL, var2723=r13, var3339=$z0, var3966=r14, var3466=$z1, var2152=$r17, var3275=null_type, var3545=$r9, var1741=$r8, var2296=$z2}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var1054, r0=var2071, org.apache.dubbo.common.URL=var2421, r13=var2723, $z0=var3339, r14=var3966, $z1=var3466, $r17=var2152, null_type=var3275, $r9=var3545, $r8=var1741, $z2=var2296}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r13 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	r14 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r13);	goto [?= $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock")];	$z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock");	if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	$r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	if $r17 == null goto $r9 = "dubbo";	$r9 = "dubbo";	$r8 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z2 = virtualinvoke $r9.<java.lang.String: boolean equals(java.lang.Object)>($r8);	if $z2 == 0 goto return r14;	return r14
;block_num 7