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

(declare-sort var1049 0)
(declare-sort var1419 0)
(declare-sort var640 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getScaleFunction/-216782979 (var1049) var1419)
(declare-fun append/-1031950772 (String var640) String)
(declare-fun cast-from-var1419-to-var640 (var1419) var640)
(declare-fun useAlternatingSort/-1162731589 (var1049) Bool)
(declare-fun useTwoLevelCompression/-1162731589 (var1049) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1049 var1049)
(declare-const var1049-useWeightLimit Bool)
(declare-const var1855 var1049) ; Statement: r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest 
(assert (not (= var1855 null-var1049)))
(define-const var2246 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2246)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2246!1 String)
(assert (= var2246!1 ""))
(assert true)
(define-const var979 String (append/672562846 var2246!1 "MergingDigest-")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-") 
(declare-const var2246!2 String)
(assert (= var2246!2 (str.++ var2246!1 "MergingDigest-")))
(assert true)
(define-const var2523 var1419 (getScaleFunction/-216782979 var1855)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>() 
(assert true)
(define-const var1977 String (append/-1031950772 var979 (cast-from-var1419-to-var640 var2523))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var979!1 String)
(assert (str.prefixof var979 var979!1))
(assert true)
(define-const var3347 String (append/672562846 var1977 "-")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var1977!1 String)
(assert (= var1977!1 (str.++ var1977 "-")))
(define-const var1080 Bool var1049-useWeightLimit) ; Statement: $z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit> 
 ; Statement: if $z0 == 0 goto $r12 = "kSize" 
(assert (not (= (ite var1080 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var827 String "weight") ; Statement: $r12 = "weight" 
 ; Statement: goto [?= $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2765 String (append/672562846 var3347 var827)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var3347!1 String)
(assert (= var3347!1 (str.++ var3347 var827)))
(assert true)
(define-const var2967 String (append/672562846 var2765 "-")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var2765!1 String)
(assert (= var2765!1 (str.++ var2765 "-")))
(define-const var471 Bool (useAlternatingSort/-1162731589 var1855)) ; Statement: $z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort> 
 ; Statement: if $z1 == 0 goto $r13 = "stable" 
(assert (not (= (ite var471 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var234 String "alternating") ; Statement: $r13 = "alternating" 
 ; Statement: goto [?= $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1195 String (append/672562846 var2967 var234)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var2967!1 String)
(assert (= var2967!1 (str.++ var2967 var234)))
(assert true)
(define-const var3941 String (append/672562846 var1195 "-")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var1195!1 String)
(assert (= var1195!1 (str.++ var1195 "-")))
(define-const var1153 Bool (useTwoLevelCompression/-1162731589 var1855)) ; Statement: $z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression> 
 ; Statement: if $z2 == 0 goto $r14 = "oneLevel" 
(assert (= (ite var1153 1 0) 0)) ; Cond: $z2 == 0 
(define-const var1319 String "oneLevel") ; Statement: $r14 = "oneLevel" 
(assert true) ; Non Conditional
(assert true)
(define-const var282 String (append/672562846 var3941 var1319)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var3941!1 String)
(assert (= var3941!1 (str.++ var3941 var1319)))
(assert true)
(define-const var3880 String (toString/-2075883882 var282)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getScaleFunction/-216782979=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], com.tdunning.math.stats.ScaleFunction), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1419-to-var640=([com.tdunning.math.stats.ScaleFunction], java.lang.Object), useAlternatingSort/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), useTwoLevelCompression/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1049=org.apache.dubbo.metrics.aggregate.DubboMergingDigest, var1855=r1, var2246=$r0, var979=$r3, var1419=com.tdunning.math.stats.ScaleFunction, var2523=$r2, var640=java.lang.Object, var1977=$r4, var3347=$r5, var1080=$z0, var827=$r12, var2765=$r6, var2967=$r7, var471=$z1, var234=$r13, var1195=$r8, var3941=$r9, var1153=$z2, var1319=$r14, var282=$r10, var3880=$r11}
; {org.apache.dubbo.metrics.aggregate.DubboMergingDigest=var1049, r1=var1855, $r0=var2246, $r3=var979, com.tdunning.math.stats.ScaleFunction=var1419, $r2=var2523, java.lang.Object=var640, $r4=var1977, $r5=var3347, $z0=var1080, $r12=var827, $r6=var2765, $r7=var2967, $z1=var471, $r13=var234, $r8=var1195, $r9=var3941, $z2=var1153, $r14=var1319, $r10=var282, $r11=var3880}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-");	$r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit>;	if $z0 == 0 goto $r12 = "kSize";	$r12 = "weight";	goto [?= $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12)];	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort>;	if $z1 == 0 goto $r13 = "stable";	$r13 = "alternating";	goto [?= $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13)];	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression>;	if $z2 == 0 goto $r14 = "oneLevel";	$r14 = "oneLevel";	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 7