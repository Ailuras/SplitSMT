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

(declare-sort var2474 0)
(declare-sort var1948 0)
(declare-sort var1598 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2474 var2474)
(declare-const null-var1948 var1948)
(declare-const null-var1598 var1598)
(declare-const var1345 var2474) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.AbstractSpringArgumentResolver 
(assert (not (= var1345 null-var2474)))
(declare-const var2858 var1948) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var2858 null-var1948)))
(declare-const var3433 var1598) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta 
(assert (not (= var3433 null-var1598)))
(define-const var2898 String "") ; Statement: $r1 = "" 
(assert true)
(define-const var2534 Bool false) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r4 = r0 
(assert (= (ite var2534 1 0) 0)) ; Cond: $z0 == 0 
(define-const var385 var1948 var2858) ; Statement: $r4 = r0 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {}
; {var2474=org.apache.dubbo.rpc.protocol.tri.rest.support.spring.AbstractSpringArgumentResolver, var1345=r3, var1948=java.lang.Object, var2858=r0, var1598=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta, var3433=r2, var2898=$r1, var2534=$z0, var385=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.spring.AbstractSpringArgumentResolver=var2474, r3=var1345, java.lang.Object=var1948, r0=var2858, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta=var1598, r2=var3433, $r1=var2898, $z0=var2534, $r4=var385}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.spring.AbstractSpringArgumentResolver;	r0 := @parameter0: java.lang.Object;	r2 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta;	$r1 = "";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r4 = r0;	$r4 = r0;	return $r4
;block_num 3