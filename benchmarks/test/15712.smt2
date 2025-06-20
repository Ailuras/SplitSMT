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

(declare-sort var3274 0)
(declare-sort var287 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var3274 var3274)
(declare-const null-String String)
(declare-const var1297 var3274) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var1297 null-var3274)))
(declare-const var1031 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1031 null-String)))
(define-const var1819 String "*") ; Statement: $r1 = "*" 
(assert true)
(define-const var2624 Bool (= var1819 var1031)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: return $z0 
(check-sat)
; {}
; {var3274=org.apache.dubbo.registry.nacos.NacosServiceName, var1297=r2, var1031=r0, var287=null_type, var1819=$r1, var2624=$z0}
; {org.apache.dubbo.registry.nacos.NacosServiceName=var3274, r2=var1297, r0=var1031, null_type=var287, $r1=var1819, $z0=var2624}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosServiceName;	r0 := @parameter0: java.lang.String;	$r1 = "*";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	return $z0
;block_num 1