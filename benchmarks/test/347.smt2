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

(declare-sort var2396 0)
(declare-sort var3585 0)
(declare-sort var2051 0)
(declare-sort var2888 0)
(declare-sort var893 0)
(declare-sort var3541 0)
(declare-sort var1997 0)
(declare-sort var3624 0)
(declare-sort var2000 0)
(declare-sort var476 0)
(declare-sort var1216 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var893_getMethodName/-516674313 (var2888) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3585_get/-1216255739 (var3585 Int) var3541)
(declare-fun cast-from-var3541-to-var1997 (var3541) var1997)
(declare-fun var3624_getUrl/-275947851 (var3624) var2051)
(declare-fun cast-from-var1997-to-var3624 (var1997) var3624)
(declare-fun getServiceKey/1456125852 (var2051) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3585_hashCode/349796465 (var3585) Int)
(declare-fun selectors/254373339 (var2396) var2000)
(declare-fun var476_get/1088891777 (var476 var3541) var3541)
(declare-fun cast-from-var2000-to-var476 (var2000) var476)
(declare-fun cast-from-String-to-var3541 (String) var3541)
(declare-fun cast-from-var3541-to-var1216 (var3541) var1216)
(declare-fun var1216-init () var1216)
(declare-fun <init>/-2055049649 (var1216 var3585 String Int) void)
(declare-fun var476_put/1464166817 (var476 var3541 var3541) var3541)
(declare-fun cast-from-var1216-to-var3541 (var1216) var3541)
(declare-fun select/1447344299 (var1216 var2888) var1997)
(declare-const null-var2396 var2396)
(declare-const null-var3585 var3585)
(declare-const null-var2051 var2051)
(declare-const null-var2888 var2888)
(declare-const null-var1216 var1216)
(declare-const var446 var2396) ; Statement: r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance 
(assert (not (= var446 null-var2396)))
(declare-const var3756 var3585) ; Statement: r3 := @parameter0: java.util.List 
(assert (not (= var3756 null-var3585)))
(declare-const var1154 var2051) ; Statement: r19 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1154 null-var2051)))
(declare-const var1282 var2888) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1282 null-var2888)))
(define-const var628 String (var893_getMethodName/-516674313 var1282)) ; Statement: r1 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var1614 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1614)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1614!1 String)
(assert (= var1614!1 ""))
(define-const var1078 var3541 (var3585_get/-1216255739 var3756 0)) ; Statement: $r4 = interfaceinvoke r3.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var2569 var1997 (cast-from-var3541-to-var1997 var1078)) ; Statement: $r5 = (org.apache.dubbo.rpc.Invoker) $r4 
(define-const var468 var2051 (var3624_getUrl/-275947851 (cast-from-var1997-to-var3624 var2569))) ; Statement: $r6 = interfaceinvoke $r5.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2531 String (getServiceKey/1456125852 var468)) ; Statement: $r7 = virtualinvoke $r6.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var2324 String (append/672562846 var1614!1 var2531)) ; Statement: $r8 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1614!2 String)
(assert (= var1614!2 (str.++ var1614!1 var2531)))
(assert true)
(define-const var2272 String (append/672562846 var2324 ".")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var2324!1 String)
(assert (= var2324!1 (str.++ var2324 ".")))
(assert true)
(define-const var1280 String (append/672562846 var2272 var628)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2272!1 String)
(assert (= var2272!1 (str.++ var2272 var628)))
(assert true)
(define-const var3950 String (toString/-2075883882 var1280)) ; Statement: r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3098 Int (var3585_hashCode/349796465 var3756)) ; Statement: i0 = interfaceinvoke r3.<java.util.List: int hashCode()>() 
(define-const var3367 var2000 (selectors/254373339 var446)) ; Statement: $r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors> 
(define-const var1560 var3541 (var476_get/1088891777 (cast-from-var2000-to-var476 var3367) (cast-from-String-to-var3541 var3950))) ; Statement: $r14 = interfaceinvoke $r13.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11) 
(define-const var1254 var1216 (cast-from-var3541-to-var1216 var1560)) ; Statement: r20 = (org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector) $r14 
 ; Statement: if r20 == null goto $r16 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors> 
(assert (= var1254 null-var1216)) ; Cond: r20 == null 
(define-const var1386 var2000 (selectors/254373339 var446)) ; Statement: $r16 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors> 
(define-const var268 var1216 var1216-init) ; Statement: $r15 = new org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector 
(assert true)
;(assert (<init>/-2055049649 var268 var3756 var628 var3098)) ; Statement: specialinvoke $r15.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: void <init>(java.util.List,java.lang.String,int)>(r3, r1, i0) 

