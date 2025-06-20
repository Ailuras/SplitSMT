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

(declare-sort var2345 0)
(declare-sort var3985 0)
(declare-sort var3527 0)
(declare-sort var580 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var2345) var3527)
(declare-fun getAnyMethodParameter/879007518 (var3527 String) String)
(declare-fun var580_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2345 var2345)
(declare-const null-String String)
(declare-const var315 var2345) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var315 null-var2345)))
(declare-const var2500 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2500 null-String)))
(define-const var2902 var3527 (overrideParams/-420841356 var315)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var119 String (getAnyMethodParameter/879007518 var2902 var2500)) ; Statement: r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getAnyMethodParameter(java.lang.String)>(r1) 
(define-const var1807 Bool (var580_isNotEmpty/-1251449450 var119)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (not (= (ite var1807 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2560 String var119) ; Statement: $r5 = r3 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getAnyMethodParameter/879007518=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var580_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2345=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var315=r0, var2500=r1, var3985=null_type, var3527=org.apache.dubbo.common.url.component.URLParam, var2902=$r2, var119=r3, var580=org.apache.dubbo.common.utils.StringUtils, var1807=$z0, var2560=$r5}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var2345, r0=var315, r1=var2500, null_type=var3985, org.apache.dubbo.common.url.component.URLParam=var3527, $r2=var2902, r3=var119, org.apache.dubbo.common.utils.StringUtils=var580, $z0=var1807, $r5=var2560}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getAnyMethodParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r5 = r3;	goto [?= return $r5];	return $r5
;block_num 3