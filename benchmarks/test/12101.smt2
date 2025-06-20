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

(declare-sort var1318 0)
(declare-sort var1322 0)
(declare-sort var3320 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getScaleFunction/-216782979 (var1318) var1322)
(declare-fun append/-1031950772 (String var3320) String)
(declare-fun cast-from-var1322-to-var3320 (var1322) var3320)
(declare-fun useAlternatingSort/-1162731589 (var1318) Bool)
(declare-fun useTwoLevelCompression/-1162731589 (var1318) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1318 var1318)
(declare-const var1318-useWeightLimit Bool)
(declare-const var3452 var1318) ; Statement: r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest 
(assert (not (= var3452 null-var1318)))
(define-const var1752 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1752)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1752!1 String)
(assert (= var1752!1 ""))
(assert true)
(define-const var2339 String (append/672562846 var1752!1 "MergingDigest-")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-") 
(declare-const var1752!2 String)
(assert (= var1752!2 (str.++ var1752!1 "MergingDigest-")))
(assert true)
(define-const var421 var1322 (getScaleFunction/-216782979 var3452)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>() 
(assert true)
(define-const var1939 String (append/-1031950772 var2339 (cast-from-var1322-to-var3320 var421))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2339!1 String)
(assert (str.prefixof var2339 var2339!1))
(assert true)
(define-const var863 String (append/672562846 var1939 "-")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var1939!1 String)
(assert (= var1939!1 (str.++ var1939 "-")))
(define-const var1353 Bool var1318-useWeightLimit) ; Statement: $z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit> 
 ; Statement: if $z0 == 0 goto $r12 = "kSize" 
(assert (= (ite var1353 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3861 String "kSize") ; Statement: $r12 = "kSize" 
(assert true) ; Non Conditional
(assert true)
(define-const var3481 String (append/672562846 var863 var3861)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var863!1 String)
(assert (= var863!1 (str.++ var863 var3861)))
(assert true)
(define-const var3011 String (append/672562846 var3481 "-")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var3481!1 String)
(assert (= var3481!1 (str.++ var3481 "-")))
(define-const var1468 Bool (useAlternatingSort/-1162731589 var3452)) ; Statement: $z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort> 
 ; Statement: if $z1 == 0 goto $r13 = "stable" 
(assert (not (= (ite var1468 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3621 String "alternating") ; Statement: $r13 = "alternating" 
 ; Statement: goto [?= $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13)] 
(assert true) ; Non Conditional
(assert true)
(define-const var780 String (append/672562846 var3011 var3621)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var3011!1 String)
(assert (= var3011!1 (str.++ var3011 var3621)))
(assert true)
(define-const var182 String (append/672562846 var780 "-")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var780!1 String)
(assert (= var780!1 (str.++ var780 "-")))
(define-const var3406 Bool (useTwoLevelCompression/-1162731589 var3452)) ; Statement: $z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression> 
 ; Statement: if $z2 == 0 goto $r14 = "oneLevel" 
(assert (= (ite var3406 1 0) 0)) ; Cond: $z2 == 0 
(define-const var2750 String "oneLevel") ; Statement: $r14 = "oneLevel" 
(assert true) ; Non Conditional
(assert true)
(define-const var632 String (append/672562846 var182 var2750)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var182!1 String)
(assert (= var182!1 (str.++ var182 var2750)))
(assert true)
(define-const var1772 String (toString/-2075883882 var632)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getScaleFunction/-216782979=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], com.tdunning.math.stats.ScaleFunction), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1322-to-var3320=([com.tdunning.math.stats.ScaleFunction], java.lang.Object), useAlternatingSort/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), useTwoLevelCompression/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1318=org.apache.dubbo.metrics.aggregate.DubboMergingDigest, var3452=r1, var1752=$r0, var2339=$r3, var1322=com.tdunning.math.stats.ScaleFunction, var421=$r2, var3320=java.lang.Object, var1939=$r4, var863=$r5, var1353=$z0, var3861=$r12, var3481=$r6, var3011=$r7, var1468=$z1, var3621=$r13, var780=$r8, var182=$r9, var3406=$z2, var2750=$r14, var632=$r10, var1772=$r11}
; {org.apache.dubbo.metrics.aggregate.DubboMergingDigest=var1318, r1=var3452, $r0=var1752, $r3=var2339, com.tdunning.math.stats.ScaleFunction=var1322, $r2=var421, java.lang.Object=var3320, $r4=var1939, $r5=var863, $z0=var1353, $r12=var3861, $r6=var3481, $r7=var3011, $z1=var1468, $r13=var3621, $r8=var780, $r9=var182, $z2=var3406, $r14=var2750, $r10=var632, $r11=var1772}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-");	$r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit>;	if $z0 == 0 goto $r12 = "kSize";	$r12 = "kSize";	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort>;	if $z1 == 0 goto $r13 = "stable";	$r13 = "alternating";	goto [?= $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13)];	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression>;	if $z2 == 0 goto $r14 = "oneLevel";	$r14 = "oneLevel";	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 7