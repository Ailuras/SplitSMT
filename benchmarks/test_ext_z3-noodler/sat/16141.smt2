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

(declare-sort var1917 0)
(declare-sort var1471 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var1471) String)
(declare-const null-var1917 var1917)
(declare-const null-var1471 var1471)
(declare-const var2488 var1917) ; Statement: r3 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2488 null-var1917)))
(declare-const var3961 var1471) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3961 null-var1471)))
(define-const var3437 String "admin") ; Statement: $r2 = "admin" 
(assert true)
(define-const var3387 String (getProtocol/491749358 var3961)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2104 Bool (= var3437 var3387)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1917=org.apache.dubbo.registry.nacos.NacosRegistry, var2488=r3, var1471=org.apache.dubbo.common.URL, var3961=r0, var3437=$r2, var3387=$r1, var2104=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var1917, r3=var2488, org.apache.dubbo.common.URL=var1471, r0=var3961, $r2=var3437, $r1=var3387, $z0=var2104}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "admin";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	return $z0
;block_num 1