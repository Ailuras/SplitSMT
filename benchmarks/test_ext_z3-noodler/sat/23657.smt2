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

(declare-sort var3775 0)
(declare-sort var2257 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun interfaceName/-1585781850 (var3775) String)
(declare-fun var2257_getInterfaceName/228305574 (var2257) String)
(declare-const null-var3775 var3775)
(declare-const null-var2257 var2257)
(declare-const var3685 var3775) ; Statement: r0 := @this: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var3685 null-var3775)))
(declare-const var174 var2257) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var174 null-var2257)))
(define-const var545 String (interfaceName/-1585781850 var3685)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String interfaceName> 
(define-const var3670 String (var2257_getInterfaceName/228305574 var174)) ; Statement: $r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.String getInterfaceName()>() 
(assert true)
(define-const var1694 Bool (= var545 var3670)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: return $z0 
(check-sat)
; {interfaceName/-1585781850=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), var2257_getInterfaceName/228305574=([org.apache.dubbo.rpc.model.ServiceDescriptor], java.lang.String)}
; {var3775=org.apache.dubbo.rpc.RpcInvocation, var3685=r0, var2257=org.apache.dubbo.rpc.model.ServiceDescriptor, var174=r1, var545=$r2, var3670=$r3, var1694=$z0}
; {org.apache.dubbo.rpc.RpcInvocation=var3775, r0=var3685, org.apache.dubbo.rpc.model.ServiceDescriptor=var2257, r1=var174, $r2=var545, $r3=var3670, $z0=var1694}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.RpcInvocation;	r1 := @parameter0: org.apache.dubbo.rpc.model.ServiceDescriptor;	$r2 = r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String interfaceName>;	$r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.String getInterfaceName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r3);	return $z0
;block_num 1