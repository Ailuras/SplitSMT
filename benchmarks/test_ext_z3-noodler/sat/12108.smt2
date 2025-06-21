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

(declare-sort var1643 0)
(declare-sort var3881 0)
(declare-sort var2635 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getScaleFunction/-216782979 (var1643) var3881)
(declare-fun append/-1031950772 (String var2635) String)
(declare-fun cast-from-var3881-to-var2635 (var3881) var2635)
(declare-fun useAlternatingSort/-1162731589 (var1643) Bool)
(declare-fun useTwoLevelCompression/-1162731589 (var1643) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1643 var1643)
(declare-const var1643-useWeightLimit Bool)
(declare-const var2760 var1643) ; Statement: r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest 
(assert (not (= var2760 null-var1643)))
(define-const var811 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var811)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var811!1 String)
(assert (= var811!1 ""))
(assert true)
(define-const var1558 String (append/672562846 var811!1 "MergingDigest-")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-") 
(declare-const var811!2 String)
(assert (= var811!2 (str.++ var811!1 "MergingDigest-")))
(assert true)
(define-const var563 var3881 (getScaleFunction/-216782979 var2760)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>() 
(assert true)
(define-const var3213 String (append/-1031950772 var1558 (cast-from-var3881-to-var2635 var563))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1558!1 String)
(assert (str.prefixof var1558 var1558!1))
(assert true)
(define-const var2712 String (append/672562846 var3213 "-")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var3213!1 String)
(assert (= var3213!1 (str.++ var3213 "-")))
(define-const var2627 Bool var1643-useWeightLimit) ; Statement: $z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit> 
 ; Statement: if $z0 == 0 goto $r12 = "kSize" 
(assert (= (ite var2627 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3559 String "kSize") ; Statement: $r12 = "kSize" 
(assert true) ; Non Conditional
(assert true)
(define-const var3545 String (append/672562846 var2712 var3559)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2712!1 String)
(assert (= var2712!1 (str.++ var2712 var3559)))
(assert true)
(define-const var1770 String (append/672562846 var3545 "-")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var3545!1 String)
(assert (= var3545!1 (str.++ var3545 "-")))
(define-const var3846 Bool (useAlternatingSort/-1162731589 var2760)) ; Statement: $z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort> 
 ; Statement: if $z1 == 0 goto $r13 = "stable" 
(assert (= (ite var3846 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2179 String "stable") ; Statement: $r13 = "stable" 
(assert true) ; Non Conditional
(assert true)
(define-const var3064 String (append/672562846 var1770 var2179)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var1770!1 String)
(assert (= var1770!1 (str.++ var1770 var2179)))
(assert true)
(define-const var2646 String (append/672562846 var3064 "-")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var3064!1 String)
(assert (= var3064!1 (str.++ var3064 "-")))
(define-const var926 Bool (useTwoLevelCompression/-1162731589 var2760)) ; Statement: $z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression> 
 ; Statement: if $z2 == 0 goto $r14 = "oneLevel" 
(assert (not (= (ite var926 1 0) 0))) ; Negate: Cond: $z2 == 0  
(define-const var1812 String "twoLevel") ; Statement: $r14 = "twoLevel" 
 ; Statement: goto [?= $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14)] 
(assert true) ; Non Conditional
(assert true)
(define-const var469 String (append/672562846 var2646 var1812)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var2646!1 String)
(assert (= var2646!1 (str.++ var2646 var1812)))
(assert true)
(define-const var51 String (toString/-2075883882 var469)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getScaleFunction/-216782979=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], com.tdunning.math.stats.ScaleFunction), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3881-to-var2635=([com.tdunning.math.stats.ScaleFunction], java.lang.Object), useAlternatingSort/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), useTwoLevelCompression/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1643=org.apache.dubbo.metrics.aggregate.DubboMergingDigest, var2760=r1, var811=$r0, var1558=$r3, var3881=com.tdunning.math.stats.ScaleFunction, var563=$r2, var2635=java.lang.Object, var3213=$r4, var2712=$r5, var2627=$z0, var3559=$r12, var3545=$r6, var1770=$r7, var3846=$z1, var2179=$r13, var3064=$r8, var2646=$r9, var926=$z2, var1812=$r14, var469=$r10, var51=$r11}
; {org.apache.dubbo.metrics.aggregate.DubboMergingDigest=var1643, r1=var2760, $r0=var811, $r3=var1558, com.tdunning.math.stats.ScaleFunction=var3881, $r2=var563, java.lang.Object=var2635, $r4=var3213, $r5=var2712, $z0=var2627, $r12=var3559, $r6=var3545, $r7=var1770, $z1=var3846, $r13=var2179, $r8=var3064, $r9=var2646, $z2=var926, $r14=var1812, $r10=var469, $r11=var51}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-");	$r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit>;	if $z0 == 0 goto $r12 = "kSize";	$r12 = "kSize";	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort>;	if $z1 == 0 goto $r13 = "stable";	$r13 = "stable";	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression>;	if $z2 == 0 goto $r14 = "oneLevel";	$r14 = "twoLevel";	goto [?= $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14)];	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 7