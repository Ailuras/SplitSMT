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

(declare-sort var2292 0)
(declare-sort var1132 0)
(declare-sort var1112 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideWithConfigurator/349125161 (var2292 var1132) var1132)
(declare-fun hasParameter/1395508799 (var1132 String) Bool)
(declare-fun removeParameter/-1301002585 (var1132 String) var1132)
(declare-fun getPath/898047937 (var1132) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var2292 var2292)
(declare-const null-var1132 var1132)
(declare-const null-String String)
(declare-const var3731 var2292) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var3731 null-var2292)))
(declare-const var2802 var1132) ; Statement: r13 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2802 null-var1132)))
(define-const var3263 Bool false) ; Statement: $z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert (not (= (ite var3263 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3592 var1132 (overrideWithConfigurator/349125161 var3731 var2802)) ; Statement: r14 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r13) 
 ; Statement: goto [?= $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock")] 
(assert true) ; Non Conditional
(assert true)
(define-const var1912 Bool (hasParameter/1395508799 var3592 "mock")) ; Statement: $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock") 
 ; Statement: if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert (not (= (ite var1912 1 0) 0))) ; Cond: $z1 != 0 
(assert true)
(define-const var3592!1 var1132 (removeParameter/-1301002585 var3592 "mock")) ; Statement: r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock") 
(assert true) ; Non Conditional
(assert true)
(define-const var2885 String (getPath/898047937 var3592!1)) ; Statement: $r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: if $r17 == null goto $r9 = "dubbo" 
(assert (not (= var2885 null-String))) ; Negate: Cond: $r17 == null  
(assert true)
(define-const var2340 String (getPath/898047937 var3592!1)) ; Statement: $r11 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var1282 Int (length/-134980193 var2340)) ; Statement: $i2 = virtualinvoke $r11.<java.lang.String: int length()>() 
 ; Statement: if $i2 != 0 goto return r14 
(assert (not (= var1282 0))) ; Cond: $i2 != 0 
 ; Statement: return r14 
(check-sat)
; {overrideWithConfigurator/349125161=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], org.apache.dubbo.common.URL), hasParameter/1395508799=([org.apache.dubbo.common.URL, java.lang.String], boolean), removeParameter/-1301002585=([org.apache.dubbo.common.URL, java.lang.String], org.apache.dubbo.common.URL), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var2292=org.apache.dubbo.registry.integration.RegistryDirectory, var3731=r0, var1132=org.apache.dubbo.common.URL, var2802=r13, var3263=$z0, var3592=r14, var1912=$z1, var2885=$r17, var1112=null_type, var2340=$r11, var1282=$i2}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var2292, r0=var3731, org.apache.dubbo.common.URL=var1132, r13=var2802, $z0=var3263, r14=var3592, $z1=var1912, $r17=var2885, null_type=var1112, $r11=var2340, $i2=var1282}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r13 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r13 instanceof org.apache.dubbo.common.url.component.ServiceAddressURL;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	r14 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL overrideWithConfigurator(org.apache.dubbo.common.URL)>(r13);	goto [?= $z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock")];	$z1 = virtualinvoke r14.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("mock");	if $z1 != 0 goto r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	r14 = virtualinvoke r14.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL removeParameter(java.lang.String)>("mock");	$r17 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	if $r17 == null goto $r9 = "dubbo";	$r11 = virtualinvoke r14.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$i2 = virtualinvoke $r11.<java.lang.String: int length()>();	if $i2 != 0 goto return r14;	return r14
;block_num 7