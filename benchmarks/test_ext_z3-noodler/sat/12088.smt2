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

(declare-sort var1112 0)
(declare-sort var1520 0)
(declare-sort var2263 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getScaleFunction/-216782979 (var1112) var1520)
(declare-fun append/-1031950772 (String var2263) String)
(declare-fun cast-from-var1520-to-var2263 (var1520) var2263)
(declare-fun useAlternatingSort/-1162731589 (var1112) Bool)
(declare-fun useTwoLevelCompression/-1162731589 (var1112) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1112 var1112)
(declare-const var1112-useWeightLimit Bool)
(declare-const var758 var1112) ; Statement: r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest 
(assert (not (= var758 null-var1112)))
(define-const var2718 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2718)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2718!1 String)
(assert (= var2718!1 ""))
(assert true)
(define-const var1605 String (append/672562846 var2718!1 "MergingDigest-")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-") 
(declare-const var2718!2 String)
(assert (= var2718!2 (str.++ var2718!1 "MergingDigest-")))
(assert true)
(define-const var3952 var1520 (getScaleFunction/-216782979 var758)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>() 
(assert true)
(define-const var2676 String (append/-1031950772 var1605 (cast-from-var1520-to-var2263 var3952))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1605!1 String)
(assert (str.prefixof var1605 var1605!1))
(assert true)
(define-const var144 String (append/672562846 var2676 "-")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var2676!1 String)
(assert (= var2676!1 (str.++ var2676 "-")))
(define-const var3843 Bool var1112-useWeightLimit) ; Statement: $z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit> 
 ; Statement: if $z0 == 0 goto $r12 = "kSize" 
(assert (not (= (ite var3843 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1303 String "weight") ; Statement: $r12 = "weight" 
 ; Statement: goto [?= $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2155 String (append/672562846 var144 var1303)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var144!1 String)
(assert (= var144!1 (str.++ var144 var1303)))
(assert true)
(define-const var198 String (append/672562846 var2155 "-")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var2155!1 String)
(assert (= var2155!1 (str.++ var2155 "-")))
(define-const var1843 Bool (useAlternatingSort/-1162731589 var758)) ; Statement: $z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort> 
 ; Statement: if $z1 == 0 goto $r13 = "stable" 
(assert (= (ite var1843 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1104 String "stable") ; Statement: $r13 = "stable" 
(assert true) ; Non Conditional
(assert true)
(define-const var2458 String (append/672562846 var198 var1104)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var198!1 String)
(assert (= var198!1 (str.++ var198 var1104)))
(assert true)
(define-const var161 String (append/672562846 var2458 "-")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var2458!1 String)
(assert (= var2458!1 (str.++ var2458 "-")))
(define-const var3329 Bool (useTwoLevelCompression/-1162731589 var758)) ; Statement: $z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression> 
 ; Statement: if $z2 == 0 goto $r14 = "oneLevel" 
(assert (= (ite var3329 1 0) 0)) ; Cond: $z2 == 0 
(define-const var679 String "oneLevel") ; Statement: $r14 = "oneLevel" 
(assert true) ; Non Conditional
(assert true)
(define-const var3380 String (append/672562846 var161 var679)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var161!1 String)
(assert (= var161!1 (str.++ var161 var679)))
(assert true)
(define-const var2502 String (toString/-2075883882 var3380)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getScaleFunction/-216782979=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], com.tdunning.math.stats.ScaleFunction), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1520-to-var2263=([com.tdunning.math.stats.ScaleFunction], java.lang.Object), useAlternatingSort/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), useTwoLevelCompression/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1112=org.apache.dubbo.metrics.aggregate.DubboMergingDigest, var758=r1, var2718=$r0, var1605=$r3, var1520=com.tdunning.math.stats.ScaleFunction, var3952=$r2, var2263=java.lang.Object, var2676=$r4, var144=$r5, var3843=$z0, var1303=$r12, var2155=$r6, var198=$r7, var1843=$z1, var1104=$r13, var2458=$r8, var161=$r9, var3329=$z2, var679=$r14, var3380=$r10, var2502=$r11}
; {org.apache.dubbo.metrics.aggregate.DubboMergingDigest=var1112, r1=var758, $r0=var2718, $r3=var1605, com.tdunning.math.stats.ScaleFunction=var1520, $r2=var3952, java.lang.Object=var2263, $r4=var2676, $r5=var144, $z0=var3843, $r12=var1303, $r6=var2155, $r7=var198, $z1=var1843, $r13=var1104, $r8=var2458, $r9=var161, $z2=var3329, $r14=var679, $r10=var3380, $r11=var2502}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-");	$r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit>;	if $z0 == 0 goto $r12 = "kSize";	$r12 = "weight";	goto [?= $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)];	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort>;	if $z1 == 0 goto $r13 = "stable";	$r13 = "stable";	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression>;	if $z2 == 0 goto $r14 = "oneLevel";	$r14 = "oneLevel";	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 7