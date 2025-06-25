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

(declare-sort var2505 0)
(declare-sort var2969 0)
(declare-sort var791 0)
(declare-sort var2981 0)
(declare-sort var2305 0)
(declare-sort var2801 0)
(declare-sort var2899 0)
(declare-sort var3283 0)
(declare-sort var2484 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var791) void)
(declare-fun cast-from-var2505-to-var791 (var2505) var791)
(declare-fun var2981-init () var2981)
(declare-fun <init>/-201242697 (var2981) void)
(declare-fun cast-from-var2981-to-var2305 (var2981) var2305)
(declare-fun optSet/1728320026 (var2505) var2305)
(declare-fun optArg/1728320026 (var2505) var2305)
(declare-fun optName/1728320026 (var2505) var2305)
(declare-fun optAlias/1728320026 (var2505) var2305)
(declare-fun var2801-init () var2801)
(declare-fun <init>/-325640736 (var2801) void)
(declare-fun cast-from-var2801-to-var2899 (var2801) var2899)
(declare-fun xargs/1728320026 (var2505) var2899)
(declare-fun args/1728320026 (var2505) var2899)
(declare-fun usageName/1728320026 (var2505) String)
(declare-fun usageIndex/1728320026 (var2505) Int)
(declare-fun error/1728320026 (var2505) String)
(declare-fun optionsFirst/1728320026 (var2505) Bool)
(declare-fun stopOnBadOption/1728320026 (var2505) Bool)
(declare-fun gspec/1728320026 (var2505) (Array Int String))
(declare-fun spec/1728320026 (var2505) (Array Int String))
(declare-fun parseSpec/-1959083625 (var2505 var2305 var2305) void)
(declare-fun var2484_unmodifiableMap/-1864031675 (var2305) var2305)
(declare-fun unmodifiableOptSet/1728320026 (var2505) var2305)
(declare-fun unmodifiableOptArg/1728320026 (var2505) var2305)
(declare-fun defOpts/1728320026 (var2505) String)
(declare-fun defArgs/1728320026 (var2505) (Array Int String))
(declare-const null-var2505 var2505)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var2969 var2969)
(declare-const null-var2899 var2899)
(declare-const null-String String)
(declare-const var1903 var2505) ; Statement: r0 := @this: org.jline.builtins.Options 
(assert (not (= var1903 null-var2505)))
(declare-const var3296 (Array Int String)) ; Statement: r8 := @parameter0: java.lang.String[] 
(assert (not (= var3296 null-__Array__Int__String__)))
(declare-const var616 (Array Int String)) ; Statement: r6 := @parameter1: java.lang.String[] 
(assert (not (= var616 null-__Array__Int__String__)))
(declare-const var1865 var2505) ; Statement: r10 := @parameter2: org.jline.builtins.Options 
(assert (not (= var1865 null-var2505)))
(declare-const var3407 var2969) ; Statement: r17 := @parameter3: java.util.function.Function 
(assert (not (= var3407 null-var2969)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2505-to-var791 var1903))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1903!1 var2505)
(define-const var1320 var2981 var2981-init) ; Statement: $r1 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1320)) ; Statement: specialinvoke $r1.<java.util.HashMap: void <init>()>() 

