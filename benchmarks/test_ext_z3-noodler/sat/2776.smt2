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

(declare-sort var2070 0)
(declare-sort var1170 0)
(declare-sort var2212 0)
(declare-sort var2954 0)
(declare-sort var3048 0)
(declare-sort var744 0)
(declare-sort var679 0)
(declare-sort var1682 0)
(declare-sort var517 0)
(declare-sort var1216 0)
(declare-sort var2369 0)
(declare-sort var1429 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getReturnType/-1494237887 (var1170) ClassObject)
(declare-fun equals/-1650223740 (var2954 var2954) Bool)
(declare-fun cast-from-ClassObject-to-var2954 (ClassObject) var2954)
(declare-fun getParameters/-1093213592 (var744) (Array Int var3048))
(declare-fun cast-from-var1170-to-var744 (var1170) var744)
(declare-fun getLength-Arr-var3048-1 ((Array Int var3048)) Int)
(declare-fun var679_range/1921392704 (Int Int) var679)
(declare-fun var517_bootstrap$/2048193366 () var1682)
(declare-fun var679_mapToObj/1936014041 (var679 var1682) var1216)
(declare-fun var1429_joining/-1302177485 (String) var2369)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1216_collect/-2050842585 (var1216 var2369) var2954)
(declare-fun cast-from-var2954-to-String (var2954) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun arr-var2954-init () (Array Int var2954))
(declare-fun getName/1227988463 (var1170) String)
(declare-fun cast-from-String-to-var2954 (String) var2954)
(declare-fun String_format/1339386452 (String (Array Int var2954)) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2070 var2070)
(declare-const null-var1170 var1170)
(declare-const var2212-TYPE ClassObject)
(declare-const null-__Array__Int__var2954__ (Array Int var2954))
(declare-const var3131 var2070) ; Statement: r17 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var3131 null-var2070)))
(declare-const var3109 var1170) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3109 null-var1170)))
(assert true)
(define-const var748 ClassObject (getReturnType/-1494237887 var3109)) ; Statement: $r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(define-const var1269 ClassObject var2212-TYPE) ; Statement: $r1 = <java.lang.Void: java.lang.Class TYPE> 
(assert true)
(define-const var2178 Bool (equals/-1650223740 (cast-from-ClassObject-to-var2954 var748) (cast-from-ClassObject-to-var2954 var1269))) ; Statement: $z0 = virtualinvoke $r2.<java.lang.Object: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r18 = "return " 
(assert (not (= (ite var2178 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var574 String "") ; Statement: $r18 = "" 
 ; Statement: goto [?= $r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.reflect.Parameter[] getParameters()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var3865 (Array Int var3048) (getParameters/-1093213592 (cast-from-var1170-to-var744 var3109))) ; Statement: $r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.reflect.Parameter[] getParameters()>() 
(define-const var1698 Int (getLength-Arr-var3048-1 var3865)) ; Statement: $i0 = lengthof $r3 
(define-const var2074 var679 (var679_range/1921392704 0 var1698)) ; Statement: $r5 = staticinvoke <java.util.stream.IntStream: java.util.stream.IntStream range(int,int)>(0, $i0) 
(define-const var3349 var1682 var517_bootstrap$/2048193366) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$lambda_generateReturnAndInvocation_2__173: java.util.function.IntFunction bootstrap$()>() 
(define-const var3709 var1216 (var679_mapToObj/1936014041 var2074 var3349)) ; Statement: $r7 = interfaceinvoke $r5.<java.util.stream.IntStream: java.util.stream.Stream mapToObj(java.util.function.IntFunction)>($r4) 
(define-const var1539 var2369 (var1429_joining/-1302177485 (cast-from-String-to-String ", "))) ; Statement: $r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ") 
(define-const var1456 var2954 (var1216_collect/-2050842585 var3709 var1539)) ; Statement: $r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6) 
(define-const var315 String (cast-from-var2954-to-String var1456)) ; Statement: $r16 = (java.lang.String) $r8 
(define-const var2853 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2853)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2853!1 String)
(assert (= var2853!1 ""))
(assert true)
(define-const var2433 String (append/672562846 var2853!1 var574)) ; Statement: $r13 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18) 
(declare-const var2853!2 String)
(assert (= var2853!2 (str.++ var2853!1 var574)))
(define-const var1696 (Array Int var2954) arr-var2954-init) ; Statement: $r10 = newarray (java.lang.Object)[2] 
(assert true)
(define-const var1759 String (getName/1227988463 var3109)) ; Statement: $r11 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(declare-const var1696!1 (Array Int var2954))
(assert (not (= var1696!1 null-__Array__Int__var2954__)))
(assert (= (select var1696!1 0) (cast-from-String-to-var2954 var1759))) ; Statement: $r10[0] = $r11 
(declare-const var1696!2 (Array Int var2954))
(assert (not (= var1696!2 null-__Array__Int__var2954__)))
(assert (= (select var1696!2 1) (cast-from-String-to-var2954 var315))) ; Statement: $r10[1] = $r16 
(define-const var2834 String (String_format/1339386452 "extension.%s(%s);\n" var1696!2)) ; Statement: $r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("extension.%s(%s);\n", $r10) 
(assert true)
(define-const var1375 String (append/672562846 var2433 var2834)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2433!1 String)
(assert (= var2433!1 (str.++ var2433 var2834)))
(assert true)
(define-const var3703 String (toString/-2075883882 var1375)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r15 
(check-sat)
; {getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), equals/-1650223740=([java.lang.Object, java.lang.Object], boolean), cast-from-ClassObject-to-var2954=([java.lang.Class], java.lang.Object), getParameters/-1093213592=([java.lang.reflect.Executable], java.lang.reflect.Parameter[]), cast-from-var1170-to-var744=([java.lang.reflect.Method], java.lang.reflect.Executable), getLength-Arr-var3048-1=([java.lang.reflect.Parameter[]], int), var679_range/1921392704=([int, int], java.util.stream.IntStream), var517_bootstrap$/2048193366=([], java.util.function.IntFunction), var679_mapToObj/1936014041=([java.util.stream.IntStream, java.util.function.IntFunction], java.util.stream.Stream), var1429_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1216_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var2954-to-String=([java.lang.Object], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), arr-var2954-init=([], java.lang.Object[]), getName/1227988463=([java.lang.reflect.Method], java.lang.String), cast-from-String-to-var2954=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2070=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var3131=r17, var1170=java.lang.reflect.Method, var3109=r0, var748=$r2, var2212=java.lang.Void, var1269=$r1, var2954=java.lang.Object, var2178=$z0, var574=$r18, var3048=java.lang.reflect.Parameter, var744=java.lang.reflect.Executable, var3865=$r3, var1698=$i0, var679=java.util.stream.IntStream, var2074=$r5, var1682=java.util.function.IntFunction, var517=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$lambda_generateReturnAndInvocation_2__173, var3349=$r4, var1216=java.util.stream.Stream, var3709=$r7, var2369=java.util.stream.Collector, var1429=java.util.stream.Collectors, var1539=$r6, var1456=$r8, var315=$r16, var2853=$r9, var2433=$r13, var1696=$r10, var1759=$r11, var2834=$r12, var1375=$r14, var3703=$r15}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var2070, r17=var3131, java.lang.reflect.Method=var1170, r0=var3109, $r2=var748, java.lang.Void=var2212, $r1=var1269, java.lang.Object=var2954, $z0=var2178, $r18=var574, java.lang.reflect.Parameter=var3048, java.lang.reflect.Executable=var744, $r3=var3865, $i0=var1698, java.util.stream.IntStream=var679, $r5=var2074, java.util.function.IntFunction=var1682, org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$lambda_generateReturnAndInvocation_2__173=var517, $r4=var3349, java.util.stream.Stream=var1216, $r7=var3709, java.util.stream.Collector=var2369, java.util.stream.Collectors=var1429, $r6=var1539, $r8=var1456, $r16=var315, $r9=var2853, $r13=var2433, $r10=var1696, $r11=var1759, $r12=var2834, $r14=var1375, $r15=var3703}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r17 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r0 := @parameter0: java.lang.reflect.Method;	$r2 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	$r1 = <java.lang.Void: java.lang.Class TYPE>;	$z0 = virtualinvoke $r2.<java.lang.Object: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r18 = "return ";	$r18 = "";	goto [?= $r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.reflect.Parameter[] getParameters()>()];	$r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.reflect.Parameter[] getParameters()>();	$i0 = lengthof $r3;	$r5 = staticinvoke <java.util.stream.IntStream: java.util.stream.IntStream range(int,int)>(0, $i0);	$r4 = staticinvoke <org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator$lambda_generateReturnAndInvocation_2__173: java.util.function.IntFunction bootstrap$()>();	$r7 = interfaceinvoke $r5.<java.util.stream.IntStream: java.util.stream.Stream mapToObj(java.util.function.IntFunction)>($r4);	$r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ");	$r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6);	$r16 = (java.lang.String) $r8;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18);	$r10 = newarray (java.lang.Object)[2];	$r11 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$r10[0] = $r11;	$r10[1] = $r16;	$r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("extension.%s(%s);\n", $r10);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	return $r15
;block_num 3