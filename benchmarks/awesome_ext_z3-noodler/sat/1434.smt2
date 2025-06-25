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

(declare-sort var49 0)
(declare-sort var3818 0)
(declare-sort var1110 0)
(declare-sort var2551 0)
(declare-sort var760 0)
(declare-sort var3252 0)
(declare-sort var647 0)
(declare-sort var3373 0)
(declare-sort var3438 0)
(declare-sort var1590 0)
(declare-sort var150 0)
(declare-sort var710 0)
(declare-sort var3676 0)
(declare-sort var3282 0)
(declare-sort var1098 0)
(declare-sort var3648 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2551_stream/-1757820 ((Array Int var760)) var1110)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var760__ ((Array Int String)) (Array Int var760))
(declare-fun var647_bootstrap$/2009655218 (var49) var3252)
(declare-fun var1110_map/130902797 (var1110 var3252) var1110)
(declare-fun var3373_bootstrap$/-10390864 () var3252)
(declare-fun var1590_bootstrap$/1580325441 () var3438)
(declare-fun var150_bootstrap$/1763238751 () var3252)
(declare-fun var3676_toList/714215649 () var710)
(declare-fun var3676_mapping/2036973679 (var3252 var710) var710)
(declare-fun var3676_groupingBy/223989863 (var3252 var3438 var710) var710)
(declare-fun var1110_collect/-2050842585 (var1110 var710) var760)
(declare-fun cast-from-var760-to-var3282 (var760) var3282)
(declare-fun var3648_bootstrap$/1952487986 (var49) var1098)
(declare-fun var3282_forEach/1471512036 (var3282 var1098) void)
(declare-const null-var49 var49)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1185 var49) ; Statement: r2 := @this: feign.RequestTemplate 
(assert (not (= var1185 null-var49)))
(declare-const var1983 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1983 null-String)))
(declare-const var2881 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var2881 null-Bool)))
; split operation: var1380 = var1983.split("&") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&") 
(define-const var2002 var1110 (var2551_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var760__ var1380))) ; Statement: $r4 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1) 
(define-const var2798 var3252 (var647_bootstrap$/2009655218 var1185)) ; Statement: $r3 = staticinvoke <feign.RequestTemplate$splitQueryParameter__26: java.util.function.Function bootstrap$(feign.RequestTemplate)>(r2) 
(define-const var95 var1110 (var1110_map/130902797 var2002 var2798)) ; Statement: $r11 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3) 
(define-const var3389 var3252 var3373_bootstrap$/-10390864) ; Statement: $r9 = staticinvoke <feign.RequestTemplate$getKey__35: java.util.function.Function bootstrap$()>() 
(define-const var2455 var3438 var1590_bootstrap$/1580325441) ; Statement: $r8 = staticinvoke <feign.RequestTemplate$init__42: java.util.function.Supplier bootstrap$()>() 
(define-const var1107 var3252 var150_bootstrap$/1763238751) ; Statement: $r6 = staticinvoke <feign.RequestTemplate$getValue__45: java.util.function.Function bootstrap$()>() 
(define-const var350 var710 var3676_toList/714215649) ; Statement: $r5 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var2194 var710 (var3676_mapping/2036973679 var1107 var350)) ; Statement: $r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector mapping(java.util.function.Function,java.util.stream.Collector)>($r6, $r5) 
(define-const var3915 var710 (var3676_groupingBy/223989863 var3389 var2455 var2194)) ; Statement: $r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector groupingBy(java.util.function.Function,java.util.function.Supplier,java.util.stream.Collector)>($r9, $r8, $r7) 
(define-const var3526 var760 (var1110_collect/-2050842585 var95 var3915)) ; Statement: $r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10) 
(define-const var1515 var3282 (cast-from-var760-to-var3282 var3526)) ; Statement: r13 = (java.util.Map) $r12 
 ; Statement: if z0 != 0 goto $r14 = staticinvoke <feign.RequestTemplate$query__51: java.util.function.BiConsumer bootstrap$(feign.RequestTemplate)>(r2) 
(assert (not (= (ite var2881 1 0) 0))) ; Cond: z0 != 0 
(define-const var3005 var1098 (var3648_bootstrap$/1952487986 var1185)) ; Statement: $r14 = staticinvoke <feign.RequestTemplate$query__51: java.util.function.BiConsumer bootstrap$(feign.RequestTemplate)>(r2) 
;(assert (var3282_forEach/1471512036 var1515 var3005)) ; Statement: interfaceinvoke r13.<java.util.Map: void forEach(java.util.function.BiConsumer)>($r14) 