(declare-const var1320!1 var2981)
(declare-const var1903!2 var2505)
(assert (not (= var1903!2 null-var2505)))
(assert (= (optSet/1728320026 var1903!2) (cast-from-var2981-to-var2305 var1320!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.Map optSet> = $r1 
(define-const var1801 var2981 var2981-init) ; Statement: $r2 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1801)) ; Statement: specialinvoke $r2.<java.util.HashMap: void <init>()>() 

(declare-const var1801!1 var2981)
(declare-const var1903!3 var2505)
(assert (not (= var1903!3 null-var2505)))
(assert (= (optArg/1728320026 var1903!3) (cast-from-var2981-to-var2305 var1801!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.Map optArg> = $r2 
(define-const var1652 var2981 var2981-init) ; Statement: $r3 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1652)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>()>() 

(declare-const var1652!1 var2981)
(declare-const var1903!4 var2505)
(assert (not (= var1903!4 null-var2505)))
(assert (= (optName/1728320026 var1903!4) (cast-from-var2981-to-var2305 var1652!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.Map optName> = $r3 
(define-const var2602 var2981 var2981-init) ; Statement: $r4 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2602)) ; Statement: specialinvoke $r4.<java.util.HashMap: void <init>()>() 

(declare-const var2602!1 var2981)
(declare-const var1903!5 var2505)
(assert (not (= var1903!5 null-var2505)))
(assert (= (optAlias/1728320026 var1903!5) (cast-from-var2981-to-var2305 var2602!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.Map optAlias> = $r4 
(define-const var802 var2801 var2801-init) ; Statement: $r5 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var802)) ; Statement: specialinvoke $r5.<java.util.ArrayList: void <init>()>() 

(declare-const var802!1 var2801)
(declare-const var1903!6 var2505)
(assert (not (= var1903!6 null-var2505)))
(assert (= (xargs/1728320026 var1903!6) (cast-from-var2801-to-var2899 var802!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.List xargs> = $r5 
(declare-const var1903!7 var2505)
(assert (not (= var1903!7 null-var2505)))
(assert (= (args/1728320026 var1903!7) null-var2899)) ; Statement: r0.<org.jline.builtins.Options: java.util.List args> = null 
(declare-const var1903!8 var2505)
(assert (not (= var1903!8 null-var2505)))
(assert (= (usageName/1728320026 var1903!8) "unknown")) ; Statement: r0.<org.jline.builtins.Options: java.lang.String usageName> = "unknown" 
(declare-const var1903!9 var2505)
(assert (not (= var1903!9 null-var2505)))
(assert (= (usageIndex/1728320026 var1903!9) 0)) ; Statement: r0.<org.jline.builtins.Options: int usageIndex> = 0 
(declare-const var1903!10 var2505)
(assert (not (= var1903!10 null-var2505)))
(assert (= (error/1728320026 var1903!10) null-String)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String error> = null 
(declare-const var1903!11 var2505)
(assert (not (= var1903!11 null-var2505)))
(assert (= (optionsFirst/1728320026 var1903!11) (ite (= 1 0) true false))) ; Statement: r0.<org.jline.builtins.Options: boolean optionsFirst> = 0 
(declare-const var1903!12 var2505)
(assert (not (= var1903!12 null-var2505)))
(assert (= (stopOnBadOption/1728320026 var1903!12) (ite (= 1 0) true false))) ; Statement: r0.<org.jline.builtins.Options: boolean stopOnBadOption> = 0 
(declare-const var1903!13 var2505)
(assert (not (= var1903!13 null-var2505)))
(assert (= (gspec/1728320026 var1903!13) var616)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String[] gspec> = r6 
 ; Statement: if r6 != null goto $r7 = new java.util.ArrayList 
(assert (not (not (= var616 null-__Array__Int__String__)))) ; Negate: Cond: r6 != null  
 ; Statement: if r10 != null goto $r7 = new java.util.ArrayList 
(assert (not (not (= var1865 null-var2505)))) ; Negate: Cond: r10 != null  
(declare-const var1903!14 var2505)
(assert (not (= var1903!14 null-var2505)))
(assert (= (spec/1728320026 var1903!14) var3296)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String[] spec> = r8 
 ; Statement: goto [?= $r43 = new java.util.HashMap] 
(assert true) ; Non Conditional
(define-const var843 var2981 var2981-init) ; Statement: $r43 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var843)) ; Statement: specialinvoke $r43.<java.util.HashMap: void <init>()>() 

(declare-const var843!1 var2981)
(define-const var3568 var2981 var2981-init) ; Statement: $r44 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3568)) ; Statement: specialinvoke $r44.<java.util.HashMap: void <init>()>() 

(declare-const var3568!1 var2981)
(assert true)
;(assert (parseSpec/-1959083625 var1903!14 (cast-from-var2981-to-var2305 var843!1) (cast-from-var2981-to-var2305 var3568!1))) ; Statement: specialinvoke r0.<org.jline.builtins.Options: void parseSpec(java.util.Map,java.util.Map)>($r43, $r44) 

(declare-const var1903!15 var2505)
(declare-const var843!2 var2981)
(declare-const var3568!2 var2981)
 ; Statement: if r10 == null goto $r15 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r43) 
(assert (= var1865 null-var2505)) ; Cond: r10 == null 
(define-const var763 var2305 (var2484_unmodifiableMap/-1864031675 (cast-from-var2981-to-var2305 var843!2))) ; Statement: $r15 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r43) 
(declare-const var1903!16 var2505)
(assert (not (= var1903!16 null-var2505)))
(assert (= (unmodifiableOptSet/1728320026 var1903!16) var763)) ; Statement: r0.<org.jline.builtins.Options: java.util.Map unmodifiableOptSet> = $r15 
(define-const var1485 var2305 (var2484_unmodifiableMap/-1864031675 (cast-from-var2981-to-var2305 var3568!2))) ; Statement: $r16 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r44) 
(declare-const var1903!17 var2505)
(assert (not (= var1903!17 null-var2505)))
(assert (= (unmodifiableOptArg/1728320026 var1903!17) var1485)) ; Statement: r0.<org.jline.builtins.Options: java.util.Map unmodifiableOptArg> = $r16 
 ; Statement: if r17 == null goto $r49 = null 
(assert (= var3407 null-var2969)) ; Cond: r17 == null 
(define-const var3452 String null-String) ; Statement: $r49 = null 
(assert true) ; Non Conditional
(declare-const var1903!18 var2505)
(assert (not (= var1903!18 null-var2505)))
(assert (= (defOpts/1728320026 var1903!18) var3452)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String defOpts> = $r49 
(define-const var3189 String (defOpts/1728320026 var1903!18)) ; Statement: $r18 = r0.<org.jline.builtins.Options: java.lang.String defOpts> 
 ; Statement: if $r18 == null goto $r50 = newarray (java.lang.String)[0] 
(assert (not (= var3189 null-String))) ; Negate: Cond: $r18 == null  
(define-const var3169 String (defOpts/1728320026 var1903!18)) ; Statement: $r19 = r0.<org.jline.builtins.Options: java.lang.String defOpts> 
; split operation: var3421 = var3169.split("\u005cs+") ; Statement: $r50 = virtualinvoke $r19.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
 ; Statement: goto [?= r0.<org.jline.builtins.Options: java.lang.String[] defArgs> = $r50] 
(assert true) ; Non Conditional
(declare-const var1903!19 var2505)
(assert (not (= var1903!19 null-var2505)))
(assert (= (defArgs/1728320026 var1903!19) var3421)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String[] defArgs> = $r50 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2505-to-var791=([org.jline.builtins.Options], java.lang.Object), var2981-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var2981-to-var2305=([java.util.HashMap], java.util.Map), optSet/1728320026=([org.jline.builtins.Options], java.util.Map), optArg/1728320026=([org.jline.builtins.Options], java.util.Map), optName/1728320026=([org.jline.builtins.Options], java.util.Map), optAlias/1728320026=([org.jline.builtins.Options], java.util.Map), var2801-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var2801-to-var2899=([java.util.ArrayList], java.util.List), xargs/1728320026=([org.jline.builtins.Options], java.util.List), args/1728320026=([org.jline.builtins.Options], java.util.List), usageName/1728320026=([org.jline.builtins.Options], java.lang.String), usageIndex/1728320026=([org.jline.builtins.Options], int), error/1728320026=([org.jline.builtins.Options], java.lang.String), optionsFirst/1728320026=([org.jline.builtins.Options], boolean), stopOnBadOption/1728320026=([org.jline.builtins.Options], boolean), gspec/1728320026=([org.jline.builtins.Options], java.lang.String[]), spec/1728320026=([org.jline.builtins.Options], java.lang.String[]), parseSpec/-1959083625=([org.jline.builtins.Options, java.util.Map, java.util.Map], void), var2484_unmodifiableMap/-1864031675=([java.util.Map], java.util.Map), unmodifiableOptSet/1728320026=([org.jline.builtins.Options], java.util.Map), unmodifiableOptArg/1728320026=([org.jline.builtins.Options], java.util.Map), defOpts/1728320026=([org.jline.builtins.Options], java.lang.String), defArgs/1728320026=([org.jline.builtins.Options], java.lang.String[])}
; {var2505=org.jline.builtins.Options, var1903=r0, var3296=r8, var616=r6, var1865=r10, var2969=java.util.function.Function, var3407=r17, var791=java.lang.Object, var2981=java.util.HashMap, var1320=$r1, var2305=java.util.Map, var1801=$r2, var1652=$r3, var2602=$r4, var2801=java.util.ArrayList, var802=$r5, var2899=java.util.List, var3283=null_type, var843=$r43, var3568=$r44, var2484=java.util.Collections, var763=$r15, var1485=$r16, var3452=$r49, var3189=$r18, var3169=$r19, var3421=$r50}
; {org.jline.builtins.Options=var2505, r0=var1903, r8=var3296, r6=var616, r10=var1865, java.util.function.Function=var2969, r17=var3407, java.lang.Object=var791, java.util.HashMap=var2981, $r1=var1320, java.util.Map=var2305, $r2=var1801, $r3=var1652, $r4=var2602, java.util.ArrayList=var2801, $r5=var802, java.util.List=var2899, null_type=var3283, $r43=var843, $r44=var3568, java.util.Collections=var2484, $r15=var763, $r16=var1485, $r49=var3452, $r18=var3189, $r19=var3169, $r50=var3421}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.jline.builtins.Options;	r8 := @parameter0: java.lang.String[];	r6 := @parameter1: java.lang.String[];	r10 := @parameter2: org.jline.builtins.Options;	r17 := @parameter3: java.util.function.Function;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.HashMap;	specialinvoke $r1.<java.util.HashMap: void <init>()>();	r0.<org.jline.builtins.Options: java.util.Map optSet> = $r1;	$r2 = new java.util.HashMap;	specialinvoke $r2.<java.util.HashMap: void <init>()>();	r0.<org.jline.builtins.Options: java.util.Map optArg> = $r2;	$r3 = new java.util.HashMap;	specialinvoke $r3.<java.util.HashMap: void <init>()>();	r0.<org.jline.builtins.Options: java.util.Map optName> = $r3;	$r4 = new java.util.HashMap;	specialinvoke $r4.<java.util.HashMap: void <init>()>();	r0.<org.jline.builtins.Options: java.util.Map optAlias> = $r4;	$r5 = new java.util.ArrayList;	specialinvoke $r5.<java.util.ArrayList: void <init>()>();	r0.<org.jline.builtins.Options: java.util.List xargs> = $r5;	r0.<org.jline.builtins.Options: java.util.List args> = null;	r0.<org.jline.builtins.Options: java.lang.String usageName> = "unknown";	r0.<org.jline.builtins.Options: int usageIndex> = 0;	r0.<org.jline.builtins.Options: java.lang.String error> = null;	r0.<org.jline.builtins.Options: boolean optionsFirst> = 0;	r0.<org.jline.builtins.Options: boolean stopOnBadOption> = 0;	r0.<org.jline.builtins.Options: java.lang.String[] gspec> = r6;	if r6 != null goto $r7 = new java.util.ArrayList;	if r10 != null goto $r7 = new java.util.ArrayList;	r0.<org.jline.builtins.Options: java.lang.String[] spec> = r8;	goto [?= $r43 = new java.util.HashMap];	$r43 = new java.util.HashMap;	specialinvoke $r43.<java.util.HashMap: void <init>()>();	$r44 = new java.util.HashMap;	specialinvoke $r44.<java.util.HashMap: void <init>()>();	specialinvoke r0.<org.jline.builtins.Options: void parseSpec(java.util.Map,java.util.Map)>($r43, $r44);	if r10 == null goto $r15 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r43);	$r15 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r43);	r0.<org.jline.builtins.Options: java.util.Map unmodifiableOptSet> = $r15;	$r16 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r44);	r0.<org.jline.builtins.Options: java.util.Map unmodifiableOptArg> = $r16;	if r17 == null goto $r49 = null;	$r49 = null;	r0.<org.jline.builtins.Options: java.lang.String defOpts> = $r49;	$r18 = r0.<org.jline.builtins.Options: java.lang.String defOpts>;	if $r18 == null goto $r50 = newarray (java.lang.String)[0];	$r19 = r0.<org.jline.builtins.Options: java.lang.String defOpts>;	$r50 = virtualinvoke $r19.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	goto [?= r0.<org.jline.builtins.Options: java.lang.String[] defArgs> = $r50];	r0.<org.jline.builtins.Options: java.lang.String[] defArgs> = $r50;	return
;block_num 9