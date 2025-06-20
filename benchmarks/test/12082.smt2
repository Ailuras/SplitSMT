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

(declare-sort var3936 0)
(declare-sort var335 0)
(declare-sort var3760 0)
(declare-sort var2011 0)
(declare-sort var3270 0)
(declare-sort var2508 0)
(declare-sort var482 0)
(declare-sort var2028 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3270_stream/-1288525013 (var3270) var2011)
(declare-fun cast-from-var3760-to-var3270 (var3760) var3270)
(declare-fun var482_bootstrap$/-1981857360 (String) var2508)
(declare-fun var2011_filter/320182972 (var2011 var2508) var2011)
(declare-fun var2011_findFirst/-512239506 (var2011) var2028)
(declare-fun isPresent/580259846 (var2028) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3936 var3936)
(declare-const null-String String)
(declare-const null-var3760 var3760)
(declare-const var2779 var3936) ; Statement: r10 := @this: org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd 
(assert (not (= var2779 null-var3936)))
(declare-const var1409 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1409 null-String)))
(declare-const var2135 var3760) ; Statement: r0 := @parameter1: java.util.List 
(assert (not (= var2135 null-var3760)))
(define-const var406 var2011 (var3270_stream/-1288525013 (cast-from-var3760-to-var3270 var2135))) ; Statement: $r3 = interfaceinvoke r0.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var3949 var2508 (var482_bootstrap$/-1981857360 var1409)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd$lambda_specifySingleApplication_0__811: java.util.function.Predicate bootstrap$(java.lang.String)>(r1) 
(define-const var3358 var2011 (var2011_filter/320182972 var406 var3949)) ; Statement: $r4 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r2) 
(define-const var253 var2028 (var2011_findFirst/-512239506 var3358)) ; Statement: r5 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.Optional findFirst()>() 
(assert true)
(define-const var2123 Bool (isPresent/580259846 var253)) ; Statement: $z0 = virtualinvoke r5.<java.util.Optional: boolean isPresent()>() 
 ; Statement: if $z0 == 0 goto $r6 = new java.lang.StringBuilder 
(assert (= (ite var2123 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3006 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3006)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3006!1 String)
(assert (= var3006!1 ""))
(assert true)
(define-const var284 String (append/672562846 var3006!1 "Not exist application: ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not exist application: ") 
(declare-const var3006!2 String)
(assert (= var3006!2 (str.++ var3006!1 "Not exist application: ")))
(assert true)
(define-const var1085 String (append/672562846 var284 var1409)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var284!1 String)
(assert (= var284!1 (str.++ var284 var1409)))
(assert true)
(define-const var3509 String (toString/-2075883882 var1085)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {var3270_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var3760-to-var3270=([java.util.List], java.util.Collection), var482_bootstrap$/-1981857360=([java.lang.String], java.util.function.Predicate), var2011_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var2011_findFirst/-512239506=([java.util.stream.Stream], java.util.Optional), isPresent/580259846=([java.util.Optional], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3936=org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd, var2779=r10, var1409=r1, var335=null_type, var3760=java.util.List, var2135=r0, var2011=java.util.stream.Stream, var3270=java.util.Collection, var406=$r3, var2508=java.util.function.Predicate, var482=org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd$lambda_specifySingleApplication_0__811, var3949=$r2, var3358=$r4, var2028=java.util.Optional, var253=r5, var2123=$z0, var3006=$r6, var284=$r7, var1085=$r8, var3509=$r9}
; {org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd=var3936, r10=var2779, r1=var1409, null_type=var335, java.util.List=var3760, r0=var2135, java.util.stream.Stream=var2011, java.util.Collection=var3270, $r3=var406, java.util.function.Predicate=var2508, org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd$lambda_specifySingleApplication_0__811=var482, $r2=var3949, $r4=var3358, java.util.Optional=var2028, r5=var253, $z0=var2123, $r6=var3006, $r7=var284, $r8=var1085, $r9=var3509}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd;	r1 := @parameter0: java.lang.String;	r0 := @parameter1: java.util.List;	$r3 = interfaceinvoke r0.<java.util.List: java.util.stream.Stream stream()>();	$r2 = staticinvoke <org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd$lambda_specifySingleApplication_0__811: java.util.function.Predicate bootstrap$(java.lang.String)>(r1);	$r4 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r2);	r5 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.Optional findFirst()>();	$z0 = virtualinvoke r5.<java.util.Optional: boolean isPresent()>();	if $z0 == 0 goto $r6 = new java.lang.StringBuilder;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not exist application: ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 2