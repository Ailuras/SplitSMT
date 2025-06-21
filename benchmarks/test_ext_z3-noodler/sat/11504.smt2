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

(declare-sort var676 0)
(declare-sort var2217 0)
(declare-sort var203 0)
(declare-sort var3117 0)
(declare-sort var1221 0)
(declare-sort var159 0)
(declare-sort var2934 0)
(declare-sort var2531 0)
(declare-sort var3279 0)
(declare-sort var319 0)
(declare-sort var39 0)
(declare-sort var726 0)
(declare-sort var1754 0)
(declare-sort var2735 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var203-init () var203)
(declare-fun <init>/-201242697 (var203) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun meterRegistry/-670035156 (var676) var3117)
(declare-fun getMeters/422293004 (var3117) var1221)
(declare-fun var2934_stream/-1288525013 (var2934) var159)
(declare-fun cast-from-var1221-to-var2934 (var1221) var2934)
(declare-fun var3279_bootstrap$/1569606792 (String) var2531)
(declare-fun var159_filter/320182972 (var159 var2531) var159)
(declare-fun var39_bootstrap$/-1750823942 (var726 var726) var319)
(declare-fun cast-from-var203-to-var726 (var203) var726)
(declare-fun var159_forEach/1037804367 (var159 var319) void)
(declare-fun var2735_bootstrap$/538552378 (String var726) var1754)
(declare-fun var726_forEach/1471512036 (var726 var1754) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var676 var676)
(declare-const null-String String)
(declare-const var3737 var676) ; Statement: r3 := @this: org.apache.dubbo.metrics.report.DefaultMetricsReporter 
(assert (not (= var3737 null-var676)))
(declare-const var980 String) ; Statement: r6 := @parameter0: java.lang.String 
(assert (not (= var980 null-String)))
(define-const var1129 var203 var203-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1129)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var1129!1 var203)
(define-const var1638 var203 var203-init) ; Statement: $r1 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1638)) ; Statement: specialinvoke $r1.<java.util.HashMap: void <init>()>() 

(declare-const var1638!1 var203)
(define-const var2025 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2025)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2025!1 String)
(assert (= var2025!1 ""))
(define-const var1022 var3117 (meterRegistry/-670035156 var3737)) ; Statement: $r4 = r3.<org.apache.dubbo.metrics.report.DefaultMetricsReporter: io.micrometer.core.instrument.simple.SimpleMeterRegistry meterRegistry> 
(assert true)
(define-const var2344 var1221 (getMeters/422293004 var1022)) ; Statement: $r5 = virtualinvoke $r4.<io.micrometer.core.instrument.simple.SimpleMeterRegistry: java.util.List getMeters()>() 
(define-const var1801 var159 (var2934_stream/-1288525013 (cast-from-var1221-to-var2934 var2344))) ; Statement: $r8 = interfaceinvoke $r5.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var1324 var2531 (var3279_bootstrap$/1569606792 var980)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_0__772: java.util.function.Predicate bootstrap$(java.lang.String)>(r6) 
(define-const var1648 var159 (var159_filter/320182972 var1801 var1324)) ; Statement: $r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r7) 
(define-const var1558 var319 (var39_bootstrap$/-1750823942 (cast-from-var203-to-var726 var1129!1) (cast-from-var203-to-var726 var1638!1))) ; Statement: $r9 = staticinvoke <org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_1__791: java.util.function.Consumer bootstrap$(java.util.Map,java.util.Map)>($r0, $r1) 
;(assert (var159_forEach/1037804367 var1648 var1558)) ; Statement: interfaceinvoke $r10.<java.util.stream.Stream: void forEach(java.util.function.Consumer)>($r9) 

(declare-const var1648!1 var159)
(declare-const var1558!1 var319)
(define-const var3125 var1754 (var2735_bootstrap$/538552378 var2025!1 (cast-from-var203-to-var726 var1129!1))) ; Statement: $r11 = staticinvoke <org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_3__806: java.util.function.BiConsumer bootstrap$(java.lang.StringBuilder,java.util.Map)>($r2, $r0) 
;(assert (var726_forEach/1471512036 (cast-from-var203-to-var726 var1638!1) var3125)) ; Statement: interfaceinvoke $r1.<java.util.Map: void forEach(java.util.function.BiConsumer)>($r11) 

