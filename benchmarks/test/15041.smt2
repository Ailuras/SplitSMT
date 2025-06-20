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

(declare-sort var1652 0)
(declare-sort var1456 0)
(declare-sort var3696 0)
(declare-sort var1134 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var1652) var3696)
(declare-fun getMethodParameter/1573524985 (var3696 String String) String)
(declare-fun var1134_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1652 var1652)
(declare-const null-String String)
(declare-const var2406 var1652) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var2406 null-var1652)))
(declare-const var3978 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var3978 null-String)))
(declare-const var3702 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3702 null-String)))
(declare-const var2721 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2721 null-String)))
(define-const var1527 var3696 (overrideParams/-420841356 var2406)) ; Statement: $r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var3682 String (getMethodParameter/1573524985 var1527 var3702 var2721)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3645 Bool (var1134_isNotEmpty/-1251449450 var3682)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var3645 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2364 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getMethodParameter/1573524985=([org.apache.dubbo.common.url.component.URLParam, java.lang.String, java.lang.String], java.lang.String), var1134_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1652=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var2406=r0, var3978=r5, var1456=null_type, var3702=r1, var2721=r2, var3696=org.apache.dubbo.common.url.component.URLParam, var1527=$r3, var3682=$r4, var1134=org.apache.dubbo.common.utils.StringUtils, var3645=$z0, var2364=$z2}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var1652, r0=var2406, r5=var3978, null_type=var1456, r1=var3702, r2=var2721, org.apache.dubbo.common.url.component.URLParam=var3696, $r3=var1527, $r4=var3682, org.apache.dubbo.common.utils.StringUtils=var1134, $z0=var3645, $z2=var2364}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r5 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r4);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3