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

(declare-sort var849 0)
(declare-sort var1791 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var849 var849)
(declare-const null-String String)
(declare-const var3889 var849) ; Statement: r1 := @this: org.apache.dubbo.common.serialize.DefaultMultipleSerialization 
(assert (not (= var3889 null-var849)))
(declare-const var2007 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2007 null-String)))
(assert true)
(define-const var3079 Bool (= var2007 "hessian4")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("hessian4") 
 ; Statement: if $z0 == 0 goto return r0 
(assert (not (= (ite var3079 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return "hessian2" 
(check-sat)
; {}
; {var849=org.apache.dubbo.common.serialize.DefaultMultipleSerialization, var3889=r1, var2007=r0, var1791=null_type, var3079=$z0}
; {org.apache.dubbo.common.serialize.DefaultMultipleSerialization=var849, r1=var3889, r0=var2007, null_type=var1791, $z0=var3079}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.serialize.DefaultMultipleSerialization;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("hessian4");	if $z0 == 0 goto return r0;	return "hessian2"
;block_num 2