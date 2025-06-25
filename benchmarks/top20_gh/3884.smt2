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

(declare-sort var3547 0)
(declare-sort var2978 0)
(declare-sort var1302 0)
(declare-sort var3859 0)
(declare-sort var328 0)
(declare-sort var3390 0)
(declare-sort var1570 0)
(declare-sort var668 0)
(declare-sort var3315 0)
(declare-sort var1747 0)
(declare-sort var1325 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun pattern/-56765647 (var3547) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var1302_stream/-1757820 ((Array Int var3859)) var2978)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3859__ ((Array Int String)) (Array Int var3859))
(declare-fun var3390_bootstrap$/179665281 () var328)
(declare-fun var2978_filter/320182972 (var2978 var328) var2978)
(declare-fun var668_bootstrap$/-1236529027 () var1570)
(declare-fun var2978_map/130902797 (var2978 var1570) var2978)
(declare-fun var1747_joining/-1221703981 (String String String) var3315)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2978_collect/-2050842585 (var2978 var3315) var3859)
(declare-fun cast-from-var3859-to-String (var3859) String)
(declare-fun var1325_compile/2141929305 (String) var1325)
(declare-const null-var3547 var3547)
(declare-const var1863 var3547) ; Statement: r0 := @this: org.springframework.aot.hint.ResourcePatternHint 
(assert (not (= var1863 null-var3547)))
(define-const var1996 String (pattern/-56765647 var1863)) ; Statement: $r1 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
(assert true)
(define-const var3760 Bool (startsWith/-1785782452 var1996 "*")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("*") 
 ; Statement: if $z0 == 0 goto $r15 = "" 
(assert (= (ite var3760 1 0) 0)) ; Cond: $z0 == 0 
(define-const var592 String "") ; Statement: $r15 = "" 
(assert true) ; Non Conditional
(define-const var1172 String var592) ; Statement: r2 = $r15 
(define-const var2962 String (pattern/-56765647 var1863)) ; Statement: $r3 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
(assert true)
(define-const var921 Bool (endsWith/985337093 var2962 "*")) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean endsWith(java.lang.String)>("*") 
 ; Statement: if $z1 == 0 goto $r16 = "" 
(assert (not (= (ite var921 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2555 String ".*") ; Statement: $r16 = ".*" 
 ; Statement: goto [?= $r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>] 
(assert true) ; Non Conditional
(define-const var2864 String (pattern/-56765647 var1863)) ; Statement: $r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
; split operation: var68 = var2864.split("\u005c*") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\*") 
(define-const var1066 var2978 (var1302_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var3859__ var68))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r5) 
(define-const var1575 var328 var3390_bootstrap$/179665281) ; Statement: $r6 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132: java.util.function.Predicate bootstrap$()>() 
(define-const var3635 var2978 (var2978_filter/320182972 var1066 var1575)) ; Statement: $r9 = interfaceinvoke $r7.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r6) 
(define-const var3214 var1570 var668_bootstrap$/-1236529027) ; Statement: $r8 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$quote__139: java.util.function.Function bootstrap$()>() 
(define-const var650 var2978 (var2978_map/130902797 var3635 var3214)) ; Statement: $r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8) 
(define-const var2114 var3315 (var1747_joining/-1221703981 (cast-from-String-to-String ".*") (cast-from-String-to-String var1172) (cast-from-String-to-String var2555))) ; Statement: $r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence,java.lang.CharSequence,java.lang.CharSequence)>(".*", r2, $r16) 
(define-const var3995 var3859 (var2978_collect/-2050842585 var650 var2114)) ; Statement: $r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10) 
(define-const var3159 String (cast-from-var3859-to-String var3995)) ; Statement: $r14 = (java.lang.String) $r12 
(define-const var235 var1325 (var1325_compile/2141929305 var3159)) ; Statement: $r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>($r14) 
 ; Statement: return $r13 
(check-sat)
; {pattern/-56765647=([org.springframework.aot.hint.ResourcePatternHint], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), endsWith/985337093=([java.lang.String, java.lang.String], boolean), var1302_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var3859__=([java.lang.String[]], java.lang.Object[]), var3390_bootstrap$/179665281=([], java.util.function.Predicate), var2978_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var668_bootstrap$/-1236529027=([], java.util.function.Function), var2978_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1747_joining/-1221703981=([java.lang.CharSequence, java.lang.CharSequence, java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2978_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var3859-to-String=([java.lang.Object], java.lang.String), var1325_compile/2141929305=([java.lang.String], java.util.regex.Pattern)}
; {var3547=org.springframework.aot.hint.ResourcePatternHint, var1863=r0, var1996=$r1, var3760=$z0, var592=$r15, var1172=r2, var2962=$r3, var921=$z1, var2555=$r16, var2864=$r4, var68=$r5, var2978=java.util.stream.Stream, var1302=java.util.Arrays, var3859=java.lang.Object, var1066=$r7, var328=java.util.function.Predicate, var3390=org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132, var1575=$r6, var3635=$r9, var1570=java.util.function.Function, var668=org.springframework.aot.hint.ResourcePatternHint$quote__139, var3214=$r8, var650=$r11, var3315=java.util.stream.Collector, var1747=java.util.stream.Collectors, var2114=$r10, var3995=$r12, var3159=$r14, var1325=java.util.regex.Pattern, var235=$r13}
; {org.springframework.aot.hint.ResourcePatternHint=var3547, r0=var1863, $r1=var1996, $z0=var3760, $r15=var592, r2=var1172, $r3=var2962, $z1=var921, $r16=var2555, $r4=var2864, $r5=var68, java.util.stream.Stream=var2978, java.util.Arrays=var1302, java.lang.Object=var3859, $r7=var1066, java.util.function.Predicate=var328, org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132=var3390, $r6=var1575, $r9=var3635, java.util.function.Function=var1570, org.springframework.aot.hint.ResourcePatternHint$quote__139=var668, $r8=var3214, $r11=var650, java.util.stream.Collector=var3315, java.util.stream.Collectors=var1747, $r10=var2114, $r12=var3995, $r14=var3159, java.util.regex.Pattern=var1325, $r13=var235}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: boolean endsWith(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.springframework.aot.hint.ResourcePatternHint;	$r1 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("*");	if $z0 == 0 goto $r15 = "";	$r15 = "";	r2 = $r15;	$r3 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$z1 = virtualinvoke $r3.<java.lang.String: boolean endsWith(java.lang.String)>("*");	if $z1 == 0 goto $r16 = "";	$r16 = ".*";	goto [?= $r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>];	$r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\*");	$r7 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r5);	$r6 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132: java.util.function.Predicate bootstrap$()>();	$r9 = interfaceinvoke $r7.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r6);	$r8 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$quote__139: java.util.function.Function bootstrap$()>();	$r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8);	$r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence,java.lang.CharSequence,java.lang.CharSequence)>(".*", r2, $r16);	$r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10);	$r14 = (java.lang.String) $r12;	$r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>($r14);	return $r13
;block_num 5