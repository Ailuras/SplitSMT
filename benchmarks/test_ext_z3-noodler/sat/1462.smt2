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

(declare-sort var2048 0)
(declare-sort var3546 0)
(declare-sort var3136 0)
(declare-sort var365 0)
(declare-sort var1552 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getUrl/-686284803 (var2048) var3136)
(declare-fun getServiceKey/1456125852 (var3136) String)
(declare-fun var3546_getInvoker/371389982 (var3546) var365)
(declare-fun var1552_getUrl/-275947851 (var1552) var3136)
(declare-fun cast-from-var365-to-var1552 (var365) var1552)
(declare-const null-var2048 var2048)
(declare-const null-var3546 var3546)
(declare-const var3719 var2048) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker 
(assert (not (= var3719 null-var2048)))
(declare-const var3089 var3546) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Exporter 
(assert (not (= var3089 null-var3546)))
(assert true)
(define-const var975 var3136 (getUrl/-686284803 var3719)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3585 String (getServiceKey/1456125852 var975)) ; Statement: $r6 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(define-const var896 var365 (var3546_getInvoker/371389982 var3089)) ; Statement: $r3 = interfaceinvoke r2.<org.apache.dubbo.rpc.Exporter: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(define-const var3557 var3136 (var1552_getUrl/-275947851 (cast-from-var365-to-var1552 var896))) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1257 String (getServiceKey/1456125852 var3557)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var1006 Bool (= var3585 var1257)) ; Statement: $z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var1006 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getUrl/-686284803=([org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker], org.apache.dubbo.common.URL), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), var3546_getInvoker/371389982=([org.apache.dubbo.rpc.Exporter], org.apache.dubbo.rpc.Invoker), var1552_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var365-to-var1552=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node)}
; {var2048=org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker, var3719=r0, var3546=org.apache.dubbo.rpc.Exporter, var3089=r2, var3136=org.apache.dubbo.common.URL, var975=$r1, var3585=$r6, var365=org.apache.dubbo.rpc.Invoker, var896=$r3, var1552=org.apache.dubbo.common.Node, var3557=$r4, var1257=$r5, var1006=$z0}
; {org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker=var2048, r0=var3719, org.apache.dubbo.rpc.Exporter=var3546, r2=var3089, org.apache.dubbo.common.URL=var3136, $r1=var975, $r6=var3585, org.apache.dubbo.rpc.Invoker=var365, $r3=var896, org.apache.dubbo.common.Node=var1552, $r4=var3557, $r5=var1257, $z0=var1006}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker;	r2 := @parameter0: org.apache.dubbo.rpc.Exporter;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.common.URL getUrl()>();	$r6 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r3 = interfaceinvoke r2.<org.apache.dubbo.rpc.Exporter: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if $z0 == 0 goto return;	return
;block_num 2