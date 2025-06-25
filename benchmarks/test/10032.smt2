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

(declare-sort var452 0)
(declare-sort var3022 0)
(declare-sort var140 0)
(declare-sort var2528 0)
(declare-sort var1640 0)
(declare-sort var3049 0)
(declare-sort var1417 0)
(declare-sort var1808 0)
(declare-sort var2234 0)
(declare-sort var1711 0)
(declare-sort var348 0)
(declare-sort var3087 0)
(declare-sort var1873 0)
(declare-sort var1769 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3022_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var140-init () var140)
(declare-fun var2528_of/184955601 ((Array Int var1640)) var2528)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1640__ ((Array Int String)) (Array Int var1640))
(declare-fun var1417_bootstrap$/323445557 () var3049)
(declare-fun var2528_map/130902797 (var2528 var3049) var2528)
(declare-fun var2234_bootstrap$/-50820576 () var1808)
(declare-fun var2528_filter/320182972 (var2528 var1808) var2528)
(declare-fun var348_toSet/773895321 () var1711)
(declare-fun var2528_collect/-2050842585 (var2528 var1711) var1640)
(declare-fun cast-from-var1640-to-var3087 (var1640) var3087)
(declare-fun <init>/-873565429 (var140 var3087) void)
(declare-fun var1769_unmodifiableSet/219896279 (var1873) var1873)
(declare-fun cast-from-var140-to-var1873 (var140) var1873)
(declare-const null-String String)
(declare-const var3911 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3911 null-String)))
(define-const var1791 Bool (var3022_isBlank/-523695098 (cast-from-String-to-String var3911))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.util.TreeSet 
(assert (= (ite var1791 1 0) 0)) ; Cond: $z0 == 0 
(define-const var524 var140 var140-init) ; Statement: $r1 = new java.util.TreeSet 
; split operation: var2410 = var3911.split(",") ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2834 var2528 (var2528_of/184955601 (cast-from-__Array__Int__String__-to-__Array__Int__var1640__ var2410))) ; Statement: $r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r2) 
(define-const var1324 var3049 var1417_bootstrap$/323445557) ; Statement: $r3 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605: java.util.function.Function bootstrap$()>() 
(define-const var2704 var2528 (var2528_map/130902797 var2834 var1324)) ; Statement: $r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3) 
(define-const var3860 var1808 var2234_bootstrap$/-50820576) ; Statement: $r5 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610: java.util.function.Predicate bootstrap$()>() 
(define-const var1027 var2528 (var2528_filter/320182972 var2704 var3860)) ; Statement: $r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r5) 
(define-const var3843 var1711 var348_toSet/773895321) ; Statement: $r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>() 
(define-const var2441 var1640 (var2528_collect/-2050842585 var1027 var3843)) ; Statement: $r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7) 
(define-const var625 var3087 (cast-from-var1640-to-var3087 var2441)) ; Statement: $r10 = (java.util.Collection) $r9 
(assert true)
;(assert (<init>/-873565429 var524 var625)) ; Statement: specialinvoke $r1.<java.util.TreeSet: void <init>(java.util.Collection)>($r10) 

(declare-const var524!1 var140)
(declare-const var625!1 var3087)
(define-const var2327 var1873 (var1769_unmodifiableSet/219896279 (cast-from-var140-to-var1873 var524!1))) ; Statement: $r11 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r1) 
(assert true) ; Non Conditional
 ; Statement: return $r11 
(check-sat)
; {var3022_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var140-init=([], java.util.TreeSet), var2528_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1640__=([java.lang.String[]], java.lang.Object[]), var1417_bootstrap$/323445557=([], java.util.function.Function), var2528_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var2234_bootstrap$/-50820576=([], java.util.function.Predicate), var2528_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var348_toSet/773895321=([], java.util.stream.Collector), var2528_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1640-to-var3087=([java.lang.Object], java.util.Collection), <init>/-873565429=([java.util.TreeSet, java.util.Collection], void), var1769_unmodifiableSet/219896279=([java.util.Set], java.util.Set), cast-from-var140-to-var1873=([java.util.TreeSet], java.util.Set)}
; {var3911=r0, var452=null_type, var3022=org.apache.dubbo.common.utils.StringUtils, var1791=$z0, var140=java.util.TreeSet, var524=$r1, var2410=$r2, var2528=java.util.stream.Stream, var1640=java.lang.Object, var2834=$r4, var3049=java.util.function.Function, var1417=org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605, var1324=$r3, var2704=$r6, var1808=java.util.function.Predicate, var2234=org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610, var3860=$r5, var1027=$r8, var1711=java.util.stream.Collector, var348=java.util.stream.Collectors, var3843=$r7, var2441=$r9, var3087=java.util.Collection, var625=$r10, var1873=java.util.Set, var1769=java.util.Collections, var2327=$r11}
; {r0=var3911, null_type=var452, org.apache.dubbo.common.utils.StringUtils=var3022, $z0=var1791, java.util.TreeSet=var140, $r1=var524, $r2=var2410, java.util.stream.Stream=var2528, java.lang.Object=var1640, $r4=var2834, java.util.function.Function=var3049, org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605=var1417, $r3=var1324, $r6=var2704, java.util.function.Predicate=var1808, org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610=var2234, $r5=var3860, $r8=var1027, java.util.stream.Collector=var1711, java.util.stream.Collectors=var348, $r7=var3843, $r9=var2441, java.util.Collection=var3087, $r10=var625, java.util.Set=var1873, java.util.Collections=var1769, $r11=var2327}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = new java.util.TreeSet;	$r1 = new java.util.TreeSet;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r2);	$r3 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605: java.util.function.Function bootstrap$()>();	$r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3);	$r5 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610: java.util.function.Predicate bootstrap$()>();	$r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r5);	$r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>();	$r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7);	$r10 = (java.util.Collection) $r9;	specialinvoke $r1.<java.util.TreeSet: void <init>(java.util.Collection)>($r10);	$r11 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r1);	return $r11
;block_num 3