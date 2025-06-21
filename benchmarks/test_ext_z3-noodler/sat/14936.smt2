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

(declare-sort var2494 0)
(declare-sort var2181 0)
(declare-sort var1805 0)
(declare-sort var1746 0)
(declare-sort var3467 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var2494) var1805)
(declare-fun getParameter/-1177831711 (var1805 String) String)
(declare-fun var1746_isNotEmpty/-1251449450 (String) Bool)
(declare-fun originUrl/-420841356 (var2494) var3467)
(declare-fun getParameter/131558630 (var3467 String) String)
(declare-const null-var2494 var2494)
(declare-const null-String String)
(declare-const var735 var2494) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var735 null-var2494)))
(declare-const var331 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var331 null-String)))
(define-const var339 var1805 (overrideParams/-420841356 var735)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var1514 String (getParameter/-1177831711 var339 var331)) ; Statement: r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1730 Bool (var1746_isNotEmpty/-1251449450 var1514)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (= (ite var1730 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1121 var3467 (originUrl/-420841356 var735)) ; Statement: $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert true)
(define-const var3021 String (getParameter/131558630 var1121 var331)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getParameter(java.lang.String)>(r1) 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getParameter/-1177831711=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var1746_isNotEmpty/-1251449450=([java.lang.String], boolean), originUrl/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.registry.client.InstanceAddressURL), getParameter/131558630=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], java.lang.String)}
; {var2494=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var735=r0, var331=r1, var2181=null_type, var1805=org.apache.dubbo.common.url.component.URLParam, var339=$r2, var1514=r3, var1746=org.apache.dubbo.common.utils.StringUtils, var1730=$z0, var3467=org.apache.dubbo.registry.client.InstanceAddressURL, var1121=$r4, var3021=$r5}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var2494, r0=var735, r1=var331, null_type=var2181, org.apache.dubbo.common.url.component.URLParam=var1805, $r2=var339, r3=var1514, org.apache.dubbo.common.utils.StringUtils=var1746, $z0=var1730, org.apache.dubbo.registry.client.InstanceAddressURL=var3467, $r4=var1121, $r5=var3021}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getParameter(java.lang.String)>(r1);	return $r5
;block_num 3