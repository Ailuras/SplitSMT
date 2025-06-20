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

(declare-sort var3571 0)
(declare-sort var18 0)
(declare-sort var3654 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-String-to-var18 (String) var18)
(declare-fun defaultValue/-1642492534 (var3654) String)
(declare-const null-var3571 var3571)
(declare-const null-var18 var18)
(declare-const null-var3654 var3654)
(declare-const var3857 var3571) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver 
(assert (not (= var3857 null-var3571)))
(declare-const var3481 var18) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var3481 null-var18)))
(declare-const var2563 var3654) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta 
(assert (not (= var2563 null-var3654)))
(define-const var3397 String "") ; Statement: $r1 = "" 
(assert true)
(define-const var109 Bool false) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r4 = r0 
(assert (not (= (ite var109 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var63 var18 (cast-from-String-to-var18 (defaultValue/-1642492534 var2563))) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String defaultValue()>() 
 ; Statement: goto [?= return $r4] 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {cast-from-String-to-var18=([java.lang.String], java.lang.Object), defaultValue/-1642492534=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], java.lang.String)}
; {var3571=org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver, var3857=r3, var18=java.lang.Object, var3481=r0, var3654=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta, var2563=r2, var3397=$r1, var109=$z0, var63=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver=var3571, r3=var3857, java.lang.Object=var18, r0=var3481, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta=var3654, r2=var2563, $r1=var3397, $z0=var109, $r4=var63}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver;	r0 := @parameter0: java.lang.Object;	r2 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta;	$r1 = "";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r4 = r0;	$r4 = virtualinvoke r2.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String defaultValue()>();	goto [?= return $r4];	return $r4
;block_num 3