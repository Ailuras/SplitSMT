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

(declare-sort var225 0)
(declare-sort var164 0)
(declare-sort var3885 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-String-to-var164 (String) var164)
(declare-fun defaultValue/-1642492534 (var3885) String)
(declare-const null-var225 var225)
(declare-const null-var164 var164)
(declare-const null-var3885 var3885)
(declare-const var3017 var225) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.AbstractSpringArgumentResolver 
(assert (not (= var3017 null-var225)))
(declare-const var2531 var164) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var2531 null-var164)))
(declare-const var2516 var3885) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta 
(assert (not (= var2516 null-var3885)))
(define-const var1777 String "") ; Statement: $r1 = "" 
(assert true)
(define-const var2053 Bool false) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r4 = r0 
(assert (not (= (ite var2053 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3366 var164 (cast-from-String-to-var164 (defaultValue/-1642492534 var2516))) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String defaultValue()>() 
 ; Statement: goto [?= return $r4] 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {cast-from-String-to-var164=([java.lang.String], java.lang.Object), defaultValue/-1642492534=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], java.lang.String)}
; {var225=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.AbstractSpringArgumentResolver, var3017=r3, var164=java.lang.Object, var2531=r0, var3885=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta, var2516=r2, var1777=$r1, var2053=$z0, var3366=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.AbstractSpringArgumentResolver=var225, r3=var3017, java.lang.Object=var164, r0=var2531, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta=var3885, r2=var2516, $r1=var1777, $z0=var2053, $r4=var3366}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.AbstractSpringArgumentResolver;	r0 := @parameter0: java.lang.Object;	r2 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta;	$r1 = "";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r4 = r0;	$r4 = virtualinvoke r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String defaultValue()>();	goto [?= return $r4];	return $r4
;block_num 3