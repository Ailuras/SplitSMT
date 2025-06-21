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

(declare-sort var2059 0)
(declare-sort var895 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getGroup/1190622214 (var2059) String)
(declare-const null-var2059 var2059)
(declare-const null-String String)
(declare-const var2826 var2059) ; Statement: r6 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL 
(assert (not (= var2826 null-var2059)))
(declare-const var1806 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1806 null-String)))
(define-const var2742 String "group") ; Statement: $r1 = "group" 
(assert true)
(define-const var1711 Bool (= var2742 var1806)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "version" 
(assert (not (= (ite var1711 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2863 String (getGroup/1190622214 var2826)) ; Statement: $r12 = virtualinvoke r6.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.lang.String getGroup()>() 
 ; Statement: return $r12 
(check-sat)
; {getGroup/1190622214=([org.apache.dubbo.common.url.component.ServiceAddressURL], java.lang.String)}
; {var2059=org.apache.dubbo.common.url.component.ServiceAddressURL, var2826=r6, var1806=r0, var895=null_type, var2742=$r1, var1711=$z0, var2863=$r12}
; {org.apache.dubbo.common.url.component.ServiceAddressURL=var2059, r6=var2826, r0=var1806, null_type=var895, $r1=var2742, $z0=var1711, $r12=var2863}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL;	r0 := @parameter0: java.lang.String;	$r1 = "group";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "version";	$r12 = virtualinvoke r6.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.lang.String getGroup()>();	return $r12
;block_num 2