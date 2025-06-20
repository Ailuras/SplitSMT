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

(declare-sort var3116 0)
(declare-sort var3784 0)
(declare-sort var2216 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-811987763 (var3116) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun match/-811987763 (var3116) var3784)
(declare-fun append/-1031950772 (String var2216) String)
(declare-fun cast-from-var3784-to-var2216 (var3784) var2216)
(declare-fun route/-811987763 (var3116) var3784)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3116 var3116)
(declare-const var2805 var3116) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail 
(assert (not (= var2805 null-var3116)))
(define-const var377 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var377)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var377!1 String)
(assert (= var377!1 ""))
(assert true)
(define-const var574 String (append/672562846 var377!1 "DubboRouteDetail{name=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboRouteDetail{name=\'") 
(declare-const var377!2 String)
(assert (= var377!2 (str.++ var377!1 "DubboRouteDetail{name=\u0027")))
(define-const var2458 String (name/-811987763 var2805)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail: java.lang.String name> 
(assert true)
(define-const var1273 String (append/672562846 var574 var2458)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var574!1 String)
(assert (= var574!1 (str.++ var574 var2458)))
(assert true)
(define-const var1689 String (append/-1166366385 var1273 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1273!1 String)
(assert (str.prefixof var1273 var1273!1))
(assert true)
(define-const var3488 String (append/672562846 var1689 ", match=")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", match=") 
(declare-const var1689!1 String)
(assert (= var1689!1 (str.++ var1689 ", match=")))
(define-const var3335 var3784 (match/-811987763 var2805)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail: java.util.List match> 
(assert true)
(define-const var43 String (append/-1031950772 var3488 (cast-from-var3784-to-var2216 var3335))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var3488!1 String)
(assert (str.prefixof var3488 var3488!1))
(assert true)
(define-const var720 String (append/672562846 var43 ", route=")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", route=") 
(declare-const var43!1 String)
(assert (= var43!1 (str.++ var43 ", route=")))
(define-const var2531 var3784 (route/-811987763 var2805)) ; Statement: $r9 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail: java.util.List route> 
(assert true)
(define-const var2795 String (append/-1031950772 var720 (cast-from-var3784-to-var2216 var2531))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var720!1 String)
(assert (str.prefixof var720 var720!1))
(assert true)
(define-const var2049 String (append/-1166366385 var2795 125)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2795!1 String)
(assert (str.prefixof var2795 var2795!1))
(assert true)
(define-const var1520 String (toString/-2075883882 var2049)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-811987763=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), match/-811987763=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3784-to-var2216=([java.util.List], java.lang.Object), route/-811987763=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail], java.util.List), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3116=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail, var2805=r1, var377=$r0, var574=$r3, var2458=$r2, var1273=$r4, var1689=$r5, var3488=$r7, var3784=java.util.List, var3335=$r6, var2216=java.lang.Object, var43=$r8, var720=$r10, var2531=$r9, var2795=$r11, var2049=$r12, var1520=$r13}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail=var3116, r1=var2805, $r0=var377, $r3=var574, $r2=var2458, $r4=var1273, $r5=var1689, $r7=var3488, java.util.List=var3784, $r6=var3335, java.lang.Object=var2216, $r8=var43, $r10=var720, $r9=var2531, $r11=var2795, $r12=var2049, $r13=var1520}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboRouteDetail{name=\'");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", match=");	$r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail: java.util.List match>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", route=");	$r9 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboRouteDetail: java.util.List route>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 1