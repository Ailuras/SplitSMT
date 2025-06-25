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

(declare-sort var1624 0)
(declare-sort var2443 0)
(declare-sort var109 0)
(declare-sort var3375 0)
(declare-sort var2734 0)
(declare-sort var62 0)
(declare-sort var2442 0)
(declare-sort var3237 0)
(declare-sort var2697 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var109) void)
(declare-fun cast-from-var1624-to-var109 (var1624) var109)
(declare-fun var3375-init () var3375)
(declare-fun <init>/-201242697 (var3375) void)
(declare-fun cast-from-var3375-to-var2734 (var3375) var2734)
(declare-fun optSet/1728320026 (var1624) var2734)
(declare-fun optArg/1728320026 (var1624) var2734)
(declare-fun optName/1728320026 (var1624) var2734)
(declare-fun optAlias/1728320026 (var1624) var2734)
(declare-fun var62-init () var62)
(declare-fun <init>/-325640736 (var62) void)
(declare-fun cast-from-var62-to-var2442 (var62) var2442)
(declare-fun xargs/1728320026 (var1624) var2442)
(declare-fun args/1728320026 (var1624) var2442)
(declare-fun usageName/1728320026 (var1624) String)
(declare-fun usageIndex/1728320026 (var1624) Int)
(declare-fun error/1728320026 (var1624) String)
(declare-fun optionsFirst/1728320026 (var1624) Bool)
(declare-fun stopOnBadOption/1728320026 (var1624) Bool)
(declare-fun gspec/1728320026 (var1624) (Array Int String))
(declare-fun spec/1728320026 (var1624) (Array Int String))
(declare-fun parseSpec/-1959083625 (var1624 var2734 var2734) void)
(declare-fun var2697_unmodifiableMap/-1864031675 (var2734) var2734)
(declare-fun unmodifiableOptSet/1728320026 (var1624) var2734)
(declare-fun unmodifiableOptArg/1728320026 (var1624) var2734)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun toUpperCase/1156088314 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2443_apply/533941847 (var2443 var109) var109)
(declare-fun cast-from-String-to-var109 (String) var109)
(declare-fun cast-from-var109-to-String (var109) String)
(declare-fun defOpts/1728320026 (var1624) String)
(declare-fun defArgs/1728320026 (var1624) (Array Int String))
(declare-const null-var1624 var1624)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var2443 var2443)
(declare-const null-var2442 var2442)
(declare-const null-String String)
(declare-const var1277 var1624) ; Statement: r0 := @this: org.jline.builtins.Options 
(assert (not (= var1277 null-var1624)))
(declare-const var1142 (Array Int String)) ; Statement: r8 := @parameter0: java.lang.String[] 
(assert (not (= var1142 null-__Array__Int__String__)))
(declare-const var1047 (Array Int String)) ; Statement: r6 := @parameter1: java.lang.String[] 
(assert (not (= var1047 null-__Array__Int__String__)))
(declare-const var3444 var1624) ; Statement: r10 := @parameter2: org.jline.builtins.Options 
(assert (not (= var3444 null-var1624)))
(declare-const var102 var2443) ; Statement: r17 := @parameter3: java.util.function.Function 
(assert (not (= var102 null-var2443)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1624-to-var109 var1277))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1277!1 var1624)
(define-const var1525 var3375 var3375-init) ; Statement: $r1 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1525)) ; Statement: specialinvoke $r1.<java.util.HashMap: void <init>()>() 

