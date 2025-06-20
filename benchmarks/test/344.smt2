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

(declare-sort var1658 0)
(declare-sort var884 0)
(declare-sort var3518 0)
(declare-sort var623 0)
(declare-sort var2077 0)
(declare-sort var2406 0)
(declare-sort var1012 0)
(declare-sort var231 0)
(declare-sort var3360 0)
(declare-sort var1614 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var884_get/-1216255739 (var884 Int) var623)
(declare-fun cast-from-var623-to-var2077 (var623) var2077)
(declare-fun var1012_getUrl/-275947851 (var1012) var2406)
(declare-fun cast-from-var2077-to-var1012 (var2077) var1012)
(declare-fun getServiceKey/1456125852 (var2406) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var231_getMethodName/-516674313 (var3518) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun methodWeightMap/1803923679 (var1658) var3360)
(declare-fun var1614_get/1088891777 (var1614 var623) var623)
(declare-fun cast-from-var3360-to-var1614 (var3360) var1614)
(declare-fun cast-from-String-to-var623 (String) var623)
(declare-fun cast-from-var623-to-var1614 (var623) var1614)
(declare-const null-var1658 var1658)
(declare-const null-var884 var884)
(declare-const null-var3518 var3518)
(declare-const null-var1614 var1614)
(declare-const var1665 var1658) ; Statement: r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance 
(assert (not (= var1665 null-var1658)))
(declare-const var298 var884) ; Statement: r1 := @parameter0: java.util.List 
(assert (not (= var298 null-var884)))
(declare-const var3613 var3518) ; Statement: r7 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3613 null-var3518)))
(define-const var3713 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3713)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3713!1 String)
(assert (= var3713!1 ""))
(define-const var1433 var623 (var884_get/-1216255739 var298 0)) ; Statement: $r2 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var3850 var2077 (cast-from-var623-to-var2077 var1433)) ; Statement: $r3 = (org.apache.dubbo.rpc.Invoker) $r2 
(define-const var1626 var2406 (var1012_getUrl/-275947851 (cast-from-var2077-to-var1012 var3850))) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1503 String (getServiceKey/1456125852 var1626)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var3167 String (append/672562846 var3713!1 var1503)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3713!2 String)
(assert (= var3713!2 (str.++ var3713!1 var1503)))
(assert true)
(define-const var830 String (append/672562846 var3167 ".")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3167!1 String)
(assert (= var3167!1 (str.++ var3167 ".")))
(define-const var3094 String (var231_getMethodName/-516674313 var3613)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r7) 
(assert true)
(define-const var2094 String (append/672562846 var830 var3094)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var830!1 String)
(assert (= var830!1 (str.++ var830 var3094)))
(assert true)
(define-const var3696 String (toString/-2075883882 var2094)) ; Statement: r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1066 var3360 (methodWeightMap/1803923679 var1665)) ; Statement: $r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance: java.util.concurrent.ConcurrentMap methodWeightMap> 
(define-const var441 var623 (var1614_get/1088891777 (cast-from-var3360-to-var1614 var1066) (cast-from-String-to-var623 var3696))) ; Statement: $r14 = interfaceinvoke $r13.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11) 
(define-const var2622 var1614 (cast-from-var623-to-var1614 var441)) ; Statement: r15 = (java.util.Map) $r14 
 ; Statement: if r15 == null goto return null 
(assert (= var2622 null-var1614)) ; Cond: r15 == null 
 ; Statement: return null 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var884_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var623-to-var2077=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var1012_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2077-to-var1012=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var231_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), methodWeightMap/1803923679=([org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance], java.util.concurrent.ConcurrentMap), var1614_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3360-to-var1614=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var623=([java.lang.String], java.lang.Object), cast-from-var623-to-var1614=([java.lang.Object], java.util.Map)}
; {var1658=org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance, var1665=r12, var884=java.util.List, var298=r1, var3518=org.apache.dubbo.rpc.Invocation, var3613=r7, var3713=$r0, var623=java.lang.Object, var1433=$r2, var2077=org.apache.dubbo.rpc.Invoker, var3850=$r3, var2406=org.apache.dubbo.common.URL, var1012=org.apache.dubbo.common.Node, var1626=$r4, var1503=$r5, var3167=$r6, var830=$r9, var231=org.apache.dubbo.rpc.support.RpcUtils, var3094=$r8, var2094=$r10, var3696=r11, var3360=java.util.concurrent.ConcurrentMap, var1066=$r13, var1614=java.util.Map, var441=$r14, var2622=r15}
; {org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance=var1658, r12=var1665, java.util.List=var884, r1=var298, org.apache.dubbo.rpc.Invocation=var3518, r7=var3613, $r0=var3713, java.lang.Object=var623, $r2=var1433, org.apache.dubbo.rpc.Invoker=var2077, $r3=var3850, org.apache.dubbo.common.URL=var2406, org.apache.dubbo.common.Node=var1012, $r4=var1626, $r5=var1503, $r6=var3167, $r9=var830, org.apache.dubbo.rpc.support.RpcUtils=var231, $r8=var3094, $r10=var2094, r11=var3696, java.util.concurrent.ConcurrentMap=var3360, $r13=var1066, java.util.Map=var1614, $r14=var441, r15=var2622}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance;	r1 := @parameter0: java.util.List;	r7 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<java.util.List: java.lang.Object get(int)>(0);	$r3 = (org.apache.dubbo.rpc.Invoker) $r2;	$r4 = interfaceinvoke $r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = r12.<org.apache.dubbo.rpc.cluster.loadbalance.RoundRobinLoadBalance: java.util.concurrent.ConcurrentMap methodWeightMap>;	$r14 = interfaceinvoke $r13.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r11);	r15 = (java.util.Map) $r14;	if r15 == null goto return null;	return null
;block_num 2