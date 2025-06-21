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

(declare-sort var1850 0)
(declare-sort var312 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var1850 var1850)
(declare-const null-String String)
(declare-const var792 var1850) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.ReflectionPackableMethod$WrapRequestPack 
(assert (not (= var792 null-var1850)))
(declare-const var3428 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3428 null-String)))
(define-const var1871 String "hessian2") ; Statement: $r1 = "hessian2" 
(assert true)
(define-const var604 Bool (= var1871 var3428)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto return r0 
(assert (= (ite var604 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r0 
(check-sat)
; {}
; {var1850=org.apache.dubbo.rpc.protocol.tri.ReflectionPackableMethod$WrapRequestPack, var792=r2, var3428=r0, var312=null_type, var1871=$r1, var604=$z0}
; {org.apache.dubbo.rpc.protocol.tri.ReflectionPackableMethod$WrapRequestPack=var1850, r2=var792, r0=var3428, null_type=var312, $r1=var1871, $z0=var604}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.ReflectionPackableMethod$WrapRequestPack;	r0 := @parameter0: java.lang.String;	$r1 = "hessian2";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto return r0;	return r0
;block_num 2