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

(declare-sort var428 0)
(declare-sort var2795 0)
(declare-sort var1256 0)
(declare-sort var750 0)
(declare-sort var953 0)
(declare-sort var2480 0)
(declare-sort var1422 0)
(declare-sort var2774 0)
(declare-sort var2673 0)
(declare-sort var283 0)
(declare-sort var3327 0)
(declare-sort var858 0)
(declare-sort var1726 0)
(declare-sort var2105 0)
(declare-sort var1314 0)
(declare-sort var2498 0)
(declare-sort var1601 0)
(declare-sort var1628 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var750-init () var750)
(declare-fun <init>/-325640736 (var750) void)
(declare-fun ffm/1723327175 (var428) var953)
(declare-fun checkProvider/549298428 (var428 String var1256 var2480 var953 String String) void)
(declare-fun cast-from-var750-to-var2480 (var750) var2480)
(declare-fun jni/1723327175 (var428) var953)
(declare-fun jansi/1723327175 (var428) var953)
(declare-fun jna/1723327175 (var428) var953)
(declare-fun exec/1723327175 (var428) var953)
(declare-fun providers/1723327175 (var428) String)
(declare-fun var1422_getProperty/-1659784690 (String String) String)
(declare-fun var2774_asList/1779083644 ((Array Int var2673)) var2480)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2673__ ((Array Int String)) (Array Int var2673))
(declare-fun var3327_bootstrap$/2025907028 (var2480) var283)
(declare-fun var858_comparing/-789310709 (var283) var858)
(declare-fun var2480_sort/-1566373175 (var2480 var858) void)
(declare-fun var2105_stream/-1288525013 (var2105) var1726)
(declare-fun cast-from-var750-to-var2105 (var750) var2105)
(declare-fun var1314_bootstrap$/-947092274 () var283)
(declare-fun var1726_map/130902797 (var1726 var283) var1726)
(declare-fun var1601_joining/-1302177485 (String) var2498)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1726_collect/-2050842585 (var1726 var2498) var2673)
(declare-fun cast-from-var2673-to-String (var2673) String)
(declare-fun arr-var2673-init () (Array Int var2673))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var2673 (String) var2673)
(declare-fun var1628_debug/-195896556 ((Array Int var2673)) void)
(declare-const null-var428 var428)
(declare-const null-String String)
(declare-const null-var1256 var1256)
(declare-const var428-PROP_PROVIDERS_DEFAULT String)
(declare-const null-__Array__Int__var2673__ (Array Int var2673))
(declare-const var2791 var428) ; Statement: r1 := @this: org.jline.terminal.TerminalBuilder 
(assert (not (= var2791 null-var428)))
(declare-const var1615 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1615 null-String)))
(declare-const var555 var1256) ; Statement: r3 := @parameter1: java.lang.IllegalStateException 
(assert (not (= var555 null-var1256)))
(define-const var3640 var750 var750-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3640)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var3640!1 var750)
(define-const var2793 var953 (ffm/1723327175 var2791)) ; Statement: $r4 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean ffm> 
(assert true)
;(assert (checkProvider/549298428 var2791 var1615 var555 (cast-from-var750-to-var2480 var3640!1) var2793 "org.jline.terminal.ffm" "ffm")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r4, "org.jline.terminal.ffm", "ffm") 

(declare-const var2791!1 var428)
(declare-const var1615!1 String)
(declare-const var555!1 var1256)
(declare-const var3640!2 var750)
(declare-const var2793!1 var953)
(declare-const var986 String)
(declare-const var833 String)
(define-const var3245 var953 (jni/1723327175 var2791!1)) ; Statement: $r5 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jni> 
(assert true)
;(assert (checkProvider/549298428 var2791!1 var1615!1 var555!1 (cast-from-var750-to-var2480 var3640!2) var3245 "org.jline.terminal.jni" "jni")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r5, "org.jline.terminal.jni", "jni") 

(declare-const var2791!2 var428)
(declare-const var1615!2 String)
(declare-const var555!2 var1256)
(declare-const var3640!3 var750)
(declare-const var3245!1 var953)
(declare-const var3484 String)
(declare-const var3492 String)
(define-const var1396 var953 (jansi/1723327175 var2791!2)) ; Statement: $r6 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jansi> 
(assert true)
;(assert (checkProvider/549298428 var2791!2 var1615!2 var555!2 (cast-from-var750-to-var2480 var3640!3) var1396 "org.jline.terminal.jansi" "jansi")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r6, "org.jline.terminal.jansi", "jansi") 

