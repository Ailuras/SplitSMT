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

(declare-sort var1412 0)
(declare-sort var3073 0)
(declare-sort var206 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun loadBalancer/-1009773892 (var1412) var3073)
(declare-fun append/-1031950772 (String var206) String)
(declare-fun cast-from-var3073-to-var206 (var3073) var206)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1412 var1412)
(declare-const var1800 var1412) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy 
(assert (not (= var1800 null-var1412)))
(define-const var2105 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2105)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2105!1 String)
(assert (= var2105!1 ""))
(assert true)
(define-const var1172 String (append/672562846 var2105!1 "TrafficPolicy{loadBalancer=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("TrafficPolicy{loadBalancer=") 
(declare-const var2105!2 String)
(assert (= var2105!2 (str.++ var2105!1 "TrafficPolicy{loadBalancer=")))
(define-const var2769 var3073 (loadBalancer/-1009773892 var1800)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings loadBalancer> 
(assert true)
(define-const var1128 String (append/-1031950772 var1172 (cast-from-var3073-to-var206 var2769))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1172!1 String)
(assert (str.prefixof var1172 var1172!1))
(assert true)
(define-const var93 String (append/-1166366385 var1128 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1128!1 String)
(assert (str.prefixof var1128 var1128!1))
(assert true)
(define-const var1856 String (toString/-2075883882 var93)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), loadBalancer/-1009773892=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy], org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3073-to-var206=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1412=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy, var1800=r1, var2105=$r0, var1172=$r3, var3073=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings, var2769=$r2, var206=java.lang.Object, var1128=$r4, var93=$r5, var1856=$r6}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy=var1412, r1=var1800, $r0=var2105, $r3=var1172, org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings=var3073, $r2=var2769, java.lang.Object=var206, $r4=var1128, $r5=var93, $r6=var1856}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("TrafficPolicy{loadBalancer=");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.loadbalance.LoadBalancerSettings loadBalancer>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1