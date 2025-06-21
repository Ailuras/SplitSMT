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

(declare-sort var1508 0)
(declare-sort var2906 0)
(declare-sort var112 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var1508 var1508)
(declare-const null-var2906 var2906)
(declare-const null-var112 var112)
(declare-const var2701 var1508) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver 
(assert (not (= var2701 null-var1508)))
(declare-const var54 var2906) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var54 null-var2906)))
(declare-const var587 var112) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta 
(assert (not (= var587 null-var112)))
(define-const var652 String "") ; Statement: $r1 = "" 
(assert true)
(define-const var2764 Bool false) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r4 = r0 
(assert (= (ite var2764 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2206 var2906 var54) ; Statement: $r4 = r0 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {}
; {var1508=org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver, var2701=r3, var2906=java.lang.Object, var54=r0, var112=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta, var587=r2, var652=$r1, var2764=$z0, var2206=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver=var1508, r3=var2701, java.lang.Object=var2906, r0=var54, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta=var112, r2=var587, $r1=var652, $z0=var2764, $r4=var2206}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver;	r0 := @parameter0: java.lang.Object;	r2 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta;	$r1 = "";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r4 = r0;	$r4 = r0;	return $r4
;block_num 3