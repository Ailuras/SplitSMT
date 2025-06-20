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

(declare-sort var1662 0)
(declare-sort var2369 0)
(declare-sort var1406 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun registerService/411514484 (var1662 ClassObject) var1406)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-const null-var1662 var1662)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var1824 var1662) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ModuleServiceRepository 
(assert (not (= var1824 null-var1662)))
(declare-const var733 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var733 null-String)))
(declare-const var2085 ClassObject) ; Statement: r1 := @parameter1: java.lang.Class 
(assert (not (= var2085 null-ClassObject)))
(assert true)
(define-const var2773 var1406 (registerService/411514484 var1824 var2085)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ModuleServiceRepository: org.apache.dubbo.rpc.model.ServiceDescriptor registerService(java.lang.Class)>(r1) 
(assert true)
(define-const var1039 String (getName/-1958580599 var2085)) ; Statement: $r4 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1585 Bool (= var1039 var733)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3) 
 ; Statement: if $z0 != 0 goto return r2 
(assert (not (= (ite var1585 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r2 
(check-sat)
; {registerService/411514484=([org.apache.dubbo.rpc.model.ModuleServiceRepository, java.lang.Class], org.apache.dubbo.rpc.model.ServiceDescriptor), getName/-1958580599=([java.lang.Class], java.lang.String)}
; {var1662=org.apache.dubbo.rpc.model.ModuleServiceRepository, var1824=r0, var733=r3, var2369=null_type, var2085=r1, var1406=org.apache.dubbo.rpc.model.ServiceDescriptor, var2773=r2, var1039=$r4, var1585=$z0}
; {org.apache.dubbo.rpc.model.ModuleServiceRepository=var1662, r0=var1824, r3=var733, null_type=var2369, r1=var2085, org.apache.dubbo.rpc.model.ServiceDescriptor=var1406, r2=var2773, $r4=var1039, $z0=var1585}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ModuleServiceRepository;	r3 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Class;	r2 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ModuleServiceRepository: org.apache.dubbo.rpc.model.ServiceDescriptor registerService(java.lang.Class)>(r1);	$r4 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3);	if $z0 != 0 goto return r2;	return r2
;block_num 2