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

(declare-sort var3399 0)
(declare-sort var966 0)
(declare-sort var1796 0)
(declare-sort var1599 0)
(declare-sort var482 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var3399) var1796)
(declare-fun getAnyMethodParameter/879007518 (var1796 String) String)
(declare-fun var1599_isNotEmpty/-1251449450 (String) Bool)
(declare-fun originUrl/-420841356 (var3399) var482)
(declare-fun getAnyMethodParameter/2123683513 (var482 String) String)
(declare-const null-var3399 var3399)
(declare-const null-String String)
(declare-const var3585 var3399) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var3585 null-var3399)))
(declare-const var752 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var752 null-String)))
(define-const var405 var1796 (overrideParams/-420841356 var3585)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var2752 String (getAnyMethodParameter/879007518 var405 var752)) ; Statement: r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getAnyMethodParameter(java.lang.String)>(r1) 
(define-const var1310 Bool (var1599_isNotEmpty/-1251449450 var2752)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (= (ite var1310 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2783 var482 (originUrl/-420841356 var3585)) ; Statement: $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert true)
(define-const var3492 String (getAnyMethodParameter/2123683513 var2783 var752)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getAnyMethodParameter(java.lang.String)>(r1) 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getAnyMethodParameter/879007518=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var1599_isNotEmpty/-1251449450=([java.lang.String], boolean), originUrl/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.registry.client.InstanceAddressURL), getAnyMethodParameter/2123683513=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], java.lang.String)}
; {var3399=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var3585=r0, var752=r1, var966=null_type, var1796=org.apache.dubbo.common.url.component.URLParam, var405=$r2, var2752=r3, var1599=org.apache.dubbo.common.utils.StringUtils, var1310=$z0, var482=org.apache.dubbo.registry.client.InstanceAddressURL, var2783=$r4, var3492=$r5}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var3399, r0=var3585, r1=var752, null_type=var966, org.apache.dubbo.common.url.component.URLParam=var1796, $r2=var405, r3=var2752, org.apache.dubbo.common.utils.StringUtils=var1599, $z0=var1310, org.apache.dubbo.registry.client.InstanceAddressURL=var482, $r4=var2783, $r5=var3492}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getAnyMethodParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getAnyMethodParameter(java.lang.String)>(r1);	return $r5
;block_num 3