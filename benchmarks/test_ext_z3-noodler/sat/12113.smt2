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

(declare-sort var2212 0)
(declare-sort var1779 0)
(declare-sort var2968 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getScaleFunction/-216782979 (var2212) var1779)
(declare-fun append/-1031950772 (String var2968) String)
(declare-fun cast-from-var1779-to-var2968 (var1779) var2968)
(declare-fun useAlternatingSort/-1162731589 (var2212) Bool)
(declare-fun useTwoLevelCompression/-1162731589 (var2212) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2212 var2212)
(declare-const var2212-useWeightLimit Bool)
(declare-const var1242 var2212) ; Statement: r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest 
(assert (not (= var1242 null-var2212)))
(define-const var1978 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1978)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1978!1 String)
(assert (= var1978!1 ""))
(assert true)
(define-const var2002 String (append/672562846 var1978!1 "MergingDigest-")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-") 
(declare-const var1978!2 String)
(assert (= var1978!2 (str.++ var1978!1 "MergingDigest-")))
(assert true)
(define-const var500 var1779 (getScaleFunction/-216782979 var1242)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>() 
(assert true)
(define-const var604 String (append/-1031950772 var2002 (cast-from-var1779-to-var2968 var500))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2002!1 String)
(assert (str.prefixof var2002 var2002!1))
(assert true)
(define-const var3817 String (append/672562846 var604 "-")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var604!1 String)
(assert (= var604!1 (str.++ var604 "-")))
(define-const var3599 Bool var2212-useWeightLimit) ; Statement: $z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit> 
 ; Statement: if $z0 == 0 goto $r12 = "kSize" 
(assert (= (ite var3599 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1991 String "kSize") ; Statement: $r12 = "kSize" 
(assert true) ; Non Conditional
(assert true)
(define-const var3271 String (append/672562846 var3817 var1991)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var3817!1 String)
(assert (= var3817!1 (str.++ var3817 var1991)))
(assert true)
(define-const var201 String (append/672562846 var3271 "-")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var3271!1 String)
(assert (= var3271!1 (str.++ var3271 "-")))
(define-const var1305 Bool (useAlternatingSort/-1162731589 var1242)) ; Statement: $z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort> 
 ; Statement: if $z1 == 0 goto $r13 = "stable" 
(assert (= (ite var1305 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1525 String "stable") ; Statement: $r13 = "stable" 
(assert true) ; Non Conditional
(assert true)
(define-const var236 String (append/672562846 var201 var1525)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var201!1 String)
(assert (= var201!1 (str.++ var201 var1525)))
(assert true)
(define-const var3481 String (append/672562846 var236 "-")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var236!1 String)
(assert (= var236!1 (str.++ var236 "-")))
(define-const var2953 Bool (useTwoLevelCompression/-1162731589 var1242)) ; Statement: $z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression> 
 ; Statement: if $z2 == 0 goto $r14 = "oneLevel" 
(assert (= (ite var2953 1 0) 0)) ; Cond: $z2 == 0 
(define-const var320 String "oneLevel") ; Statement: $r14 = "oneLevel" 
(assert true) ; Non Conditional
(assert true)
(define-const var2862 String (append/672562846 var3481 var320)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var3481!1 String)
(assert (= var3481!1 (str.++ var3481 var320)))
(assert true)
(define-const var2863 String (toString/-2075883882 var2862)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getScaleFunction/-216782979=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], com.tdunning.math.stats.ScaleFunction), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1779-to-var2968=([com.tdunning.math.stats.ScaleFunction], java.lang.Object), useAlternatingSort/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), useTwoLevelCompression/-1162731589=([org.apache.dubbo.metrics.aggregate.DubboMergingDigest], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2212=org.apache.dubbo.metrics.aggregate.DubboMergingDigest, var1242=r1, var1978=$r0, var2002=$r3, var1779=com.tdunning.math.stats.ScaleFunction, var500=$r2, var2968=java.lang.Object, var604=$r4, var3817=$r5, var3599=$z0, var1991=$r12, var3271=$r6, var201=$r7, var1305=$z1, var1525=$r13, var236=$r8, var3481=$r9, var2953=$z2, var320=$r14, var2862=$r10, var2863=$r11}
; {org.apache.dubbo.metrics.aggregate.DubboMergingDigest=var2212, r1=var1242, $r0=var1978, $r3=var2002, com.tdunning.math.stats.ScaleFunction=var1779, $r2=var500, java.lang.Object=var2968, $r4=var604, $r5=var3817, $z0=var3599, $r12=var1991, $r6=var3271, $r7=var201, $z1=var1305, $r13=var1525, $r8=var236, $r9=var3481, $z2=var2953, $r14=var320, $r10=var2862, $r11=var2863}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MergingDigest-");	$r2 = virtualinvoke r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: com.tdunning.math.stats.ScaleFunction getScaleFunction()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z0 = <org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useWeightLimit>;	if $z0 == 0 goto $r12 = "kSize";	$r12 = "kSize";	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z1 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useAlternatingSort>;	if $z1 == 0 goto $r13 = "stable";	$r13 = "stable";	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$z2 = r1.<org.apache.dubbo.metrics.aggregate.DubboMergingDigest: boolean useTwoLevelCompression>;	if $z2 == 0 goto $r14 = "oneLevel";	$r14 = "oneLevel";	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 7