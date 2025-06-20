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

(declare-sort var1116 0)
(declare-sort var565 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getVersion/1139699570 (var1116) String)
(declare-const null-var1116 var1116)
(declare-const null-String String)
(declare-const var937 var1116) ; Statement: r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var937 null-var1116)))
(declare-const var1972 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1972 null-String)))
(define-const var1349 String "version") ; Statement: $r1 = "version" 
(assert true)
(define-const var2081 Bool (= var1349 var1972)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "group" 
(assert (not (= (ite var2081 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var544 String (getVersion/1139699570 var937)) ; Statement: $r16 = virtualinvoke r6.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getVersion()>() 
 ; Statement: return $r16 
(check-sat)
; {getVersion/1139699570=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String)}
; {var1116=org.apache.dubbo.registry.client.InstanceAddressURL, var937=r6, var1972=r0, var565=null_type, var1349=$r1, var2081=$z0, var544=$r16}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1116, r6=var937, r0=var1972, null_type=var565, $r1=var1349, $z0=var2081, $r16=var544}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r0 := @parameter0: java.lang.String;	$r1 = "version";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "group";	$r16 = virtualinvoke r6.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getVersion()>();	return $r16
;block_num 2