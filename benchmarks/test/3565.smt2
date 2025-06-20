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

(declare-sort var3995 0)
(declare-sort var3605 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getVersion/-173326067 (var3995) String)
(declare-const null-var3995 var3995)
(declare-const null-String String)
(declare-const var2015 var3995) ; Statement: r6 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL 
(assert (not (= var2015 null-var3995)))
(declare-const var2462 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2462 null-String)))
(define-const var1210 String "group") ; Statement: $r1 = "group" 
(assert true)
(define-const var3549 Bool (= var1210 var2462)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "version" 
(assert (= (ite var3549 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3791 String "version") ; Statement: $r2 = "version" 
(assert true)
(define-const var1151 Bool (= var3791 var2462)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z1 == 0 goto $r3 = "application" 
(assert (not (= (ite var1151 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var1801 String (getVersion/-173326067 var2015)) ; Statement: $r12 = virtualinvoke r6.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.lang.String getVersion()>() 
 ; Statement: return $r12 
(check-sat)
; {getVersion/-173326067=([org.apache.dubbo.common.url.component.ServiceAddressURL], java.lang.String)}
; {var3995=org.apache.dubbo.common.url.component.ServiceAddressURL, var2015=r6, var2462=r0, var3605=null_type, var1210=$r1, var3549=$z0, var3791=$r2, var1151=$z1, var1801=$r12}
; {org.apache.dubbo.common.url.component.ServiceAddressURL=var3995, r6=var2015, r0=var2462, null_type=var3605, $r1=var1210, $z0=var3549, $r2=var3791, $z1=var1151, $r12=var1801}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r6 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL;	r0 := @parameter0: java.lang.String;	$r1 = "group";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "version";	$r2 = "version";	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z1 == 0 goto $r3 = "application";	$r12 = virtualinvoke r6.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.lang.String getVersion()>();	return $r12
;block_num 3