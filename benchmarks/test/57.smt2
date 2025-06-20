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

(declare-sort var2353 0)
(declare-sort var3515 0)
(declare-sort var3 0)
(declare-sort var738 0)
(declare-sort var1569 0)
(declare-sort var1820 0)
(declare-sort var566 0)
(declare-sort var2208 0)
(declare-sort var1046 0)
(declare-sort var2988 0)
(declare-sort var1057 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1569_getMethodName/-516674313 (var738) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3515_get/-1216255739 (var3515 Int) var1820)
(declare-fun cast-from-var1820-to-var566 (var1820) var566)
(declare-fun var2208_getUrl/-275947851 (var2208) var3)
(declare-fun cast-from-var566-to-var2208 (var566) var2208)
(declare-fun getServiceKey/1456125852 (var3) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3515_hashCode/349796465 (var3515) Int)
(declare-fun selectors/254373339 (var2353) var1046)
(declare-fun var2988_get/1088891777 (var2988 var1820) var1820)
(declare-fun cast-from-var1046-to-var2988 (var1046) var2988)
(declare-fun cast-from-String-to-var1820 (String) var1820)
(declare-fun cast-from-var1820-to-var1057 (var1820) var1057)
(declare-fun var1057_access$000/-845328696 (var1057) Int)
(declare-fun select/1447344299 (var1057 var738) var566)
(declare-const null-var2353 var2353)
(declare-const null-var3515 var3515)
(declare-const null-var3 var3)
(declare-const null-var738 var738)
(declare-const null-var1057 var1057)
(declare-const var2490 var2353) ; Statement: r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance 
(assert (not (= var2490 null-var2353)))
(declare-const var1144 var3515) ; Statement: r3 := @parameter0: java.util.List 
(assert (not (= var1144 null-var3515)))
(declare-const var489 var3) ; Statement: r19 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var489 null-var3)))
(declare-const var2186 var738) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2186 null-var738)))
(define-const var2789 String (var1569_getMethodName/-516674313 var2186)) ; Statement: r1 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var3971 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3971)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3971!1 String)
(assert (= var3971!1 ""))
(define-const var3366 var1820 (var3515_get/-1216255739 var1144 0)) ; Statement: $r4 = interfaceinvoke r3.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var843 var566 (cast-from-var1820-to-var566 var3366)) ; Statement: $r5 = (org.apache.dubbo.rpc.Invoker) $r4 
(define-const var2298 var3 (var2208_getUrl/-275947851 (cast-from-var566-to-var2208 var843))) ; Statement: $r6 = interfaceinvoke $r5.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2094 String (getServiceKey/1456125852 var2298)) ; Statement: $r7 = virtualinvoke $r6.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var1208 String (append/672562846 var3971!1 var2094)) ; Statement: $r8 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3971!2 String)
(assert (= var3971!2 (str.++ var3971!1 var2094)))
(assert true)
(define-const var3833 String (append/672562846 var1208 ".")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var1208!1 String)
(assert (= var1208!1 (str.++ var1208 ".")))
(assert true)
(define-const var1783 String (append/672562846 var3833 var2789)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3833!1 String)
(assert (= var3833!1 (str.++ var3833 var2789)))
(assert true)
(define-const var657 String (toString/-2075883882 var1783)) ; Statement: r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var902 Int (var3515_hashCode/349796465 var1144)) ; Statement: i0 = interfaceinvoke r3.<java.util.List: int hashCode()>() 
(define-const var2448 var1046 (selectors/254373339 var2490)) ; Statement: $r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors> 
(define-const var458 var1820 (var2988_get/1088891777 (cast-from-var1046-to-var2988 var2448) (cast-from-String-to-var1820 var657))) ; Statement: $r14 = interfaceinvoke $r13.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11) 
(define-const var905 var1057 (cast-from-var1820-to-var1057 var458)) ; Statement: r20 = (org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector) $r14 
 ; Statement: if r20 == null goto $r16 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors> 
