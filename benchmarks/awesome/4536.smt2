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

(declare-sort var2444 0)
(declare-sort var1050 0)
(declare-sort var3171 0)
(declare-sort var1919 0)
(declare-sort var1076 0)
(declare-sort var3317 0)
(declare-sort var896 0)
(declare-sort var3756 0)
(declare-sort var1988 0)
(declare-sort var3814 0)
(declare-sort var3487 0)
(declare-sort var2966 0)
(declare-sort var1793 0)
(declare-sort var2701 0)
(declare-sort var2372 0)
(declare-sort var3790 0)
(declare-sort var1353 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1919-init () var1919)
(declare-fun <init>/-325640736 (var1919) void)
(declare-fun ffm/1723327175 (var2444) var1076)
(declare-fun checkProvider/549298428 (var2444 String var3171 var3317 var1076 String String) void)
(declare-fun cast-from-var1919-to-var3317 (var1919) var3317)
(declare-fun jni/1723327175 (var2444) var1076)
(declare-fun jansi/1723327175 (var2444) var1076)
(declare-fun jna/1723327175 (var2444) var1076)
(declare-fun exec/1723327175 (var2444) var1076)
(declare-fun providers/1723327175 (var2444) String)
(declare-fun var896_asList/1779083644 ((Array Int var3756)) var3317)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3756__ ((Array Int String)) (Array Int var3756))
(declare-fun var3814_bootstrap$/2025907028 (var3317) var1988)
(declare-fun var3487_comparing/-789310709 (var1988) var3487)
(declare-fun var3317_sort/-1566373175 (var3317 var3487) void)
(declare-fun var1793_stream/-1288525013 (var1793) var2966)
(declare-fun cast-from-var1919-to-var1793 (var1919) var1793)
(declare-fun var2701_bootstrap$/-947092274 () var1988)
(declare-fun var2966_map/130902797 (var2966 var1988) var2966)
(declare-fun var3790_joining/-1302177485 (String) var2372)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2966_collect/-2050842585 (var2966 var2372) var3756)
(declare-fun cast-from-var3756-to-String (var3756) String)
(declare-fun arr-var3756-init () (Array Int var3756))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var3756 (String) var3756)
(declare-fun var1353_debug/-195896556 ((Array Int var3756)) void)
(declare-const null-var2444 var2444)
(declare-const null-String String)
(declare-const null-var3171 var3171)
(declare-const null-__Array__Int__var3756__ (Array Int var3756))
(declare-const var1171 var2444) ; Statement: r1 := @this: org.jline.terminal.TerminalBuilder 
(assert (not (= var1171 null-var2444)))
(declare-const var626 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var626 null-String)))
(declare-const var33 var3171) ; Statement: r3 := @parameter1: java.lang.IllegalStateException 
(assert (not (= var33 null-var3171)))
(define-const var271 var1919 var1919-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var271)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var271!1 var1919)
(define-const var3518 var1076 (ffm/1723327175 var1171)) ; Statement: $r4 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean ffm> 
(assert true)
;(assert (checkProvider/549298428 var1171 var626 var33 (cast-from-var1919-to-var3317 var271!1) var3518 "org.jline.terminal.ffm" "ffm")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r4, "org.jline.terminal.ffm", "ffm") 

(declare-const var1171!1 var2444)
(declare-const var626!1 String)
(declare-const var33!1 var3171)
(declare-const var271!2 var1919)
(declare-const var3518!1 var1076)
(declare-const var671 String)
(declare-const var3101 String)
(define-const var439 var1076 (jni/1723327175 var1171!1)) ; Statement: $r5 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jni> 
(assert true)
;(assert (checkProvider/549298428 var1171!1 var626!1 var33!1 (cast-from-var1919-to-var3317 var271!2) var439 "org.jline.terminal.jni" "jni")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r5, "org.jline.terminal.jni", "jni") 

