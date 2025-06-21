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

(declare-sort var3617 0)
(declare-sort var1673 0)
(declare-sort var1939 0)
(declare-sort var3858 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun overrideParams/-420841356 (var3617) var1939)
(declare-fun getMethodParameter/1573524985 (var1939 String String) String)
(declare-fun var3858_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3617 var3617)
(declare-const null-String String)
(declare-const var1126 var3617) ; Statement: r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var1126 null-var3617)))
(declare-const var30 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var30 null-String)))
(declare-const var2061 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2061 null-String)))
(declare-const var3110 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var3110 null-String)))
(define-const var2120 var1939 (overrideParams/-420841356 var1126)) ; Statement: $r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var2125 String (getMethodParameter/1573524985 var2120 var2061 var3110)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var804 Bool (var3858_isNotEmpty/-1251449450 var2125)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r6 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert (not (= (ite var804 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1723 String var2125) ; Statement: $r7 = r4 
 ; Statement: goto [?= return $r7] 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), getMethodParameter/1573524985=([org.apache.dubbo.common.url.component.URLParam, java.lang.String, java.lang.String], java.lang.String), var3858_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3617=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var1126=r0, var30=r5, var1673=null_type, var2061=r1, var3110=r2, var1939=org.apache.dubbo.common.url.component.URLParam, var2120=$r3, var2125=r4, var3858=org.apache.dubbo.common.utils.StringUtils, var804=$z0, var1723=$r7}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var3617, r0=var1126, r5=var30, null_type=var1673, r1=var2061, r2=var3110, org.apache.dubbo.common.url.component.URLParam=var1939, $r3=var2120, r4=var2125, org.apache.dubbo.common.utils.StringUtils=var3858, $z0=var804, $r7=var1723}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	r5 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r3 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r6 = r0.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r7 = r4;	goto [?= return $r7];	return $r7
;block_num 3