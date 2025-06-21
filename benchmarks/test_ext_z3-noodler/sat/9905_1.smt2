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

(declare-sort var3130 0)
(declare-sort var3277 0)
(declare-sort var3476 0)
(declare-sort var2997 0)
(declare-sort var1354 0)
(declare-sort var511 0)
(declare-sort var527 0)
(declare-sort var3428 0)
(declare-sort var423 0)
(declare-sort var2707 0)
(declare-sort var91 0)
(declare-sort var3329 0)
(declare-sort var3539 0)
(declare-sort var1159 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3277_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3476-init () var3476)
(declare-fun var2997_of/184955601 ((Array Int var1354)) var2997)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1354__ ((Array Int String)) (Array Int var1354))
(declare-fun var527_bootstrap$/323445557 () var511)
(declare-fun var2997_map/130902797 (var2997 var511) var2997)
(declare-fun var423_bootstrap$/-50820576 () var3428)
(declare-fun var2997_filter/320182972 (var2997 var3428) var2997)
(declare-fun var91_toSet/773895321 () var2707)
(declare-fun var2997_collect/-2050842585 (var2997 var2707) var1354)
(declare-fun cast-from-var1354-to-var3329 (var1354) var3329)
(declare-fun <init>/-873565429 (var3476 var3329) void)
(declare-fun var1159_unmodifiableSet/219896279 (var3539) var3539)
(declare-fun cast-from-var3476-to-var3539 (var3476) var3539)
(declare-const null-String String)
(declare-const var336 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var336 null-String)))
(define-const var1800 Bool (var3277_isBlank/-523695098 (cast-from-String-to-String var336))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.util.TreeSet 
(assert (= (ite var1800 1 0) 0)) ; Cond: $z0 == 0 
(define-const var761 var3476 var3476-init) ; Statement: $r1 = new java.util.TreeSet 
; split operation: var482 = var336.split(",") ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1442 var2997 (var2997_of/184955601 (cast-from-__Array__Int__String__-to-__Array__Int__var1354__ var482))) ; Statement: $r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r2) 
(define-const var2719 var511 var527_bootstrap$/323445557) ; Statement: $r3 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605: java.util.function.Function bootstrap$()>() 
(define-const var2921 var2997 (var2997_map/130902797 var1442 var2719)) ; Statement: $r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3) 
(define-const var3212 var3428 var423_bootstrap$/-50820576) ; Statement: $r5 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610: java.util.function.Predicate bootstrap$()>() 
(define-const var692 var2997 (var2997_filter/320182972 var2921 var3212)) ; Statement: $r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r5) 
(define-const var1999 var2707 var91_toSet/773895321) ; Statement: $r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>() 
(define-const var438 var1354 (var2997_collect/-2050842585 var692 var1999)) ; Statement: $r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7) 
(define-const var1867 var3329 (cast-from-var1354-to-var3329 var438)) ; Statement: $r10 = (java.util.Collection) $r9 
(assert true)
;(assert (<init>/-873565429 var761 var1867)) ; Statement: specialinvoke $r1.<java.util.TreeSet: void <init>(java.util.Collection)>($r10) 

(declare-const var761!1 var3476)
(declare-const var1867!1 var3329)
(define-const var3721 var3539 (var1159_unmodifiableSet/219896279 (cast-from-var3476-to-var3539 var761!1))) ; Statement: $r11 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r1) 
(assert true) ; Non Conditional
 ; Statement: return $r11 
(check-sat)
; {var3277_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3476-init=([], java.util.TreeSet), var2997_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1354__=([java.lang.String[]], java.lang.Object[]), var527_bootstrap$/323445557=([], java.util.function.Function), var2997_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var423_bootstrap$/-50820576=([], java.util.function.Predicate), var2997_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var91_toSet/773895321=([], java.util.stream.Collector), var2997_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1354-to-var3329=([java.lang.Object], java.util.Collection), <init>/-873565429=([java.util.TreeSet, java.util.Collection], void), var1159_unmodifiableSet/219896279=([java.util.Set], java.util.Set), cast-from-var3476-to-var3539=([java.util.TreeSet], java.util.Set)}
; {var336=r0, var3130=null_type, var3277=org.apache.dubbo.common.utils.StringUtils, var1800=$z0, var3476=java.util.TreeSet, var761=$r1, var482=$r2, var2997=java.util.stream.Stream, var1354=java.lang.Object, var1442=$r4, var511=java.util.function.Function, var527=org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605, var2719=$r3, var2921=$r6, var3428=java.util.function.Predicate, var423=org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610, var3212=$r5, var692=$r8, var2707=java.util.stream.Collector, var91=java.util.stream.Collectors, var1999=$r7, var438=$r9, var3329=java.util.Collection, var1867=$r10, var3539=java.util.Set, var1159=java.util.Collections, var3721=$r11}
; {r0=var336, null_type=var3130, org.apache.dubbo.common.utils.StringUtils=var3277, $z0=var1800, java.util.TreeSet=var3476, $r1=var761, $r2=var482, java.util.stream.Stream=var2997, java.lang.Object=var1354, $r4=var1442, java.util.function.Function=var511, org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605=var527, $r3=var2719, $r6=var2921, java.util.function.Predicate=var3428, org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610=var423, $r5=var3212, $r8=var692, java.util.stream.Collector=var2707, java.util.stream.Collectors=var91, $r7=var1999, $r9=var438, java.util.Collection=var3329, $r10=var1867, java.util.Set=var3539, java.util.Collections=var1159, $r11=var3721}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = new java.util.TreeSet;	$r1 = new java.util.TreeSet;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r2);	$r3 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605: java.util.function.Function bootstrap$()>();	$r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3);	$r5 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610: java.util.function.Predicate bootstrap$()>();	$r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r5);	$r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>();	$r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7);	$r10 = (java.util.Collection) $r9;	specialinvoke $r1.<java.util.TreeSet: void <init>(java.util.Collection)>($r10);	$r11 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r1);	return $r11
;block_num 3