(declare-const var1171!2 var2444)
(declare-const var626!2 String)
(declare-const var33!2 var3171)
(declare-const var271!3 var1919)
(declare-const var439!1 var1076)
(declare-const var3959 String)
(declare-const var1782 String)
(define-const var2807 var1076 (jansi/1723327175 var1171!2)) ; Statement: $r6 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jansi> 
(assert true)
;(assert (checkProvider/549298428 var1171!2 var626!2 var33!2 (cast-from-var1919-to-var3317 var271!3) var2807 "org.jline.terminal.jansi" "jansi")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r6, "org.jline.terminal.jansi", "jansi") 

(declare-const var1171!3 var2444)
(declare-const var626!3 String)
(declare-const var33!3 var3171)
(declare-const var271!4 var1919)
(declare-const var2807!1 var1076)
(declare-const var2170 String)
(declare-const var2645 String)
(define-const var1853 var1076 (jna/1723327175 var1171!3)) ; Statement: $r7 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jna> 
(assert true)
;(assert (checkProvider/549298428 var1171!3 var626!3 var33!3 (cast-from-var1919-to-var3317 var271!4) var1853 "org.jline.terminal.jna" "jna")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r7, "org.jline.terminal.jna", "jna") 

(declare-const var1171!4 var2444)
(declare-const var626!4 String)
(declare-const var33!4 var3171)
(declare-const var271!5 var1919)
(declare-const var1853!1 var1076)
(declare-const var3215 String)
(declare-const var2914 String)
(define-const var1394 var1076 (exec/1723327175 var1171!4)) ; Statement: $r8 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean exec> 
(assert true)
;(assert (checkProvider/549298428 var1171!4 var626!4 var33!4 (cast-from-var1919-to-var3317 var271!5) var1394 "org.jline.terminal.exec" "exec")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r8, "org.jline.terminal.exec", "exec") 

(declare-const var1171!5 var2444)
(declare-const var626!5 String)
(declare-const var33!5 var3171)
(declare-const var271!6 var1919)
(declare-const var1394!1 var1076)
(declare-const var1389 String)
(declare-const var274 String)
(define-const var3141 String (providers/1723327175 var1171!5)) ; Statement: $r9 = r1.<org.jline.terminal.TerminalBuilder: java.lang.String providers> 
 ; Statement: if $r9 == null goto $r10 = <org.jline.terminal.TerminalBuilder: java.lang.String PROP_PROVIDERS_DEFAULT> 
(assert (not (= var3141 null-String))) ; Negate: Cond: $r9 == null  
(define-const var1225 String (providers/1723327175 var1171!5)) ; Statement: $r26 = r1.<org.jline.terminal.TerminalBuilder: java.lang.String providers> 
 ; Statement: goto [?= $r11 = virtualinvoke $r26.<java.lang.String: java.lang.String[] split(java.lang.String)>(",")] 
(assert true) ; Non Conditional
; split operation: var1968 = var1225.split(",") ; Statement: $r11 = virtualinvoke $r26.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1367 var3317 (var896_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3756__ var1968))) ; Statement: $r24 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r11) 
(define-const var3793 var1988 (var3814_bootstrap$/2025907028 var1367)) ; Statement: $r12 = staticinvoke <org.jline.terminal.TerminalBuilder$lambda_getProviders_7__367: java.util.function.Function bootstrap$(java.util.List)>($r24) 
(define-const var2819 var3487 (var3487_comparing/-789310709 var3793)) ; Statement: $r13 = staticinvoke <java.util.Comparator: java.util.Comparator comparing(java.util.function.Function)>($r12) 
;(assert (var3317_sort/-1566373175 (cast-from-var1919-to-var3317 var271!6) var2819)) ; Statement: interfaceinvoke $r0.<java.util.List: void sort(java.util.Comparator)>($r13) 

