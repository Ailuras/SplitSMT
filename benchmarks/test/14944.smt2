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

(declare-sort var2185 0)
(declare-sort var3921 0)
(declare-sort var3816 0)
(declare-sort var2881 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var2185) var3816)
(declare-fun getParameter/-1177831711 (var3816 String) String)
(declare-fun var2881_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2185 var2185)
(declare-const null-String String)
(declare-const var2184 var2185) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var2184 null-var2185)))
(declare-const var492 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var492 null-String)))
(declare-const var686 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var686 null-String)))
(define-const var285 var3816 (overrideParams/-420841356 var2184)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var590 String (getParameter/-1177831711 var285 var686)) ; Statement: r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3702 Bool (var2881_isNotEmpty/-1251449450 var590)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (not (= (ite var3702 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3089 String var590) ; Statement: $r6 = r3 
 ; Statement: goto [?= return $r6] 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getParameter/-1177831711=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var2881_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2185=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var2184=r0, var492=r4, var3921=null_type, var686=r1, var3816=org.apache.dubbo.common.url.component.URLParam, var285=$r2, var590=r3, var2881=org.apache.dubbo.common.utils.StringUtils, var3702=$z0, var3089=$r6}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var2185, r0=var2184, r4=var492, null_type=var3921, r1=var686, org.apache.dubbo.common.url.component.URLParam=var3816, $r2=var285, r3=var590, org.apache.dubbo.common.utils.StringUtils=var2881, $z0=var3702, $r6=var3089}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r4 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r6 = r3;	goto [?= return $r6];	return $r6
;block_num 3