(declare-const var268!1 var1216)
(declare-const var3756!1 var3585)
(declare-const var628!1 String)
(declare-const var3098!1 Int)
;(assert (var476_put/1464166817 (cast-from-var2000-to-var476 var1386) (cast-from-String-to-var3541 var3950) (cast-from-var1216-to-var3541 var268!1))) ; Statement: interfaceinvoke $r16.<java.util.concurrent.ConcurrentMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r11, $r15) 

(declare-const var1386!1 var2000)
(declare-const var3950!1 String)
(declare-const var268!2 var1216)
(define-const var1514 var2000 (selectors/254373339 var446)) ; Statement: $r17 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors> 
(define-const var2406 var3541 (var476_get/1088891777 (cast-from-var2000-to-var476 var1514) (cast-from-String-to-var3541 var3950!1))) ; Statement: $r18 = interfaceinvoke $r17.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11) 
(define-const var1254!1 var1216 (cast-from-var3541-to-var1216 var2406)) ; Statement: r20 = (org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector) $r18 
(assert true) ; Non Conditional
(assert true)
(define-const var3686 var1997 (select/1447344299 var1254!1 var1282)) ; Statement: $r21 = virtualinvoke r20.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: org.apache.dubbo.rpc.Invoker select(org.apache.dubbo.rpc.Invocation)>(r0) 
 ; Statement: return $r21 
(check-sat)
; {var893_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3585_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var3541-to-var1997=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var3624_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1997-to-var3624=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3585_hashCode/349796465=([java.util.List], int), selectors/254373339=([org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance], java.util.concurrent.ConcurrentMap), var476_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var2000-to-var476=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var3541=([java.lang.String], java.lang.Object), cast-from-var3541-to-var1216=([java.lang.Object], org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector), var1216-init=([], org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector), <init>/-2055049649=([org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector, java.util.List, java.lang.String, int], void), var476_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var1216-to-var3541=([org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector], java.lang.Object), select/1447344299=([org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Invoker)}
; {var2396=org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance, var446=r12, var3585=java.util.List, var3756=r3, var2051=org.apache.dubbo.common.URL, var1154=r19, var2888=org.apache.dubbo.rpc.Invocation, var1282=r0, var893=org.apache.dubbo.rpc.support.RpcUtils, var628=r1, var1614=$r2, var3541=java.lang.Object, var1078=$r4, var1997=org.apache.dubbo.rpc.Invoker, var2569=$r5, var3624=org.apache.dubbo.common.Node, var468=$r6, var2531=$r7, var2324=$r8, var2272=$r9, var1280=$r10, var3950=r11, var3098=i0, var2000=java.util.concurrent.ConcurrentMap, var3367=$r13, var476=java.util.Map, var1560=$r14, var1216=org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector, var1254=r20, var1386=$r16, var268=$r15, var1514=$r17, var2406=$r18, var3686=$r21}
; {org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance=var2396, r12=var446, java.util.List=var3585, r3=var3756, org.apache.dubbo.common.URL=var2051, r19=var1154, org.apache.dubbo.rpc.Invocation=var2888, r0=var1282, org.apache.dubbo.rpc.support.RpcUtils=var893, r1=var628, $r2=var1614, java.lang.Object=var3541, $r4=var1078, org.apache.dubbo.rpc.Invoker=var1997, $r5=var2569, org.apache.dubbo.common.Node=var3624, $r6=var468, $r7=var2531, $r8=var2324, $r9=var2272, $r10=var1280, r11=var3950, i0=var3098, java.util.concurrent.ConcurrentMap=var2000, $r13=var3367, java.util.Map=var476, $r14=var1560, org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector=var1216, r20=var1254, $r16=var1386, $r15=var268, $r17=var1514, $r18=var2406, $r21=var3686}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance;	r3 := @parameter0: java.util.List;	r19 := @parameter1: org.apache.dubbo.common.URL;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	r1 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = interfaceinvoke r3.<java.util.List: java.lang.Object get(int)>(0);	$r5 = (org.apache.dubbo.rpc.Invoker) $r4;	$r6 = interfaceinvoke $r5.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r7 = virtualinvoke $r6.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r8 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	i0 = interfaceinvoke r3.<java.util.List: int hashCode()>();	$r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors>;	$r14 = interfaceinvoke $r13.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11);	r20 = (org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector) $r14;	if r20 == null goto $r16 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors>;	$r16 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors>;	$r15 = new org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector;	specialinvoke $r15.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: void <init>(java.util.List,java.lang.String,int)>(r3, r1, i0);	interfaceinvoke $r16.<java.util.concurrent.ConcurrentMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r11, $r15);	$r17 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance: java.util.concurrent.ConcurrentMap selectors>;	$r18 = interfaceinvoke $r17.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11);	r20 = (org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector) $r18;	$r21 = virtualinvoke r20.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: org.apache.dubbo.rpc.Invoker select(org.apache.dubbo.rpc.Invocation)>(r0);	return $r21
;block_num 3