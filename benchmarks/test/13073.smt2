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

(declare-sort var3080 0)
(declare-sort var3431 0)
(declare-sort var342 0)
(declare-sort var1243 0)
(declare-sort var1547 0)
(declare-sort var3852 0)
(declare-sort var1981 0)
(declare-sort var3833 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var342-init () var342)
(declare-fun <init>/1281898776 (var342) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun iterator/-2009143821 (var3431) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun Iterator_next/-1124697587 (Iterator) var1243)
(declare-fun cast-from-var1243-to-var1547 (var1243) var1547)
(declare-fun var1981_getUrl/-275947851 (var1981) var3852)
(declare-fun cast-from-var1547-to-var1981 (var1547) var1981)
(declare-fun toFullString/-798704221 (var3852) String)
(declare-fun var3833_add/328494887 (var3833 var1243) Bool)
(declare-fun cast-from-var342-to-var3833 (var342) var3833)
(declare-fun cast-from-String-to-var1243 (String) var1243)
(declare-fun var3080_put/1464166817 (var3080 var1243 var1243) var1243)
(declare-fun cast-from-var342-to-var1243 (var342) var1243)
(declare-const null-String String)
(declare-const null-var3080 var3080)
(declare-const null-var3431 var3431)
(declare-const var2894 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2894 null-String)))
(declare-const var1620 var3080) ; Statement: r4 := @parameter1: java.util.Map 
(assert (not (= var1620 null-var3080)))
(declare-const var2290 var3431) ; Statement: r2 := @parameter2: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var2290 null-var3431)))
(define-const var3374 var342 var342-init) ; Statement: $r0 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var3374)) ; Statement: specialinvoke $r0.<java.util.LinkedList: void <init>()>() 

(declare-const var3374!1 var342)
(assert true)
;(assert (append/672562846 var2894 "Valid Invokers: \n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Valid Invokers: \n") 
(declare-const var2894!1 String)
(assert (= var2894!1 (str.++ var2894 "Valid Invokers: \n")))
(assert true)
(define-const var245 Iterator (iterator/-2009143821 var2290)) ; Statement: r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var20 Bool (Iterator_hasNext/-1669924200 var245)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (not (= (ite var20 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1343 var1243 (Iterator_next/-1124697587 var245)) ; Statement: $r5 = interfaceinvoke r3.<java.util.Iterator: java.lang.Object next()>() 
(declare-const var245!1 Iterator)
(define-const var3379 var1547 (cast-from-var1243-to-var1547 var1343)) ; Statement: r6 = (org.apache.dubbo.rpc.Invoker) $r5 
(define-const var2443 var3852 (var1981_getUrl/-275947851 (cast-from-var1547-to-var1981 var3379))) ; Statement: $r7 = interfaceinvoke r6.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3471 String (toFullString/-798704221 var2443)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
;(assert (var3833_add/328494887 (cast-from-var342-to-var3833 var3374!1) (cast-from-String-to-var1243 var3471))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r8) 

(declare-const var3374!2 var342)
(declare-const var3471!1 String)
(define-const var2503 var3852 (var1981_getUrl/-275947851 (cast-from-var1547-to-var1981 var3379))) ; Statement: $r9 = interfaceinvoke r6.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2534 String (toFullString/-798704221 var2503)) ; Statement: $r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var1681 String (append/672562846 var2894!1 var2534)) ; Statement: $r11 = virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var2894!2 String)
(assert (= var2894!2 (str.++ var2894!1 var2534)))
(assert true)
;(assert (append/672562846 var1681 "\n")) ; Statement: virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1681!1 String)
(assert (= var1681!1 (str.++ var1681 "\n")))
 ; Statement: goto [?= $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>()] 
(assert true) ; Non Conditional
(define-const var20!1 Bool (Iterator_hasNext/-1669924200 var245!1)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (= (ite var20!1 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var2894!2 "\n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var2894!3 String)
(assert (= var2894!3 (str.++ var2894!2 "\n")))
;(assert (var3080_put/1464166817 var1620 (cast-from-String-to-var1243 "Valid") (cast-from-var342-to-var1243 var3374!2))) ; Statement: interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Valid", $r0) 

(declare-const var1620!1 var3080)
(declare-const var2514 String)
(declare-const var3374!3 var342)
 ; Statement: return 
(check-sat)
; {var342-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), iterator/-2009143821=([org.apache.dubbo.rpc.cluster.router.state.BitList], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), Iterator_next/-1124697587=([java.util.Iterator], java.lang.Object), cast-from-var1243-to-var1547=([java.lang.Object], org.apache.dubbo.rpc.Invoker), var1981_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1547-to-var1981=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String), var3833_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var342-to-var3833=([java.util.LinkedList], java.util.List), cast-from-String-to-var1243=([java.lang.String], java.lang.Object), var3080_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var342-to-var1243=([java.util.LinkedList], java.lang.Object)}
; {var2894=r1, var3080=java.util.Map, var1620=r4, var3431=org.apache.dubbo.rpc.cluster.router.state.BitList, var2290=r2, var342=java.util.LinkedList, var3374=$r0, var245=r3, var20=$z0, var1243=java.lang.Object, var1343=$r5, var1547=org.apache.dubbo.rpc.Invoker, var3379=r6, var3852=org.apache.dubbo.common.URL, var1981=org.apache.dubbo.common.Node, var2443=$r7, var3471=$r8, var3833=java.util.List, var2503=$r9, var2534=$r10, var1681=$r11, var2514="Valid"}
; {r1=var2894, java.util.Map=var3080, r4=var1620, org.apache.dubbo.rpc.cluster.router.state.BitList=var3431, r2=var2290, java.util.LinkedList=var342, $r0=var3374, r3=var245, $z0=var20, java.lang.Object=var1243, $r5=var1343, org.apache.dubbo.rpc.Invoker=var1547, r6=var3379, org.apache.dubbo.common.URL=var3852, org.apache.dubbo.common.Node=var1981, $r7=var2443, $r8=var3471, java.util.List=var3833, $r9=var2503, $r10=var2534, $r11=var1681, "Valid"=var2514}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r4 := @parameter1: java.util.Map;	r2 := @parameter2: org.apache.dubbo.rpc.cluster.router.state.BitList;	$r0 = new java.util.LinkedList;	specialinvoke $r0.<java.util.LinkedList: void <init>()>();	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Valid Invokers: \n");	r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$r5 = interfaceinvoke r3.<java.util.Iterator: java.lang.Object next()>();	r6 = (org.apache.dubbo.rpc.Invoker) $r5;	$r7 = interfaceinvoke r6.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r8);	$r9 = interfaceinvoke r6.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r11 = virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	goto [?= $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>()];	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Valid", $r0);	return
;block_num 5