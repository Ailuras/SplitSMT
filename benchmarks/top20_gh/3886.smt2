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

(declare-sort var1182 0)
(declare-sort var2751 0)
(declare-sort var3669 0)
(declare-sort var1070 0)
(declare-sort var552 0)
(declare-sort var1820 0)
(declare-sort var681 0)
(declare-sort var1631 0)
(declare-sort var3458 0)
(declare-sort var2869 0)
(declare-sort var2164 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun pattern/-56765647 (var1182) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var3669_stream/-1757820 ((Array Int var1070)) var2751)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1070__ ((Array Int String)) (Array Int var1070))
(declare-fun var1820_bootstrap$/179665281 () var552)
(declare-fun var2751_filter/320182972 (var2751 var552) var2751)
(declare-fun var1631_bootstrap$/-1236529027 () var681)
(declare-fun var2751_map/130902797 (var2751 var681) var2751)
(declare-fun var2869_joining/-1221703981 (String String String) var3458)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2751_collect/-2050842585 (var2751 var3458) var1070)
(declare-fun cast-from-var1070-to-String (var1070) String)
(declare-fun var2164_compile/2141929305 (String) var2164)
(declare-const null-var1182 var1182)
(declare-const var263 var1182) ; Statement: r0 := @this: org.springframework.aot.hint.ResourcePatternHint 
(assert (not (= var263 null-var1182)))
(define-const var3211 String (pattern/-56765647 var263)) ; Statement: $r1 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
(assert true)
(define-const var115 Bool (startsWith/-1785782452 var3211 "*")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("*") 
 ; Statement: if $z0 == 0 goto $r15 = "" 
(assert (= (ite var115 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3004 String "") ; Statement: $r15 = "" 
(assert true) ; Non Conditional
(define-const var3806 String var3004) ; Statement: r2 = $r15 
(define-const var2903 String (pattern/-56765647 var263)) ; Statement: $r3 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
(assert true)
(define-const var2044 Bool (endsWith/985337093 var2903 "*")) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean endsWith(java.lang.String)>("*") 
 ; Statement: if $z1 == 0 goto $r16 = "" 
(assert (= (ite var2044 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1496 String "") ; Statement: $r16 = "" 
(assert true) ; Non Conditional
(define-const var3581 String (pattern/-56765647 var263)) ; Statement: $r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern> 
; split operation: var715 = var3581.split("\u005c*") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\*") 
(define-const var682 var2751 (var3669_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var1070__ var715))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r5) 
(define-const var1588 var552 var1820_bootstrap$/179665281) ; Statement: $r6 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132: java.util.function.Predicate bootstrap$()>() 
(define-const var1868 var2751 (var2751_filter/320182972 var682 var1588)) ; Statement: $r9 = interfaceinvoke $r7.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r6) 
(define-const var405 var681 var1631_bootstrap$/-1236529027) ; Statement: $r8 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$quote__139: java.util.function.Function bootstrap$()>() 
(define-const var3197 var2751 (var2751_map/130902797 var1868 var405)) ; Statement: $r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8) 
(define-const var2250 var3458 (var2869_joining/-1221703981 (cast-from-String-to-String ".*") (cast-from-String-to-String var3806) (cast-from-String-to-String var1496))) ; Statement: $r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence,java.lang.CharSequence,java.lang.CharSequence)>(".*", r2, $r16) 
(define-const var557 var1070 (var2751_collect/-2050842585 var3197 var2250)) ; Statement: $r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10) 
(define-const var2963 String (cast-from-var1070-to-String var557)) ; Statement: $r14 = (java.lang.String) $r12 
(define-const var2179 var2164 (var2164_compile/2141929305 var2963)) ; Statement: $r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>($r14) 
 ; Statement: return $r13 
(check-sat)
; {pattern/-56765647=([org.springframework.aot.hint.ResourcePatternHint], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), endsWith/985337093=([java.lang.String, java.lang.String], boolean), var3669_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1070__=([java.lang.String[]], java.lang.Object[]), var1820_bootstrap$/179665281=([], java.util.function.Predicate), var2751_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var1631_bootstrap$/-1236529027=([], java.util.function.Function), var2751_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var2869_joining/-1221703981=([java.lang.CharSequence, java.lang.CharSequence, java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2751_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1070-to-String=([java.lang.Object], java.lang.String), var2164_compile/2141929305=([java.lang.String], java.util.regex.Pattern)}
; {var1182=org.springframework.aot.hint.ResourcePatternHint, var263=r0, var3211=$r1, var115=$z0, var3004=$r15, var3806=r2, var2903=$r3, var2044=$z1, var1496=$r16, var3581=$r4, var715=$r5, var2751=java.util.stream.Stream, var3669=java.util.Arrays, var1070=java.lang.Object, var682=$r7, var552=java.util.function.Predicate, var1820=org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132, var1588=$r6, var1868=$r9, var681=java.util.function.Function, var1631=org.springframework.aot.hint.ResourcePatternHint$quote__139, var405=$r8, var3197=$r11, var3458=java.util.stream.Collector, var2869=java.util.stream.Collectors, var2250=$r10, var557=$r12, var2963=$r14, var2164=java.util.regex.Pattern, var2179=$r13}
; {org.springframework.aot.hint.ResourcePatternHint=var1182, r0=var263, $r1=var3211, $z0=var115, $r15=var3004, r2=var3806, $r3=var2903, $z1=var2044, $r16=var1496, $r4=var3581, $r5=var715, java.util.stream.Stream=var2751, java.util.Arrays=var3669, java.lang.Object=var1070, $r7=var682, java.util.function.Predicate=var552, org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132=var1820, $r6=var1588, $r9=var1868, java.util.function.Function=var681, org.springframework.aot.hint.ResourcePatternHint$quote__139=var1631, $r8=var405, $r11=var3197, java.util.stream.Collector=var3458, java.util.stream.Collectors=var2869, $r10=var2250, $r12=var557, $r14=var2963, java.util.regex.Pattern=var2164, $r13=var2179}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: boolean endsWith(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.springframework.aot.hint.ResourcePatternHint;	$r1 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean startsWith(java.lang.String)>("*");	if $z0 == 0 goto $r15 = "";	$r15 = "";	r2 = $r15;	$r3 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$z1 = virtualinvoke $r3.<java.lang.String: boolean endsWith(java.lang.String)>("*");	if $z1 == 0 goto $r16 = "";	$r16 = "";	$r4 = r0.<org.springframework.aot.hint.ResourcePatternHint: java.lang.String pattern>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\*");	$r7 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r5);	$r6 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$lambda_toRegex_1__132: java.util.function.Predicate bootstrap$()>();	$r9 = interfaceinvoke $r7.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r6);	$r8 = staticinvoke <org.springframework.aot.hint.ResourcePatternHint$quote__139: java.util.function.Function bootstrap$()>();	$r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8);	$r10 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence,java.lang.CharSequence,java.lang.CharSequence)>(".*", r2, $r16);	$r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r10);	$r14 = (java.lang.String) $r12;	$r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>($r14);	return $r13
;block_num 5