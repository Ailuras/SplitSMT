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

(declare-sort var562 0)
(declare-sort var1179 0)
(declare-sort var2504 0)
(declare-sort var3077 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var562) var2504)
(declare-fun getMethodParameter/1573524985 (var2504 String String) String)
(declare-fun var3077_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var562 var562)
(declare-const null-String String)
(declare-const var643 var562) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var643 null-var562)))
(declare-const var3695 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3695 null-String)))
(declare-const var832 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var832 null-String)))
(define-const var925 var2504 (overrideParams/-420841356 var643)) ; Statement: $r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var3640 String (getMethodParameter/1573524985 var925 var3695 var832)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2058 Bool (var3077_isNotEmpty/-1251449450 var3640)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (not (= (ite var2058 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2560 String var3640) ; Statement: $r6 = r4 
 ; Statement: goto [?= return $r6] 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getMethodParameter/1573524985=([org.apache.dubbo.common.url.component.URLParam, java.lang.String, java.lang.String], java.lang.String), var3077_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var562=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var643=r0, var3695=r1, var1179=null_type, var832=r2, var2504=org.apache.dubbo.common.url.component.URLParam, var925=$r3, var3640=r4, var3077=org.apache.dubbo.common.utils.StringUtils, var2058=$z0, var2560=$r6}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var562, r0=var643, r1=var3695, null_type=var1179, r2=var832, org.apache.dubbo.common.url.component.URLParam=var2504, $r3=var925, r4=var3640, org.apache.dubbo.common.utils.StringUtils=var3077, $z0=var2058, $r6=var2560}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r6 = r4;	goto [?= return $r6];	return $r6
;block_num 3