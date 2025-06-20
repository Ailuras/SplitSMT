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

(declare-sort var2135 0)
(declare-sort var1747 0)
(declare-sort var3063 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-1396175467 (var2135) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun labels/-1396175467 (var2135) var1747)
(declare-fun append/-1031950772 (String var3063) String)
(declare-fun cast-from-var1747-to-var3063 (var1747) var3063)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2135 var2135)
(declare-const var1058 var2135) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset 
(assert (not (= var1058 null-var2135)))
(define-const var2932 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2932)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2932!1 String)
(assert (= var2932!1 ""))
(assert true)
(define-const var1200 String (append/672562846 var2932!1 "Subset{name=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Subset{name=\'") 
(declare-const var2932!2 String)
(assert (= var2932!2 (str.++ var2932!1 "Subset{name=\u0027")))
(define-const var2446 String (name/-1396175467 var1058)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset: java.lang.String name> 
(assert true)
(define-const var932 String (append/672562846 var1200 var2446)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1200!1 String)
(assert (= var1200!1 (str.++ var1200 var2446)))
(assert true)
(define-const var96 String (append/-1166366385 var932 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var932!1 String)
(assert (str.prefixof var932 var932!1))
(assert true)
(define-const var3311 String (append/672562846 var96 ", labels=")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", labels=") 
(declare-const var96!1 String)
(assert (= var96!1 (str.++ var96 ", labels=")))
(define-const var191 var1747 (labels/-1396175467 var1058)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset: java.util.Map labels> 
(assert true)
(define-const var682 String (append/-1031950772 var3311 (cast-from-var1747-to-var3063 var191))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var3311!1 String)
(assert (str.prefixof var3311 var3311!1))
(assert true)
(define-const var660 String (append/-1166366385 var682 125)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var682!1 String)
(assert (str.prefixof var682 var682!1))
(assert true)
(define-const var3230 String (toString/-2075883882 var660)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-1396175467=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), labels/-1396175467=([org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1747-to-var3063=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2135=org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset, var1058=r1, var2932=$r0, var1200=$r3, var2446=$r2, var932=$r4, var96=$r5, var3311=$r7, var1747=java.util.Map, var191=$r6, var3063=java.lang.Object, var682=$r8, var660=$r9, var3230=$r10}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset=var2135, r1=var1058, $r0=var2932, $r3=var1200, $r2=var2446, $r4=var932, $r5=var96, $r7=var3311, java.util.Map=var1747, $r6=var191, java.lang.Object=var3063, $r8=var682, $r9=var660, $r10=var3230}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Subset{name=\'");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", labels=");	$r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.destination.Subset: java.util.Map labels>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1