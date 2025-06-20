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

(declare-sort var1857 0)
(declare-sort var460 0)
(declare-sort var1372 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getScaleFunction/-216782979 (var1857) var460)
(declare-fun append/-1031950772 (String var1372) String)
(declare-fun cast-from-var460-to-var1372 (var460) var1372)
(declare-fun useAlternatingSort/-1162731589 (var1857) Bool)
(declare-fun useTwoLevelCompression/-1162731589 (var1857) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1857 var1857)
(declare-const var1857-useWeightLimit Bool)
(declare-const var3857 var1857) ; Statement: r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest 
(assert (not (= var3857 null-var1857)))
(define-const var1009 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1009)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1009!1 String)
(assert (= var1009!1 ""))
(assert true)
(define-const var1360 String (append/672562846 var1009!1 "MergingDigest-")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-") 
(declare-const var1009!2 String)
(assert (= var1009!2 (str.++ var1009!1 "MergingDigest-")))
(assert true)
(define-const var2750 var460 (getScaleFunction/-216782979 var3857)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>() 
(assert true)
(define-const var461 String (append/-1031950772 var1360 (cast-from-var460-to-var1372 var2750))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1360!1 String)
(assert (str.prefixof var1360 var1360!1))
(assert true)
(define-const var80 String (append/672562846 var461 "-")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var461!1 String)
(assert (= var461!1 (str.++ var461 "-")))
(define-const var63 Bool var1857-useWeightLimit) ; Statement: $z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit> 
 ; Statement: if $z0 == 0 goto $r12 = "kSize" 
(assert (not (= (ite var63 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3089 String "weight") ; Statement: $r12 = "weight" 
 ; Statement: goto [?= $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1513 String (append/672562846 var80 var3089)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var80!1 String)
(assert (= var80!1 (str.++ var80 var3089)))
(assert true)
(define-const var3194 String (append/672562846 var1513 "-")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var1513!1 String)
(assert (= var1513!1 (str.++ var1513 "-")))
(define-const var896 Bool (useAlternatingSort/-1162731589 var3857)) ; Statement: $z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort> 
 ; Statement: if $z1 == 0 goto $r13 = "stable" 
(assert (= (ite var896 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3606 String "stable") ; Statement: $r13 = "stable" 
(assert true) ; Non Conditional
(assert true)
(define-const var34 String (append/672562846 var3194 var3606)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var3194!1 String)
(assert (= var3194!1 (str.++ var3194 var3606)))
(assert true)
(define-const var329 String (append/672562846 var34 "-")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var34!1 String)
(assert (= var34!1 (str.++ var34 "-")))
(define-const var3048 Bool (useTwoLevelCompression/-1162731589 var3857)) ; Statement: $z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression> 
 ; Statement: if $z2 == 0 goto $r14 = "oneLevel" 
(assert (not (= (ite var3048 1 0) 0))) ; Negate: Cond: $z2 == 0  
(define-const var361 String "twoLevel") ; Statement: $r14 = "twoLevel" 
 ; Statement: goto [?= $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1927 String (append/672562846 var329 var361)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var329!1 String)
(assert (= var329!1 (str.++ var329 var361)))
(assert true)
(define-const var3770 String (toString/-2075883882 var1927)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getScaleFunction/-216782979=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], com.tdunning.math.stats.ScaleFunction), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var460-to-var1372=([com.tdunning.math.stats.ScaleFunction], java.lang.Object), useAlternatingSort/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), useTwoLevelCompression/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1857=org.apache.dubbo.metrics.aggregate.DubboMergingDigest, var3857=r1, var1009=$r0, var1360=$r3, var460=com.tdunning.math.stats.ScaleFunction, var2750=$r2, var1372=java.lang.Object, var461=$r4, var80=$r5, var63=$z0, var3089=$r12, var1513=$r6, var3194=$r7, var896=$z1, var3606=$r13, var34=$r8, var329=$r9, var3048=$z2, var361=$r14, var1927=$r10, var3770=$r11}
; {org.apache.dubbo.metrics.aggregate.DubboMergingDigest=var1857, r1=var3857, $r0=var1009, $r3=var1360, com.tdunning.math.stats.ScaleFunction=var460, $r2=var2750, java.lang.Object=var1372, $r4=var461, $r5=var80, $z0=var63, $r12=var3089, $r6=var1513, $r7=var3194, $z1=var896, $r13=var3606, $r8=var34, $r9=var329, $z2=var3048, $r14=var361, $r10=var1927, $r11=var3770}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-");	$r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit>;	if $z0 == 0 goto $r12 = "kSize";	$r12 = "weight";	goto [?= $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)];	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort>;	if $z1 == 0 goto $r13 = "stable";	$r13 = "stable";	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression>;	if $z2 == 0 goto $r14 = "oneLevel";	$r14 = "twoLevel";	goto [?= $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14)];	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 7