(declare-const var1638!2 var203)
(declare-const var3125!1 var1754)
(assert true)
(define-const var840 String (toString/-2075883882 var2025!1)) ; Statement: $r12 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {var203-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), meterRegistry/-670035156=([org.apache.dubbo.metrics.report.DefaultMetricsReporter], io.micrometer.core.instrument.simple.SimpleMeterRegistry), getMeters/422293004=([io.micrometer.core.instrument.simple.SimpleMeterRegistry], java.util.List), var2934_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var1221-to-var2934=([java.util.List], java.util.Collection), var3279_bootstrap$/1569606792=([java.lang.String], java.util.function.Predicate), var159_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var39_bootstrap$/-1750823942=([java.util.Map, java.util.Map], java.util.function.Consumer), cast-from-var203-to-var726=([java.util.HashMap], java.util.Map), var159_forEach/1037804367=([java.util.stream.Stream, java.util.function.Consumer], void), var2735_bootstrap$/538552378=([java.lang.StringBuilder, java.util.Map], java.util.function.BiConsumer), var726_forEach/1471512036=([java.util.Map, java.util.function.BiConsumer], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var676=org.apache.dubbo.metrics.report.DefaultMetricsReporter, var3737=r3, var980=r6, var2217=null_type, var203=java.util.HashMap, var1129=$r0, var1638=$r1, var2025=$r2, var3117=io.micrometer.core.instrument.simple.SimpleMeterRegistry, var1022=$r4, var1221=java.util.List, var2344=$r5, var159=java.util.stream.Stream, var2934=java.util.Collection, var1801=$r8, var2531=java.util.function.Predicate, var3279=org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_0__772, var1324=$r7, var1648=$r10, var319=java.util.function.Consumer, var39=org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_1__791, var726=java.util.Map, var1558=$r9, var1754=java.util.function.BiConsumer, var2735=org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_3__806, var3125=$r11, var840=$r12}
; {org.apache.dubbo.metrics.report.DefaultMetricsReporter=var676, r3=var3737, r6=var980, null_type=var2217, java.util.HashMap=var203, $r0=var1129, $r1=var1638, $r2=var2025, io.micrometer.core.instrument.simple.SimpleMeterRegistry=var3117, $r4=var1022, java.util.List=var1221, $r5=var2344, java.util.stream.Stream=var159, java.util.Collection=var2934, $r8=var1801, java.util.function.Predicate=var2531, org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_0__772=var3279, $r7=var1324, $r10=var1648, java.util.function.Consumer=var319, org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_1__791=var39, java.util.Map=var726, $r9=var1558, java.util.function.BiConsumer=var1754, org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_3__806=var2735, $r11=var3125, $r12=var840}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.metrics.report.DefaultMetricsReporter;	r6 := @parameter0: java.lang.String;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$r1 = new java.util.HashMap;	specialinvoke $r1.<java.util.HashMap: void <init>()>();	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = r3.<org.apache.dubbo.metrics.report.DefaultMetricsReporter: io.micrometer.core.instrument.simple.SimpleMeterRegistry meterRegistry>;	$r5 = virtualinvoke $r4.<io.micrometer.core.instrument.simple.SimpleMeterRegistry: java.util.List getMeters()>();	$r8 = interfaceinvoke $r5.<java.util.List: java.util.stream.Stream stream()>();	$r7 = staticinvoke <org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_0__772: java.util.function.Predicate bootstrap$(java.lang.String)>(r6);	$r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r7);	$r9 = staticinvoke <org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_1__791: java.util.function.Consumer bootstrap$(java.util.Map,java.util.Map)>($r0, $r1);	interfaceinvoke $r10.<java.util.stream.Stream: void forEach(java.util.function.Consumer)>($r9);	$r11 = staticinvoke <org.apache.dubbo.metrics.report.DefaultMetricsReporter$lambda_getResponseWithName_3__806: java.util.function.BiConsumer bootstrap$(java.lang.StringBuilder,java.util.Map)>($r2, $r0);	interfaceinvoke $r1.<java.util.Map: void forEach(java.util.function.BiConsumer)>($r11);	$r12 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1