(assert (not (= var905 null-var1057))) ; Negate: Cond: r20 == null  
(define-const var3337 Int (var1057_access$000/-845328696 var905)) ; Statement: $i1 = staticinvoke <org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: int access$000(org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector)>(r20) 
 ; Statement: if $i1 == i0 goto $r21 = virtualinvoke r20.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: org.apache.dubbo.rpc.Invoker select(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert (= var3337 var902)) ; Cond: $i1 == i0 
(assert true)
(define-const var1079 var566 (select/1447344299 var905 var2186)) ; Statement: $r21 = virtualinvoke r20.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: org.apache.dubbo.rpc.Invoker select(org.apache.dubbo.rpc.Invocation)>(r0) 
 ; Statement: return $r21 
(check-sat)
; {var1569_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3515_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var1820-to-var566=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var2208_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var566-to-var2208=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3515_hashCode/349796465=([java.util.List], int), selectors/254373339=([org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance], java.util.concurrent.ConcurrentMap), var2988_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1046-to-var2988=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var1820=([java.lang.String], java.lang.Object), cast-from-var1820-to-var1057=([java.lang.Object], org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector), var1057_access$000/-845328696=([org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector], int), select/1447344299=([org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Invoker)}
; {var2353=org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance, var2490=r12, var3515=java.util.List, var1144=r3, var3=org.apache.dubbo.common.URL, var489=r19, var738=org.apache.dubbo.rpc.Invocation, var2186=r0, var1569=org.apache.dubbo.rpc.support.RpcUtils, var2789=r1, var3971=$r2, var1820=java.lang.Object, var3366=$r4, var566=org.apache.dubbo.rpc.Invoker, var843=$r5, var2208=org.apache.dubbo.common.Node, var2298=$r6, var2094=$r7, var1208=$r8, var3833=$r9, var1783=$r10, var657=r11, var902=i0, var1046=java.util.concurrent.ConcurrentMap, var2448=$r13, var2988=java.util.Map, var458=$r14, var1057=org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector, var905=r20, var3337=$i1, var1079=$r21}
; {org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance=var2353, r12=var2490, java.util.List=var3515, r3=var1144, org.apache.dubbo.common.URL=var3, r19=var489, org.apache.dubbo.rpc.Invocation=var738, r0=var2186, org.apache.dubbo.rpc.support.RpcUtils=var1569, r1=var2789, $r2=var3971, java.lang.Object=var1820, $r4=var3366, org.apache.dubbo.rpc.Invoker=var566, $r5=var843, org.apache.dubbo.common.Node=var2208, $r6=var2298, $r7=var2094, $r8=var1208, $r9=var3833, $r10=var1783, r11=var657, i0=var902, java.util.concurrent.ConcurrentMap=var1046, $r13=var2448, java.util.Map=var2988, $r14=var458, org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector=var1057, r20=var905, $i1=var3337, $r21=var1079}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance;	r3 := @parameter0: java.util.List;	r19 := @parameter1: org.apache.dubbo.common.URL;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	r1 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = interfaceinvoke r3.<java.util.List: java.lang.Object get(int)>(0);	$r5 = (org.apache.dubbo.rpc.Invoker) $r4;	$r6 = interfaceinvoke $r5.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r7 = virtualinvoke $r6.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r8 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	i0 = interfaceinvoke r3.<java.util.List: int hashCode()>();	$r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors>;	$r14 = interfaceinvoke $r13.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11);	r20 = (org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector) $r14;	if r20 == null goto $r16 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors>;	$i1 = staticinvoke <org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: int access$000(org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector)>(r20);	if $i1 == i0 goto $r21 = virtualinvoke r20.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: org.apache.dubbo.rpc.Invoker select(org.apache.dubbo.rpc.Invocation)>(r0);	$r21 = virtualinvoke r20.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: org.apache.dubbo.rpc.Invoker select(org.apache.dubbo.rpc.Invocation)>(r0);	return $r21
;block_num 3