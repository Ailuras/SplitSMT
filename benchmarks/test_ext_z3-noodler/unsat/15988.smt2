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

(declare-sort var1176 0)
(declare-sort var2473 0)
(declare-sort var1462 0)
(declare-sort var2699 0)
(declare-sort var2621 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2699_getUrl/-275947851 (var2699) var1462)
(declare-fun cast-from-var2473-to-var2699 (var2473) var2699)
(declare-fun getAttribute/-225665909 (var1462 String) var2621)
(declare-fun cast-from-var2621-to-var1462 (var2621) var1462)
(declare-const null-var1176 var1176)
(declare-const null-var2473 var2473)
(declare-const var1586 var1176) ; Statement: r11 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var1586 null-var1176)))
(declare-const var240 var2473) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var240 null-var2473)))
(define-const var1126 var1462 (var2699_getUrl/-275947851 (cast-from-var2473-to-var2699 var240))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2374 var2621 (getAttribute/-225665909 var1126 "export")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("export") 
(define-const var1533 Bool false) ; Statement: $z0 = r2 instanceof org.apache.dubbo.common.URL 
 ; Statement: if $z0 != 0 goto $r3 = (org.apache.dubbo.common.URL) r2 
(assert (not (= (ite var1533 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3851 var1462 (cast-from-var2621-to-var1462 var2374)) ; Statement: $r3 = (org.apache.dubbo.common.URL) r2 
 ; Statement: return $r3 
(check-sat)
; {var2699_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2473-to-var2699=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getAttribute/-225665909=([org.apache.dubbo.common.URL, java.lang.String], java.lang.Object), cast-from-var2621-to-var1462=([java.lang.Object], org.apache.dubbo.common.URL)}
; {var1176=org.apache.dubbo.registry.integration.RegistryProtocol, var1586=r11, var2473=org.apache.dubbo.rpc.Invoker, var240=r0, var1462=org.apache.dubbo.common.URL, var2699=org.apache.dubbo.common.Node, var1126=$r1, var2621=java.lang.Object, var2374=r2, var1533=$z0, var3851=$r3}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var1176, r11=var1586, org.apache.dubbo.rpc.Invoker=var2473, r0=var240, org.apache.dubbo.common.URL=var1462, org.apache.dubbo.common.Node=var2699, $r1=var1126, java.lang.Object=var2621, r2=var2374, $z0=var1533, $r3=var3851}
;seq 
;cnt {}
;stmts r11 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("export");	$z0 = r2 instanceof org.apache.dubbo.common.URL;	if $z0 != 0 goto $r3 = (org.apache.dubbo.common.URL) r2;	$r3 = (org.apache.dubbo.common.URL) r2;	return $r3
;block_num 2