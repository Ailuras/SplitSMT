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

(declare-sort var866 0)
(declare-sort var3228 0)
(declare-sort var658 0)
(declare-sort var3161 0)
(declare-sort var1725 0)
(declare-sort var508 0)
(declare-sort var2498 0)
(declare-sort var1723 0)
(declare-sort var1472 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getExceptionTypes/1420527167 (var3228) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun var3161_stream/-1757820 ((Array Int var1725)) var658)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1725__ ((Array Int ClassObject)) (Array Int var1725))
(declare-fun var2498_bootstrap$/400246084 () var508)
(declare-fun var658_map/130902797 (var658 var508) var658)
(declare-fun var1472_joining/-1302177485 (String) var1723)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var658_collect/-2050842585 (var658 var1723) var1725)
(declare-fun cast-from-var1725-to-String (var1725) String)
(declare-fun arr-var1725-init () (Array Int var1725))
(declare-fun cast-from-String-to-var1725 (String) var1725)
(declare-fun String_format/1339386452 (String (Array Int var1725)) String)
(declare-const null-var866 var866)
(declare-const null-var3228 var3228)
(declare-const null-__Array__Int__var1725__ (Array Int var1725))
(declare-const var2294 var866) ; Statement: r10 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var2294 null-var866)))
(declare-const var1786 var3228) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1786 null-var3228)))
(assert true)
(define-const var1245 (Array Int ClassObject) (getExceptionTypes/1420527167 var1786)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getExceptionTypes()>() 
(define-const var3738 Int (getLength-Arr-ClassObject-1 var1245)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 0 goto return "" 
(assert (not (<= var3738 0))) ; Negate: Cond: $i0 <= 0  
(define-const var886 var658 (var3161_stream/-1757820 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1725__ var1245))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>(r1) 
(define-const var1663 var508 var2498_bootstrap$/400246084) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$getCanonicalName__172: java.util.function.Function bootstrap$()>() 
(define-const var3693 var658 (var658_map/130902797 var886 var1663)) ; Statement: $r5 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r2) 
(define-const var877 var1723 (var1472_joining/-1302177485 (cast-from-String-to-String ", "))) ; Statement: $r4 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ") 
(define-const var233 var1725 (var658_collect/-2050842585 var3693 var877)) ; Statement: $r6 = interfaceinvoke $r5.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r4) 
(define-const var1798 String (cast-from-var1725-to-String var233)) ; Statement: r7 = (java.lang.String) $r6 
(define-const var2104 (Array Int var1725) arr-var1725-init) ; Statement: $r8 = newarray (java.lang.Object)[1] 
(declare-const var2104!1 (Array Int var1725))
(assert (not (= var2104!1 null-__Array__Int__var1725__)))
(assert (= (select var2104!1 0) (cast-from-String-to-var1725 var1798))) ; Statement: $r8[0] = r7 
(define-const var2145 String (String_format/1339386452 "throws %s" var2104!1)) ; Statement: $r9 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("throws %s", $r8) 
 ; Statement: return $r9 
(check-sat)
; {getExceptionTypes/1420527167=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), var3161_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1725__=([java.lang.Class[]], java.lang.Object[]), var2498_bootstrap$/400246084=([], java.util.function.Function), var658_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1472_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var658_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1725-to-String=([java.lang.Object], java.lang.String), arr-var1725-init=([], java.lang.Object[]), cast-from-String-to-var1725=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var866=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var2294=r10, var3228=java.lang.reflect.Method, var1786=r0, var1245=r1, var3738=$i0, var658=java.util.stream.Stream, var3161=java.util.Arrays, var1725=java.lang.Object, var886=$r3, var508=java.util.function.Function, var2498=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$getCanonicalName__172, var1663=$r2, var3693=$r5, var1723=java.util.stream.Collector, var1472=java.util.stream.Collectors, var877=$r4, var233=$r6, var1798=r7, var2104=$r8, var2145=$r9}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var866, r10=var2294, java.lang.reflect.Method=var3228, r0=var1786, r1=var1245, $i0=var3738, java.util.stream.Stream=var658, java.util.Arrays=var3161, java.lang.Object=var1725, $r3=var886, java.util.function.Function=var508, org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$getCanonicalName__172=var2498, $r2=var1663, $r5=var3693, java.util.stream.Collector=var1723, java.util.stream.Collectors=var1472, $r4=var877, $r6=var233, r7=var1798, $r8=var2104, $r9=var2145}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r10 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getExceptionTypes()>();	$i0 = lengthof r1;	if $i0 <= 0 goto return "";	$r3 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>(r1);	$r2 = staticinvoke <org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$getCanonicalName__172: java.util.function.Function bootstrap$()>();	$r5 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r2);	$r4 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ");	$r6 = interfaceinvoke $r5.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r4);	r7 = (java.lang.String) $r6;	$r8 = newarray (java.lang.Object)[1];	$r8[0] = r7;	$r9 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("throws %s", $r8);	return $r9
;block_num 2