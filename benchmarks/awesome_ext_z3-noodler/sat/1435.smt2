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

(declare-sort var1464 0)
(declare-sort var24 0)
(declare-sort var2823 0)
(declare-sort var2150 0)
(declare-sort var1123 0)
(declare-sort var1052 0)
(declare-sort var3694 0)
(declare-sort var3749 0)
(declare-sort var3550 0)
(declare-sort var577 0)
(declare-sort var2086 0)
(declare-sort var2800 0)
(declare-sort var1800 0)
(declare-sort var1452 0)
(declare-sort var3605 0)
(declare-sort var402 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2150_stream/-1757820 ((Array Int var1123)) var2823)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1123__ ((Array Int String)) (Array Int var1123))
(declare-fun var3694_bootstrap$/2009655218 (var1464) var1052)
(declare-fun var2823_map/130902797 (var2823 var1052) var2823)
(declare-fun var3749_bootstrap$/-10390864 () var1052)
(declare-fun var577_bootstrap$/1580325441 () var3550)
(declare-fun var2086_bootstrap$/1763238751 () var1052)
(declare-fun var1800_toList/714215649 () var2800)
(declare-fun var1800_mapping/2036973679 (var1052 var2800) var2800)
(declare-fun var1800_groupingBy/223989863 (var1052 var3550 var2800) var2800)
(declare-fun var2823_collect/-2050842585 (var2823 var2800) var1123)
(declare-fun cast-from-var1123-to-var1452 (var1123) var1452)
(declare-fun queries/447845900 (var1464) var1452)
(declare-fun var1452_clear/2125668534 (var1452) void)
(declare-fun var402_bootstrap$/1952487986 (var1464) var3605)
(declare-fun var1452_forEach/1471512036 (var1452 var3605) void)
(declare-const null-var1464 var1464)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2726 var1464) ; Statement: r2 := @this: feign.RequestTemplate 
(assert (not (= var2726 null-var1464)))
(declare-const var329 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var329 null-String)))
(declare-const var277 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var277 null-Bool)))
; split operation: var3719 = var329.split("&") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&") 
(define-const var3076 var2823 (var2150_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var1123__ var3719))) ; Statement: $r4 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1) 
(define-const var199 var1052 (var3694_bootstrap$/2009655218 var2726)) ; Statement: $r3 = staticinvoke <feign.RequestTemplate$splitQueryParameter__26: java.util.function.Function bootstrap$(feign.RequestTemplate)>(r2) 
(define-const var2601 var2823 (var2823_map/130902797 var3076 var199)) ; Statement: $r11 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3) 
(define-const var3096 var1052 var3749_bootstrap$/-10390864) ; Statement: $r9 = staticinvoke <feign.RequestTemplate$getKey__35: java.util.function.Function bootstrap$()>() 
(define-const var3742 var3550 var577_bootstrap$/1580325441) ; Statement: $r8 = staticinvoke <feign.RequestTemplate$init__42: java.util.function.Supplier bootstrap$()>() 
(define-const var3053 var1052 var2086_bootstrap$/1763238751) ; Statement: $r6 = staticinvoke <feign.RequestTemplate$getValue__45: java.util.function.Function bootstrap$()>() 
(define-const var663 var2800 var1800_toList/714215649) ; Statement: $r5 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var3792 var2800 (var1800_mapping/2036973679 var3053 var663)) ; Statement: $r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector mapping(java.util.function.Function,java.util.stream.Collector)>($r6, $r5) 
(define-const var2140 var2800 (var1800_groupingBy/223989863 var3096 var3742 var3792)) ; Statement: $r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector groupingBy(java.util.function.Function,java.util.function.Supplier,java.util.stream.Collector)>($r9, $r8, $r7) 
(define-const var2382 var1123 (var2823_collect/-2050842585 var2601 var2140)) ; Statement: $r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10) 
(define-const var2021 var1452 (cast-from-var1123-to-var1452 var2382)) ; Statement: r13 = (java.util.Map) $r12 
 ; Statement: if z0 != 0 goto $r14 = staticinvoke <feign.RequestTemplate$query__51: java.util.function.BiConsumer bootstrap$(feign.RequestTemplate)>(r2) 
(assert (not (not (= (ite var277 1 0) 0)))) ; Negate: Cond: z0 != 0  
(define-const var619 var1452 (queries/447845900 var2726)) ; Statement: $r15 = r2.<feign.RequestTemplate: java.util.Map queries> 
;(assert (var1452_clear/2125668534 var619)) ; Statement: interfaceinvoke $r15.<java.util.Map: void clear()>() 

(declare-const var619!1 var1452)
(assert true) ; Non Conditional
(define-const var953 var3605 (var402_bootstrap$/1952487986 var2726)) ; Statement: $r14 = staticinvoke <feign.RequestTemplate$query__51: java.util.function.BiConsumer bootstrap$(feign.RequestTemplate)>(r2) 
;(assert (var1452_forEach/1471512036 var2021 var953)) ; Statement: interfaceinvoke r13.<java.util.Map: void forEach(java.util.function.BiConsumer)>($r14) 

