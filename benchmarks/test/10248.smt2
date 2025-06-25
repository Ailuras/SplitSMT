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

(declare-sort var2979 0)
(declare-sort var3458 0)
(declare-sort var3851 0)
(declare-sort var3987 0)
(declare-sort var782 0)
(declare-sort var1845 0)
(declare-sort var2379 0)
(declare-sort var2970 0)
(declare-sort var3113 0)
(declare-sort var1795 0)
(declare-sort var3009 0)
(declare-sort var291 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3458_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3851-init () var3851)
(declare-fun var3987_of/184955601 ((Array Int var782)) var3987)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var782__ ((Array Int String)) (Array Int var782))
(declare-fun var2379_bootstrap$/1317093144 () var1845)
(declare-fun var3987_map/130902797 (var3987 var1845) var3987)
(declare-fun var3113_bootstrap$/1627830309 () var2970)
(declare-fun var3987_filter/320182972 (var3987 var2970) var3987)
(declare-fun var3009_toSet/773895321 () var1795)
(declare-fun var3987_collect/-2050842585 (var3987 var1795) var782)
(declare-fun cast-from-var782-to-var291 (var782) var291)
(declare-fun <init>/-873565429 (var3851 var291) void)
(declare-const null-String String)
(declare-const var331 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var331 null-String)))
(define-const var2703 Bool (var3458_isBlank/-523695098 (cast-from-String-to-String var331))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.util.TreeSet 
(assert (= (ite var2703 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2620 var3851 var3851-init) ; Statement: $r1 = new java.util.TreeSet 
; split operation: var92 = var331.split(",") ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var3702 var3987 (var3987_of/184955601 (cast-from-__Array__Int__String__-to-__Array__Int__var782__ var92))) ; Statement: $r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r2) 
(define-const var2182 var1845 var2379_bootstrap$/1317093144) ; Statement: $r3 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping$trim__626: java.util.function.Function bootstrap$()>() 
(define-const var3050 var3987 (var3987_map/130902797 var3702 var2182)) ; Statement: $r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3) 
(define-const var1841 var2970 var3113_bootstrap$/1627830309) ; Statement: $r5 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__639: java.util.function.Predicate bootstrap$()>() 
(define-const var3720 var3987 (var3987_filter/320182972 var3050 var1841)) ; Statement: $r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r5) 
(define-const var574 var1795 var3009_toSet/773895321) ; Statement: $r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>() 
(define-const var3555 var782 (var3987_collect/-2050842585 var3720 var574)) ; Statement: $r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7) 
(define-const var3990 var291 (cast-from-var782-to-var291 var3555)) ; Statement: $r10 = (java.util.Collection) $r9 
(assert true)
;(assert (<init>/-873565429 var2620 var3990)) ; Statement: specialinvoke $r1.<java.util.TreeSet: void <init>(java.util.Collection)>($r10) 

(declare-const var2620!1 var3851)
(declare-const var3990!1 var291)
 ; Statement: return $r1 
(check-sat)
; {var3458_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3851-init=([], java.util.TreeSet), var3987_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var782__=([java.lang.String[]], java.lang.Object[]), var2379_bootstrap$/1317093144=([], java.util.function.Function), var3987_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var3113_bootstrap$/1627830309=([], java.util.function.Predicate), var3987_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var3009_toSet/773895321=([], java.util.stream.Collector), var3987_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var782-to-var291=([java.lang.Object], java.util.Collection), <init>/-873565429=([java.util.TreeSet, java.util.Collection], void)}
; {var331=r0, var2979=null_type, var3458=org.apache.dubbo.common.utils.StringUtils, var2703=$z0, var3851=java.util.TreeSet, var2620=$r1, var92=$r2, var3987=java.util.stream.Stream, var782=java.lang.Object, var3702=$r4, var1845=java.util.function.Function, var2379=org.apache.dubbo.metadata.ServiceNameMapping$trim__626, var2182=$r3, var3050=$r6, var2970=java.util.function.Predicate, var3113=org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__639, var1841=$r5, var3720=$r8, var1795=java.util.stream.Collector, var3009=java.util.stream.Collectors, var574=$r7, var3555=$r9, var291=java.util.Collection, var3990=$r10}
; {r0=var331, null_type=var2979, org.apache.dubbo.common.utils.StringUtils=var3458, $z0=var2703, java.util.TreeSet=var3851, $r1=var2620, $r2=var92, java.util.stream.Stream=var3987, java.lang.Object=var782, $r4=var3702, java.util.function.Function=var1845, org.apache.dubbo.metadata.ServiceNameMapping$trim__626=var2379, $r3=var2182, $r6=var3050, java.util.function.Predicate=var2970, org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__639=var3113, $r5=var1841, $r8=var3720, java.util.stream.Collector=var1795, java.util.stream.Collectors=var3009, $r7=var574, $r9=var3555, java.util.Collection=var291, $r10=var3990}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = new java.util.TreeSet;	$r1 = new java.util.TreeSet;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r2);	$r3 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping$trim__626: java.util.function.Function bootstrap$()>();	$r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3);	$r5 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__639: java.util.function.Predicate bootstrap$()>();	$r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r5);	$r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>();	$r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7);	$r10 = (java.util.Collection) $r9;	specialinvoke $r1.<java.util.TreeSet: void <init>(java.util.Collection)>($r10);	return $r1
;block_num 2