(declare-const var2791!3 var428)
(declare-const var1615!3 String)
(declare-const var555!3 var1256)
(declare-const var3640!4 var750)
(declare-const var1396!1 var953)
(declare-const var3204 String)
(declare-const var356 String)
(define-const var599 var953 (jna/1723327175 var2791!3)) ; Statement: $r7 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jna> 
(assert true)
;(assert (checkProvider/549298428 var2791!3 var1615!3 var555!3 (cast-from-var750-to-var2480 var3640!4) var599 "org.jline.terminal.jna" "jna")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r7, "org.jline.terminal.jna", "jna") 

(declare-const var2791!4 var428)
(declare-const var1615!4 String)
(declare-const var555!4 var1256)
(declare-const var3640!5 var750)
(declare-const var599!1 var953)
(declare-const var3289 String)
(declare-const var2931 String)
(define-const var1594 var953 (exec/1723327175 var2791!4)) ; Statement: $r8 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean exec> 
(assert true)
;(assert (checkProvider/549298428 var2791!4 var1615!4 var555!4 (cast-from-var750-to-var2480 var3640!5) var1594 "org.jline.terminal.exec" "exec")) ; Statement: specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r8, "org.jline.terminal.exec", "exec") 

(declare-const var2791!5 var428)
(declare-const var1615!5 String)
(declare-const var555!5 var1256)
(declare-const var3640!6 var750)
(declare-const var1594!1 var953)
(declare-const var38 String)
(declare-const var981 String)
(define-const var2310 String (providers/1723327175 var2791!5)) ; Statement: $r9 = r1.<org.jline.terminal.TerminalBuilder: java.lang.String providers> 
 ; Statement: if $r9 == null goto $r10 = <org.jline.terminal.TerminalBuilder: java.lang.String PROP_PROVIDERS_DEFAULT> 
(assert (= var2310 null-String)) ; Cond: $r9 == null 
(define-const var3524 String var428-PROP_PROVIDERS_DEFAULT) ; Statement: $r10 = <org.jline.terminal.TerminalBuilder: java.lang.String PROP_PROVIDERS_DEFAULT> 
(define-const var2337 String (var1422_getProperty/-1659784690 "org.jline.terminal.providers" var3524)) ; Statement: $r26 = staticinvoke <java.lang.System: java.lang.String getProperty(java.lang.String,java.lang.String)>("org.jline.terminal.providers", $r10) 
(assert true) ; Non Conditional
; split operation: var615 = var2337.split(",") ; Statement: $r11 = virtualinvoke $r26.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var180 var2480 (var2774_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2673__ var615))) ; Statement: $r24 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r11) 
(define-const var2098 var283 (var3327_bootstrap$/2025907028 var180)) ; Statement: $r12 = staticinvoke <org.jline.terminal.TerminalBuilder$lambda_getProviders_7__367: java.util.function.Function bootstrap$(java.util.List)>($r24) 
(define-const var1706 var858 (var858_comparing/-789310709 var2098)) ; Statement: $r13 = staticinvoke <java.util.Comparator: java.util.Comparator comparing(java.util.function.Function)>($r12) 
;(assert (var2480_sort/-1566373175 (cast-from-var750-to-var2480 var3640!6) var1706)) ; Statement: interfaceinvoke $r0.<java.util.List: void sort(java.util.Comparator)>($r13) 

