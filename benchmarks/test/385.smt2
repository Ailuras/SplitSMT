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

(declare-sort var651 0)
(declare-sort var391 0)
(declare-sort var589 0)
(declare-sort var554 0)
(declare-sort var1202 0)
(declare-sort var23 0)
(declare-sort var227 0)
(declare-sort var288 0)
(declare-sort var1523 0)
(declare-sort var3841 0)
(declare-sort var1552 0)
(declare-sort var3033 0)
(declare-sort var3881 0)
(declare-sort var2857 0)
(declare-sort var26 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var391_get/-1216255739 (var391 Int) var1202)
(declare-fun cast-from-var1202-to-var23 (var1202) var23)
(declare-fun var227_getUrl/-275947851 (var227) var589)
(declare-fun cast-from-var23-to-var227 (var23) var227)
(declare-fun getServiceKey/1456125852 (var589) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var288_getMethodName/-516674313 (var554) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun methodWeightMap/1803923679 (var651) var1523)
(declare-fun var1552_bootstrap$/1935585354 () var3841)
(declare-fun var3033_computeIfAbsent/-1297680746 (var1523 var1202 var3841) var1202)
(declare-fun cast-from-String-to-var1202 (String) var1202)
(declare-fun cast-from-var1202-to-var1523 (var1202) var1523)
(declare-fun var3881_currentTimeMillis/630293680 () Int)
(declare-fun var391_iterator/-912451715 (var391) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var391_size/-959786421 (var391) Int)
(declare-fun var26_size/-1594421051 (var26) Int)
(declare-fun cast-from-var1523-to-var26 (var1523) var26)
(declare-fun sel/-596206420 (var2857 Int) void)
(declare-const null-var651 var651)
(declare-const null-var391 var391)
(declare-const null-var589 var589)
(declare-const null-var554 var554)
(declare-const null-var23 var23)
(declare-const null-var2857 var2857)
(declare-const var1515 var651) ; Statement: r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance 
(assert (not (= var1515 null-var651)))
(declare-const var1414 var391) ; Statement: r1 := @parameter0: java.util.List 
(assert (not (= var1414 null-var391)))
(declare-const var3024 var589) ; Statement: r29 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3024 null-var589)))
(declare-const var560 var554) ; Statement: r7 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var560 null-var554)))
(define-const var312 String String-init) ; Statement: $r32 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var312)) ; Statement: specialinvoke $r32.<java.lang.StringBuilder: void <init>()>() 
(declare-const var312!1 String)
(assert (= var312!1 ""))
(define-const var1008 var1202 (var391_get/-1216255739 var1414 0)) ; Statement: $r2 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var290 var23 (cast-from-var1202-to-var23 var1008)) ; Statement: $r3 = (org.apache.dubbo.rpc.Invoker) $r2 
(define-const var147 var589 (var227_getUrl/-275947851 (cast-from-var23-to-var227 var290))) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2154 String (getServiceKey/1456125852 var147)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var149 String (append/672562846 var312!1 var2154)) ; Statement: $r6 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var312!2 String)
(assert (= var312!2 (str.++ var312!1 var2154)))
(assert true)
(define-const var3297 String (append/672562846 var149 ".")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var149!1 String)
(assert (= var149!1 (str.++ var149 ".")))
(define-const var2498 String (var288_getMethodName/-516674313 var560)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r7) 
(assert true)
(define-const var1527 String (append/672562846 var3297 var2498)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var3297!1 String)
(assert (= var3297!1 (str.++ var3297 var2498)))
(assert true)
(define-const var285 String (toString/-2075883882 var1527)) ; Statement: r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var286 var1523 (methodWeightMap/1803923679 var1515)) ; Statement: $r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance: java.util.concurrent.ConcurrentMap methodWeightMap> 
(define-const var3247 var3841 var1552_bootstrap$/1935585354) ; Statement: $r14 = staticinvoke <org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$lambda_doSelect_0__42: java.util.function.Function bootstrap$()>() 
(define-const var444 var1202 (var3033_computeIfAbsent/-1297680746 var286 (cast-from-String-to-var1202 var285) var3247)) ; Statement: $r15 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r13, r11, $r14) 
(define-const var3136 var1523 (cast-from-var1202-to-var1523 var444)) ; Statement: r16 = (java.util.concurrent.ConcurrentMap) $r15 
(define-const var50 Int 0) ; Statement: i7 = 0 
(define-const var3985 Int -9223372036854775808) ; Statement: l8 = -9223372036854775808L 
(define-const var3635 Int var3881_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var1935 var23 null-var23) ; Statement: r30 = null 
(define-const var3234 var2857 null-var2857) ; Statement: r31 = null 
(define-const var2336 Iterator (var391_iterator/-912451715 var1414)) ; Statement: r17 = interfaceinvoke r1.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3205 Bool (Iterator_hasNext/-1669924200 var2336)) ; Statement: $z0 = interfaceinvoke r17.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $i2 = interfaceinvoke r1.<java.util.List: int size()>() 
(assert (= (ite var3205 1 0) 0)) ; Cond: $z0 == 0 
(define-const var38 Int (var391_size/-959786421 var1414)) ; Statement: $i2 = interfaceinvoke r1.<java.util.List: int size()>() 
(define-const var3467 Int (var26_size/-1594421051 (cast-from-var1523-to-var26 var3136))) ; Statement: $i1 = interfaceinvoke r16.<java.util.concurrent.ConcurrentMap: int size()>() 
 ; Statement: if $i2 == $i1 goto (branch) 