(declare-const var1525!1 var3375)
(declare-const var1277!2 var1624)
(assert (not (= var1277!2 null-var1624)))
(assert (= (optSet/1728320026 var1277!2) (cast-from-var3375-to-var2734 var1525!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.Map optSet> = $r1 
(define-const var2559 var3375 var3375-init) ; Statement: $r2 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2559)) ; Statement: specialinvoke $r2.<java.util.HashMap: void <init>()>() 

(declare-const var2559!1 var3375)
(declare-const var1277!3 var1624)
(assert (not (= var1277!3 null-var1624)))
(assert (= (optArg/1728320026 var1277!3) (cast-from-var3375-to-var2734 var2559!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.Map optArg> = $r2 
(define-const var1733 var3375 var3375-init) ; Statement: $r3 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1733)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>()>() 

(declare-const var1733!1 var3375)
(declare-const var1277!4 var1624)
(assert (not (= var1277!4 null-var1624)))
(assert (= (optName/1728320026 var1277!4) (cast-from-var3375-to-var2734 var1733!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.Map optName> = $r3 
(define-const var3549 var3375 var3375-init) ; Statement: $r4 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3549)) ; Statement: specialinvoke $r4.<java.util.HashMap: void <init>()>() 

(declare-const var3549!1 var3375)
(declare-const var1277!5 var1624)
(assert (not (= var1277!5 null-var1624)))
(assert (= (optAlias/1728320026 var1277!5) (cast-from-var3375-to-var2734 var3549!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.Map optAlias> = $r4 
(define-const var2132 var62 var62-init) ; Statement: $r5 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2132)) ; Statement: specialinvoke $r5.<java.util.ArrayList: void <init>()>() 

(declare-const var2132!1 var62)
(declare-const var1277!6 var1624)
(assert (not (= var1277!6 null-var1624)))
(assert (= (xargs/1728320026 var1277!6) (cast-from-var62-to-var2442 var2132!1))) ; Statement: r0.<org.jline.builtins.Options: java.util.List xargs> = $r5 
(declare-const var1277!7 var1624)
(assert (not (= var1277!7 null-var1624)))
(assert (= (args/1728320026 var1277!7) null-var2442)) ; Statement: r0.<org.jline.builtins.Options: java.util.List args> = null 
(declare-const var1277!8 var1624)
(assert (not (= var1277!8 null-var1624)))
(assert (= (usageName/1728320026 var1277!8) "unknown")) ; Statement: r0.<org.jline.builtins.Options: java.lang.String usageName> = "unknown" 
(declare-const var1277!9 var1624)
(assert (not (= var1277!9 null-var1624)))
(assert (= (usageIndex/1728320026 var1277!9) 0)) ; Statement: r0.<org.jline.builtins.Options: int usageIndex> = 0 
(declare-const var1277!10 var1624)
(assert (not (= var1277!10 null-var1624)))
(assert (= (error/1728320026 var1277!10) null-String)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String error> = null 
(declare-const var1277!11 var1624)
(assert (not (= var1277!11 null-var1624)))
(assert (= (optionsFirst/1728320026 var1277!11) (ite (= 1 0) true false))) ; Statement: r0.<org.jline.builtins.Options: boolean optionsFirst> = 0 
(declare-const var1277!12 var1624)
(assert (not (= var1277!12 null-var1624)))
(assert (= (stopOnBadOption/1728320026 var1277!12) (ite (= 1 0) true false))) ; Statement: r0.<org.jline.builtins.Options: boolean stopOnBadOption> = 0 
(declare-const var1277!13 var1624)
(assert (not (= var1277!13 null-var1624)))
(assert (= (gspec/1728320026 var1277!13) var1047)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String[] gspec> = r6 
 ; Statement: if r6 != null goto $r7 = new java.util.ArrayList 
(assert (not (not (= var1047 null-__Array__Int__String__)))) ; Negate: Cond: r6 != null  
 ; Statement: if r10 != null goto $r7 = new java.util.ArrayList 
(assert (not (not (= var3444 null-var1624)))) ; Negate: Cond: r10 != null  
(declare-const var1277!14 var1624)
(assert (not (= var1277!14 null-var1624)))
(assert (= (spec/1728320026 var1277!14) var1142)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String[] spec> = r8 
 ; Statement: goto [?= $r43 = new java.util.HashMap] 
(assert true) ; Non Conditional
(define-const var2510 var3375 var3375-init) ; Statement: $r43 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2510)) ; Statement: specialinvoke $r43.<java.util.HashMap: void <init>()>() 

(declare-const var2510!1 var3375)
(define-const var3083 var3375 var3375-init) ; Statement: $r44 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3083)) ; Statement: specialinvoke $r44.<java.util.HashMap: void <init>()>() 

(declare-const var3083!1 var3375)
(assert true)
;(assert (parseSpec/-1959083625 var1277!14 (cast-from-var3375-to-var2734 var2510!1) (cast-from-var3375-to-var2734 var3083!1))) ; Statement: specialinvoke r0.<org.jline.builtins.Options: void parseSpec(java.util.Map,java.util.Map)>($r43, $r44) 

(declare-const var1277!15 var1624)
(declare-const var2510!2 var3375)
(declare-const var3083!2 var3375)
 ; Statement: if r10 == null goto $r15 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r43) 
(assert (= var3444 null-var1624)) ; Cond: r10 == null 
(define-const var3234 var2734 (var2697_unmodifiableMap/-1864031675 (cast-from-var3375-to-var2734 var2510!2))) ; Statement: $r15 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r43) 
(declare-const var1277!16 var1624)
(assert (not (= var1277!16 null-var1624)))
(assert (= (unmodifiableOptSet/1728320026 var1277!16) var3234)) ; Statement: r0.<org.jline.builtins.Options: java.util.Map unmodifiableOptSet> = $r15 
(define-const var1086 var2734 (var2697_unmodifiableMap/-1864031675 (cast-from-var3375-to-var2734 var3083!2))) ; Statement: $r16 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r44) 
(declare-const var1277!17 var1624)
(assert (not (= var1277!17 null-var1624)))
(assert (= (unmodifiableOptArg/1728320026 var1277!17) var1086)) ; Statement: r0.<org.jline.builtins.Options: java.util.Map unmodifiableOptArg> = $r16 
 ; Statement: if r17 == null goto $r49 = null 
(assert (not (= var102 null-var2443))) ; Negate: Cond: r17 == null  
(define-const var3948 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3948)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3948!1 String)
(assert (= var3948!1 ""))
(define-const var1117 String (usageName/1728320026 var1277!17)) ; Statement: $r21 = r0.<org.jline.builtins.Options: java.lang.String usageName> 
(assert true)
(define-const var1880 String (toUpperCase/1156088314 var1117)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var1762 String (append/672562846 var3948!1 var1880)) ; Statement: $r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var3948!2 String)
(assert (= var3948!2 (str.++ var3948!1 var1880)))
(assert true)
(define-const var3033 String (append/672562846 var1762 "_OPTS")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("_OPTS") 
(declare-const var1762!1 String)
(assert (= var1762!1 (str.++ var1762 "_OPTS")))
(assert true)
(define-const var3228 String (toString/-2075883882 var3033)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var454 var109 (var2443_apply/533941847 var102 (cast-from-String-to-var109 var3228))) ; Statement: $r26 = interfaceinvoke r17.<java.util.function.Function: java.lang.Object apply(java.lang.Object)>($r25) 
(define-const var1516 String (cast-from-var109-to-String var454)) ; Statement: $r49 = (java.lang.String) $r26 
 ; Statement: goto [?= r0.<org.jline.builtins.Options: java.lang.String defOpts> = $r49] 
(assert true) ; Non Conditional
(declare-const var1277!18 var1624)
(assert (not (= var1277!18 null-var1624)))
(assert (= (defOpts/1728320026 var1277!18) var1516)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String defOpts> = $r49 
(define-const var1031 String (defOpts/1728320026 var1277!18)) ; Statement: $r18 = r0.<org.jline.builtins.Options: java.lang.String defOpts> 
 ; Statement: if $r18 == null goto $r50 = newarray (java.lang.String)[0] 
(assert (not (= var1031 null-String))) ; Negate: Cond: $r18 == null  
(define-const var177 String (defOpts/1728320026 var1277!18)) ; Statement: $r19 = r0.<org.jline.builtins.Options: java.lang.String defOpts> 
; split operation: var3663 = var177.split("\u005cs+") ; Statement: $r50 = virtualinvoke $r19.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
 ; Statement: goto [?= r0.<org.jline.builtins.Options: java.lang.String[] defArgs> = $r50] 
(assert true) ; Non Conditional
(declare-const var1277!19 var1624)
(assert (not (= var1277!19 null-var1624)))
(assert (= (defArgs/1728320026 var1277!19) var3663)) ; Statement: r0.<org.jline.builtins.Options: java.lang.String[] defArgs> = $r50 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1624-to-var109=([org.jline.builtins.Options], java.lang.Object), var3375-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var3375-to-var2734=([java.util.HashMap], java.util.Map), optSet/1728320026=([org.jline.builtins.Options], java.util.Map), optArg/1728320026=([org.jline.builtins.Options], java.util.Map), optName/1728320026=([org.jline.builtins.Options], java.util.Map), optAlias/1728320026=([org.jline.builtins.Options], java.util.Map), var62-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var62-to-var2442=([java.util.ArrayList], java.util.List), xargs/1728320026=([org.jline.builtins.Options], java.util.List), args/1728320026=([org.jline.builtins.Options], java.util.List), usageName/1728320026=([org.jline.builtins.Options], java.lang.String), usageIndex/1728320026=([org.jline.builtins.Options], int), error/1728320026=([org.jline.builtins.Options], java.lang.String), optionsFirst/1728320026=([org.jline.builtins.Options], boolean), stopOnBadOption/1728320026=([org.jline.builtins.Options], boolean), gspec/1728320026=([org.jline.builtins.Options], java.lang.String[]), spec/1728320026=([org.jline.builtins.Options], java.lang.String[]), parseSpec/-1959083625=([org.jline.builtins.Options, java.util.Map, java.util.Map], void), var2697_unmodifiableMap/-1864031675=([java.util.Map], java.util.Map), unmodifiableOptSet/1728320026=([org.jline.builtins.Options], java.util.Map), unmodifiableOptArg/1728320026=([org.jline.builtins.Options], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toUpperCase/1156088314=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2443_apply/533941847=([java.util.function.Function, java.lang.Object], java.lang.Object), cast-from-String-to-var109=([java.lang.String], java.lang.Object), cast-from-var109-to-String=([java.lang.Object], java.lang.String), defOpts/1728320026=([org.jline.builtins.Options], java.lang.String), defArgs/1728320026=([org.jline.builtins.Options], java.lang.String[])}
; {var1624=org.jline.builtins.Options, var1277=r0, var1142=r8, var1047=r6, var3444=r10, var2443=java.util.function.Function, var102=r17, var109=java.lang.Object, var3375=java.util.HashMap, var1525=$r1, var2734=java.util.Map, var2559=$r2, var1733=$r3, var3549=$r4, var62=java.util.ArrayList, var2132=$r5, var2442=java.util.List, var3237=null_type, var2510=$r43, var3083=$r44, var2697=java.util.Collections, var3234=$r15, var1086=$r16, var3948=$r20, var1117=$r21, var1880=$r22, var1762=$r23, var3033=$r24, var3228=$r25, var454=$r26, var1516=$r49, var1031=$r18, var177=$r19, var3663=$r50}
; {org.jline.builtins.Options=var1624, r0=var1277, r8=var1142, r6=var1047, r10=var3444, java.util.function.Function=var2443, r17=var102, java.lang.Object=var109, java.util.HashMap=var3375, $r1=var1525, java.util.Map=var2734, $r2=var2559, $r3=var1733, $r4=var3549, java.util.ArrayList=var62, $r5=var2132, java.util.List=var2442, null_type=var3237, $r43=var2510, $r44=var3083, java.util.Collections=var2697, $r15=var3234, $r16=var1086, $r20=var3948, $r21=var1117, $r22=var1880, $r23=var1762, $r24=var3033, $r25=var3228, $r26=var454, $r49=var1516, $r18=var1031, $r19=var177, $r50=var3663}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String toUpperCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.jline.builtins.Options;	r8 := @parameter0: java.lang.String[];	r6 := @parameter1: java.lang.String[];	r10 := @parameter2: org.jline.builtins.Options;	r17 := @parameter3: java.util.function.Function;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.HashMap;	specialinvoke $r1.<java.util.HashMap: void <init>()>();	r0.<org.jline.builtins.Options: java.util.Map optSet> = $r1;	$r2 = new java.util.HashMap;	specialinvoke $r2.<java.util.HashMap: void <init>()>();	r0.<org.jline.builtins.Options: java.util.Map optArg> = $r2;	$r3 = new java.util.HashMap;	specialinvoke $r3.<java.util.HashMap: void <init>()>();	r0.<org.jline.builtins.Options: java.util.Map optName> = $r3;	$r4 = new java.util.HashMap;	specialinvoke $r4.<java.util.HashMap: void <init>()>();	r0.<org.jline.builtins.Options: java.util.Map optAlias> = $r4;	$r5 = new java.util.ArrayList;	specialinvoke $r5.<java.util.ArrayList: void <init>()>();	r0.<org.jline.builtins.Options: java.util.List xargs> = $r5;	r0.<org.jline.builtins.Options: java.util.List args> = null;	r0.<org.jline.builtins.Options: java.lang.String usageName> = "unknown";	r0.<org.jline.builtins.Options: int usageIndex> = 0;	r0.<org.jline.builtins.Options: java.lang.String error> = null;	r0.<org.jline.builtins.Options: boolean optionsFirst> = 0;	r0.<org.jline.builtins.Options: boolean stopOnBadOption> = 0;	r0.<org.jline.builtins.Options: java.lang.String[] gspec> = r6;	if r6 != null goto $r7 = new java.util.ArrayList;	if r10 != null goto $r7 = new java.util.ArrayList;	r0.<org.jline.builtins.Options: java.lang.String[] spec> = r8;	goto [?= $r43 = new java.util.HashMap];	$r43 = new java.util.HashMap;	specialinvoke $r43.<java.util.HashMap: void <init>()>();	$r44 = new java.util.HashMap;	specialinvoke $r44.<java.util.HashMap: void <init>()>();	specialinvoke r0.<org.jline.builtins.Options: void parseSpec(java.util.Map,java.util.Map)>($r43, $r44);	if r10 == null goto $r15 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r43);	$r15 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r43);	r0.<org.jline.builtins.Options: java.util.Map unmodifiableOptSet> = $r15;	$r16 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r44);	r0.<org.jline.builtins.Options: java.util.Map unmodifiableOptArg> = $r16;	if r17 == null goto $r49 = null;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r21 = r0.<org.jline.builtins.Options: java.lang.String usageName>;	$r22 = virtualinvoke $r21.<java.lang.String: java.lang.String toUpperCase()>();	$r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("_OPTS");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	$r26 = interfaceinvoke r17.<java.util.function.Function: java.lang.Object apply(java.lang.Object)>($r25);	$r49 = (java.lang.String) $r26;	goto [?= r0.<org.jline.builtins.Options: java.lang.String defOpts> = $r49];	r0.<org.jline.builtins.Options: java.lang.String defOpts> = $r49;	$r18 = r0.<org.jline.builtins.Options: java.lang.String defOpts>;	if $r18 == null goto $r50 = newarray (java.lang.String)[0];	$r19 = r0.<org.jline.builtins.Options: java.lang.String defOpts>;	$r50 = virtualinvoke $r19.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	goto [?= r0.<org.jline.builtins.Options: java.lang.String[] defArgs> = $r50];	r0.<org.jline.builtins.Options: java.lang.String[] defArgs> = $r50;	return
;block_num 9