(declare-const var2021!1 var1452)
(declare-const var953!1 var3605)
 ; Statement: return 
(check-sat)
; {var2150_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1123__=([java.lang.String[]], java.lang.Object[]), var3694_bootstrap$/2009655218=([feign.RequestTemplate], java.util.function.Function), var2823_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var3749_bootstrap$/-10390864=([], java.util.function.Function), var577_bootstrap$/1580325441=([], java.util.function.Supplier), var2086_bootstrap$/1763238751=([], java.util.function.Function), var1800_toList/714215649=([], java.util.stream.Collector), var1800_mapping/2036973679=([java.util.function.Function, java.util.stream.Collector], java.util.stream.Collector), var1800_groupingBy/223989863=([java.util.function.Function, java.util.function.Supplier, java.util.stream.Collector], java.util.stream.Collector), var2823_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1123-to-var1452=([java.lang.Object], java.util.Map), queries/447845900=([feign.RequestTemplate], java.util.Map), var1452_clear/2125668534=([java.util.Map], void), var402_bootstrap$/1952487986=([feign.RequestTemplate], java.util.function.BiConsumer), var1452_forEach/1471512036=([java.util.Map, java.util.function.BiConsumer], void)}
; {var1464=feign.RequestTemplate, var2726=r2, var329=r0, var24=null_type, var277=z0, var3719=$r1, var2823=java.util.stream.Stream, var2150=java.util.Arrays, var1123=java.lang.Object, var3076=$r4, var1052=java.util.function.Function, var3694=feign.RequestTemplate$splitQueryParameter__26, var199=$r3, var2601=$r11, var3749=feign.RequestTemplate$getKey__35, var3096=$r9, var3550=java.util.function.Supplier, var577=feign.RequestTemplate$init__42, var3742=$r8, var2086=feign.RequestTemplate$getValue__45, var3053=$r6, var2800=java.util.stream.Collector, var1800=java.util.stream.Collectors, var663=$r5, var3792=$r7, var2140=$r10, var2382=$r12, var1452=java.util.Map, var2021=r13, var619=$r15, var3605=java.util.function.BiConsumer, var402=feign.RequestTemplate$query__51, var953=$r14}
; {feign.RequestTemplate=var1464, r2=var2726, r0=var329, null_type=var24, z0=var277, $r1=var3719, java.util.stream.Stream=var2823, java.util.Arrays=var2150, java.lang.Object=var1123, $r4=var3076, java.util.function.Function=var1052, feign.RequestTemplate$splitQueryParameter__26=var3694, $r3=var199, $r11=var2601, feign.RequestTemplate$getKey__35=var3749, $r9=var3096, java.util.function.Supplier=var3550, feign.RequestTemplate$init__42=var577, $r8=var3742, feign.RequestTemplate$getValue__45=var2086, $r6=var3053, java.util.stream.Collector=var2800, java.util.stream.Collectors=var1800, $r5=var663, $r7=var3792, $r10=var2140, $r12=var2382, java.util.Map=var1452, r13=var2021, $r15=var619, java.util.function.BiConsumer=var3605, feign.RequestTemplate$query__51=var402, $r14=var953}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @this: feign.RequestTemplate;	r0 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&");	$r4 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1);	$r3 = staticinvoke <feign.RequestTemplate$splitQueryParameter__26: java.util.function.Function bootstrap$(feign.RequestTemplate)>(r2);	$r11 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3);	$r9 = staticinvoke <feign.RequestTemplate$getKey__35: java.util.function.Function bootstrap$()>();	$r8 = staticinvoke <feign.RequestTemplate$init__42: java.util.function.Supplier bootstrap$()>();	$r6 = staticinvoke <feign.RequestTemplate$getValue__45: java.util.function.Function bootstrap$()>();	$r5 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector mapping(java.util.function.Function,java.util.stream.Collector)>($r6, $r5);	$r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector groupingBy(java.util.function.Function,java.util.function.Supplier,java.util.stream.Collector)>($r9, $r8, $r7);	$r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10);	r13 = (java.util.Map) $r12;	if z0 != 0 goto $r14 = staticinvoke <feign.RequestTemplate$query__51: java.util.function.BiConsumer bootstrap$(feign.RequestTemplate)>(r2);	$r15 = r2.<feign.RequestTemplate: java.util.Map queries>;	interfaceinvoke $r15.<java.util.Map: void clear()>();	$r14 = staticinvoke <feign.RequestTemplate$query__51: java.util.function.BiConsumer bootstrap$(feign.RequestTemplate)>(r2);	interfaceinvoke r13.<java.util.Map: void forEach(java.util.function.BiConsumer)>($r14);	return
;block_num 3