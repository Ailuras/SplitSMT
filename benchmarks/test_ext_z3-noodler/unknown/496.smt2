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

(declare-sort var890 0)
(declare-sort var1081 0)
(declare-sort var3629 0)
(declare-sort var2986 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toString/-1647567016 (var1081) String)
(declare-fun cast-from-var890-to-var1081 (var890) var1081)
(declare-fun spec/-364867049 (var890) var3629)
(declare-fun append/-1031950772 (String var2986) String)
(declare-fun cast-from-var3629-to-var2986 (var3629) var2986)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var890 var890)
(declare-const var3881 var890) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRule 
(assert (not (= var3881 null-var890)))
(define-const var1193 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1193)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1193!1 String)
(assert (= var1193!1 ""))
(assert true)
(define-const var3517 String (append/672562846 var1193!1 "DestinationRule{base=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DestinationRule{base=") 
(declare-const var1193!2 String)
(assert (= var1193!2 (str.++ var1193!1 "DestinationRule{base=")))
(assert true)
(define-const var3188 String (toString/-1647567016 (cast-from-var890-to-var1081 var3881))) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String toString()>() 
(assert true)
(define-const var906 String (append/672562846 var3517 var3188)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3517!1 String)
(assert (= var3517!1 (str.++ var3517 var3188)))
(assert true)
(define-const var216 String (append/672562846 var906 ", spec=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", spec=") 
(declare-const var906!1 String)
(assert (= var906!1 (str.++ var906 ", spec=")))
(define-const var2720 var3629 (spec/-364867049 var3881)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRule: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec spec> 
(assert true)
(define-const var3215 String (append/-1031950772 var216 (cast-from-var3629-to-var2986 var2720))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var216!1 String)
(assert (str.prefixof var216 var216!1))
(assert true)
(define-const var3077 String (append/-1166366385 var3215 125)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3215!1 String)
(assert (str.prefixof var3215 var3215!1))
(assert true)
(define-const var3511 String (toString/-2075883882 var3077)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-1647567016=([org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule], java.lang.String), cast-from-var890-to-var1081=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRule], org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule), spec/-364867049=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRule], org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3629-to-var2986=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var890=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRule, var3881=r1, var1193=$r0, var3517=$r3, var1081=org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule, var3188=$r2, var906=$r4, var216=$r6, var3629=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec, var2720=$r5, var2986=java.lang.Object, var3215=$r7, var3077=$r8, var3511=$r9}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRule=var890, r1=var3881, $r0=var1193, $r3=var3517, org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule=var1081, $r2=var3188, $r4=var906, $r6=var216, org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec=var3629, $r5=var2720, java.lang.Object=var2986, $r7=var3215, $r8=var3077, $r9=var3511}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRule;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DestinationRule{base=");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", spec=");	$r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRule: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.DestinationRuleSpec spec>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1