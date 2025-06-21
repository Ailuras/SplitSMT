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

(declare-sort var3048 0)
(declare-sort var1201 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getApplicationName/-640420247 (var1201) String)
(declare-fun cast-from-var3048-to-var1201 (var3048) var1201)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun serviceKey/-716074480 (var3048) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3048 var3048)
(declare-const var3311 var3048) ; Statement: r1 := @this: org.apache.dubbo.metrics.model.ServiceKeyMetric 
(assert (not (= var3311 null-var3048)))
(define-const var1285 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1285)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1285!1 String)
(assert (= var1285!1 ""))
(assert true)
(define-const var608 String (append/672562846 var1285!1 "ServiceKeyMetric{applicationName=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceKeyMetric{applicationName=\'") 
(declare-const var1285!2 String)
(assert (= var1285!2 (str.++ var1285!1 "ServiceKeyMetric{applicationName=\u0027")))
(assert true)
(define-const var2659 String (getApplicationName/-640420247 (cast-from-var3048-to-var1201 var3311))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metrics.model.ServiceKeyMetric: java.lang.String getApplicationName()>() 
(assert true)
(define-const var3560 String (append/672562846 var608 var2659)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var608!1 String)
(assert (= var608!1 (str.++ var608 var2659)))
(assert true)
(define-const var3017 String (append/-1166366385 var3560 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3560!1 String)
(assert (str.prefixof var3560 var3560!1))
(assert true)
(define-const var3985 String (append/672562846 var3017 ", serviceKey=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", serviceKey=\'") 
(declare-const var3017!1 String)
(assert (= var3017!1 (str.++ var3017 ", serviceKey=\u0027")))
(define-const var743 String (serviceKey/-716074480 var3311)) ; Statement: $r6 = r1.<org.apache.dubbo.metrics.model.ServiceKeyMetric: java.lang.String serviceKey> 
(assert true)
(define-const var1716 String (append/672562846 var3985 var743)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3985!1 String)
(assert (= var3985!1 (str.++ var3985 var743)))
(assert true)
(define-const var345 String (append/-1166366385 var1716 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1716!1 String)
(assert (str.prefixof var1716 var1716!1))
(assert true)
(define-const var870 String (append/-1166366385 var345 125)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var345!1 String)
(assert (str.prefixof var345 var345!1))
(assert true)
(define-const var1505 String (toString/-2075883882 var870)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getApplicationName/-640420247=([org.apache.dubbo.metrics.model.ApplicationMetric], java.lang.String), cast-from-var3048-to-var1201=([org.apache.dubbo.metrics.model.ServiceKeyMetric], org.apache.dubbo.metrics.model.ApplicationMetric), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), serviceKey/-716074480=([org.apache.dubbo.metrics.model.ServiceKeyMetric], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3048=org.apache.dubbo.metrics.model.ServiceKeyMetric, var3311=r1, var1285=$r0, var608=$r3, var1201=org.apache.dubbo.metrics.model.ApplicationMetric, var2659=$r2, var3560=$r4, var3017=$r5, var3985=$r7, var743=$r6, var1716=$r8, var345=$r9, var870=$r10, var1505=$r11}
; {org.apache.dubbo.metrics.model.ServiceKeyMetric=var3048, r1=var3311, $r0=var1285, $r3=var608, org.apache.dubbo.metrics.model.ApplicationMetric=var1201, $r2=var2659, $r4=var3560, $r5=var3017, $r7=var3985, $r6=var743, $r8=var1716, $r9=var345, $r10=var870, $r11=var1505}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.model.ServiceKeyMetric;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceKeyMetric{applicationName=\'");	$r2 = virtualinvoke r1.<org.apache.dubbo.metrics.model.ServiceKeyMetric: java.lang.String getApplicationName()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", serviceKey=\'");	$r6 = r1.<org.apache.dubbo.metrics.model.ServiceKeyMetric: java.lang.String serviceKey>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 1