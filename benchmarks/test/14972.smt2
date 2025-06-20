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

(declare-sort var822 0)
(declare-sort var3360 0)
(declare-sort var2245 0)
(declare-sort var1115 0)
(declare-sort var2001 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var822) var2245)
(declare-fun getParameter/-1177831711 (var2245 String) String)
(declare-fun var1115_isNotEmpty/-1251449450 (String) Bool)
(declare-fun originUrl/-420841356 (var822) var2001)
(declare-fun getServiceParameter/-1044179462 (var2001 String String) String)
(declare-const null-var822 var822)
(declare-const null-String String)
(declare-const var1001 var822) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var1001 null-var822)))
(declare-const var1698 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var1698 null-String)))
(declare-const var3080 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3080 null-String)))
(define-const var3519 var2245 (overrideParams/-420841356 var1001)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var340 String (getParameter/-1177831711 var3519 var3080)) ; Statement: r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3186 Bool (var1115_isNotEmpty/-1251449450 var340)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (= (ite var3186 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2760 var2001 (originUrl/-420841356 var1001)) ; Statement: $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert true)
(define-const var3971 String (getServiceParameter/-1044179462 var2760 var1698 var3080)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r4, r1) 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getParameter/-1177831711=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var1115_isNotEmpty/-1251449450=([java.lang.String], boolean), originUrl/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.registry.client.InstanceAddressURL), getServiceParameter/-1044179462=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String, java.lang.String], java.lang.String)}
; {var822=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var1001=r0, var1698=r4, var3360=null_type, var3080=r1, var2245=org.apache.dubbo.common.url.component.URLParam, var3519=$r2, var340=r3, var1115=org.apache.dubbo.common.utils.StringUtils, var3186=$z0, var2001=org.apache.dubbo.registry.client.InstanceAddressURL, var2760=$r5, var3971=$r6}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var822, r0=var1001, r4=var1698, null_type=var3360, r1=var3080, org.apache.dubbo.common.url.component.URLParam=var2245, $r2=var3519, r3=var340, org.apache.dubbo.common.utils.StringUtils=var1115, $z0=var3186, org.apache.dubbo.registry.client.InstanceAddressURL=var2001, $r5=var2760, $r6=var3971}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r4 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r4, r1);	return $r6
;block_num 3