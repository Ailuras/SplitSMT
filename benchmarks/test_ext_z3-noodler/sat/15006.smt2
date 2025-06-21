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

(declare-sort var477 0)
(declare-sort var1654 0)
(declare-sort var1820 0)
(declare-sort var3325 0)
(declare-sort var1989 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var477) var1820)
(declare-fun getMethodParameter/1573524985 (var1820 String String) String)
(declare-fun var3325_isNotEmpty/-1251449450 (String) Bool)
(declare-fun originUrl/-420841356 (var477) var1989)
(declare-fun getServiceMethodParameter/1908992162 (var1989 String String String) String)
(declare-const null-var477 var477)
(declare-const null-String String)
(declare-const var3563 var477) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var3563 null-var477)))
(declare-const var842 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var842 null-String)))
(declare-const var3077 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3077 null-String)))
(declare-const var3176 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var3176 null-String)))
(define-const var616 var1820 (overrideParams/-420841356 var3563)) ; Statement: $r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var3804 String (getMethodParameter/1573524985 var616 var3077 var3176)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1686 Bool (var3325_isNotEmpty/-1251449450 var3804)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r6 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (= (ite var1686 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2347 var1989 (originUrl/-420841356 var3563)) ; Statement: $r6 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert true)
(define-const var2036 String (getServiceMethodParameter/1908992162 var2347 var842 var3077 var3176)) ; Statement: $r7 = virtualinvoke $r6.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r5, r1, r2) 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getMethodParameter/1573524985=([org.apache.dubbo.common.url.component.URLParam, java.lang.String, java.lang.String], java.lang.String), var3325_isNotEmpty/-1251449450=([java.lang.String], boolean), originUrl/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.registry.client.InstanceAddressURL), getServiceMethodParameter/1908992162=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var477=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var3563=r0, var842=r5, var1654=null_type, var3077=r1, var3176=r2, var1820=org.apache.dubbo.common.url.component.URLParam, var616=$r3, var3804=r4, var3325=org.apache.dubbo.common.utils.StringUtils, var1686=$z0, var1989=org.apache.dubbo.registry.client.InstanceAddressURL, var2347=$r6, var2036=$r7}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var477, r0=var3563, r5=var842, null_type=var1654, r1=var3077, r2=var3176, org.apache.dubbo.common.url.component.URLParam=var1820, $r3=var616, r4=var3804, org.apache.dubbo.common.utils.StringUtils=var3325, $z0=var1686, org.apache.dubbo.registry.client.InstanceAddressURL=var1989, $r6=var2347, $r7=var2036}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r5 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r6 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r6 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r7 = virtualinvoke $r6.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r5, r1, r2);	return $r7
;block_num 3