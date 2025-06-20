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

(declare-sort var1757 0)
(declare-sort var819 0)
(declare-sort var2113 0)
(declare-sort var1590 0)
(declare-sort var2990 0)
(declare-sort var2926 0)
(declare-sort var2917 0)
(declare-sort var3745 0)
(declare-sort var1431 0)
(declare-sort var3998 0)
(declare-sort var144 0)
(declare-sort var3196 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getReturnType/-1494237887 (var819) ClassObject)
(declare-fun equals/-1650223740 (var1590 var1590) Bool)
(declare-fun cast-from-ClassObject-to-var1590 (ClassObject) var1590)
(declare-fun getParameters/-1093213592 (var2926) (Array Int var2990))
(declare-fun cast-from-var819-to-var2926 (var819) var2926)
(declare-fun getLength-Arr-var2990-1 ((Array Int var2990)) Int)
(declare-fun var2917_range/1921392704 (Int Int) var2917)
(declare-fun var1431_bootstrap$/2048193366 () var3745)
(declare-fun var2917_mapToObj/1936014041 (var2917 var3745) var3998)
(declare-fun var3196_joining/-1302177485 (String) var144)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3998_collect/-2050842585 (var3998 var144) var1590)
(declare-fun cast-from-var1590-to-String (var1590) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun arr-var1590-init () (Array Int var1590))
(declare-fun getName/1227988463 (var819) String)
(declare-fun cast-from-String-to-var1590 (String) var1590)
(declare-fun String_format/1339386452 (String (Array Int var1590)) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1757 var1757)
(declare-const null-var819 var819)
(declare-const var2113-TYPE ClassObject)
(declare-const null-__Array__Int__var1590__ (Array Int var1590))
(declare-const var3665 var1757) ; Statement: r17 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var3665 null-var1757)))
(declare-const var1380 var819) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1380 null-var819)))
(assert true)
(define-const var1005 ClassObject (getReturnType/-1494237887 var1380)) ; Statement: $r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(define-const var2743 ClassObject var2113-TYPE) ; Statement: $r1 = <java.lang.Void: java.lang.Class TYPE> 
(assert true)
(define-const var1234 Bool (equals/-1650223740 (cast-from-ClassObject-to-var1590 var1005) (cast-from-ClassObject-to-var1590 var2743))) ; Statement: $z0 = virtualinvoke $r2.<java.lang.Object: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r18 = "return " 
(assert (= (ite var1234 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1787 String "return ") ; Statement: $r18 = "return " 
(assert true) ; Non Conditional
(assert true)
(define-const var3552 (Array Int var2990) (getParameters/-1093213592 (cast-from-var819-to-var2926 var1380))) ; Statement: $r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.reflect.Parameter[] getParameters()>() 
(define-const var2873 Int (getLength-Arr-var2990-1 var3552)) ; Statement: $i0 = lengthof $r3 
(define-const var2295 var2917 (var2917_range/1921392704 0 var2873)) ; Statement: $r5 = staticinvoke <java.util.stream.IntStream: java.util.stream.IntStream range(int,int)>(0, $i0) 
(define-const var3398 var3745 var1431_bootstrap$/2048193366) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$lambda_generateReturnAndInvocation_2__173: java.util.function.IntFunction bootstrap$()>() 
(define-const var2225 var3998 (var2917_mapToObj/1936014041 var2295 var3398)) ; Statement: $r7 = interfaceinvoke $r5.<java.util.stream.IntStream: java.util.stream.Stream mapToObj(java.util.function.IntFunction)>($r4) 
(define-const var351 var144 (var3196_joining/-1302177485 (cast-from-String-to-String ", "))) ; Statement: $r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ") 
(define-const var654 var1590 (var3998_collect/-2050842585 var2225 var351)) ; Statement: $r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6) 
(define-const var154 String (cast-from-var1590-to-String var654)) ; Statement: $r16 = (java.lang.String) $r8 
(define-const var2493 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2493)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2493!1 String)
(assert (= var2493!1 ""))
(assert true)
(define-const var1348 String (append/672562846 var2493!1 var1787)) ; Statement: $r13 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18) 
(declare-const var2493!2 String)
(assert (= var2493!2 (str.++ var2493!1 var1787)))
(define-const var2402 (Array Int var1590) arr-var1590-init) ; Statement: $r10 = newarray (java.lang.Object)[2] 
(assert true)
(define-const var2293 String (getName/1227988463 var1380)) ; Statement: $r11 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(declare-const var2402!1 (Array Int var1590))
(assert (not (= var2402!1 null-__Array__Int__var1590__)))
(assert (= (select var2402!1 0) (cast-from-String-to-var1590 var2293))) ; Statement: $r10[0] = $r11 
(declare-const var2402!2 (Array Int var1590))
(assert (not (= var2402!2 null-__Array__Int__var1590__)))
(assert (= (select var2402!2 1) (cast-from-String-to-var1590 var154))) ; Statement: $r10[1] = $r16 
(define-const var3946 String (String_format/1339386452 "extension.%s(%s);\n" var2402!2)) ; Statement: $r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("extension.%s(%s);\n", $r10) 
(assert true)
(define-const var1785 String (append/672562846 var1348 var3946)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var1348!1 String)
(assert (= var1348!1 (str.++ var1348 var3946)))
(assert true)
(define-const var2899 String (toString/-2075883882 var1785)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r15 
(check-sat)
; {getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), equals/-1650223740=([java.lang.Object, java.lang.Object], boolean), cast-from-ClassObject-to-var1590=([java.lang.Class], java.lang.Object), getParameters/-1093213592=([java.lang.reflect.Executable], java.lang.reflect.Parameter[]), cast-from-var819-to-var2926=([java.lang.reflect.Method], java.lang.reflect.Executable), getLength-Arr-var2990-1=([java.lang.reflect.Parameter[]], int), var2917_range/1921392704=([int, int], java.util.stream.IntStream), var1431_bootstrap$/2048193366=([], java.util.function.IntFunction), var2917_mapToObj/1936014041=([java.util.stream.IntStream, java.util.function.IntFunction], java.util.stream.Stream), var3196_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3998_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1590-to-String=([java.lang.Object], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), arr-var1590-init=([], java.lang.Object[]), getName/1227988463=([java.lang.reflect.Method], java.lang.String), cast-from-String-to-var1590=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1757=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var3665=r17, var819=java.lang.reflect.Method, var1380=r0, var1005=$r2, var2113=java.lang.Void, var2743=$r1, var1590=java.lang.Object, var1234=$z0, var1787=$r18, var2990=java.lang.reflect.Parameter, var2926=java.lang.reflect.Executable, var3552=$r3, var2873=$i0, var2917=java.util.stream.IntStream, var2295=$r5, var3745=java.util.function.IntFunction, var1431=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$lambda_generateReturnAndInvocation_2__173, var3398=$r4, var3998=java.util.stream.Stream, var2225=$r7, var144=java.util.stream.Collector, var3196=java.util.stream.Collectors, var351=$r6, var654=$r8, var154=$r16, var2493=$r9, var1348=$r13, var2402=$r10, var2293=$r11, var3946=$r12, var1785=$r14, var2899=$r15}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var1757, r17=var3665, java.lang.reflect.Method=var819, r0=var1380, $r2=var1005, java.lang.Void=var2113, $r1=var2743, java.lang.Object=var1590, $z0=var1234, $r18=var1787, java.lang.reflect.Parameter=var2990, java.lang.reflect.Executable=var2926, $r3=var3552, $i0=var2873, java.util.stream.IntStream=var2917, $r5=var2295, java.util.function.IntFunction=var3745, org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$lambda_generateReturnAndInvocation_2__173=var1431, $r4=var3398, java.util.stream.Stream=var3998, $r7=var2225, java.util.stream.Collector=var144, java.util.stream.Collectors=var3196, $r6=var351, $r8=var654, $r16=var154, $r9=var2493, $r13=var1348, $r10=var2402, $r11=var2293, $r12=var3946, $r14=var1785, $r15=var2899}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r17 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r0 := @parameter0: java.lang.reflect.Method;	$r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	$r1 = <java.lang.Void: java.lang.Class TYPE>;	$z0 = virtualinvoke $r2.<java.lang.Object: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r18 = "return ";	$r18 = "return ";	$r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.reflect.Parameter[] getParameters()>();	$i0 = lengthof $r3;	$r5 = staticinvoke <java.util.stream.IntStream: java.util.stream.IntStream range(int,int)>(0, $i0);	$r4 = staticinvoke <org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$lambda_generateReturnAndInvocation_2__173: java.util.function.IntFunction bootstrap$()>();	$r7 = interfaceinvoke $r5.<java.util.stream.IntStream: java.util.stream.Stream mapToObj(java.util.function.IntFunction)>($r4);	$r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ");	$r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6);	$r16 = (java.lang.String) $r8;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18);	$r10 = newarray (java.lang.Object)[2];	$r11 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$r10[0] = $r11;	$r10[1] = $r16;	$r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("extension.%s(%s);\n", $r10);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	return $r15
;block_num 3