(declare-const var3640!7 var750)
(declare-const var1706!1 var858)
(define-const var3953 var1726 (var2105_stream/-1288525013 (cast-from-var750-to-var2105 var3640!7))) ; Statement: $r15 = interfaceinvoke $r0.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var3664 var283 var1314_bootstrap$/-947092274) ; Statement: $r14 = staticinvoke <org.jline.terminal.TerminalBuilder$name__371: java.util.function.Function bootstrap$()>() 
(define-const var891 var1726 (var1726_map/130902797 var3953 var3664)) ; Statement: $r17 = interfaceinvoke $r15.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r14) 
(define-const var2961 var2498 (var1601_joining/-1302177485 (cast-from-String-to-String ", "))) ; Statement: $r16 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ") 
(define-const var3856 var2673 (var1726_collect/-2050842585 var891 var2961)) ; Statement: $r18 = interfaceinvoke $r17.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r16) 
(define-const var2389 String (cast-from-var2673-to-String var3856)) ; Statement: $r25 = (java.lang.String) $r18 
(define-const var1243 (Array Int var2673) arr-var2673-init) ; Statement: $r19 = newarray (java.lang.Object)[1] 
(define-const var3866 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3866)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3866!1 String)
(assert (= var3866!1 ""))
(assert true)
(define-const var1076 String (append/672562846 var3866!1 "Available providers: ")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Available providers: ") 
(declare-const var3866!2 String)
(assert (= var3866!2 (str.++ var3866!1 "Available providers: ")))
(assert true)
(define-const var3179 String (append/672562846 var1076 var2389)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var1076!1 String)
(assert (= var1076!1 (str.++ var1076 var2389)))
(assert true)
(define-const var98 String (toString/-2075883882 var3179)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var1243!1 (Array Int var2673))
(assert (not (= var1243!1 null-__Array__Int__var2673__)))
(assert (= (select var1243!1 0) (cast-from-String-to-var2673 var98))) ; Statement: $r19[0] = $r23 
;(assert (var1628_debug/-195896556 var1243!1)) ; Statement: staticinvoke <org.jline.utils.Log: void debug(java.lang.Object[])>($r19) 

(declare-const var1243!2 (Array Int var2673))
 ; Statement: return $r0 
(check-sat)
; {var750-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), ffm/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), checkProvider/549298428=([org.jline.terminal.TerminalBuilder, java.lang.String, java.lang.IllegalStateException, java.util.List, java.lang.Boolean, java.lang.String, java.lang.String], void), cast-from-var750-to-var2480=([java.util.ArrayList], java.util.List), jni/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), jansi/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), jna/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), exec/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.Boolean), providers/1723327175=([org.jline.terminal.TerminalBuilder], java.lang.String), var1422_getProperty/-1659784690=([java.lang.String, java.lang.String], java.lang.String), var2774_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var2673__=([java.lang.String[]], java.lang.Object[]), var3327_bootstrap$/2025907028=([java.util.List], java.util.function.Function), var858_comparing/-789310709=([java.util.function.Function], java.util.Comparator), var2480_sort/-1566373175=([java.util.List, java.util.Comparator], void), var2105_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var750-to-var2105=([java.util.ArrayList], java.util.Collection), var1314_bootstrap$/-947092274=([], java.util.function.Function), var1726_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1601_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1726_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var2673-to-String=([java.lang.Object], java.lang.String), arr-var2673-init=([], java.lang.Object[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var2673=([java.lang.String], java.lang.Object), var1628_debug/-195896556=([java.lang.Object[]], void)}
; {var428=org.jline.terminal.TerminalBuilder, var2791=r1, var1615=r2, var2795=null_type, var1256=java.lang.IllegalStateException, var555=r3, var750=java.util.ArrayList, var3640=$r0, var953=java.lang.Boolean, var2793=$r4, var2480=java.util.List, var986="org.jline.terminal.ffm", var833="ffm", var3245=$r5, var3484="org.jline.terminal.jni", var3492="jni", var1396=$r6, var3204="org.jline.terminal.jansi", var356="jansi", var599=$r7, var3289="org.jline.terminal.jna", var2931="jna", var1594=$r8, var38="org.jline.terminal.exec", var981="exec", var2310=$r9, var3524=$r10, var1422=java.lang.System, var2337=$r26, var615=$r11, var2774=java.util.Arrays, var2673=java.lang.Object, var180=$r24, var283=java.util.function.Function, var3327=org.jline.terminal.TerminalBuilder$lambda_getProviders_7__367, var2098=$r12, var858=java.util.Comparator, var1706=$r13, var1726=java.util.stream.Stream, var2105=java.util.Collection, var3953=$r15, var1314=org.jline.terminal.TerminalBuilder$name__371, var3664=$r14, var891=$r17, var2498=java.util.stream.Collector, var1601=java.util.stream.Collectors, var2961=$r16, var3856=$r18, var2389=$r25, var1243=$r19, var3866=$r20, var1076=$r21, var3179=$r22, var98=$r23, var1628=org.jline.utils.Log}
; {org.jline.terminal.TerminalBuilder=var428, r1=var2791, r2=var1615, null_type=var2795, java.lang.IllegalStateException=var1256, r3=var555, java.util.ArrayList=var750, $r0=var3640, java.lang.Boolean=var953, $r4=var2793, java.util.List=var2480, "org.jline.terminal.ffm"=var986, "ffm"=var833, $r5=var3245, "org.jline.terminal.jni"=var3484, "jni"=var3492, $r6=var1396, "org.jline.terminal.jansi"=var3204, "jansi"=var356, $r7=var599, "org.jline.terminal.jna"=var3289, "jna"=var2931, $r8=var1594, "org.jline.terminal.exec"=var38, "exec"=var981, $r9=var2310, $r10=var3524, java.lang.System=var1422, $r26=var2337, $r11=var615, java.util.Arrays=var2774, java.lang.Object=var2673, $r24=var180, java.util.function.Function=var283, org.jline.terminal.TerminalBuilder$lambda_getProviders_7__367=var3327, $r12=var2098, java.util.Comparator=var858, $r13=var1706, java.util.stream.Stream=var1726, java.util.Collection=var2105, $r15=var3953, org.jline.terminal.TerminalBuilder$name__371=var1314, $r14=var3664, $r17=var891, java.util.stream.Collector=var2498, java.util.stream.Collectors=var1601, $r16=var2961, $r18=var3856, $r25=var2389, $r19=var1243, $r20=var3866, $r21=var1076, $r22=var3179, $r23=var98, org.jline.utils.Log=var1628}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.jline.terminal.TerminalBuilder;	r2 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.IllegalStateException;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r4 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean ffm>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r4, "org.jline.terminal.ffm", "ffm");	$r5 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jni>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r5, "org.jline.terminal.jni", "jni");	$r6 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jansi>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r6, "org.jline.terminal.jansi", "jansi");	$r7 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean jna>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r7, "org.jline.terminal.jna", "jna");	$r8 = r1.<org.jline.terminal.TerminalBuilder: java.lang.Boolean exec>;	specialinvoke r1.<org.jline.terminal.TerminalBuilder: void checkProvider(java.lang.String,java.lang.IllegalStateException,java.util.List,java.lang.Boolean,java.lang.String,java.lang.String)>(r2, r3, $r0, $r8, "org.jline.terminal.exec", "exec");	$r9 = r1.<org.jline.terminal.TerminalBuilder: java.lang.String providers>;	if $r9 == null goto $r10 = <org.jline.terminal.TerminalBuilder: java.lang.String PROP_PROVIDERS_DEFAULT>;	$r10 = <org.jline.terminal.TerminalBuilder: java.lang.String PROP_PROVIDERS_DEFAULT>;	$r26 = staticinvoke <java.lang.System: java.lang.String getProperty(java.lang.String,java.lang.String)>("org.jline.terminal.providers", $r10);	$r11 = virtualinvoke $r26.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r24 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r11);	$r12 = staticinvoke <org.jline.terminal.TerminalBuilder$lambda_getProviders_7__367: java.util.function.Function bootstrap$(java.util.List)>($r24);	$r13 = staticinvoke <java.util.Comparator: java.util.Comparator comparing(java.util.function.Function)>($r12);	interfaceinvoke $r0.<java.util.List: void sort(java.util.Comparator)>($r13);	$r15 = interfaceinvoke $r0.<java.util.List: java.util.stream.Stream stream()>();	$r14 = staticinvoke <org.jline.terminal.TerminalBuilder$name__371: java.util.function.Function bootstrap$()>();	$r17 = interfaceinvoke $r15.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r14);	$r16 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ");	$r18 = interfaceinvoke $r17.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r16);	$r25 = (java.lang.String) $r18;	$r19 = newarray (java.lang.Object)[1];	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Available providers: ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	$r19[0] = $r23;	staticinvoke <org.jline.utils.Log: void debug(java.lang.Object[])>($r19);	return $r0
;block_num 3