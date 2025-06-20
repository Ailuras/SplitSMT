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

(declare-sort var2239 0)
(declare-sort var2505 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2239 var2239)
(declare-const null-String String)
(declare-const var688 var2239) ; Statement: r1 := @this: org.apache.dubbo.common.serialize.DefaultMultipleSerialization 
(assert (not (= var688 null-var2239)))
(declare-const var2453 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2453 null-String)))
(assert true)
(define-const var3199 Bool (= var2453 "hessian4")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("hessian4") 
 ; Statement: if $z0 == 0 goto return r0 
(assert (= (ite var3199 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r0 
(check-sat)
; {}
; {var2239=org.apache.dubbo.common.serialize.DefaultMultipleSerialization, var688=r1, var2453=r0, var2505=null_type, var3199=$z0}
; {org.apache.dubbo.common.serialize.DefaultMultipleSerialization=var2239, r1=var688, r0=var2453, null_type=var2505, $z0=var3199}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.serialize.DefaultMultipleSerialization;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("hessian4");	if $z0 == 0 goto return r0;	return r0
;block_num 2