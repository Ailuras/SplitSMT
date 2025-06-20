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

(declare-sort var2609 0)
(declare-sort var3390 0)
(declare-sort var30 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceInterface/-1311863806 (var3390) String)
(declare-const null-var2609 var2609)
(declare-const null-var3390 var3390)
(declare-const var2609-ALL_SUPPORTED_CATEGORIES var30)
(declare-const var2542 var2609) ; Statement: r4 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2542 null-var2609)))
(declare-const var2918 var3390) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2918 null-var3390)))
(define-const var2108 String "*") ; Statement: $r2 = "*" 
(assert true)
(define-const var1087 String (getServiceInterface/-1311863806 var2918)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var3631 Bool (= var2108 var1087)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = newarray (java.lang.String)[1] 
(assert (not (= (ite var3631 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2219 var30 var2609-ALL_SUPPORTED_CATEGORIES) ; Statement: $r5 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.util.List ALL_SUPPORTED_CATEGORIES> 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String)}
; {var2609=org.apache.dubbo.registry.nacos.NacosRegistry, var2542=r4, var3390=org.apache.dubbo.common.URL, var2918=r0, var2108=$r2, var1087=$r1, var3631=$z0, var30=java.util.List, var2219=$r5}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var2609, r4=var2542, org.apache.dubbo.common.URL=var3390, r0=var2918, $r2=var2108, $r1=var1087, $z0=var3631, java.util.List=var30, $r5=var2219}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "*";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = newarray (java.lang.String)[1];	$r5 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.util.List ALL_SUPPORTED_CATEGORIES>;	goto [?= return $r5];	return $r5
;block_num 3