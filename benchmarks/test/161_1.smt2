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

(declare-sort var2677 0)
(declare-sort var3675 0)
(declare-sort var2266 0)
(declare-sort var1384 0)
(declare-sort var1935 0)
(declare-sort var264 0)
(declare-sort var712 0)
(declare-sort var2383 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3675_get/-1216255739 (var3675 Int) var1384)
(declare-fun cast-from-var1384-to-var1935 (var1384) var1935)
(declare-fun var712_getUrl/-275947851 (var712) var264)
(declare-fun cast-from-var1935-to-var712 (var1935) var712)
(declare-fun getServiceInterface/-1311863806 (var264) String)
(declare-fun getParameter/-1307325648 (var264 String) String)
(declare-fun var2383_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2677 var2677)
(declare-const null-var3675 var3675)
(declare-const null-var2266 var2266)
(declare-const var1532 var2677) ; Statement: r10 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RandomLoadBalance 
(assert (not (= var1532 null-var2677)))
(declare-const var837 var3675) ; Statement: r0 := @parameter0: java.util.List 
(assert (not (= var837 null-var3675)))
(declare-const var3244 var2266) ; Statement: r5 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3244 null-var2266)))
(define-const var3149 var1384 (var3675_get/-1216255739 var837 0)) ; Statement: $r1 = interfaceinvoke r0.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var486 var1935 (cast-from-var1384-to-var1935 var3149)) ; Statement: r2 = (org.apache.dubbo.rpc.Invoker) $r1 
(define-const var3986 var264 (var712_getUrl/-275947851 (cast-from-var1935-to-var712 var486))) ; Statement: r11 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2746 Bool true) ; Statement: $z0 = r2 instanceof org.apache.dubbo.rpc.cluster.ClusterInvoker 
 ; Statement: if $z0 == 0 goto $r4 = "org.apache.dubbo.registry.RegistryService" 
(assert (= (ite var2746 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2828 String "org.apache.dubbo.registry.RegistryService") ; Statement: $r4 = "org.apache.dubbo.registry.RegistryService" 
(assert true)
(define-const var3732 String (getServiceInterface/-1311863806 var3986)) ; Statement: $r3 = virtualinvoke r11.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var130 Bool (= var2828 var3732)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: if $z1 == 0 goto $r6 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r5) 
(assert (not (= (ite var130 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var950 String (getParameter/-1307325648 var3986 "weight")) ; Statement: r12 = virtualinvoke r11.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("weight") 
(define-const var676 Bool (var2383_isNotEmpty/-1251449450 var950)) ; Statement: $z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12) 
 ; Statement: return $z4 
(check-sat)
; {var3675_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var1384-to-var1935=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var712_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1935-to-var712=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2383_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2677=org.apache.dubbo.rpc.cluster.loadbalance.RandomLoadBalance, var1532=r10, var3675=java.util.List, var837=r0, var2266=org.apache.dubbo.rpc.Invocation, var3244=r5, var1384=java.lang.Object, var3149=$r1, var1935=org.apache.dubbo.rpc.Invoker, var486=r2, var264=org.apache.dubbo.common.URL, var712=org.apache.dubbo.common.Node, var3986=r11, var2746=$z0, var2828=$r4, var3732=$r3, var130=$z1, var950=r12, var2383=org.apache.dubbo.common.utils.StringUtils, var676=$z4}
; {org.apache.dubbo.rpc.cluster.loadbalance.RandomLoadBalance=var2677, r10=var1532, java.util.List=var3675, r0=var837, org.apache.dubbo.rpc.Invocation=var2266, r5=var3244, java.lang.Object=var1384, $r1=var3149, org.apache.dubbo.rpc.Invoker=var1935, r2=var486, org.apache.dubbo.common.URL=var264, org.apache.dubbo.common.Node=var712, r11=var3986, $z0=var2746, $r4=var2828, $r3=var3732, $z1=var130, r12=var950, org.apache.dubbo.common.utils.StringUtils=var2383, $z4=var676}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r10 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RandomLoadBalance;	r0 := @parameter0: java.util.List;	r5 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<java.util.List: java.lang.Object get(int)>(0);	r2 = (org.apache.dubbo.rpc.Invoker) $r1;	r11 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$z0 = r2 instanceof org.apache.dubbo.rpc.cluster.ClusterInvoker;	if $z0 == 0 goto $r4 = "org.apache.dubbo.registry.RegistryService";	$r4 = "org.apache.dubbo.registry.RegistryService";	$r3 = virtualinvoke r11.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	if $z1 == 0 goto $r6 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r5);	r12 = virtualinvoke r11.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("weight");	$z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12);	return $z4
;block_num 3