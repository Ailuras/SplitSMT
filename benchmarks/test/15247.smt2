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

(declare-sort var222 0)
(declare-sort var1342 0)
(declare-sort var342 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var342) String)
(declare-const null-var222 var222)
(declare-const null-String String)
(declare-const null-var342 var342)
(declare-const var3132 var222) ; Statement: r2 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var3132 null-var222)))
(declare-const var782 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var782 null-String)))
(declare-const var3282 var342) ; Statement: r1 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3282 null-var342)))
 ; Statement: if r0 == null goto $r32 = "empty" 
(assert (= var782 null-String)) ; Cond: r0 == null 
(define-const var2218 String "empty") ; Statement: $r32 = "empty" 
(assert true)
(define-const var1860 String (getProtocol/491749358 var3282)) ; Statement: $r33 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var3945 Bool (= var2218 var1860)) ; Statement: $z3 = virtualinvoke $r32.<java.lang.String: boolean equals(java.lang.Object)>($r33) 
 ; Statement: if $z3 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (= (ite var3945 1 0) 0))) ; Negate: Cond: $z3 == 0  
 ; Statement: return 0 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var222=org.apache.dubbo.registry.integration.RegistryDirectory, var3132=r2, var782=r0, var1342=null_type, var342=org.apache.dubbo.common.URL, var3282=r1, var2218=$r32, var1860=$r33, var3945=$z3}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var222, r2=var3132, r0=var782, null_type=var1342, org.apache.dubbo.common.URL=var342, r1=var3282, $r32=var2218, $r33=var1860, $z3=var3945}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: org.apache.dubbo.common.URL;	if r0 == null goto $r32 = "empty";	$r32 = "empty";	$r33 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z3 = virtualinvoke $r32.<java.lang.String: boolean equals(java.lang.Object)>($r33);	if $z3 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL getUrl()>();	return 0
;block_num 3