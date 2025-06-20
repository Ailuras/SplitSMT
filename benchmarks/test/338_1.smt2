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

(declare-sort var1707 0)
(declare-sort var130 0)
(declare-sort var165 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun filter/-124242292 (var1707) var130)
(declare-fun var165_getClass/1258963082 (var165) ClassObject)
(declare-fun cast-from-var130-to-var165 (var130) var165)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1707 var1707)
(declare-const var1364 var1707) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$FilterChainNode 
(assert (not (= var1364 null-var1707)))
(define-const var3322 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3322)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3322!1 String)
(assert (= var3322!1 ""))
(assert true)
(define-const var669 String (append/672562846 var3322!1 "Filter ")) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Filter ") 
(declare-const var3322!2 String)
(assert (= var3322!2 (str.++ var3322!1 "Filter ")))
(define-const var3570 var130 (filter/-124242292 var1364)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$FilterChainNode: org.apache.dubbo.rpc.BaseFilter filter> 
(define-const var1022 ClassObject (var165_getClass/1258963082 (cast-from-var130-to-var165 var3570))) ; Statement: $r3 = interfaceinvoke $r2.<org.apache.dubbo.rpc.BaseFilter: java.lang.Class getClass()>() 
(assert true)
(define-const var153 String (getName/-1958580599 var1022)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2227 String (append/672562846 var669 var153)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var669!1 String)
(assert (= var669!1 (str.++ var669 var153)))
(assert true)
(define-const var1920 String (append/672562846 var2227 " invoke.")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" invoke.") 
(declare-const var2227!1 String)
(assert (= var2227!1 (str.++ var2227 " invoke.")))
(assert true)
(define-const var3253 String (toString/-2075883882 var1920)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), filter/-124242292=([org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$FilterChainNode], org.apache.dubbo.rpc.BaseFilter), var165_getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var130-to-var165=([org.apache.dubbo.rpc.BaseFilter], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1707=org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$FilterChainNode, var1364=r1, var3322=$r0, var669=$r5, var130=org.apache.dubbo.rpc.BaseFilter, var3570=$r2, var165=java.lang.Object, var1022=$r3, var153=$r4, var2227=$r6, var1920=$r7, var3253=$r8}
; {org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$FilterChainNode=var1707, r1=var1364, $r0=var3322, $r5=var669, org.apache.dubbo.rpc.BaseFilter=var130, $r2=var3570, java.lang.Object=var165, $r3=var1022, $r4=var153, $r6=var2227, $r7=var1920, $r8=var3253}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$FilterChainNode;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Filter ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.filter.FilterChainBuilder$FilterChainNode: org.apache.dubbo.rpc.BaseFilter filter>;	$r3 = interfaceinvoke $r2.<org.apache.dubbo.rpc.BaseFilter: java.lang.Class getClass()>();	$r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" invoke.");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1