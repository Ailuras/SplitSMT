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

(declare-sort var3021 0)
(declare-sort var3548 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCategory/-59794707 (var3548 String) String)
(declare-const null-var3021 var3021)
(declare-const null-var3548 var3548)
(declare-const var3617 var3021) ; Statement: r15 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var3617 null-var3021)))
(declare-const var2177 var3548) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2177 null-var3548)))
(assert true)
(define-const var1691 String (getCategory/-59794707 var2177 "providers")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers") 
(define-const var1687 String "routers") ; Statement: $r2 = "routers" 
(assert true)
(define-const var1154 Bool (= var1687 var1691)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto return 1 
(assert (not (= (ite var1154 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 1 
(check-sat)
; {getCategory/-59794707=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String)}
; {var3021=org.apache.dubbo.registry.integration.RegistryDirectory, var3617=r15, var3548=org.apache.dubbo.common.URL, var2177=r0, var1691=r1, var1687=$r2, var1154=$z0}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var3021, r15=var3617, org.apache.dubbo.common.URL=var3548, r0=var2177, r1=var1691, $r2=var1687, $z0=var1154}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r15 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers");	$r2 = "routers";	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto return 1;	return 1
;block_num 2