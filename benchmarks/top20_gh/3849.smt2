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

(declare-sort var2408 0)
(declare-sort var2842 0)
(declare-sort var3092 0)
(declare-sort var326 0)
(declare-sort var148 0)
(declare-sort var750 0)
(declare-sort var126 0)
(declare-sort var732 0)
(declare-sort var1188 0)
(declare-sort var61 0)
(declare-sort var746 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun pattern/-56765647 (var2408) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var3092_stream/-1757820 ((Array Int var326)) var2842)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var326__ ((Array Int String)) (Array Int var326))
(declare-fun var750_bootstrap$/179665281 () var148)
(declare-fun var2842_filter/320182972 (var2842 var148) var2842)
(declare-fun var732_bootstrap$/-1236529027 () var126)
(declare-fun var2842_map/130902797 (var2842 var126) var2842)
(declare-fun var61_joining/-1221703981 (String String String) var1188)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2842_collect/-2050842585 (var2842 var1188) var326)
(declare-fun cast-from-var326-to-String (var326) String)
(declare-fun var746_compile/2141929305 (String) var746)
(declare-const null-var2408 var2408)
(declare-const var3256 var2408) ; Statement: r0 := @this: org.springframework.aot.hint.ResourcePatternHint 
(assert (not (= var3256 null-var2408)))
(define-const var1635 String (pattern/-56765647 var3256)) ; Statement: $r1 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
(assert true)
(define-const var2412 Bool (startsWith/-1785782452 var1635 "*")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("*") 
 ; Statement: if $z0 == 0 goto $r15 = "" 
(assert (not (= (ite var2412 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2515 String ".*") ; Statement: $r15 = ".*" 
 ; Statement: goto [?= r2 = $r15] 
(assert true) ; Non Conditional
(define-const var3247 String var2515) ; Statement: r2 = $r15 
(define-const var592 String (pattern/-56765647 var3256)) ; Statement: $r3 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
(assert true)
(define-const var2649 Bool (endsWith/985337093 var592 "*")) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean endsWith(java.lang.String)>("*") 
 ; Statement: if $z1 == 0 goto $r16 = "" 
(assert (not (= (ite var2649 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2290 String ".*") ; Statement: $r16 = ".*" 
 ; Statement: goto [?= $r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>] 
(assert true) ; Non Conditional
(define-const var443 String (pattern/-56765647 var3256)) ; Statement: $r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
; split operation: var2513 = var443.split("\u005c*") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\*") 
(define-const var3283 var2842 (var3092_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var326__ var2513))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r5) 
(define-const var2729 var148 var750_bootstrap$/179665281) ; Statement: $r6 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132: java.util.function.Predicate bootstrap$()>() 
(define-const var412 var2842 (var2842_filter/320182972 var3283 var2729)) ; Statement: $r9 = interfaceinvoke $r7.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r6) 
(define-const var444 var126 var732_bootstrap$/-1236529027) ; Statement: $r8 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$quote__139: java.util.function.Function bootstrap$()>() 
(define-const var3245 var2842 (var2842_map/130902797 var412 var444)) ; Statement: $r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8) 
(define-const var276 var1188 (var61_joining/-1221703981 (cast-from-String-to-String ".*") (cast-from-String-to-String var3247) (cast-from-String-to-String var2290))) ; Statement: $r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence,java.lang.CharSequence,java.lang.CharSequence)>(".*", r2, $r16) 
(define-const var3599 var326 (var2842_collect/-2050842585 var3245 var276)) ; Statement: $r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10) 
(define-const var438 String (cast-from-var326-to-String var3599)) ; Statement: $r14 = (java.lang.String) $r12 
(define-const var310 var746 (var746_compile/2141929305 var438)) ; Statement: $r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>($r14) 
 ; Statement: return $r13 
(check-sat)
; {pattern/-56765647=([org.springframework.aot.hint.ResourcePatternHint], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), endsWith/985337093=([java.lang.String, java.lang.String], boolean), var3092_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var326__=([java.lang.String[]], java.lang.Object[]), var750_bootstrap$/179665281=([], java.util.function.Predicate), var2842_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var732_bootstrap$/-1236529027=([], java.util.function.Function), var2842_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var61_joining/-1221703981=([java.lang.CharSequence, java.lang.CharSequence, java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2842_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var326-to-String=([java.lang.Object], java.lang.String), var746_compile/2141929305=([java.lang.String], java.util.regex.Pattern)}
; {var2408=org.springframework.aot.hint.ResourcePatternHint, var3256=r0, var1635=$r1, var2412=$z0, var2515=$r15, var3247=r2, var592=$r3, var2649=$z1, var2290=$r16, var443=$r4, var2513=$r5, var2842=java.util.stream.Stream, var3092=java.util.Arrays, var326=java.lang.Object, var3283=$r7, var148=java.util.function.Predicate, var750=org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132, var2729=$r6, var412=$r9, var126=java.util.function.Function, var732=org.springframework.aot.hint.ResourcePatternHint$quote__139, var444=$r8, var3245=$r11, var1188=java.util.stream.Collector, var61=java.util.stream.Collectors, var276=$r10, var3599=$r12, var438=$r14, var746=java.util.regex.Pattern, var310=$r13}
; {org.springframework.aot.hint.ResourcePatternHint=var2408, r0=var3256, $r1=var1635, $z0=var2412, $r15=var2515, r2=var3247, $r3=var592, $z1=var2649, $r16=var2290, $r4=var443, $r5=var2513, java.util.stream.Stream=var2842, java.util.Arrays=var3092, java.lang.Object=var326, $r7=var3283, java.util.function.Predicate=var148, org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132=var750, $r6=var2729, $r9=var412, java.util.function.Function=var126, org.springframework.aot.hint.ResourcePatternHint$quote__139=var732, $r8=var444, $r11=var3245, java.util.stream.Collector=var1188, java.util.stream.Collectors=var61, $r10=var276, $r12=var3599, $r14=var438, java.util.regex.Pattern=var746, $r13=var310}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: boolean endsWith(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.springframework.aot.hint.ResourcePatternHint;	$r1 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("*");	if $z0 == 0 goto $r15 = "";	$r15 = ".*";	goto [?= r2 = $r15];	r2 = $r15;	$r3 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$z1 = virtualinvoke $r3.<java.lang.String: boolean endsWith(java.lang.String)>("*");	if $z1 == 0 goto $r16 = "";	$r16 = ".*";	goto [?= $r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>];	$r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\*");	$r7 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r5);	$r6 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132: java.util.function.Predicate bootstrap$()>();	$r9 = interfaceinvoke $r7.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r6);	$r8 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$quote__139: java.util.function.Function bootstrap$()>();	$r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8);	$r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence,java.lang.CharSequence,java.lang.CharSequence)>(".*", r2, $r16);	$r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10);	$r14 = (java.lang.String) $r12;	$r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>($r14);	return $r13
;block_num 5