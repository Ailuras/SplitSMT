(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2367 0)
(declare-sort var324 0)
(declare-sort var879 0)
(declare-sort var1726 0)
(declare-sort var1120 0)
(declare-sort var581 0)
(declare-sort var3426 0)
(declare-sort var2648 0)
(declare-sort var1606 0)
(declare-sort var2336 0)
(declare-sort var1886 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var879_stream/-1757820 ((Array Int var1726)) var324)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1726__ ((Array Int String)) (Array Int var1726))
(declare-fun var581_bootstrap$/-341680553 () var1120)
(declare-fun var324_map/130902797 (var324 var1120) var324)
(declare-fun var2648_bootstrap$/1731141092 () var3426)
(declare-fun var324_filter/320182972 (var324 var3426) var324)
(declare-fun var2336_toList/714215649 () var1606)
(declare-fun var324_collect/-2050842585 (var324 var1606) var1726)
(declare-fun cast-from-var1726-to-var1886 (var1726) var1886)
(declare-const null-String String)
(declare-const var1839 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1839 null-String)))
; split operation: var893 = var1839.split("[ _-]") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[ _-]") 
(define-const var2205 var324 (var879_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var1726__ var893))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>(r1) 
(define-const var1168 var1120 var581_bootstrap$/-341680553) ; Statement: $r2 = staticinvoke <org.assertj.core.util.introspection.CaseFormatUtils$trim__477: java.util.function.Function bootstrap$()>() 
(define-const var1821 var324 (var324_map/130902797 var2205 var1168)) ; Statement: $r5 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r2) 
(define-const var1314 var3426 var2648_bootstrap$/1731141092) ; Statement: $r4 = staticinvoke <org.assertj.core.util.introspection.CaseFormatUtils$lambda_extractWords_1__482: java.util.function.Predicate bootstrap$()>() 
(define-const var3285 var324 (var324_filter/320182972 var1821 var1314)) ; Statement: $r7 = interfaceinvoke $r5.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r4) 
(define-const var926 var1606 var2336_toList/714215649) ; Statement: $r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var2703 var1726 (var324_collect/-2050842585 var3285 var926)) ; Statement: $r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6) 
(define-const var1665 var1886 (cast-from-var1726-to-var1886 var2703)) ; Statement: $r9 = (java.util.List) $r8 
 ; Statement: return $r9 
(check-sat)
; {var879_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1726__=([java.lang.String[]], java.lang.Object[]), var581_bootstrap$/-341680553=([], java.util.function.Function), var324_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var2648_bootstrap$/1731141092=([], java.util.function.Predicate), var324_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var2336_toList/714215649=([], java.util.stream.Collector), var324_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1726-to-var1886=([java.lang.Object], java.util.List)}
; {var1839=r0, var2367=null_type, var893=r1, var324=java.util.stream.Stream, var879=java.util.Arrays, var1726=java.lang.Object, var2205=$r3, var1120=java.util.function.Function, var581=org.assertj.core.util.introspection.CaseFormatUtils$trim__477, var1168=$r2, var1821=$r5, var3426=java.util.function.Predicate, var2648=org.assertj.core.util.introspection.CaseFormatUtils$lambda_extractWords_1__482, var1314=$r4, var3285=$r7, var1606=java.util.stream.Collector, var2336=java.util.stream.Collectors, var926=$r6, var2703=$r8, var1886=java.util.List, var1665=$r9}
; {r0=var1839, null_type=var2367, r1=var893, java.util.stream.Stream=var324, java.util.Arrays=var879, java.lang.Object=var1726, $r3=var2205, java.util.function.Function=var1120, org.assertj.core.util.introspection.CaseFormatUtils$trim__477=var581, $r2=var1168, $r5=var1821, java.util.function.Predicate=var3426, org.assertj.core.util.introspection.CaseFormatUtils$lambda_extractWords_1__482=var2648, $r4=var1314, $r7=var3285, java.util.stream.Collector=var1606, java.util.stream.Collectors=var2336, $r6=var926, $r8=var2703, java.util.List=var1886, $r9=var1665}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[ _-]");	$r3 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>(r1);	$r2 = staticinvoke <org.assertj.core.util.introspection.CaseFormatUtils$trim__477: java.util.function.Function bootstrap$()>();	$r5 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r2);	$r4 = staticinvoke <org.assertj.core.util.introspection.CaseFormatUtils$lambda_extractWords_1__482: java.util.function.Predicate bootstrap$()>();	$r7 = interfaceinvoke $r5.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r4);	$r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6);	$r9 = (java.util.List) $r8;	return $r9
;block_num 1