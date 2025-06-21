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

(declare-sort var3912 0)
(declare-sort var338 0)
(declare-sort var3079 0)
(declare-sort var3056 0)
(declare-sort var2104 0)
(declare-sort var3489 0)
(declare-sort var1673 0)
(declare-sort var3675 0)
(declare-sort var1750 0)
(declare-sort var2085 0)
(declare-sort var923 0)
(declare-sort var2020 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var338_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3079-init () var3079)
(declare-fun var3056_of/184955601 ((Array Int var2104)) var3056)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2104__ ((Array Int String)) (Array Int var2104))
(declare-fun var1673_bootstrap$/-1953180231 () var3489)
(declare-fun var3056_map/130902797 (var3056 var3489) var3056)
(declare-fun var1750_bootstrap$/734343971 () var3675)
(declare-fun var3056_filter/320182972 (var3056 var3675) var3056)
(declare-fun var923_toSet/773895321 () var2085)
(declare-fun var3056_collect/-2050842585 (var3056 var2085) var2104)
(declare-fun cast-from-var2104-to-var2020 (var2104) var2020)
(declare-fun <init>/-873565429 (var3079 var2020) void)
(declare-const null-String String)
(declare-const var3071 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3071 null-String)))
(define-const var3482 Bool (var338_isBlank/-523695098 (cast-from-String-to-String var3071))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.util.TreeSet 
(assert (= (ite var3482 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1160 var3079 var3079-init) ; Statement: $r1 = new java.util.TreeSet 
; split operation: var1708 = var3071.split(",") ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1803 var3056 (var3056_of/184955601 (cast-from-__Array__Int__String__-to-__Array__Int__var2104__ var1708))) ; Statement: $r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r2) 
(define-const var726 var3489 var1673_bootstrap$/-1953180231) ; Statement: $r3 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping$trim__625: java.util.function.Function bootstrap$()>() 
(define-const var217 var3056 (var3056_map/130902797 var1803 var726)) ; Statement: $r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3) 
(define-const var1285 var3675 var1750_bootstrap$/734343971) ; Statement: $r5 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__637: java.util.function.Predicate bootstrap$()>() 
(define-const var1447 var3056 (var3056_filter/320182972 var217 var1285)) ; Statement: $r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r5) 
(define-const var1707 var2085 var923_toSet/773895321) ; Statement: $r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>() 
(define-const var3743 var2104 (var3056_collect/-2050842585 var1447 var1707)) ; Statement: $r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7) 
(define-const var124 var2020 (cast-from-var2104-to-var2020 var3743)) ; Statement: $r10 = (java.util.Collection) $r9 
(assert true)
;(assert (<init>/-873565429 var1160 var124)) ; Statement: specialinvoke $r1.<java.util.TreeSet: void <init>(java.util.Collection)>($r10) 

(declare-const var1160!1 var3079)
(declare-const var124!1 var2020)
 ; Statement: return $r1 
(check-sat)
; {var338_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3079-init=([], java.util.TreeSet), var3056_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var2104__=([java.lang.String[]], java.lang.Object[]), var1673_bootstrap$/-1953180231=([], java.util.function.Function), var3056_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1750_bootstrap$/734343971=([], java.util.function.Predicate), var3056_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var923_toSet/773895321=([], java.util.stream.Collector), var3056_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var2104-to-var2020=([java.lang.Object], java.util.Collection), <init>/-873565429=([java.util.TreeSet, java.util.Collection], void)}
; {var3071=r0, var3912=null_type, var338=org.apache.dubbo.common.utils.StringUtils, var3482=$z0, var3079=java.util.TreeSet, var1160=$r1, var1708=$r2, var3056=java.util.stream.Stream, var2104=java.lang.Object, var1803=$r4, var3489=java.util.function.Function, var1673=org.apache.dubbo.metadata.ServiceNameMapping$trim__625, var726=$r3, var217=$r6, var3675=java.util.function.Predicate, var1750=org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__637, var1285=$r5, var1447=$r8, var2085=java.util.stream.Collector, var923=java.util.stream.Collectors, var1707=$r7, var3743=$r9, var2020=java.util.Collection, var124=$r10}
; {r0=var3071, null_type=var3912, org.apache.dubbo.common.utils.StringUtils=var338, $z0=var3482, java.util.TreeSet=var3079, $r1=var1160, $r2=var1708, java.util.stream.Stream=var3056, java.lang.Object=var2104, $r4=var1803, java.util.function.Function=var3489, org.apache.dubbo.metadata.ServiceNameMapping$trim__625=var1673, $r3=var726, $r6=var217, java.util.function.Predicate=var3675, org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__637=var1750, $r5=var1285, $r8=var1447, java.util.stream.Collector=var2085, java.util.stream.Collectors=var923, $r7=var1707, $r9=var3743, java.util.Collection=var2020, $r10=var124}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = new java.util.TreeSet;	$r1 = new java.util.TreeSet;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r4 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r2);	$r3 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping$trim__625: java.util.function.Function bootstrap$()>();	$r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r3);	$r5 = staticinvoke <org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__637: java.util.function.Predicate bootstrap$()>();	$r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r5);	$r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>();	$r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7);	$r10 = (java.util.Collection) $r9;	specialinvoke $r1.<java.util.TreeSet: void <init>(java.util.Collection)>($r10);	return $r1
;block_num 2