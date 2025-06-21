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

(declare-sort var1940 0)
(declare-sort var3974 0)
(declare-sort var319 0)
(declare-sort var2715 0)
(declare-sort var3882 0)
(declare-sort var2136 0)
(declare-sort var3279 0)
(declare-sort var2170 0)
(declare-sort var2497 0)
(declare-sort var1188 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun var3974_setAttribute/1308417157 (var3974 String var319) void)
(declare-fun cast-from-Int-to-var319 (Int) var319)
(declare-fun var2715-init () var2715)
(declare-fun <init>/2133929520 (var2715) void)
(declare-fun cast-from-var2715-to-var319 (var2715) var319)
(declare-fun var3882_isNotEmpty/-1251449450 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2497_bootstrap$/-2041286917 () var2170)
(declare-fun var2136_computeIfAbsent/-354326494 (var2136 var319 var2170) var319)
(declare-fun cast-from-String-to-var319 (String) var319)
(declare-fun cast-from-var319-to-var1188 (var319) var1188)
(declare-fun var1188_add/-1142548109 (var1188 var319) Bool)
(declare-fun cast-from-var3974-to-var319 (var3974) var319)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var3974 var3974)
(declare-const null-Int Int)
(declare-const var3279-TRACERS var2136)
(declare-const var2564 ClassObject) ; Statement: r4 := @parameter0: java.lang.Class 
(assert (not (= var2564 null-ClassObject)))
(declare-const var2338 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2338 null-String)))
(declare-const var2711 var3974) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.Channel 
(assert (not (= var2711 null-var3974)))
(declare-const var795 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var795 null-Int)))
(define-const var1834 Int (Int_valueOf/-1371140006 var795)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
;(assert (var3974_setAttribute/1308417157 var2711 "trace.max" (cast-from-Int-to-var319 var1834))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("trace.max", $r1) 

(declare-const var2711!1 var3974)
(declare-const var590 String)
(declare-const var1834!1 Int)
(define-const var3104 var2715 var2715-init) ; Statement: $r2 = new java.util.concurrent.atomic.AtomicInteger 
(assert true)
;(assert (<init>/2133929520 var3104)) ; Statement: specialinvoke $r2.<java.util.concurrent.atomic.AtomicInteger: void <init>()>() 

(declare-const var3104!1 var2715)
;(assert (var3974_setAttribute/1308417157 var2711!1 "trace.count" (cast-from-var2715-to-var319 var3104!1))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("trace.count", $r2) 

(declare-const var2711!2 var3974)
(declare-const var2544 String)
(declare-const var3104!2 var2715)
(define-const var1575 Bool (var3882_isNotEmpty/-1251449450 var2338)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r14 = virtualinvoke r4.<java.lang.Class: java.lang.String getName()>() 
(assert (not (= (ite var1575 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3223 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3223)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3223!1 String)
(assert (= var3223!1 ""))
(assert true)
(define-const var2088 String (getName/-1958580599 var2564)) ; Statement: $r9 = virtualinvoke r4.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3873 String (append/672562846 var3223!1 var2088)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var3223!2 String)
(assert (= var3223!2 (str.++ var3223!1 var2088)))
(assert true)
(define-const var993 String (append/672562846 var3873 ".")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3873!1 String)
(assert (= var3873!1 (str.++ var3873 ".")))
(assert true)
(define-const var3479 String (append/672562846 var993 var2338)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var993!1 String)
(assert (= var993!1 (str.++ var993 var2338)))
(assert true)
(define-const var2379 String (toString/-2075883882 var3479)) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r5 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS>] 
(assert true) ; Non Conditional
(define-const var3087 var2136 var3279-TRACERS) ; Statement: $r5 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS> 
(define-const var2713 var2170 var2497_bootstrap$/-2041286917) ; Statement: $r6 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter$lambda_addTracer_0__1334: java.util.function.Function bootstrap$()>() 
(define-const var1730 var319 (var2136_computeIfAbsent/-354326494 var3087 (cast-from-String-to-var319 var2379) var2713)) ; Statement: $r7 = interfaceinvoke $r5.<java.util.concurrent.ConcurrentMap: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>($r14, $r6) 
(define-const var1920 var1188 (cast-from-var319-to-var1188 var1730)) ; Statement: $r13 = (java.util.Set) $r7 
;(assert (var1188_add/-1142548109 var1920 (cast-from-var3974-to-var319 var2711!2))) ; Statement: interfaceinvoke $r13.<java.util.Set: boolean add(java.lang.Object)>(r0) 

(declare-const var1920!1 var1188)
(declare-const var2711!3 var3974)
 ; Statement: return 
(check-sat)
; {Int_valueOf/-1371140006=([int], java.lang.Integer), var3974_setAttribute/1308417157=([org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Object], void), cast-from-Int-to-var319=([java.lang.Integer], java.lang.Object), var2715-init=([], java.util.concurrent.atomic.AtomicInteger), <init>/2133929520=([java.util.concurrent.atomic.AtomicInteger], void), cast-from-var2715-to-var319=([java.util.concurrent.atomic.AtomicInteger], java.lang.Object), var3882_isNotEmpty/-1251449450=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2497_bootstrap$/-2041286917=([], java.util.function.Function), var2136_computeIfAbsent/-354326494=([java.util.concurrent.ConcurrentMap, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var319=([java.lang.String], java.lang.Object), cast-from-var319-to-var1188=([java.lang.Object], java.util.Set), var1188_add/-1142548109=([java.util.Set, java.lang.Object], boolean), cast-from-var3974-to-var319=([org.apache.dubbo.remoting.Channel], java.lang.Object)}
; {var2564=r4, var2338=r3, var1940=null_type, var3974=org.apache.dubbo.remoting.Channel, var2711=r0, var795=i0, var1834=$r1, var319=java.lang.Object, var590="trace.max", var2715=java.util.concurrent.atomic.AtomicInteger, var3104=$r2, var2544="trace.count", var3882=org.apache.dubbo.common.utils.StringUtils, var1575=$z0, var3223=$r8, var2088=$r9, var3873=$r10, var993=$r11, var3479=$r12, var2379=$r14, var2136=java.util.concurrent.ConcurrentMap, var3279=org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter, var3087=$r5, var2170=java.util.function.Function, var2497=org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter$lambda_addTracer_0__1334, var2713=$r6, var1730=$r7, var1188=java.util.Set, var1920=$r13}
; {r4=var2564, r3=var2338, null_type=var1940, org.apache.dubbo.remoting.Channel=var3974, r0=var2711, i0=var795, $r1=var1834, java.lang.Object=var319, "trace.max"=var590, java.util.concurrent.atomic.AtomicInteger=var2715, $r2=var3104, "trace.count"=var2544, org.apache.dubbo.common.utils.StringUtils=var3882, $z0=var1575, $r8=var3223, $r9=var2088, $r10=var3873, $r11=var993, $r12=var3479, $r14=var2379, java.util.concurrent.ConcurrentMap=var2136, org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter=var3279, $r5=var3087, java.util.function.Function=var2170, org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter$lambda_addTracer_0__1334=var2497, $r6=var2713, $r7=var1730, java.util.Set=var1188, $r13=var1920}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @parameter0: java.lang.Class;	r3 := @parameter1: java.lang.String;	r0 := @parameter2: org.apache.dubbo.remoting.Channel;	i0 := @parameter3: int;	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("trace.max", $r1);	$r2 = new java.util.concurrent.atomic.AtomicInteger;	specialinvoke $r2.<java.util.concurrent.atomic.AtomicInteger: void <init>()>();	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("trace.count", $r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r14 = virtualinvoke r4.<java.lang.Class: java.lang.String getName()>();	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke r4.<java.lang.Class: java.lang.String getName()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r5 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS>];	$r5 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS>;	$r6 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter$lambda_addTracer_0__1334: java.util.function.Function bootstrap$()>();	$r7 = interfaceinvoke $r5.<java.util.concurrent.ConcurrentMap: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>($r14, $r6);	$r13 = (java.util.Set) $r7;	interfaceinvoke $r13.<java.util.Set: boolean add(java.lang.Object)>(r0);	return
;block_num 3