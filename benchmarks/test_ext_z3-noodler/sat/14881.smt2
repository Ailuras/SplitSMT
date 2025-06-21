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

(declare-sort var707 0)
(declare-sort var1796 0)
(declare-sort var3705 0)
(declare-sort var1832 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var707) var3705)
(declare-fun getParameter/-1177831711 (var3705 String) String)
(declare-fun var1832_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var707 var707)
(declare-const null-String String)
(declare-const var956 var707) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var956 null-var707)))
(declare-const var1098 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1098 null-String)))
(define-const var3992 var3705 (overrideParams/-420841356 var956)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var3599 String (getParameter/-1177831711 var3992 var1098)) ; Statement: r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1485 Bool (var1832_isNotEmpty/-1251449450 var3599)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (not (= (ite var1485 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var50 String var3599) ; Statement: $r5 = r3 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getParameter/-1177831711=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var1832_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var707=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var956=r0, var1098=r1, var1796=null_type, var3705=org.apache.dubbo.common.url.component.URLParam, var3992=$r2, var3599=r3, var1832=org.apache.dubbo.common.utils.StringUtils, var1485=$z0, var50=$r5}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var707, r0=var956, r1=var1098, null_type=var1796, org.apache.dubbo.common.url.component.URLParam=var3705, $r2=var3992, r3=var3599, org.apache.dubbo.common.utils.StringUtils=var1832, $z0=var1485, $r5=var50}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r3 = virtualinvoke $r2.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r5 = r3;	goto [?= return $r5];	return $r5
;block_num 3