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

(declare-sort var1132 0)
(declare-sort var3109 0)
(declare-sort var835 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/727678300 (var1132) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun services/727678300 (var1132) var3109)
(declare-fun append/-1031950772 (String var835) String)
(declare-fun cast-from-var3109-to-var835 (var3109) var835)
(declare-fun routedetail/727678300 (var1132) var3109)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1132 var1132)
(declare-const var3294 var1132) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute 
(assert (not (= var3294 null-var1132)))
(define-const var1473 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1473)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1473!1 String)
(assert (= var1473!1 ""))
(assert true)
(define-const var2395 String (append/672562846 var1473!1 "DubboRoute{name=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboRoute{name=\'") 
(declare-const var1473!2 String)
(assert (= var1473!2 (str.++ var1473!1 "DubboRoute{name=\u0027")))
(define-const var3361 String (name/727678300 var3294)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute: java.lang.String name> 
(assert true)
(define-const var640 String (append/672562846 var2395 var3361)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2395!1 String)
(assert (= var2395!1 (str.++ var2395 var3361)))
(assert true)
(define-const var3749 String (append/-1166366385 var640 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var640!1 String)
(assert (str.prefixof var640 var640!1))
(assert true)
(define-const var3831 String (append/672562846 var3749 ", services=")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", services=") 
(declare-const var3749!1 String)
(assert (= var3749!1 (str.++ var3749 ", services=")))
(define-const var1116 var3109 (services/727678300 var3294)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute: java.util.List services> 
(assert true)
(define-const var275 String (append/-1031950772 var3831 (cast-from-var3109-to-var835 var1116))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var3831!1 String)
(assert (str.prefixof var3831 var3831!1))
(assert true)
(define-const var2907 String (append/672562846 var275 ", routedetail=")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", routedetail=") 
(declare-const var275!1 String)
(assert (= var275!1 (str.++ var275 ", routedetail=")))
(define-const var1180 var3109 (routedetail/727678300 var3294)) ; Statement: $r9 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute: java.util.List routedetail> 
(assert true)
(define-const var3064 String (append/-1031950772 var2907 (cast-from-var3109-to-var835 var1180))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var2907!1 String)
(assert (str.prefixof var2907 var2907!1))
(assert true)
(define-const var121 String (append/-1166366385 var3064 125)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3064!1 String)
(assert (str.prefixof var3064 var3064!1))
(assert true)
(define-const var2077 String (toString/-2075883882 var121)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/727678300=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), services/727678300=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3109-to-var835=([java.util.List], java.lang.Object), routedetail/727678300=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute], java.util.List), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1132=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute, var3294=r1, var1473=$r0, var2395=$r3, var3361=$r2, var640=$r4, var3749=$r5, var3831=$r7, var3109=java.util.List, var1116=$r6, var835=java.lang.Object, var275=$r8, var2907=$r10, var1180=$r9, var3064=$r11, var121=$r12, var2077=$r13}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute=var1132, r1=var3294, $r0=var1473, $r3=var2395, $r2=var3361, $r4=var640, $r5=var3749, $r7=var3831, java.util.List=var3109, $r6=var1116, java.lang.Object=var835, $r8=var275, $r10=var2907, $r9=var1180, $r11=var3064, $r12=var121, $r13=var2077}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboRoute{name=\'");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", services=");	$r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute: java.util.List services>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", routedetail=");	$r9 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRoute: java.util.List routedetail>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 1