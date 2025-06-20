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

(declare-sort var1071 0)
(declare-sort var3367 0)
(declare-sort var799 0)
(declare-sort var130 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var1071) var799)
(declare-fun getMethodParameter/1573524985 (var799 String String) String)
(declare-fun var130_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1071 var1071)
(declare-const null-String String)
(declare-const var2850 var1071) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var2850 null-var1071)))
(declare-const var1499 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1499 null-String)))
(declare-const var3018 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3018 null-String)))
(define-const var2005 var799 (overrideParams/-420841356 var2850)) ; Statement: $r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var2232 String (getMethodParameter/1573524985 var2005 var1499 var3018)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2251 Bool (var130_isNotEmpty/-1251449450 var2232)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var2251 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1313 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getMethodParameter/1573524985=([org.apache.dubbo.common.url.component.URLParam, java.lang.String, java.lang.String], java.lang.String), var130_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1071=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var2850=r0, var1499=r1, var3367=null_type, var3018=r2, var799=org.apache.dubbo.common.url.component.URLParam, var2005=$r3, var2232=$r4, var130=org.apache.dubbo.common.utils.StringUtils, var2251=$z0, var1313=$z2}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var1071, r0=var2850, r1=var1499, null_type=var3367, r2=var3018, org.apache.dubbo.common.url.component.URLParam=var799, $r3=var2005, $r4=var2232, org.apache.dubbo.common.utils.StringUtils=var130, $z0=var2251, $z2=var1313}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r4);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3