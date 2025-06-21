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

(declare-sort var3392 0)
(declare-sort var797 0)
(declare-sort var3822 0)
(declare-sort var1143 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toString/-1647567016 (var797) String)
(declare-fun cast-from-var3392-to-var797 (var3392) var797)
(declare-fun spec/1702344887 (var3392) var3822)
(declare-fun append/-1031950772 (String var1143) String)
(declare-fun cast-from-var3822-to-var1143 (var3822) var1143)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3392 var3392)
(declare-const var2388 var3392) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceRule 
(assert (not (= var2388 null-var3392)))
(define-const var539 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var539)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var539!1 String)
(assert (= var539!1 ""))
(assert true)
(define-const var745 String (append/672562846 var539!1 "VirtualServiceRule{base=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("VirtualServiceRule{base=") 
(declare-const var539!2 String)
(assert (= var539!2 (str.++ var539!1 "VirtualServiceRule{base=")))
(assert true)
(define-const var435 String (toString/-1647567016 (cast-from-var3392-to-var797 var2388))) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String toString()>() 
(assert true)
(define-const var336 String (append/672562846 var745 var435)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var745!1 String)
(assert (= var745!1 (str.++ var745 var435)))
(assert true)
(define-const var2190 String (append/672562846 var336 ", spec=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", spec=") 
(declare-const var336!1 String)
(assert (= var336!1 (str.++ var336 ", spec=")))
(define-const var2664 var3822 (spec/1702344887 var2388)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceRule: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec spec> 
(assert true)
(define-const var2977 String (append/-1031950772 var2190 (cast-from-var3822-to-var1143 var2664))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2190!1 String)
(assert (str.prefixof var2190 var2190!1))
(assert true)
(define-const var2150 String (append/-1166366385 var2977 125)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2977!1 String)
(assert (str.prefixof var2977 var2977!1))
(assert true)
(define-const var3976 String (toString/-2075883882 var2150)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-1647567016=([org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule], java.lang.String), cast-from-var3392-to-var797=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceRule], org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule), spec/1702344887=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceRule], org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3822-to-var1143=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3392=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceRule, var2388=r1, var539=$r0, var745=$r3, var797=org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule, var435=$r2, var336=$r4, var2190=$r6, var3822=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec, var2664=$r5, var1143=java.lang.Object, var2977=$r7, var2150=$r8, var3976=$r9}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceRule=var3392, r1=var2388, $r0=var539, $r3=var745, org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule=var797, $r2=var435, $r4=var336, $r6=var2190, org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec=var3822, $r5=var2664, java.lang.Object=var1143, $r7=var2977, $r8=var2150, $r9=var3976}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceRule;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("VirtualServiceRule{base=");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", spec=");	$r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceRule: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.VirtualServiceSpec spec>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1