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

(declare-sort var1009 0)
(declare-sort var3427 0)
(declare-sort var1873 0)
(declare-sort var790 0)
(declare-sort var2167 0)
(declare-sort var3424 0)
(declare-sort var2579 0)
(declare-sort var795 0)
(declare-sort var1890 0)
(declare-sort var646 0)
(declare-sort var902 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3427_get/-1216255739 (var3427 Int) var790)
(declare-fun cast-from-var790-to-var2167 (var790) var2167)
(declare-fun var2579_getUrl/-275947851 (var2579) var3424)
(declare-fun cast-from-var2167-to-var2579 (var2167) var2579)
(declare-fun getServiceKey/1456125852 (var3424) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var795_getMethodName/-516674313 (var1873) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun methodWeightMap/1803923679 (var1009) var1890)
(declare-fun var646_get/1088891777 (var646 var790) var790)
(declare-fun cast-from-var1890-to-var646 (var1890) var646)
(declare-fun cast-from-String-to-var790 (String) var790)
(declare-fun cast-from-var790-to-var646 (var790) var646)
(declare-fun var646_keySet/-712633290 (var646) var902)
(declare-const null-var1009 var1009)
(declare-const null-var3427 var3427)
(declare-const null-var1873 var1873)
(declare-const null-var646 var646)
(declare-const var3065 var1009) ; Statement: r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance 
(assert (not (= var3065 null-var1009)))
(declare-const var120 var3427) ; Statement: r1 := @parameter0: java.util.List 
(assert (not (= var120 null-var3427)))
(declare-const var2520 var1873) ; Statement: r7 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2520 null-var1873)))
(define-const var3430 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3430)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3430!1 String)
(assert (= var3430!1 ""))
(define-const var1154 var790 (var3427_get/-1216255739 var120 0)) ; Statement: $r2 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var3224 var2167 (cast-from-var790-to-var2167 var1154)) ; Statement: $r3 = (org.apache.dubbo.rpc.Invoker) $r2 
(define-const var390 var3424 (var2579_getUrl/-275947851 (cast-from-var2167-to-var2579 var3224))) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3441 String (getServiceKey/1456125852 var390)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var3759 String (append/672562846 var3430!1 var3441)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3430!2 String)
(assert (= var3430!2 (str.++ var3430!1 var3441)))
(assert true)
(define-const var914 String (append/672562846 var3759 ".")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3759!1 String)
(assert (= var3759!1 (str.++ var3759 ".")))
(define-const var1143 String (var795_getMethodName/-516674313 var2520)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r7) 
(assert true)
(define-const var354 String (append/672562846 var914 var1143)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var914!1 String)
(assert (= var914!1 (str.++ var914 var1143)))
(assert true)
(define-const var2184 String (toString/-2075883882 var354)) ; Statement: r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var592 var1890 (methodWeightMap/1803923679 var3065)) ; Statement: $r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance: java.util.concurrent.ConcurrentMap methodWeightMap> 
(define-const var2239 var790 (var646_get/1088891777 (cast-from-var1890-to-var646 var592) (cast-from-String-to-var790 var2184))) ; Statement: $r14 = interfaceinvoke $r13.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11) 
(define-const var3435 var646 (cast-from-var790-to-var646 var2239)) ; Statement: r15 = (java.util.Map) $r14 
 ; Statement: if r15 == null goto return null 
(assert (not (= var3435 null-var646))) ; Negate: Cond: r15 == null  
(define-const var209 var902 (var646_keySet/-712633290 var3435)) ; Statement: $r16 = interfaceinvoke r15.<java.util.Map: java.util.Set keySet()>() 
 ; Statement: return $r16 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3427_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var790-to-var2167=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var2579_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2167-to-var2579=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var795_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), methodWeightMap/1803923679=([org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance], java.util.concurrent.ConcurrentMap), var646_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1890-to-var646=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var790=([java.lang.String], java.lang.Object), cast-from-var790-to-var646=([java.lang.Object], java.util.Map), var646_keySet/-712633290=([java.util.Map], java.util.Set)}
; {var1009=org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance, var3065=r12, var3427=java.util.List, var120=r1, var1873=org.apache.dubbo.rpc.Invocation, var2520=r7, var3430=$r0, var790=java.lang.Object, var1154=$r2, var2167=org.apache.dubbo.rpc.Invoker, var3224=$r3, var3424=org.apache.dubbo.common.URL, var2579=org.apache.dubbo.common.Node, var390=$r4, var3441=$r5, var3759=$r6, var914=$r9, var795=org.apache.dubbo.rpc.support.RpcUtils, var1143=$r8, var354=$r10, var2184=r11, var1890=java.util.concurrent.ConcurrentMap, var592=$r13, var646=java.util.Map, var2239=$r14, var3435=r15, var902=java.util.Set, var209=$r16}
; {org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance=var1009, r12=var3065, java.util.List=var3427, r1=var120, org.apache.dubbo.rpc.Invocation=var1873, r7=var2520, $r0=var3430, java.lang.Object=var790, $r2=var1154, org.apache.dubbo.rpc.Invoker=var2167, $r3=var3224, org.apache.dubbo.common.URL=var3424, org.apache.dubbo.common.Node=var2579, $r4=var390, $r5=var3441, $r6=var3759, $r9=var914, org.apache.dubbo.rpc.support.RpcUtils=var795, $r8=var1143, $r10=var354, r11=var2184, java.util.concurrent.ConcurrentMap=var1890, $r13=var592, java.util.Map=var646, $r14=var2239, r15=var3435, java.util.Set=var902, $r16=var209}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance;	r1 := @parameter0: java.util.List;	r7 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0);	$r3 = (org.apache.dubbo.rpc.Invoker) $r2;	$r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance: java.util.concurrent.ConcurrentMap methodWeightMap>;	$r14 = interfaceinvoke $r13.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11);	r15 = (java.util.Map) $r14;	if r15 == null goto return null;	$r16 = interfaceinvoke r15.<java.util.Map: java.util.Set keySet()>();	return $r16
;block_num 2