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

(declare-sort var1852 0)
(declare-sort var3205 0)
(declare-sort var2759 0)
(declare-sort var3792 0)
(declare-sort var3169 0)
(declare-sort var2826 0)
(declare-sort var1676 0)
(declare-sort var3499 0)
(declare-sort var3479 0)
(declare-sort var341 0)
(declare-sort var2050 0)
(declare-sort var2430 0)
(declare-sort var1057 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2759_stream/-1757820 ((Array Int var3792)) var3205)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3792__ ((Array Int String)) (Array Int var3792))
(declare-fun var2826_bootstrap$/708977197 () var3169)
(declare-fun var1676_bootstrap$/2027205583 () var3169)
(declare-fun var3479_toMap/957941883 (var3169 var3169) var3499)
(declare-fun var3205_collect/-2050842585 (var3205 var3499) var3792)
(declare-fun cast-from-var3792-to-var341 (var3792) var341)
(declare-fun var2050-init () var2050)
(declare-fun var2430-init () var2430)
(declare-fun <init>/-334015317 (var2430 var341) void)
(declare-fun var1057_bootstrap$/1544312062 (var2430) var3169)
(declare-fun <init>/-414444817 (var2050 var3169) void)
(declare-const null-String String)
(declare-const var557 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var557 null-String)))
; split operation: var170 = var557.split(":") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var3569 var3205 (var2759_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var3792__ var170))) ; Statement: $r5 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1) 
(define-const var1267 var3169 var2826_bootstrap$/708977197) ; Statement: $r3 = staticinvoke <org.jline.builtins.Styles$lambda_style_1__52: java.util.function.Function bootstrap$()>() 
(define-const var2112 var3169 var1676_bootstrap$/2027205583) ; Statement: $r2 = staticinvoke <org.jline.builtins.Styles$lambda_style_2__60: java.util.function.Function bootstrap$()>() 
(define-const var652 var3499 (var3479_toMap/957941883 var1267 var2112)) ; Statement: $r4 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toMap(java.util.function.Function,java.util.function.Function)>($r3, $r2) 
(define-const var3110 var3792 (var3205_collect/-2050842585 var3569 var652)) ; Statement: $r6 = interfaceinvoke $r5.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r4) 
(define-const var3560 var341 (cast-from-var3792-to-var341 var3110)) ; Statement: r7 = (java.util.Map) $r6 
(define-const var132 var2050 var2050-init) ; Statement: $r8 = new org.jline.utils.StyleResolver 
(define-const var3470 var2430 var2430-init) ; Statement: $r9 = new org.jline.builtins.Styles$StyleCompiler 
(assert true)
;(assert (<init>/-334015317 var3470 var3560)) ; Statement: specialinvoke $r9.<org.jline.builtins.Styles$StyleCompiler: void <init>(java.util.Map)>(r7) 

(declare-const var3470!1 var2430)
(declare-const var3560!1 var341)
(define-const var519 var3169 (var1057_bootstrap$/1544312062 var3470!1)) ; Statement: $r10 = staticinvoke <org.jline.builtins.Styles$getStyle__62: java.util.function.Function bootstrap$(org.jline.builtins.Styles$StyleCompiler)>($r9) 
(assert true)
;(assert (<init>/-414444817 var132 var519)) ; Statement: specialinvoke $r8.<org.jline.utils.StyleResolver: void <init>(java.util.function.Function)>($r10) 

(declare-const var132!1 var2050)
(declare-const var519!1 var3169)
 ; Statement: return $r8 
(check-sat)
; {var2759_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var3792__=([java.lang.String[]], java.lang.Object[]), var2826_bootstrap$/708977197=([], java.util.function.Function), var1676_bootstrap$/2027205583=([], java.util.function.Function), var3479_toMap/957941883=([java.util.function.Function, java.util.function.Function], java.util.stream.Collector), var3205_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var3792-to-var341=([java.lang.Object], java.util.Map), var2050-init=([], org.jline.utils.StyleResolver), var2430-init=([], org.jline.builtins.Styles$StyleCompiler), <init>/-334015317=([org.jline.builtins.Styles$StyleCompiler, java.util.Map], void), var1057_bootstrap$/1544312062=([org.jline.builtins.Styles$StyleCompiler], java.util.function.Function), <init>/-414444817=([org.jline.utils.StyleResolver, java.util.function.Function], void)}
; {var557=r0, var1852=null_type, var170=$r1, var3205=java.util.stream.Stream, var2759=java.util.Arrays, var3792=java.lang.Object, var3569=$r5, var3169=java.util.function.Function, var2826=org.jline.builtins.Styles$lambda_style_1__52, var1267=$r3, var1676=org.jline.builtins.Styles$lambda_style_2__60, var2112=$r2, var3499=java.util.stream.Collector, var3479=java.util.stream.Collectors, var652=$r4, var3110=$r6, var341=java.util.Map, var3560=r7, var2050=org.jline.utils.StyleResolver, var132=$r8, var2430=org.jline.builtins.Styles$StyleCompiler, var3470=$r9, var1057=org.jline.builtins.Styles$getStyle__62, var519=$r10}
; {r0=var557, null_type=var1852, $r1=var170, java.util.stream.Stream=var3205, java.util.Arrays=var2759, java.lang.Object=var3792, $r5=var3569, java.util.function.Function=var3169, org.jline.builtins.Styles$lambda_style_1__52=var2826, $r3=var1267, org.jline.builtins.Styles$lambda_style_2__60=var1676, $r2=var2112, java.util.stream.Collector=var3499, java.util.stream.Collectors=var3479, $r4=var652, $r6=var3110, java.util.Map=var341, r7=var3560, org.jline.utils.StyleResolver=var2050, $r8=var132, org.jline.builtins.Styles$StyleCompiler=var2430, $r9=var3470, org.jline.builtins.Styles$getStyle__62=var1057, $r10=var519}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$r5 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1);	$r3 = staticinvoke <org.jline.builtins.Styles$lambda_style_1__52: java.util.function.Function bootstrap$()>();	$r2 = staticinvoke <org.jline.builtins.Styles$lambda_style_2__60: java.util.function.Function bootstrap$()>();	$r4 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toMap(java.util.function.Function,java.util.function.Function)>($r3, $r2);	$r6 = interfaceinvoke $r5.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r4);	r7 = (java.util.Map) $r6;	$r8 = new org.jline.utils.StyleResolver;	$r9 = new org.jline.builtins.Styles$StyleCompiler;	specialinvoke $r9.<org.jline.builtins.Styles$StyleCompiler: void <init>(java.util.Map)>(r7);	$r10 = staticinvoke <org.jline.builtins.Styles$getStyle__62: java.util.function.Function bootstrap$(org.jline.builtins.Styles$StyleCompiler)>($r9);	specialinvoke $r8.<org.jline.utils.StyleResolver: void <init>(java.util.function.Function)>($r10);	return $r8
;block_num 1