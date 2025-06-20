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

(declare-sort var2726 0)
(declare-sort var3538 0)
(declare-sort var3189 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideWithConfigurator/349125161 (var2726 var3538) var3538)
(declare-fun hasParameter/1395508799 (var3538 String) Bool)
(declare-fun getAnyMethodParameter/748481455 (var3538 String) String)
(declare-fun getPath/898047937 (var3538) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var2726 var2726)
(declare-const null-var3538 var3538)
(declare-const null-String String)
(declare-const var2231 var2726) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var2231 null-var2726)))
(declare-const var3657 var3538) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3657 null-var3538)))
(define-const var1977 Bool false) ; Statement: $z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert (not (= (ite var1977 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2277 var3538 (overrideWithConfigurator/349125161 var2231 var3657)) ; Statement: r14 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r13) 
 ; Statement: goto [?= $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock")] 
(assert true) ; Non Conditional
(assert true)
(define-const var1988 Bool (hasParameter/1395508799 var2277 "mock")) ; Statement: $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock") 
 ; Statement: if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert (not (not (= (ite var1988 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(assert true)
(define-const var3046 String (getAnyMethodParameter/748481455 var2277 "mock")) ; Statement: $r12 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getAnyMethodParameter(java.lang.String)>("mock") 
 ; Statement: if $r12 == null goto $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (= var3046 null-String)) ; Cond: $r12 == null 
(assert true)
(define-const var3577 String (getPath/898047937 var2277)) ; Statement: $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: if $r17 == null goto $r9 = "dubbo" 
(assert (not (= var3577 null-String))) ; Negate: Cond: $r17 == null  
(assert true)
(define-const var1188 String (getPath/898047937 var2277)) ; Statement: $r11 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var3286 Int (length/-134980193 var1188)) ; Statement: $i2 = virtualinvoke $r11.<java.lang.String: int length()>() 
 ; Statement: if $i2 != 0 goto return r14 
(assert (not (= var3286 0))) ; Cond: $i2 != 0 
 ; Statement: return r14 
(check-sat)
; {overrideWithConfigurator/349125161=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL), hasParameter/1395508799=([org.apache.dubbo.common.URL, java.lang.String], boolean), getAnyMethodParameter/748481455=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var2726=org.apache.dubbo.registry.integration.RegistryDirectory, var2231=r0, var3538=org.apache.dubbo.common.URL, var3657=r13, var1977=$z0, var2277=r14, var1988=$z1, var3046=$r12, var3189=null_type, var3577=$r17, var1188=$r11, var3286=$i2}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var2726, r0=var2231, org.apache.dubbo.common.URL=var3538, r13=var3657, $z0=var1977, r14=var2277, $z1=var1988, $r12=var3046, null_type=var3189, $r17=var3577, $r11=var1188, $i2=var3286}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r13 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	r14 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r13);	goto [?= $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock")];	$z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock");	if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	$r12 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getAnyMethodParameter(java.lang.String)>("mock");	if $r12 == null goto $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	if $r17 == null goto $r9 = "dubbo";	$r11 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$i2 = virtualinvoke $r11.<java.lang.String: int length()>();	if $i2 != 0 goto return r14;	return r14
;block_num 7