(declare-const var271!7 var1919)
(declare-const var2819!1 var3487)
(define-const var29 var2966 (var1793_stream/-1288525013 (cast-from-var1919-to-var1793 var271!7))) ; Statement: $r15 = interfaceinvoke $r0.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var1667 var1988 var2701_bootstrap$/-947092274) ; Statement: $r14 = staticinvoke <org.jline.terminal.TerminalBuilder$name__371: java.util.function.Function bootstrap$()>() 
(define-const var2448 var2966 (var2966_map/130902797 var29 var1667)) ; Statement: $r17 = interfaceinvoke $r15.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r14) 
(define-const var3520 var2372 (var3790_joining/-1302177485 (cast-from-String-to-String ", "))) ; Statement: $r16 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ") 
(define-const var1751 var3756 (var2966_collect/-2050842585 var2448 var3520)) ; Statement: $r18 = interfaceinvoke $r17.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r16) 
(define-const var300 String (cast-from-var3756-to-String var1751)) ; Statement: $r25 = (java.lang.String) $r18 
(define-const var1918 (Array Int var3756) arr-var3756-init) ; Statement: $r19 = newarray (java.lang.Object)[1] 
(define-const var847 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var847)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var847!1 String)
(assert (= var847!1 ""))
(assert true)
(define-const var1569 String (append/672562846 var847!1 "Available providers: ")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Available providers: ") 
(declare-const var847!2 String)
(assert (= var847!2 (str.++ var847!1 "Available providers: ")))
(assert true)
(define-const var3119 String (append/672562846 var1569 var300)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var1569!1 String)
(assert (= var1569!1 (str.++ var1569 var300)))
(assert true)
(define-const var895 String (toString/-2075883882 var3119)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var1918!1 (Array Int var3756))
(assert (not (= var1918!1 null-__Array__Int__var3756__)))
(assert (= (select var1918!1 0) (cast-from-String-to-var3756 var895))) ; Statement: $r19[0] = $r23 
;(assert (var1353_debug/-195896556 var1918!1)) ; Statement: staticinvoke <org.jline.utils.Log: void debug(java.lang.Object[])>($r19) 

(declare-const var1918!2 (Array Int var3756))
 ; Statement: return $r0 
(check-sat)
; {var1919-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), ffm/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), checkProvider/549298428=([org.jline.terminal.TerminalBuilder, java.lang.String, java.lang.IllegalStateException, java.util.List, java.lang.Boolean, java.lang.String, java.lang.String], void), cast-from-var1919-to-var3317=([java.util.ArrayList], java.util.List), jni/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), jansi/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), jna/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), exec/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), providers/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.String), var896_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var3756__=([java.lang.String[]], java.lang.Object[]), var3814_bootstrap$/2025907028=([java.util.List], java.util.function.Function), var3487_comparing/-789310709=([java.util.function.Function], java.util.Comparator), var3317_sort/-1566373175=([java.util.List, java.util.Comparator], void), var1793_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var1919-to-var1793=([java.util.ArrayList], java.util.Collection), var2701_bootstrap$/-947092274=([], java.util.function.Function), var2966_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var3790_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2966_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var3756-to-String=([java.lang.Object], java.lang.String), arr-var3756-init=([], java.lang.Object[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var3756=([java.lang.String], java.lang.Object), var1353_debug/-195896556=([java.lang.Object[]], void)}
; {var2444=org.jline.terminal.TerminalBuilder, var1171=r1, var626=r2, var1050=null_type, var3171=java.lang.IllegalStateException, var33=r3, var1919=java.util.ArrayList, var271=$r0, var1076=java.lang.Boolean, var3518=$r4, var3317=java.util.List, var671="org.jline.terminal.ffm", var3101="ffm", var439=$r5, var3959="org.jline.terminal.jni", var1782="jni", var2807=$r6, var2170="org.jline.terminal.jansi", var2645="jansi", var1853=$r7, var3215="org.jline.terminal.jna", var2914="jna", var1394=$r8, var1389="org.jline.terminal.exec", var274="exec", var3141=$r9, var1225=$r26, var1968=$r11, var896=java.util.Arrays, var3756=java.lang.Object, var1367=$r24, var1988=java.util.function.Function, var3814=org.jline.terminal.TerminalBuilder$lambda_getProviders_7__367, var3793=$r12, var3487=java.util.Comparator, var2819=$r13, var2966=java.util.stream.Stream, var1793=java.util.Collection, var29=$r15, var2701=org.jline.terminal.TerminalBuilder$name__371, var1667=$r14, var2448=$r17, var2372=java.util.stream.Collector, var3790=java.util.stream.Collectors, var3520=$r16, var1751=$r18, var300=$r25, var1918=$r19, var847=$r20, var1569=$r21, var3119=$r22, var895=$r23, var1353=org.jline.utils.Log}
; {org.jline.terminal.TerminalBuilder=var2444, r1=var1171, r2=var626, null_type=var1050, java.lang.IllegalStateException=var3171, r3=var33, java.util.ArrayList=var1919, $r0=var271, java.lang.Boolean=var1076, $r4=var3518, java.util.List=var3317, "org.jline.terminal.ffm"=var671, "ffm"=var3101, $r5=var439, "org.jline.terminal.jni"=var3959, "jni"=var1782, $r6=var2807, "org.jline.terminal.jansi"=var2170, "jansi"=var2645, $r7=var1853, "org.jline.terminal.jna"=var3215, "jna"=var2914, $r8=var1394, "org.jline.terminal.exec"=var1389, "exec"=var274, $r9=var3141, $r26=var1225, $r11=var1968, java.util.Arrays=var896, java.lang.Object=var3756, $r24=var1367, java.util.function.Function=var1988, org.jline.terminal.TerminalBuilder$lambda_getProviders_7__367=var3814, $r12=var3793, java.util.Comparator=var3487, $r13=var2819, java.util.stream.Stream=var2966, java.util.Collection=var1793, $r15=var29, org.jline.terminal.TerminalBuilder$name__371=var2701, $r14=var1667, $r17=var2448, java.util.stream.Collector=var2372, java.util.stream.Collectors=var3790, $r16=var3520, $r18=var1751, $r25=var300, $r19=var1918, $r20=var847, $r21=var1569, $r22=var3119, $r23=var895, org.jline.utils.Log=var1353}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.jline.terminal.TerminalBuilder;	r2 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.IllegalStateException;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r4 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean ffm>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r4, "org.jline.terminal.ffm", "ffm");	$r5 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jni>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r5, "org.jline.terminal.jni", "jni");	$r6 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jansi>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r6, "org.jline.terminal.jansi", "jansi");	$r7 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jna>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r7, "org.jline.terminal.jna", "jna");	$r8 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean exec>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r8, "org.jline.terminal.exec", "exec");	$r9 = r1.<org.jline.terminal.TerminalBuilder: java.lang.String providers>;	if $r9 == null goto $r10 = <org.jline.terminal.TerminalBuilder: java.lang.String PROP_PROVIDERS_DEFAULT>;	$r26 = r1.<org.jline.terminal.TerminalBuilder: java.lang.String providers>;	goto [?= $r11 = virtualinvoke $r26.<java.lang.String: java.lang.String[] split(java.lang.String)>(",")];	$r11 = virtualinvoke $r26.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r24 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r11);	$r12 = staticinvoke <org.jline.terminal.TerminalBuilder$lambda_getProviders_7__367: java.util.function.Function bootstrap$(java.util.List)>($r24);	$r13 = staticinvoke <java.util.Comparator: java.util.Comparator comparing(java.util.function.Function)>($r12);	interfaceinvoke $r0.<java.util.List: void sort(java.util.Comparator)>($r13);	$r15 = interfaceinvoke $r0.<java.util.List: java.util.stream.Stream stream()>();	$r14 = staticinvoke <org.jline.terminal.TerminalBuilder$name__371: java.util.function.Function bootstrap$()>();	$r17 = interfaceinvoke $r15.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r14);	$r16 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ");	$r18 = interfaceinvoke $r17.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r16);	$r25 = (java.lang.String) $r18;	$r19 = newarray (java.lang.Object)[1];	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Available providers: ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	$r19[0] = $r23;	staticinvoke <org.jline.utils.Log: void debug(java.lang.Object[])>($r19);	return $r0
;block_num 3