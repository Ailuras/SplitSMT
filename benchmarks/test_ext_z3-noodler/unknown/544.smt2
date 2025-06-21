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

(declare-sort var2068 0)
(declare-sort var3806 0)
(declare-sort var2727 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun hosts/1702369654 (var2068) var3806)
(declare-fun append/-1031950772 (String var2727) String)
(declare-fun cast-from-var3806-to-var2727 (var3806) var2727)
(declare-fun dubbo/1702369654 (var2068) var3806)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2068 var2068)
(declare-const var3360 var2068) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec 
(assert (not (= var3360 null-var2068)))
(define-const var481 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var481)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var481!1 String)
(assert (= var481!1 ""))
(assert true)
(define-const var2673 String (append/672562846 var481!1 "VirtualServiceSpec{hosts=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("VirtualServiceSpec{hosts=") 
(declare-const var481!2 String)
(assert (= var481!2 (str.++ var481!1 "VirtualServiceSpec{hosts=")))
(define-const var3845 var3806 (hosts/1702369654 var3360)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec: java.util.List hosts> 
(assert true)
(define-const var2075 String (append/-1031950772 var2673 (cast-from-var3806-to-var2727 var3845))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2673!1 String)
(assert (str.prefixof var2673 var2673!1))
(assert true)
(define-const var2582 String (append/672562846 var2075 ", dubbo=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", dubbo=") 
(declare-const var2075!1 String)
(assert (= var2075!1 (str.++ var2075 ", dubbo=")))
(define-const var2525 var3806 (dubbo/1702369654 var3360)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec: java.util.List dubbo> 
(assert true)
(define-const var1668 String (append/-1031950772 var2582 (cast-from-var3806-to-var2727 var2525))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2582!1 String)
(assert (str.prefixof var2582 var2582!1))
(assert true)
(define-const var1162 String (append/-1166366385 var1668 125)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1668!1 String)
(assert (str.prefixof var1668 var1668!1))
(assert true)
(define-const var1998 String (toString/-2075883882 var1162)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), hosts/1702369654=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3806-to-var2727=([java.util.List], java.lang.Object), dubbo/1702369654=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec], java.util.List), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2068=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec, var3360=r1, var481=$r0, var2673=$r3, var3806=java.util.List, var3845=$r2, var2727=java.lang.Object, var2075=$r4, var2582=$r6, var2525=$r5, var1668=$r7, var1162=$r8, var1998=$r9}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec=var2068, r1=var3360, $r0=var481, $r3=var2673, java.util.List=var3806, $r2=var3845, java.lang.Object=var2727, $r4=var2075, $r6=var2582, $r5=var2525, $r7=var1668, $r8=var1162, $r9=var1998}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("VirtualServiceSpec{hosts=");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec: java.util.List hosts>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", dubbo=");	$r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec: java.util.List dubbo>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1