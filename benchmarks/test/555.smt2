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

(declare-sort var2453 0)
(declare-sort var359 0)
(declare-sort var3032 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun apiVersion/-1104429376 (var2453) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun kind/-1104429376 (var2453) String)
(declare-fun metadata/-1104429376 (var2453) var359)
(declare-fun append/-1031950772 (String var3032) String)
(declare-fun cast-from-var359-to-var3032 (var359) var3032)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2453 var2453)
(declare-const var3262 var2453) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule 
(assert (not (= var3262 null-var2453)))
(define-const var3881 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3881)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3881!1 String)
(assert (= var3881!1 ""))
(assert true)
(define-const var1076 String (append/672562846 var3881!1 "BaseRule{apiVersion=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("BaseRule{apiVersion=\'") 
(declare-const var3881!2 String)
(assert (= var3881!2 (str.++ var3881!1 "BaseRule{apiVersion=\u0027")))
(define-const var509 String (apiVersion/-1104429376 var3262)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String apiVersion> 
(assert true)
(define-const var1106 String (append/672562846 var1076 var509)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1076!1 String)
(assert (= var1076!1 (str.++ var1076 var509)))
(assert true)
(define-const var2563 String (append/-1166366385 var1106 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1106!1 String)
(assert (str.prefixof var1106 var1106!1))
(assert true)
(define-const var1364 String (append/672562846 var2563 ", kind=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", kind=\'") 
(declare-const var2563!1 String)
(assert (= var2563!1 (str.++ var2563 ", kind=\u0027")))
(define-const var69 String (kind/-1104429376 var3262)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String kind> 
(assert true)
(define-const var584 String (append/672562846 var1364 var69)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1364!1 String)
(assert (= var1364!1 (str.++ var1364 var69)))
(assert true)
(define-const var3677 String (append/-1166366385 var584 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var584!1 String)
(assert (str.prefixof var584 var584!1))
(assert true)
(define-const var1264 String (append/672562846 var3677 ", metadata=")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", metadata=") 
(declare-const var3677!1 String)
(assert (= var3677!1 (str.++ var3677 ", metadata=")))
(define-const var3007 var359 (metadata/-1104429376 var3262)) ; Statement: $r10 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.util.Map metadata> 
(assert true)
(define-const var1735 String (append/-1031950772 var1264 (cast-from-var359-to-var3032 var3007))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var1264!1 String)
(assert (str.prefixof var1264 var1264!1))
(assert true)
(define-const var183 String (append/-1166366385 var1735 125)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1735!1 String)
(assert (str.prefixof var1735 var1735!1))
(assert true)
(define-const var1050 String (toString/-2075883882 var183)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), apiVersion/-1104429376=([org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), kind/-1104429376=([org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule], java.lang.String), metadata/-1104429376=([org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var359-to-var3032=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2453=org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule, var3262=r1, var3881=$r0, var1076=$r3, var509=$r2, var1106=$r4, var2563=$r5, var1364=$r7, var69=$r6, var584=$r8, var3677=$r9, var1264=$r11, var359=java.util.Map, var3007=$r10, var3032=java.lang.Object, var1735=$r12, var183=$r13, var1050=$r14}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule=var2453, r1=var3262, $r0=var3881, $r3=var1076, $r2=var509, $r4=var1106, $r5=var2563, $r7=var1364, $r6=var69, $r8=var584, $r9=var3677, $r11=var1264, java.util.Map=var359, $r10=var3007, java.lang.Object=var3032, $r12=var1735, $r13=var183, $r14=var1050}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("BaseRule{apiVersion=\'");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String apiVersion>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", kind=\'");	$r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.lang.String kind>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", metadata=");	$r10 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.BaseRule: java.util.Map metadata>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 1