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

(declare-sort var3070 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3070_getMethodName/-1216290648 (var3070) String)
(declare-const null-var3070 var3070)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-ClassObject ClassObject)
(declare-const var792 var3070) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.MethodDescriptor 
(assert (not (= var792 null-var3070)))
(declare-const var3940 (Array Int ClassObject)) ; Statement: r6 := @parameter1: java.lang.Class[] 
(assert (not (= var3940 null-__Array__Int__ClassObject__)))
(declare-const var1852 ClassObject) ; Statement: r5 := @parameter2: java.lang.Class 
(assert (not (= var1852 null-ClassObject)))
(define-const var810 String (var3070_getMethodName/-1216290648 var792)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.model.MethodDescriptor: java.lang.String getMethodName()>() 
(define-const var983 String "$invoke") ; Statement: $r2 = "$invoke" 
(assert true)
(define-const var293 Bool (= var983 var810)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto return 1 
(assert (not (= (ite var293 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 1 
(check-sat)
; {var3070_getMethodName/-1216290648=([org.apache.dubbo.rpc.model.MethodDescriptor], java.lang.String)}
; {var3070=org.apache.dubbo.rpc.model.MethodDescriptor, var792=r0, var3940=r6, var1852=r5, var810=r1, var983=$r2, var293=$z0}
; {org.apache.dubbo.rpc.model.MethodDescriptor=var3070, r0=var792, r6=var3940, r5=var1852, r1=var810, $r2=var983, $z0=var293}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.MethodDescriptor;	r6 := @parameter1: java.lang.Class[];	r5 := @parameter2: java.lang.Class;	r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.model.MethodDescriptor: java.lang.String getMethodName()>();	$r2 = "$invoke";	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto return 1;	return 1
;block_num 2