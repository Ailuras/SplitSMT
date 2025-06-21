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

(declare-sort var1041 0)
(declare-sort var876 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getVersion/1139699570 (var1041) String)
(declare-const null-var1041 var1041)
(declare-const null-String String)
(declare-const var1750 var1041) ; Statement: r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1750 null-var1041)))
(declare-const var3312 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3312 null-String)))
(define-const var800 String "version") ; Statement: $r1 = "version" 
(assert true)
(define-const var2174 Bool (= var800 var3312)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "group" 
(assert (not (= (ite var2174 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1581 String (getVersion/1139699570 var1750)) ; Statement: $r15 = virtualinvoke r6.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getVersion()>() 
 ; Statement: return $r15 
(check-sat)
; {getVersion/1139699570=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String)}
; {var1041=org.apache.dubbo.registry.client.InstanceAddressURL, var1750=r6, var3312=r0, var876=null_type, var800=$r1, var2174=$z0, var1581=$r15}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1041, r6=var1750, r0=var3312, null_type=var876, $r1=var800, $z0=var2174, $r15=var1581}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r0 := @parameter0: java.lang.String;	$r1 = "version";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "group";	$r15 = virtualinvoke r6.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getVersion()>();	return $r15
;block_num 2