(declare-const var1515!1 var3282)
(declare-const var3005!1 var1098)
 ; Statement: return 
(check-sat)
; {var2551_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var760__=([java.lang.String[]], java.lang.Object[]), var647_bootstrap$/2009655218=([feign.RequestTemplate], java.util.function.Function), var1110_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var3373_bootstrap$/-10390864=([], java.util.function.Function), var1590_bootstrap$/1580325441=([], java.util.function.Supplier), var150_bootstrap$/1763238751=([], java.util.function.Function), var3676_toList/714215649=([], java.util.stream.Collector), var3676_mapping/2036973679=([java.util.function.Function, java.util.stream.Collector], java.util.stream.Collector), var3676_groupingBy/223989863=([java.util.function.Function, java.util.function.Supplier, java.util.stream.Collector], java.util.stream.Collector), var1110_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var760-to-var3282=([java.lang.Object], java.util.Map), var3648_bootstrap$/1952487986=([feign.RequestTemplate], java.util.function.BiConsumer), var3282_forEach/1471512036=([java.util.Map, java.util.function.BiConsumer], void)}
; {var49=feign.RequestTemplate, var1185=r2, var1983=r0, var3818=null_type, var2881=z0, var1380=$r1, var1110=java.util.stream.Stream, var2551=java.util.Arrays, var760=java.lang.Object, var2002=$r4, var3252=java.util.function.Function, var647=feign.RequestTemplate$splitQueryParameter__26, var2798=$r3, var95=$r11, var3373=feign.RequestTemplate$getKey__35, var3389=$r9, var3438=java.util.function.Supplier, var1590=feign.RequestTemplate$init__42, var2455=$r8, var150=feign.RequestTemplate$getValue__45, var1107=$r6, var710=java.util.stream.Collector, var3676=java.util.stream.Collectors, var350=$r5, var2194=$r7, var3915=$r10, var3526=$r12, var3282=java.util.Map, var1515=r13, var1098=java.util.function.BiConsumer, var3648=feign.RequestTemplate$query__51, var3005=$r14}
; {feign.RequestTemplate=var49, r2=var1185, r0=var1983, null_type=var3818, z0=var2881, $r1=var1380, java.util.stream.Stream=var1110, java.util.Arrays=var2551, java.lang.Object=var760, $r4=var2002, java.util.function.Function=var3252, feign.RequestTemplate$splitQueryParameter__26=var647, $r3=var2798, $r11=var95, feign.RequestTemplate$getKey__35=var3373, $r9=var3389, java.util.function.Supplier=var3438, feign.RequestTemplate$init__42=var1590, $r8=var2455, feign.RequestTemplate$getValue__45=var150, $r6=var1107, java.util.stream.Collector=var710, java.util.stream.Collectors=var3676, $r5=var350, $r7=var2194, $r10=var3915, $r12=var3526, java.util.Map=var3282, r13=var1515, java.util.function.BiConsumer=var1098, feign.RequestTemplate$query__51=var3648, $r14=var3005}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @this: feign.RequestTemplate;	r0 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&");	$r4 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1);	$r3 = staticinvoke <feign.RequestTemplate$splitQueryParameter__26: java.util.function.Function bootstrap$(feign.RequestTemplate)>(r2);	$r11 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3);	$r9 = staticinvoke <feign.RequestTemplate$getKey__35: java.util.function.Function bootstrap$()>();	$r8 = staticinvoke <feign.RequestTemplate$init__42: java.util.function.Supplier bootstrap$()>();	$r6 = staticinvoke <feign.RequestTemplate$getValue__45: java.util.function.Function bootstrap$()>();	$r5 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector mapping(java.util.function.Function,java.util.stream.Collector)>($r6, $r5);	$r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector groupingBy(java.util.function.Function,java.util.function.Supplier,java.util.stream.Collector)>($r9, $r8, $r7);	$r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10);	r13 = (java.util.Map) $r12;	if z0 != 0 goto $r14 = staticinvoke <feign.RequestTemplate$query__51: java.util.function.BiConsumer bootstrap$(feign.RequestTemplate)>(r2);	$r14 = staticinvoke <feign.RequestTemplate$query__51: java.util.function.BiConsumer bootstrap$(feign.RequestTemplate)>(r2);	interfaceinvoke r13.<java.util.Map: void forEach(java.util.function.BiConsumer)>($r14);	return
;block_num 2