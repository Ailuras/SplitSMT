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

(declare-sort var3588 0)
(declare-sort var158 0)
(declare-sort var552 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var552_getUrl/-275947851 (var552) var158)
(declare-fun cast-from-var3588-to-var552 (var3588) var552)
(declare-fun getProtocol/491749358 (var158) String)
(declare-const null-var3588 var3588)
(declare-const var459 var3588) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var459 null-var3588)))
(define-const var3087 var158 (var552_getUrl/-275947851 (cast-from-var3588-to-var552 var459))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var444 String (getProtocol/491749358 var3087)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1359 Bool (= var444 "mock")) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("mock") 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var1359 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1985 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var552_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3588-to-var552=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var3588=org.apache.dubbo.rpc.Invoker, var459=r0, var158=org.apache.dubbo.common.URL, var552=org.apache.dubbo.common.Node, var3087=$r1, var444=$r2, var1359=$z0, var1985=$z1}
; {org.apache.dubbo.rpc.Invoker=var3588, r0=var459, org.apache.dubbo.common.URL=var158, org.apache.dubbo.common.Node=var552, $r1=var3087, $r2=var444, $z0=var1359, $z1=var1985}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("mock");	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3