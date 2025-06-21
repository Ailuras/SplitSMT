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

(declare-sort var3625 0)
(declare-sort var2482 0)
(declare-sort var1993 0)
(declare-sort var2221 0)
(declare-sort var3731 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/396767592 (var3625) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun description/396767592 (var3625) String)
(declare-fun baseUnit/396767592 (var3625) String)
(declare-fun type/396767592 (var3625) var2482)
(declare-fun append/-1031950772 (String var1993) String)
(declare-fun cast-from-var2482-to-var1993 (var2482) var1993)
(declare-fun category/396767592 (var3625) var2221)
(declare-fun cast-from-var2221-to-var1993 (var2221) var1993)
(declare-fun tags/396767592 (var3625) var3731)
(declare-fun cast-from-var3731-to-var1993 (var3731) var1993)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3625 var3625)
(declare-const var281 var3625) ; Statement: r1 := @this: org.apache.dubbo.metrics.model.sample.MetricSample 
(assert (not (= var281 null-var3625)))
(define-const var2433 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2433)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2433!1 String)
(assert (= var2433!1 ""))
(assert true)
(define-const var1029 String (append/672562846 var2433!1 "MetricSample{name=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MetricSample{name=\'") 
(declare-const var2433!2 String)
(assert (= var2433!2 (str.++ var2433!1 "MetricSample{name=\u0027")))
(define-const var2527 String (name/396767592 var281)) ; Statement: $r2 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: java.lang.String name> 
(assert true)
(define-const var2133 String (append/672562846 var1029 var2527)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1029!1 String)
(assert (= var1029!1 (str.++ var1029 var2527)))
(assert true)
(define-const var99 String (append/-1166366385 var2133 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2133!1 String)
(assert (str.prefixof var2133 var2133!1))
(assert true)
(define-const var551 String (append/672562846 var99 ", description=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", description=\'") 
(declare-const var99!1 String)
(assert (= var99!1 (str.++ var99 ", description=\u0027")))
(define-const var1122 String (description/396767592 var281)) ; Statement: $r6 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: java.lang.String description> 
(assert true)
(define-const var3969 String (append/672562846 var551 var1122)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var551!1 String)
(assert (= var551!1 (str.++ var551 var1122)))
(assert true)
(define-const var2804 String (append/-1166366385 var3969 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3969!1 String)
(assert (str.prefixof var3969 var3969!1))
(assert true)
(define-const var1885 String (append/672562846 var2804 ", baseUnit=\u0027")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", baseUnit=\'") 
(declare-const var2804!1 String)
(assert (= var2804!1 (str.++ var2804 ", baseUnit=\u0027")))
(define-const var2148 String (baseUnit/396767592 var281)) ; Statement: $r10 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: java.lang.String baseUnit> 
(assert true)
(define-const var1947 String (append/672562846 var1885 var2148)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var1885!1 String)
(assert (= var1885!1 (str.++ var1885 var2148)))
(assert true)
(define-const var1251 String (append/-1166366385 var1947 39)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1947!1 String)
(assert (str.prefixof var1947 var1947!1))
(assert true)
(define-const var155 String (append/672562846 var1251 ", type=")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type=") 
(declare-const var1251!1 String)
(assert (= var1251!1 (str.++ var1251 ", type=")))
(define-const var2390 var2482 (type/396767592 var281)) ; Statement: $r14 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: org.apache.dubbo.metrics.model.sample.MetricSample$Type type> 
(assert true)
(define-const var395 String (append/-1031950772 var155 (cast-from-var2482-to-var1993 var2390))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14) 
(declare-const var155!1 String)
(assert (str.prefixof var155 var155!1))
(assert true)
(define-const var93 String (append/672562846 var395 ", category=")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", category=") 
(declare-const var395!1 String)
(assert (= var395!1 (str.++ var395 ", category=")))
(define-const var2077 var2221 (category/396767592 var281)) ; Statement: $r17 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: org.apache.dubbo.metrics.model.MetricsCategory category> 
(assert true)
(define-const var1740 String (append/-1031950772 var93 (cast-from-var2221-to-var1993 var2077))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r17) 
(declare-const var93!1 String)
(assert (str.prefixof var93 var93!1))
(assert true)
(define-const var2110 String (append/672562846 var1740 ", tags=")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", tags=") 
(declare-const var1740!1 String)
(assert (= var1740!1 (str.++ var1740 ", tags=")))
(define-const var2203 var3731 (tags/396767592 var281)) ; Statement: $r20 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: java.util.Map tags> 
(assert true)
(define-const var3876 String (append/-1031950772 var2110 (cast-from-var3731-to-var1993 var2203))) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var2110!1 String)
(assert (str.prefixof var2110 var2110!1))
(assert true)
(define-const var1167 String (append/-1166366385 var3876 125)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3876!1 String)
(assert (str.prefixof var3876 var3876!1))
(assert true)
(define-const var1404 String (toString/-2075883882 var1167)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r24 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/396767592=([org.apache.dubbo.metrics.model.sample.MetricSample], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), description/396767592=([org.apache.dubbo.metrics.model.sample.MetricSample], java.lang.String), baseUnit/396767592=([org.apache.dubbo.metrics.model.sample.MetricSample], java.lang.String), type/396767592=([org.apache.dubbo.metrics.model.sample.MetricSample], org.apache.dubbo.metrics.model.sample.MetricSample$Type), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2482-to-var1993=([org.apache.dubbo.metrics.model.sample.MetricSample$Type], java.lang.Object), category/396767592=([org.apache.dubbo.metrics.model.sample.MetricSample], org.apache.dubbo.metrics.model.MetricsCategory), cast-from-var2221-to-var1993=([org.apache.dubbo.metrics.model.MetricsCategory], java.lang.Object), tags/396767592=([org.apache.dubbo.metrics.model.sample.MetricSample], java.util.Map), cast-from-var3731-to-var1993=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3625=org.apache.dubbo.metrics.model.sample.MetricSample, var281=r1, var2433=$r0, var1029=$r3, var2527=$r2, var2133=$r4, var99=$r5, var551=$r7, var1122=$r6, var3969=$r8, var2804=$r9, var1885=$r11, var2148=$r10, var1947=$r12, var1251=$r13, var155=$r15, var2482=org.apache.dubbo.metrics.model.sample.MetricSample$Type, var2390=$r14, var1993=java.lang.Object, var395=$r16, var93=$r18, var2221=org.apache.dubbo.metrics.model.MetricsCategory, var2077=$r17, var1740=$r19, var2110=$r21, var3731=java.util.Map, var2203=$r20, var3876=$r22, var1167=$r23, var1404=$r24}
; {org.apache.dubbo.metrics.model.sample.MetricSample=var3625, r1=var281, $r0=var2433, $r3=var1029, $r2=var2527, $r4=var2133, $r5=var99, $r7=var551, $r6=var1122, $r8=var3969, $r9=var2804, $r11=var1885, $r10=var2148, $r12=var1947, $r13=var1251, $r15=var155, org.apache.dubbo.metrics.model.sample.MetricSample$Type=var2482, $r14=var2390, java.lang.Object=var1993, $r16=var395, $r18=var93, org.apache.dubbo.metrics.model.MetricsCategory=var2221, $r17=var2077, $r19=var1740, $r21=var2110, java.util.Map=var3731, $r20=var2203, $r22=var3876, $r23=var1167, $r24=var1404}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 9,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.model.sample.MetricSample;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MetricSample{name=\'");	$r2 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", description=\'");	$r6 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: java.lang.String description>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", baseUnit=\'");	$r10 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: java.lang.String baseUnit>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type=");	$r14 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: org.apache.dubbo.metrics.model.sample.MetricSample$Type type>;	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14);	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", category=");	$r17 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: org.apache.dubbo.metrics.model.MetricsCategory category>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", tags=");	$r20 = r1.<org.apache.dubbo.metrics.model.sample.MetricSample: java.util.Map tags>;	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.String toString()>();	return $r24
;block_num 1