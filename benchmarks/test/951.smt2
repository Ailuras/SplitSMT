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

(declare-sort var1914 0)
(declare-sort var3025 0)
(declare-sort var1368 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1368_getUrl/-275947851 (var1368) var3025)
(declare-fun cast-from-var1914-to-var1368 (var1914) var1368)
(declare-fun getProtocol/491749358 (var3025) String)
(declare-const null-var1914 var1914)
(declare-const var1738 var1914) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1738 null-var1914)))
(define-const var1404 var3025 (var1368_getUrl/-275947851 (cast-from-var1914-to-var1368 var1738))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1281 String (getProtocol/491749358 var1404)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2430 Bool (= var1281 "mock")) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("mock") 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var2430 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1960 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var1368_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1914-to-var1368=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1914=org.apache.dubbo.rpc.Invoker, var1738=r0, var3025=org.apache.dubbo.common.URL, var1368=org.apache.dubbo.common.Node, var1404=$r1, var1281=$r2, var2430=$z0, var1960=$z1}
; {org.apache.dubbo.rpc.Invoker=var1914, r0=var1738, org.apache.dubbo.common.URL=var3025, org.apache.dubbo.common.Node=var1368, $r1=var1404, $r2=var1281, $z0=var2430, $z1=var1960}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("mock");	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3