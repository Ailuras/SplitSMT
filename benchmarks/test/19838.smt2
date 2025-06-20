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

(declare-sort var1993 0)
(declare-sort var205 0)
(declare-sort var2815 0)
(declare-sort var3318 0)
(declare-sort var2407 0)
(declare-sort var1539 0)
(declare-sort var3608 0)
(declare-sort var2437 0)
(declare-sort var1937 0)
(declare-sort var2754 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun var205_setAttribute/1308417157 (var205 String var2815) void)
(declare-fun cast-from-Int-to-var2815 (Int) var2815)
(declare-fun var3318-init () var3318)
(declare-fun <init>/2133929520 (var3318) void)
(declare-fun cast-from-var3318-to-var2815 (var3318) var2815)
(declare-fun var2407_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var1937_bootstrap$/-2041286917 () var2437)
(declare-fun var1539_computeIfAbsent/-354326494 (var1539 var2815 var2437) var2815)
(declare-fun cast-from-String-to-var2815 (String) var2815)
(declare-fun cast-from-var2815-to-var2754 (var2815) var2754)
(declare-fun var2754_add/-1142548109 (var2754 var2815) Bool)
(declare-fun cast-from-var205-to-var2815 (var205) var2815)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var205 var205)
(declare-const null-Int Int)
(declare-const var3608-TRACERS var1539)
(declare-const var2864 ClassObject) ; Statement: r4 := @parameter0: java.lang.Class 
(assert (not (= var2864 null-ClassObject)))
(declare-const var2511 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2511 null-String)))
(declare-const var3232 var205) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.Channel 
(assert (not (= var3232 null-var205)))
(declare-const var1159 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var1159 null-Int)))
(define-const var1977 Int (Int_valueOf/-1371140006 var1159)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
;(assert (var205_setAttribute/1308417157 var3232 "trace.max" (cast-from-Int-to-var2815 var1977))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("trace.max", $r1) 

(declare-const var3232!1 var205)
(declare-const var3572 String)
(declare-const var1977!1 Int)
(define-const var553 var3318 var3318-init) ; Statement: $r2 = new java.util.concurrent.atomic.AtomicInteger 
(assert true)
;(assert (<init>/2133929520 var553)) ; Statement: specialinvoke $r2.<java.util.concurrent.atomic.AtomicInteger: void <init>()>() 

(declare-const var553!1 var3318)
;(assert (var205_setAttribute/1308417157 var3232!1 "trace.count" (cast-from-var3318-to-var2815 var553!1))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("trace.count", $r2) 

(declare-const var3232!2 var205)
(declare-const var1689 String)
(declare-const var553!2 var3318)
(define-const var1814 Bool (var2407_isNotEmpty/-1251449450 var2511)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r14 = virtualinvoke r4.<java.lang.Class: java.lang.String getName()>() 
(assert (= (ite var1814 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var826 String (getName/-1958580599 var2864)) ; Statement: $r14 = virtualinvoke r4.<java.lang.Class: java.lang.String getName()>() 
(assert true) ; Non Conditional
(define-const var2060 var1539 var3608-TRACERS) ; Statement: $r5 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS> 
(define-const var3306 var2437 var1937_bootstrap$/-2041286917) ; Statement: $r6 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter$lambda_addTracer_0__1334: java.util.function.Function bootstrap$()>() 
(define-const var2061 var2815 (var1539_computeIfAbsent/-354326494 var2060 (cast-from-String-to-var2815 var826) var3306)) ; Statement: $r7 = interfaceinvoke $r5.<java.util.concurrent.ConcurrentMap: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>($r14, $r6) 
(define-const var391 var2754 (cast-from-var2815-to-var2754 var2061)) ; Statement: $r13 = (java.util.Set) $r7 
;(assert (var2754_add/-1142548109 var391 (cast-from-var205-to-var2815 var3232!2))) ; Statement: interfaceinvoke $r13.<java.util.Set: boolean add(java.lang.Object)>(r0) 

(declare-const var391!1 var2754)
(declare-const var3232!3 var205)
 ; Statement: return 
(check-sat)
; {Int_valueOf/-1371140006=([int], java.lang.Integer), var205_setAttribute/1308417157=([org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Object], void), cast-from-Int-to-var2815=([java.lang.Integer], java.lang.Object), var3318-init=([], java.util.concurrent.atomic.AtomicInteger), <init>/2133929520=([java.util.concurrent.atomic.AtomicInteger], void), cast-from-var3318-to-var2815=([java.util.concurrent.atomic.AtomicInteger], java.lang.Object), var2407_isNotEmpty/-1251449450=([java.lang.String], boolean), getName/-1958580599=([java.lang.Class], java.lang.String), var1937_bootstrap$/-2041286917=([], java.util.function.Function), var1539_computeIfAbsent/-354326494=([java.util.concurrent.ConcurrentMap, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var2815=([java.lang.String], java.lang.Object), cast-from-var2815-to-var2754=([java.lang.Object], java.util.Set), var2754_add/-1142548109=([java.util.Set, java.lang.Object], boolean), cast-from-var205-to-var2815=([org.apache.dubbo.remoting.Channel], java.lang.Object)}
; {var2864=r4, var2511=r3, var1993=null_type, var205=org.apache.dubbo.remoting.Channel, var3232=r0, var1159=i0, var1977=$r1, var2815=java.lang.Object, var3572="trace.max", var3318=java.util.concurrent.atomic.AtomicInteger, var553=$r2, var1689="trace.count", var2407=org.apache.dubbo.common.utils.StringUtils, var1814=$z0, var826=$r14, var1539=java.util.concurrent.ConcurrentMap, var3608=org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter, var2060=$r5, var2437=java.util.function.Function, var1937=org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter$lambda_addTracer_0__1334, var3306=$r6, var2061=$r7, var2754=java.util.Set, var391=$r13}
; {r4=var2864, r3=var2511, null_type=var1993, org.apache.dubbo.remoting.Channel=var205, r0=var3232, i0=var1159, $r1=var1977, java.lang.Object=var2815, "trace.max"=var3572, java.util.concurrent.atomic.AtomicInteger=var3318, $r2=var553, "trace.count"=var1689, org.apache.dubbo.common.utils.StringUtils=var2407, $z0=var1814, $r14=var826, java.util.concurrent.ConcurrentMap=var1539, org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter=var3608, $r5=var2060, java.util.function.Function=var2437, org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter$lambda_addTracer_0__1334=var1937, $r6=var3306, $r7=var2061, java.util.Set=var2754, $r13=var391}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r4 := @parameter0: java.lang.Class;	r3 := @parameter1: java.lang.String;	r0 := @parameter2: org.apache.dubbo.remoting.Channel;	i0 := @parameter3: int;	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("trace.max", $r1);	$r2 = new java.util.concurrent.atomic.AtomicInteger;	specialinvoke $r2.<java.util.concurrent.atomic.AtomicInteger: void <init>()>();	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("trace.count", $r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r14 = virtualinvoke r4.<java.lang.Class: java.lang.String getName()>();	$r14 = virtualinvoke r4.<java.lang.Class: java.lang.String getName()>();	$r5 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS>;	$r6 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter$lambda_addTracer_0__1334: java.util.function.Function bootstrap$()>();	$r7 = interfaceinvoke $r5.<java.util.concurrent.ConcurrentMap: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>($r14, $r6);	$r13 = (java.util.Set) $r7;	interfaceinvoke $r13.<java.util.Set: boolean add(java.lang.Object)>(r0);	return
;block_num 3