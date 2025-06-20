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

(declare-sort var3003 0)
(declare-sort var1254 0)
(declare-sort var2879 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInterfaceName/1781137661 (var3003) String)
(declare-fun var1254_equals/1031735566 (var2879 var2879) Bool)
(declare-fun cast-from-String-to-var2879 (String) var2879)
(declare-fun getVersion/996379145 (var3003) String)
(declare-fun getGroup/-823800830 (var3003) String)
(declare-const null-var3003 var3003)
(declare-const var2602 var3003) ; Statement: r0 := @parameter0: org.apache.dubbo.common.ServiceKey 
(assert (not (= var2602 null-var3003)))
(declare-const var2195 var3003) ; Statement: r1 := @parameter1: org.apache.dubbo.common.ServiceKey 
(assert (not (= var2195 null-var3003)))
(assert true)
(define-const var1230 String (getInterfaceName/1781137661 var2602)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.ServiceKey: java.lang.String getInterfaceName()>() 
(assert true)
(define-const var2379 String (getInterfaceName/1781137661 var2195)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.ServiceKey: java.lang.String getInterfaceName()>() 
(define-const var3698 Bool (var1254_equals/1031735566 (cast-from-String-to-var2879 var1230) (cast-from-String-to-var2879 var2379))) ; Statement: $z0 = staticinvoke <java.util.Objects: boolean equals(java.lang.Object,java.lang.Object)>($r3, $r2) 
 ; Statement: if $z0 != 0 goto $r5 = "*" 
(assert (not (= (ite var3698 1 0) 0))) ; Cond: $z0 != 0 
(define-const var632 String "*") ; Statement: $r5 = "*" 
(assert true)
(define-const var3695 String (getVersion/996379145 var2602)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.common.ServiceKey: java.lang.String getVersion()>() 
(assert true)
(define-const var1363 Bool (= var632 var3695)) ; Statement: $z1 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4) 
 ; Statement: if $z1 != 0 goto $r27 = "*" 
(assert (not (= (ite var1363 1 0) 0))) ; Cond: $z1 != 0 
(define-const var1415 String "*") ; Statement: $r27 = "*" 
(assert true)
(define-const var3478 String (getGroup/-823800830 var2602)) ; Statement: $r28 = virtualinvoke r0.<org.apache.dubbo.common.ServiceKey: java.lang.String getGroup()>() 
(assert true)
(define-const var3615 Bool (= var1415 var3478)) ; Statement: $z19 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>($r28) 
 ; Statement: if $z19 != 0 goto return 1 
(assert (not (= (ite var3615 1 0) 0))) ; Cond: $z19 != 0 
 ; Statement: return 1 
(check-sat)
; {getInterfaceName/1781137661=([org.apache.dubbo.common.ServiceKey], java.lang.String), var1254_equals/1031735566=([java.lang.Object, java.lang.Object], boolean), cast-from-String-to-var2879=([java.lang.String], java.lang.Object), getVersion/996379145=([org.apache.dubbo.common.ServiceKey], java.lang.String), getGroup/-823800830=([org.apache.dubbo.common.ServiceKey], java.lang.String)}
; {var3003=org.apache.dubbo.common.ServiceKey, var2602=r0, var2195=r1, var1230=$r3, var2379=$r2, var1254=java.util.Objects, var2879=java.lang.Object, var3698=$z0, var632=$r5, var3695=$r4, var1363=$z1, var1415=$r27, var3478=$r28, var3615=$z19}
; {org.apache.dubbo.common.ServiceKey=var3003, r0=var2602, r1=var2195, $r3=var1230, $r2=var2379, java.util.Objects=var1254, java.lang.Object=var2879, $z0=var3698, $r5=var632, $r4=var3695, $z1=var1363, $r27=var1415, $r28=var3478, $z19=var3615}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @parameter0: org.apache.dubbo.common.ServiceKey;	r1 := @parameter1: org.apache.dubbo.common.ServiceKey;	$r3 = virtualinvoke r0.<org.apache.dubbo.common.ServiceKey: java.lang.String getInterfaceName()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.ServiceKey: java.lang.String getInterfaceName()>();	$z0 = staticinvoke <java.util.Objects: boolean equals(java.lang.Object,java.lang.Object)>($r3, $r2);	if $z0 != 0 goto $r5 = "*";	$r5 = "*";	$r4 = virtualinvoke r0.<org.apache.dubbo.common.ServiceKey: java.lang.String getVersion()>();	$z1 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4);	if $z1 != 0 goto $r27 = "*";	$r27 = "*";	$r28 = virtualinvoke r0.<org.apache.dubbo.common.ServiceKey: java.lang.String getGroup()>();	$z19 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>($r28);	if $z19 != 0 goto return 1;	return 1
;block_num 4