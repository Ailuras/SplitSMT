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

(declare-sort var3628 0)
(declare-sort var834 0)
(declare-sort var2268 0)
(declare-sort var3495 0)
(declare-sort var2124 0)
(declare-sort var3276 0)
(declare-sort var1266 0)
(declare-sort var1249 0)
(declare-sort var1474 0)
(declare-sort var362 0)
(declare-sort var2488 0)
(declare-sort var2360 0)
(declare-sort var561 0)
(declare-sort var855 0)
(declare-sort var2387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var834_get/-1216255739 (var834 Int) var2124)
(declare-fun cast-from-var2124-to-var3276 (var2124) var3276)
(declare-fun var1266_getUrl/-275947851 (var1266) var2268)
(declare-fun cast-from-var3276-to-var1266 (var3276) var1266)
(declare-fun getServiceKey/1456125852 (var2268) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1249_getMethodName/-516674313 (var3495) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun methodWeightMap/1803923679 (var3628) var1474)
(declare-fun var2488_bootstrap$/1935585354 () var362)
(declare-fun var2360_computeIfAbsent/-1297680746 (var1474 var2124 var362) var2124)
(declare-fun cast-from-String-to-var2124 (String) var2124)
(declare-fun cast-from-var2124-to-var1474 (var2124) var1474)
(declare-fun var561_currentTimeMillis/630293680 () Int)
(declare-fun var834_iterator/-912451715 (var834) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var834_size/-959786421 (var834) Int)
(declare-fun var2387_size/-1594421051 (var2387) Int)
(declare-fun cast-from-var1474-to-var2387 (var1474) var2387)
(declare-const null-var3628 var3628)
(declare-const null-var834 var834)
(declare-const null-var2268 var2268)
(declare-const null-var3495 var3495)
(declare-const null-var3276 var3276)
(declare-const null-var855 var855)
(declare-const var3055 var3628) ; Statement: r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance 
(assert (not (= var3055 null-var3628)))
(declare-const var3141 var834) ; Statement: r1 := @parameter0: java.util.List 
(assert (not (= var3141 null-var834)))
(declare-const var2103 var2268) ; Statement: r29 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var2103 null-var2268)))
(declare-const var1108 var3495) ; Statement: r7 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1108 null-var3495)))
(define-const var2810 String String-init) ; Statement: $r32 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2810)) ; Statement: specialinvoke $r32.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2810!1 String)
(assert (= var2810!1 ""))
(define-const var3443 var2124 (var834_get/-1216255739 var3141 0)) ; Statement: $r2 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var2677 var3276 (cast-from-var2124-to-var3276 var3443)) ; Statement: $r3 = (org.apache.dubbo.rpc.Invoker) $r2 
(define-const var726 var2268 (var1266_getUrl/-275947851 (cast-from-var3276-to-var1266 var2677))) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var127 String (getServiceKey/1456125852 var726)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var2509 String (append/672562846 var2810!1 var127)) ; Statement: $r6 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2810!2 String)
(assert (= var2810!2 (str.++ var2810!1 var127)))
(assert true)
(define-const var2315 String (append/672562846 var2509 ".")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var2509!1 String)
(assert (= var2509!1 (str.++ var2509 ".")))
(define-const var2634 String (var1249_getMethodName/-516674313 var1108)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r7) 
(assert true)
(define-const var1355 String (append/672562846 var2315 var2634)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var2315!1 String)
(assert (= var2315!1 (str.++ var2315 var2634)))
(assert true)
(define-const var349 String (toString/-2075883882 var1355)) ; Statement: r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var622 var1474 (methodWeightMap/1803923679 var3055)) ; Statement: $r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance: java.util.concurrent.ConcurrentMap methodWeightMap> 
(define-const var1380 var362 var2488_bootstrap$/1935585354) ; Statement: $r14 = staticinvoke <org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$lambda_doSelect_0__42: java.util.function.Function bootstrap$()>() 
(define-const var3525 var2124 (var2360_computeIfAbsent/-1297680746 var622 (cast-from-String-to-var2124 var349) var1380)) ; Statement: $r15 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r13, r11, $r14) 
(define-const var654 var1474 (cast-from-var2124-to-var1474 var3525)) ; Statement: r16 = (java.util.concurrent.ConcurrentMap) $r15 
(define-const var3127 Int 0) ; Statement: i7 = 0 
(define-const var2740 Int -9223372036854775808) ; Statement: l8 = -9223372036854775808L 
(define-const var2739 Int var561_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var2863 var3276 null-var3276) ; Statement: r30 = null 
(define-const var1277 var855 null-var855) ; Statement: r31 = null 
(define-const var1200 Iterator (var834_iterator/-912451715 var3141)) ; Statement: r17 = interfaceinvoke r1.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3630 Bool (Iterator_hasNext/-1669924200 var1200)) ; Statement: $z0 = interfaceinvoke r17.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $i2 = interfaceinvoke r1.<java.util.List: int size()>() 
(assert (= (ite var3630 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2719 Int (var834_size/-959786421 var3141)) ; Statement: $i2 = interfaceinvoke r1.<java.util.List: int size()>() 
(define-const var3643 Int (var2387_size/-1594421051 (cast-from-var1474-to-var2387 var654))) ; Statement: $i1 = interfaceinvoke r16.<java.util.concurrent.ConcurrentMap: int size()>() 
 ; Statement: if $i2 == $i1 goto (branch) 
(assert (= var2719 var3643)) ; Cond: $i2 == $i1 
 ; Statement: if r30 == null goto $r18 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0) 
(assert (= var2863 null-var3276)) ; Cond: r30 == null 
(define-const var2191 var2124 (var834_get/-1216255739 var3141 0)) ; Statement: $r18 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var1693 var3276 (cast-from-var2124-to-var3276 var2191)) ; Statement: $r19 = (org.apache.dubbo.rpc.Invoker) $r18 
 ; Statement: return $r19 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var834_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var2124-to-var3276=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var1266_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3276-to-var1266=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1249_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), methodWeightMap/1803923679=([org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance], java.util.concurrent.ConcurrentMap), var2488_bootstrap$/1935585354=([], java.util.function.Function), var2360_computeIfAbsent/-1297680746=([java.util.concurrent.ConcurrentMap, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var2124=([java.lang.String], java.lang.Object), cast-from-var2124-to-var1474=([java.lang.Object], java.util.concurrent.ConcurrentMap), var561_currentTimeMillis/630293680=([], long), var834_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var834_size/-959786421=([java.util.List], int), var2387_size/-1594421051=([java.util.Map], int), cast-from-var1474-to-var2387=([java.util.concurrent.ConcurrentMap], java.util.Map)}
; {var3628=org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance, var3055=r12, var834=java.util.List, var3141=r1, var2268=org.apache.dubbo.common.URL, var2103=r29, var3495=org.apache.dubbo.rpc.Invocation, var1108=r7, var2810=$r32, var2124=java.lang.Object, var3443=$r2, var3276=org.apache.dubbo.rpc.Invoker, var2677=$r3, var1266=org.apache.dubbo.common.Node, var726=$r4, var127=$r5, var2509=$r6, var2315=$r9, var1249=org.apache.dubbo.rpc.support.RpcUtils, var2634=$r8, var1355=$r10, var349=r11, var1474=java.util.concurrent.ConcurrentMap, var622=$r13, var362=java.util.function.Function, var2488=org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$lambda_doSelect_0__42, var1380=$r14, var2360=org.apache.dubbo.common.utils.ConcurrentHashMapUtils, var3525=$r15, var654=r16, var3127=i7, var2740=l8, var561=java.lang.System, var2739=l0, var2863=r30, var855=org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$WeightedRoundRobin, var1277=r31, var1200=r17, var3630=$z0, var2719=$i2, var2387=java.util.Map, var3643=$i1, var2191=$r18, var1693=$r19}
; {org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance=var3628, r12=var3055, java.util.List=var834, r1=var3141, org.apache.dubbo.common.URL=var2268, r29=var2103, org.apache.dubbo.rpc.Invocation=var3495, r7=var1108, $r32=var2810, java.lang.Object=var2124, $r2=var3443, org.apache.dubbo.rpc.Invoker=var3276, $r3=var2677, org.apache.dubbo.common.Node=var1266, $r4=var726, $r5=var127, $r6=var2509, $r9=var2315, org.apache.dubbo.rpc.support.RpcUtils=var1249, $r8=var2634, $r10=var1355, r11=var349, java.util.concurrent.ConcurrentMap=var1474, $r13=var622, java.util.function.Function=var362, org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$lambda_doSelect_0__42=var2488, $r14=var1380, org.apache.dubbo.common.utils.ConcurrentHashMapUtils=var2360, $r15=var3525, r16=var654, i7=var3127, l8=var2740, java.lang.System=var561, l0=var2739, r30=var2863, org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$WeightedRoundRobin=var855, r31=var1277, r17=var1200, $z0=var3630, $i2=var2719, java.util.Map=var2387, $i1=var3643, $r18=var2191, $r19=var1693}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance;	r1 := @parameter0: java.util.List;	r29 := @parameter1: org.apache.dubbo.common.URL;	r7 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r32 = new java.lang.StringBuilder;	specialinvoke $r32.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0);	$r3 = (org.apache.dubbo.rpc.Invoker) $r2;	$r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r6 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance: java.util.concurrent.ConcurrentMap methodWeightMap>;	$r14 = staticinvoke <org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$lambda_doSelect_0__42: java.util.function.Function bootstrap$()>();	$r15 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r13, r11, $r14);	r16 = (java.util.concurrent.ConcurrentMap) $r15;	i7 = 0;	l8 = -9223372036854775808L;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	r30 = null;	r31 = null;	r17 = interfaceinvoke r1.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r17.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $i2 = interfaceinvoke r1.<java.util.List: int size()>();	$i2 = interfaceinvoke r1.<java.util.List: int size()>();	$i1 = interfaceinvoke r16.<java.util.concurrent.ConcurrentMap: int size()>();	if $i2 == $i1 goto (branch);	if r30 == null goto $r18 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0);	$r18 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0);	$r19 = (org.apache.dubbo.rpc.Invoker) $r18;	return $r19
;block_num 5