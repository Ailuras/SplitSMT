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

(declare-sort var1376 0)
(declare-sort var3405 0)
(declare-sort var3869 0)
(declare-sort var783 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun simple/695017930 (var1376) var3405)
(declare-fun append/-1031950772 (String var3869) String)
(declare-fun cast-from-var3405-to-var3869 (var3405) var3869)
(declare-fun consistentHash/695017930 (var1376) var783)
(declare-fun cast-from-var783-to-var3869 (var783) var3869)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1376 var1376)
(declare-const var2312 var1376) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings 
(assert (not (= var2312 null-var1376)))
(define-const var3516 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3516)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3516!1 String)
(assert (= var3516!1 ""))
(assert true)
(define-const var1348 String (append/672562846 var3516!1 "LoadBalancerSettings{simple=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("LoadBalancerSettings{simple=") 
(declare-const var3516!2 String)
(assert (= var3516!2 (str.++ var3516!1 "LoadBalancerSettings{simple=")))
(define-const var3091 var3405 (simple/695017930 var2312)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.SimpleLB simple> 
(assert true)
(define-const var245 String (append/-1031950772 var1348 (cast-from-var3405-to-var3869 var3091))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1348!1 String)
(assert (str.prefixof var1348 var1348!1))
(assert true)
(define-const var2972 String (append/672562846 var245 ", consistentHash=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", consistentHash=") 
(declare-const var245!1 String)
(assert (= var245!1 (str.++ var245 ", consistentHash=")))
(define-const var1527 var783 (consistentHash/695017930 var2312)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.ConsistentHashLB consistentHash> 
(assert true)
(define-const var1712 String (append/-1031950772 var2972 (cast-from-var783-to-var3869 var1527))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2972!1 String)
(assert (str.prefixof var2972 var2972!1))
(assert true)
(define-const var2295 String (append/-1166366385 var1712 125)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1712!1 String)
(assert (str.prefixof var1712 var1712!1))
(assert true)
(define-const var1902 String (toString/-2075883882 var2295)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), simple/695017930=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings], org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.SimpleLB), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3405-to-var3869=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.SimpleLB], java.lang.Object), consistentHash/695017930=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings], org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.ConsistentHashLB), cast-from-var783-to-var3869=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.ConsistentHashLB], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1376=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings, var2312=r1, var3516=$r0, var1348=$r3, var3405=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.SimpleLB, var3091=$r2, var3869=java.lang.Object, var245=$r4, var2972=$r6, var783=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.ConsistentHashLB, var1527=$r5, var1712=$r7, var2295=$r8, var1902=$r9}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings=var1376, r1=var2312, $r0=var3516, $r3=var1348, org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.SimpleLB=var3405, $r2=var3091, java.lang.Object=var3869, $r4=var245, $r6=var2972, org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.ConsistentHashLB=var783, $r5=var1527, $r7=var1712, $r8=var2295, $r9=var1902}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("LoadBalancerSettings{simple=");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.SimpleLB simple>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", consistentHash=");	$r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.ConsistentHashLB consistentHash>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1