(assert (= var38 var3467)) ; Cond: $i2 == $i1 
 ; Statement: if r30 == null goto $r18 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0) 
(assert (not (= var1935 null-var23))) ; Negate: Cond: r30 == null  
(assert true)
;(assert (sel/-596206420 var3234 var50)) ; Statement: virtualinvoke r31.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$WeightedRoundRobin: void sel(int)>(i7) 

(declare-const var3234!1 var2857)
(declare-const var50!1 Int)
 ; Statement: return r30 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var391_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var1202-to-var23=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var227_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var23-to-var227=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var288_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), methodWeightMap/1803923679=([org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance], java.util.concurrent.ConcurrentMap), var1552_bootstrap$/1935585354=([], java.util.function.Function), var3033_computeIfAbsent/-1297680746=([java.util.concurrent.ConcurrentMap, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var1202=([java.lang.String], java.lang.Object), cast-from-var1202-to-var1523=([java.lang.Object], java.util.concurrent.ConcurrentMap), var3881_currentTimeMillis/630293680=([], long), var391_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var391_size/-959786421=([java.util.List], int), var26_size/-1594421051=([java.util.Map], int), cast-from-var1523-to-var26=([java.util.concurrent.ConcurrentMap], java.util.Map), sel/-596206420=([org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$WeightedRoundRobin, int], void)}
; {var651=org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance, var1515=r12, var391=java.util.List, var1414=r1, var589=org.apache.dubbo.common.URL, var3024=r29, var554=org.apache.dubbo.rpc.Invocation, var560=r7, var312=$r32, var1202=java.lang.Object, var1008=$r2, var23=org.apache.dubbo.rpc.Invoker, var290=$r3, var227=org.apache.dubbo.common.Node, var147=$r4, var2154=$r5, var149=$r6, var3297=$r9, var288=org.apache.dubbo.rpc.support.RpcUtils, var2498=$r8, var1527=$r10, var285=r11, var1523=java.util.concurrent.ConcurrentMap, var286=$r13, var3841=java.util.function.Function, var1552=org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$lambda_doSelect_0__42, var3247=$r14, var3033=org.apache.dubbo.common.utils.ConcurrentHashMapUtils, var444=$r15, var3136=r16, var50=i7, var3985=l8, var3881=java.lang.System, var3635=l0, var1935=r30, var2857=org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$WeightedRoundRobin, var3234=r31, var2336=r17, var3205=$z0, var38=$i2, var26=java.util.Map, var3467=$i1}
; {org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance=var651, r12=var1515, java.util.List=var391, r1=var1414, org.apache.dubbo.common.URL=var589, r29=var3024, org.apache.dubbo.rpc.Invocation=var554, r7=var560, $r32=var312, java.lang.Object=var1202, $r2=var1008, org.apache.dubbo.rpc.Invoker=var23, $r3=var290, org.apache.dubbo.common.Node=var227, $r4=var147, $r5=var2154, $r6=var149, $r9=var3297, org.apache.dubbo.rpc.support.RpcUtils=var288, $r8=var2498, $r10=var1527, r11=var285, java.util.concurrent.ConcurrentMap=var1523, $r13=var286, java.util.function.Function=var3841, org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$lambda_doSelect_0__42=var1552, $r14=var3247, org.apache.dubbo.common.utils.ConcurrentHashMapUtils=var3033, $r15=var444, r16=var3136, i7=var50, l8=var3985, java.lang.System=var3881, l0=var3635, r30=var1935, org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$WeightedRoundRobin=var2857, r31=var3234, r17=var2336, $z0=var3205, $i2=var38, java.util.Map=var26, $i1=var3467}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance;	r1 := @parameter0: java.util.List;	r29 := @parameter1: org.apache.dubbo.common.URL;	r7 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r32 = new java.lang.StringBuilder;	specialinvoke $r32.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0);	$r3 = (org.apache.dubbo.rpc.Invoker) $r2;	$r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r6 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance: java.util.concurrent.ConcurrentMap methodWeightMap>;	$r14 = staticinvoke <org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$lambda_doSelect_0__42: java.util.function.Function bootstrap$()>();	$r15 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r13, r11, $r14);	r16 = (java.util.concurrent.ConcurrentMap) $r15;	i7 = 0;	l8 = -9223372036854775808L;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	r30 = null;	r31 = null;	r17 = interfaceinvoke r1.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r17.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $i2 = interfaceinvoke r1.<java.util.List: int size()>();	$i2 = interfaceinvoke r1.<java.util.List: int size()>();	$i1 = interfaceinvoke r16.<java.util.concurrent.ConcurrentMap: int size()>();	if $i2 == $i1 goto (branch);	if r30 == null goto $r18 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0);	virtualinvoke r31.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance$WeightedRoundRobin: void sel(int)>(i7);	return r30
;block_num 5