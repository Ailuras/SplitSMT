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

(declare-sort var2105 0)
(declare-sort var3930 0)
(declare-sort var3574 0)
(declare-sort var1924 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1924_getUrl/-275947851 (var1924) var3574)
(declare-fun cast-from-var3930-to-var1924 (var3930) var1924)
(declare-fun getProtocol/491749358 (var3574) String)
(declare-const null-var2105 var2105)
(declare-const null-var3930 var3930)
(declare-const var3959 var2105) ; Statement: r5 := @this: org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol 
(assert (not (= var3959 null-var2105)))
(declare-const var3901 var3930) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3901 null-var3930)))
(define-const var3666 var3574 (var1924_getUrl/-275947851 (cast-from-var3930-to-var1924 var3901))) ; Statement: r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2954 String "registry") ; Statement: $r2 = "registry" 
(assert true)
(define-const var2301 String (getProtocol/491749358 var3666)) ; Statement: $r1 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var646 Bool (= var2954 var2301)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto return r6 
(assert (= (ite var646 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r6 
(check-sat)
; {var1924_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3930-to-var1924=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var2105=org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol, var3959=r5, var3930=org.apache.dubbo.rpc.Invoker, var3901=r0, var3574=org.apache.dubbo.common.URL, var1924=org.apache.dubbo.common.Node, var3666=r6, var2954=$r2, var2301=$r1, var646=$z0}
; {org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol=var2105, r5=var3959, org.apache.dubbo.rpc.Invoker=var3930, r0=var3901, org.apache.dubbo.common.URL=var3574, org.apache.dubbo.common.Node=var1924, r6=var3666, $r2=var2954, $r1=var2301, $z0=var646}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = "registry";	$r1 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto return r6;	return r6
;block_num 2