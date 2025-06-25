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

(declare-sort var961 0)
(declare-sort var2180 0)
(declare-sort var1103 0)
(declare-sort var558 0)
(declare-sort var2404 0)
(declare-sort var386 0)
(declare-sort var3482 0)
(declare-sort var1476 0)
(declare-sort var3869 0)
(declare-sort var3318 0)
(declare-sort var1159 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun pattern/-56765647 (var961) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var1103_stream/-1757820 ((Array Int var558)) var2180)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var558__ ((Array Int String)) (Array Int var558))
(declare-fun var386_bootstrap$/179665281 () var2404)
(declare-fun var2180_filter/320182972 (var2180 var2404) var2180)
(declare-fun var1476_bootstrap$/-1236529027 () var3482)
(declare-fun var2180_map/130902797 (var2180 var3482) var2180)
(declare-fun var3318_joining/-1221703981 (String String String) var3869)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2180_collect/-2050842585 (var2180 var3869) var558)
(declare-fun cast-from-var558-to-String (var558) String)
(declare-fun var1159_compile/2141929305 (String) var1159)
(declare-const null-var961 var961)
(declare-const var2607 var961) ; Statement: r0 := @this: org.springframework.aot.hint.ResourcePatternHint 
(assert (not (= var2607 null-var961)))
(define-const var3547 String (pattern/-56765647 var2607)) ; Statement: $r1 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
(assert true)
(define-const var3586 Bool (startsWith/-1785782452 var3547 "*")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("*") 
 ; Statement: if $z0 == 0 goto $r15 = "" 
(assert (not (= (ite var3586 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3489 String ".*") ; Statement: $r15 = ".*" 
 ; Statement: goto [?= r2 = $r15] 
(assert true) ; Non Conditional
(define-const var1772 String var3489) ; Statement: r2 = $r15 
(define-const var1972 String (pattern/-56765647 var2607)) ; Statement: $r3 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
(assert true)
(define-const var2910 Bool (endsWith/985337093 var1972 "*")) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean endsWith(java.lang.String)>("*") 
 ; Statement: if $z1 == 0 goto $r16 = "" 
(assert (= (ite var2910 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2203 String "") ; Statement: $r16 = "" 
(assert true) ; Non Conditional
(define-const var3665 String (pattern/-56765647 var2607)) ; Statement: $r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
; split operation: var2706 = var3665.split("\u005c*") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\*") 
(define-const var9 var2180 (var1103_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var558__ var2706))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r5) 
(define-const var1113 var2404 var386_bootstrap$/179665281) ; Statement: $r6 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132: java.util.function.Predicate bootstrap$()>() 
(define-const var156 var2180 (var2180_filter/320182972 var9 var1113)) ; Statement: $r9 = interfaceinvoke $r7.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r6) 
(define-const var2005 var3482 var1476_bootstrap$/-1236529027) ; Statement: $r8 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$quote__139: java.util.function.Function bootstrap$()>() 
(define-const var3600 var2180 (var2180_map/130902797 var156 var2005)) ; Statement: $r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8) 
(define-const var2757 var3869 (var3318_joining/-1221703981 (cast-from-String-to-String ".*") (cast-from-String-to-String var1772) (cast-from-String-to-String var2203))) ; Statement: $r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence,java.lang.CharSequence,java.lang.CharSequence)>(".*", r2, $r16) 
(define-const var3300 var558 (var2180_collect/-2050842585 var3600 var2757)) ; Statement: $r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10) 
(define-const var3406 String (cast-from-var558-to-String var3300)) ; Statement: $r14 = (java.lang.String) $r12 
(define-const var1944 var1159 (var1159_compile/2141929305 var3406)) ; Statement: $r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>($r14) 
 ; Statement: return $r13 
(check-sat)
; {pattern/-56765647=([org.springframework.aot.hint.ResourcePatternHint], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), endsWith/985337093=([java.lang.String, java.lang.String], boolean), var1103_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var558__=([java.lang.String[]], java.lang.Object[]), var386_bootstrap$/179665281=([], java.util.function.Predicate), var2180_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var1476_bootstrap$/-1236529027=([], java.util.function.Function), var2180_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var3318_joining/-1221703981=([java.lang.CharSequence, java.lang.CharSequence, java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2180_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var558-to-String=([java.lang.Object], java.lang.String), var1159_compile/2141929305=([java.lang.String], java.util.regex.Pattern)}
; {var961=org.springframework.aot.hint.ResourcePatternHint, var2607=r0, var3547=$r1, var3586=$z0, var3489=$r15, var1772=r2, var1972=$r3, var2910=$z1, var2203=$r16, var3665=$r4, var2706=$r5, var2180=java.util.stream.Stream, var1103=java.util.Arrays, var558=java.lang.Object, var9=$r7, var2404=java.util.function.Predicate, var386=org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132, var1113=$r6, var156=$r9, var3482=java.util.function.Function, var1476=org.springframework.aot.hint.ResourcePatternHint$quote__139, var2005=$r8, var3600=$r11, var3869=java.util.stream.Collector, var3318=java.util.stream.Collectors, var2757=$r10, var3300=$r12, var3406=$r14, var1159=java.util.regex.Pattern, var1944=$r13}
; {org.springframework.aot.hint.ResourcePatternHint=var961, r0=var2607, $r1=var3547, $z0=var3586, $r15=var3489, r2=var1772, $r3=var1972, $z1=var2910, $r16=var2203, $r4=var3665, $r5=var2706, java.util.stream.Stream=var2180, java.util.Arrays=var1103, java.lang.Object=var558, $r7=var9, java.util.function.Predicate=var2404, org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132=var386, $r6=var1113, $r9=var156, java.util.function.Function=var3482, org.springframework.aot.hint.ResourcePatternHint$quote__139=var1476, $r8=var2005, $r11=var3600, java.util.stream.Collector=var3869, java.util.stream.Collectors=var3318, $r10=var2757, $r12=var3300, $r14=var3406, java.util.regex.Pattern=var1159, $r13=var1944}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: boolean endsWith(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.springframework.aot.hint.ResourcePatternHint;	$r1 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("*");	if $z0 == 0 goto $r15 = "";	$r15 = ".*";	goto [?= r2 = $r15];	r2 = $r15;	$r3 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$z1 = virtualinvoke $r3.<java.lang.String: boolean endsWith(java.lang.String)>("*");	if $z1 == 0 goto $r16 = "";	$r16 = "";	$r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\*");	$r7 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r5);	$r6 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132: java.util.function.Predicate bootstrap$()>();	$r9 = interfaceinvoke $r7.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r6);	$r8 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$quote__139: java.util.function.Function bootstrap$()>();	$r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8);	$r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence,java.lang.CharSequence,java.lang.CharSequence)>(".*", r2, $r16);	$r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10);	$r14 = (java.lang.String) $r12;	$r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>($r14);	return $r13
;block_num 5