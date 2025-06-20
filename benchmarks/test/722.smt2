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

(declare-sort var1611 0)
(declare-sort var1068 0)
(declare-sort var325 0)
(declare-sort var2587 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun host/-720168334 (var1611) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun subsets/-720168334 (var1611) var1068)
(declare-fun append/-1031950772 (String var325) String)
(declare-fun cast-from-var1068-to-var325 (var1068) var325)
(declare-fun trafficPolicy/-720168334 (var1611) var2587)
(declare-fun cast-from-var2587-to-var325 (var2587) var325)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1611 var1611)
(declare-const var3506 var1611) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec 
(assert (not (= var3506 null-var1611)))
(define-const var2521 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2521)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2521!1 String)
(assert (= var2521!1 ""))
(assert true)
(define-const var2930 String (append/672562846 var2521!1 "DestinationRuleSpec{host=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DestinationRuleSpec{host=\'") 
(declare-const var2521!2 String)
(assert (= var2521!2 (str.++ var2521!1 "DestinationRuleSpec{host=\u0027")))
(define-const var1352 String (host/-720168334 var3506)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec: java.lang.String host> 
(assert true)
(define-const var2276 String (append/672562846 var2930 var1352)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2930!1 String)
(assert (= var2930!1 (str.++ var2930 var1352)))
(assert true)
(define-const var3885 String (append/-1166366385 var2276 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2276!1 String)
(assert (str.prefixof var2276 var2276!1))
(assert true)
(define-const var2571 String (append/672562846 var3885 ", subsets=")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", subsets=") 
(declare-const var3885!1 String)
(assert (= var3885!1 (str.++ var3885 ", subsets=")))
(define-const var243 var1068 (subsets/-720168334 var3506)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec: java.util.List subsets> 
(assert true)
(define-const var2748 String (append/-1031950772 var2571 (cast-from-var1068-to-var325 var243))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var2571!1 String)
(assert (str.prefixof var2571 var2571!1))
(assert true)
(define-const var1818 String (append/672562846 var2748 ", trafficPolicy=")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", trafficPolicy=") 
(declare-const var2748!1 String)
(assert (= var2748!1 (str.++ var2748 ", trafficPolicy=")))
(define-const var2380 var2587 (trafficPolicy/-720168334 var3506)) ; Statement: $r9 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy trafficPolicy> 
(assert true)
(define-const var1689 String (append/-1031950772 var1818 (cast-from-var2587-to-var325 var2380))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var1818!1 String)
(assert (str.prefixof var1818 var1818!1))
(assert true)
(define-const var1073 String (append/-1166366385 var1689 125)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1689!1 String)
(assert (str.prefixof var1689 var1689!1))
(assert true)
(define-const var1301 String (toString/-2075883882 var1073)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), host/-720168334=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), subsets/-720168334=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1068-to-var325=([java.util.List], java.lang.Object), trafficPolicy/-720168334=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec], org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy), cast-from-var2587-to-var325=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1611=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec, var3506=r1, var2521=$r0, var2930=$r3, var1352=$r2, var2276=$r4, var3885=$r5, var2571=$r7, var1068=java.util.List, var243=$r6, var325=java.lang.Object, var2748=$r8, var1818=$r10, var2587=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy, var2380=$r9, var1689=$r11, var1073=$r12, var1301=$r13}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec=var1611, r1=var3506, $r0=var2521, $r3=var2930, $r2=var1352, $r4=var2276, $r5=var3885, $r7=var2571, java.util.List=var1068, $r6=var243, java.lang.Object=var325, $r8=var2748, $r10=var1818, org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy=var2587, $r9=var2380, $r11=var1689, $r12=var1073, $r13=var1301}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DestinationRuleSpec{host=\'");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec: java.lang.String host>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", subsets=");	$r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec: java.util.List subsets>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", trafficPolicy=");	$r9 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.TrafficPolicy trafficPolicy>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 1