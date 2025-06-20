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

(declare-sort var1936 0)
(declare-sort var2034 0)
(declare-sort var1523 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1523_getUrl/-275947851 (var1523) var2034)
(declare-fun cast-from-var1936-to-var1523 (var1936) var1523)
(declare-fun getProtocol/491749358 (var2034) String)
(declare-const null-var1936 var1936)
(declare-const var212 var1936) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var212 null-var1936)))
(define-const var51 var2034 (var1523_getUrl/-275947851 (cast-from-var1936-to-var1523 var212))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1290 String (getProtocol/491749358 var51)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2246 Bool (= var1290 "mock")) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("mock") 
 ; Statement: return $z0 
(check-sat)
; {var1523_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1936-to-var1523=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1936=org.apache.dubbo.rpc.Invoker, var212=r0, var2034=org.apache.dubbo.common.URL, var1523=org.apache.dubbo.common.Node, var51=$r1, var1290=$r2, var2246=$z0}
; {org.apache.dubbo.rpc.Invoker=var1936, r0=var212, org.apache.dubbo.common.URL=var2034, org.apache.dubbo.common.Node=var1523, $r1=var51, $r2=var1290, $z0=var2246}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("mock");	return $z0
;block_num 1