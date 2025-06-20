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

(declare-sort var484 0)
(declare-sort var855 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getGroup/1190622214 (var484) String)
(declare-const null-var484 var484)
(declare-const null-String String)
(declare-const var1339 var484) ; Statement: r6 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL 
(assert (not (= var1339 null-var484)))
(declare-const var3130 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3130 null-String)))
(define-const var964 String "group") ; Statement: $r1 = "group" 
(assert true)
(define-const var2792 Bool (= var964 var3130)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "version" 
(assert (not (= (ite var2792 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2344 String (getGroup/1190622214 var1339)) ; Statement: $r13 = virtualinvoke r6.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.lang.String getGroup()>() 
 ; Statement: return $r13 
(check-sat)
; {getGroup/1190622214=([org.apache.dubbo.common.url.component.ServiceAddressURL], java.lang.String)}
; {var484=org.apache.dubbo.common.url.component.ServiceAddressURL, var1339=r6, var3130=r0, var855=null_type, var964=$r1, var2792=$z0, var2344=$r13}
; {org.apache.dubbo.common.url.component.ServiceAddressURL=var484, r6=var1339, r0=var3130, null_type=var855, $r1=var964, $z0=var2792, $r13=var2344}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL;	r0 := @parameter0: java.lang.String;	$r1 = "group";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "version";	$r13 = virtualinvoke r6.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.lang.String getGroup()>();	return $r13
;block_num 2