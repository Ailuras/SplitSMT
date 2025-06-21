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

(declare-sort var2007 0)
(declare-sort var3697 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2007 var2007)
(declare-const null-String String)
(declare-const var2221 var2007) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.ReflectionPackableMethod$WrapRequestPack 
(assert (not (= var2221 null-var2007)))
(declare-const var3881 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3881 null-String)))
(define-const var289 String "hessian2") ; Statement: $r1 = "hessian2" 
(assert true)
(define-const var141 Bool (= var289 var3881)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto return r0 
(assert (not (= (ite var141 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return "hessian4" 
(check-sat)
; {}
; {var2007=org.apache.dubbo.rpc.protocol.tri.ReflectionPackableMethod$WrapRequestPack, var2221=r2, var3881=r0, var3697=null_type, var289=$r1, var141=$z0}
; {org.apache.dubbo.rpc.protocol.tri.ReflectionPackableMethod$WrapRequestPack=var2007, r2=var2221, r0=var3881, null_type=var3697, $r1=var289, $z0=var141}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.ReflectionPackableMethod$WrapRequestPack;	r0 := @parameter0: java.lang.String;	$r1 = "hessian2";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto return r0;	return "hessian4"
;block_num 2