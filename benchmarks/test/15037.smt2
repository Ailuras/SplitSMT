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

(declare-sort var422 0)
(declare-sort var1403 0)
(declare-sort var900 0)
(declare-sort var1026 0)
(declare-sort var3430 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var422) var900)
(declare-fun getMethodParameter/1573524985 (var900 String String) String)
(declare-fun var1026_isNotEmpty/-1251449450 (String) Bool)
(declare-fun originUrl/-420841356 (var422) var3430)
(declare-fun getMethodParameter/2063166036 (var3430 String String) String)
(declare-const null-var422 var422)
(declare-const null-String String)
(declare-const var639 var422) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var639 null-var422)))
(declare-const var2268 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2268 null-String)))
(declare-const var1162 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1162 null-String)))
(define-const var3733 var900 (overrideParams/-420841356 var639)) ; Statement: $r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var1553 String (getMethodParameter/1573524985 var3733 var2268 var1162)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var629 Bool (var1026_isNotEmpty/-1251449450 var1553)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (= (ite var629 1 0) 0)) ; Cond: $z0 == 0 
(define-const var214 var3430 (originUrl/-420841356 var639)) ; Statement: $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert true)
(define-const var1499 String (getMethodParameter/2063166036 var214 var2268 var1162)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getMethodParameter/1573524985=([org.apache.dubbo.common.url.component.URLParam, java.lang.String, java.lang.String], java.lang.String), var1026_isNotEmpty/-1251449450=([java.lang.String], boolean), originUrl/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.registry.client.InstanceAddressURL), getMethodParameter/2063166036=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String, java.lang.String], java.lang.String)}
; {var422=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var639=r0, var2268=r1, var1403=null_type, var1162=r2, var900=org.apache.dubbo.common.url.component.URLParam, var3733=$r3, var1553=r4, var1026=org.apache.dubbo.common.utils.StringUtils, var629=$z0, var3430=org.apache.dubbo.registry.client.InstanceAddressURL, var214=$r5, var1499=$r6}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var422, r0=var639, r1=var2268, null_type=var1403, r2=var1162, org.apache.dubbo.common.url.component.URLParam=var900, $r3=var3733, r4=var1553, org.apache.dubbo.common.utils.StringUtils=var1026, $z0=var629, org.apache.dubbo.registry.client.InstanceAddressURL=var3430, $r5=var214, $r6=var1499}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	return $r6
;block_num 3