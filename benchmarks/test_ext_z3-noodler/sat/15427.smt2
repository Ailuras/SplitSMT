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

(declare-sort var2815 0)
(declare-sort var1013 0)
(declare-sort var3198 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2815 String) Bool)
(declare-fun getProtocolServiceKey/574559726 (var2815) String)
(declare-fun var3198_isEmpty/-813097145 (String) Bool)
(declare-const null-var2815 var2815)
(declare-const null-String String)
(declare-const var580 var2815) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var580 null-var2815)))
(declare-const var1997 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1997 null-String)))
(declare-const var355 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var355 null-String)))
(assert true)
(define-const var3998 Bool (consumerParamFirst/5744255 var580 var355)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(assert (= (ite var3998 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3210 String (getProtocolServiceKey/574559726 var580)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var3676 Bool (var3198_isEmpty/-813097145 var3210)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r5) 
 ; Statement: if $z3 == 0 goto $z1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r5, r2, r1) 
(assert (not (= (ite var3676 1 0) 0))) ; Negate: Cond: $z3 == 0  
 ; Statement: return 0 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var3198_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2815=org.apache.dubbo.registry.client.InstanceAddressURL, var580=r0, var1997=r2, var1013=null_type, var355=r1, var3998=$z0, var3210=$r5, var3198=org.apache.dubbo.common.utils.StringUtils, var3676=$z3}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2815, r0=var580, r2=var1997, null_type=var1013, r1=var355, $z0=var3998, $r5=var3210, org.apache.dubbo.common.utils.StringUtils=var3198, $z3=var3676}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$r5 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r5);	if $z3 == 0 goto $z1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean hasServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r5, r2, r1);	return 0
;block_num 3