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

(declare-sort var1734 0)
(declare-sort var1027 0)
(declare-sort var1072 0)
(declare-sort var2971 0)
(declare-sort var3928 0)
(declare-sort var1758 0)
(declare-sort var234 0)
(declare-sort var1849 0)
(declare-sort var3843 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun dupTree/-239505906 (var1072) var1072)
(declare-fun cast-from-var1027-to-var1072 (var1027) var1072)
(declare-fun cast-from-var1072-to-var1027 (var1072) var1027)
(declare-fun altLabel/-134158986 (var1027) var1072)
(declare-fun getText/1230265107 (var2971) String)
(declare-fun cast-from-var1072-to-var2971 (var1072) var2971)
(declare-fun stripLeftRecursion/-314147500 (var1734 var1072) var1072)
(declare-fun stripAltLabel/568044820 (var1734 var1072) void)
(declare-fun nextPrecedence/579164756 (var1734 Int) Int)
(declare-fun addPrecedenceArgToRules/-2101804795 (var1734 var1027 Int) var1027)
(declare-fun text/779296631 (var1734 var1072) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1758-init () var1758)
(declare-fun <init>/64382128 (var1758 Int String String String Bool var1027) void)
(declare-fun nextPrec/92480221 (var1758) Int)
(declare-fun binaryAlts/-164356992 (var1734) var234)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun put/-1127386829 (var1849 var3843 var3843) var3843)
(declare-fun cast-from-var234-to-var1849 (var234) var1849)
(declare-fun cast-from-Int-to-var3843 (Int) var3843)
(declare-fun cast-from-var1758-to-var3843 (var1758) var3843)
(declare-const null-var1734 var1734)
(declare-const null-var1027 var1027)
(declare-const null-Int Int)
(declare-const null-var1072 var1072)
(declare-const null-String String)
(declare-const null-var1758 var1758)
(declare-const var2605 var1734) ; Statement: r4 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer 
(assert (not (= var2605 null-var1734)))
(declare-const var3252 var1027) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.AltAST 
(assert (not (= var3252 null-var1027)))
(declare-const var3393 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3393 null-Int)))
(assert true)
(define-const var2780 var1072 (dupTree/-239505906 (cast-from-var1027-to-var1072 var3252))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>() 
(define-const var2506 var1027 (cast-from-var1072-to-var1027 var2780)) ; Statement: r10 = (org.antlr.v4.tool.ast.AltAST) $r1 
(define-const var445 var1072 (altLabel/-134158986 var2506)) ; Statement: $r2 = r10.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
 ; Statement: if $r2 == null goto $r11 = null 
(assert (not (= var445 null-var1072))) ; Negate: Cond: $r2 == null  
(define-const var1853 var1072 (altLabel/-134158986 var2506)) ; Statement: $r8 = r10.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
(assert true)
(define-const var2465 String (getText/1230265107 (cast-from-var1072-to-var2971 var1853))) ; Statement: $r11 = virtualinvoke $r8.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
 ; Statement: goto [?= r3 = $r11] 
(assert true) ; Non Conditional
(define-const var2365 String var2465) ; Statement: r3 = $r11 
(define-const var3663 String null-String) ; Statement: r12 = null 
(define-const var2583 Bool (ite (= 1 0) true false)) ; Statement: z0 = 0 
(assert true)
(define-const var2411 var1072 (stripLeftRecursion/-314147500 var2605 (cast-from-var1027-to-var1072 var2506))) ; Statement: $r9 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.GrammarAST stripLeftRecursion(org.antlr.v4.tool.ast.GrammarAST)>(r10) 
 ; Statement: if $r9 == null goto virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r10) 
(assert (= var2411 null-var1072)) ; Cond: $r9 == null 
(assert true)
;(assert (stripAltLabel/568044820 var2605 (cast-from-var1027-to-var1072 var2506))) ; Statement: virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r10) 

(declare-const var2605!1 var1734)
(declare-const var2506!1 var1027)
(assert true)
(define-const var3027 Int (nextPrecedence/579164756 var2605!1 var3393)) ; Statement: $i2 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: int nextPrecedence(int)>(i0) 
(assert true)
(define-const var1712 var1027 (addPrecedenceArgToRules/-2101804795 var2605!1 var2506!1 var3027)) ; Statement: $r13 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.AltAST addPrecedenceArgToRules(org.antlr.v4.tool.ast.AltAST,int)>(r10, $i2) 
(assert true)
;(assert (stripAltLabel/568044820 var2605!1 (cast-from-var1027-to-var1072 var1712))) ; Statement: virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>($r13) 

(declare-const var2605!2 var1734)
(declare-const var1712!1 var1027)
(assert true)
(define-const var2068 String (text/779296631 var2605!2 (cast-from-var1027-to-var1072 var1712!1))) ; Statement: $r14 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>($r13) 
(assert true)
(define-const var1748 String (trim/-847153721 var2068)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.String: java.lang.String trim()>() 
(define-const var3467 var1758 var1758-init) ; Statement: $r16 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo 
(assert true)
;(assert (<init>/64382128 var3467 var3393 var1748 var3663 var2365 var2583 var3252)) ; Statement: specialinvoke $r16.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, $r15, r12, r3, z0, r0) 

(declare-const var3467!1 var1758)
(declare-const var3393!1 Int)
(declare-const var1748!1 String)
(declare-const var3663!1 String)
(declare-const var2365!1 String)
(declare-const var2583!1 Bool)
(declare-const var3252!1 var1027)
(declare-const var3467!2 var1758)
(assert (not (= var3467!2 null-var1758)))
(assert (= (nextPrec/92480221 var3467!2) var3027)) ; Statement: $r16.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: int nextPrec> = $i2 
(define-const var772 var234 (binaryAlts/-164356992 var2605!2)) ; Statement: $r17 = r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.LinkedHashMap binaryAlts> 
(define-const var2564 Int (Int_valueOf/-1371140006 var3393!1)) ; Statement: $r18 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(assert true)
;(assert (put/-1127386829 (cast-from-var234-to-var1849 var772) (cast-from-Int-to-var3843 var2564) (cast-from-var1758-to-var3843 var3467!2))) ; Statement: virtualinvoke $r17.<java.util.LinkedHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r18, $r16) 

(declare-const var772!1 var234)
(declare-const var2564!1 Int)
(declare-const var3467!3 var1758)
 ; Statement: return 
(check-sat)
; {dupTree/-239505906=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var1027-to-var1072=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var1072-to-var1027=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.AltAST), altLabel/-134158986=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var1072-to-var2971=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), stripLeftRecursion/-314147500=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), stripAltLabel/568044820=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], void), nextPrecedence/579164756=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, int], int), addPrecedenceArgToRules/-2101804795=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.AltAST, int], org.antlr.v4.tool.ast.AltAST), text/779296631=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var1758-init=([], org.antlr.v4.analysis.LeftRecursiveRuleAltInfo), <init>/64382128=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, int, java.lang.String, java.lang.String, java.lang.String, boolean, org.antlr.v4.tool.ast.AltAST], void), nextPrec/92480221=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], int), binaryAlts/-164356992=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer], java.util.LinkedHashMap), Int_valueOf/-1371140006=([int], java.lang.Integer), put/-1127386829=([java.util.HashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var234-to-var1849=([java.util.LinkedHashMap], java.util.HashMap), cast-from-Int-to-var3843=([java.lang.Integer], java.lang.Object), cast-from-var1758-to-var3843=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], java.lang.Object)}
; {var1734=org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, var2605=r4, var1027=org.antlr.v4.tool.ast.AltAST, var3252=r0, var3393=i0, var1072=org.antlr.v4.tool.ast.GrammarAST, var2780=$r1, var2506=r10, var445=$r2, var1853=$r8, var2971=org.antlr.runtime.tree.CommonTree, var2465=$r11, var2365=r3, var3928=null_type, var3663=r12, var2583=z0, var2411=$r9, var3027=$i2, var1712=$r13, var2068=$r14, var1748=$r15, var1758=org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, var3467=$r16, var234=java.util.LinkedHashMap, var772=$r17, var2564=$r18, var1849=java.util.HashMap, var3843=java.lang.Object}
; {org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer=var1734, r4=var2605, org.antlr.v4.tool.ast.AltAST=var1027, r0=var3252, i0=var3393, org.antlr.v4.tool.ast.GrammarAST=var1072, $r1=var2780, r10=var2506, $r2=var445, $r8=var1853, org.antlr.runtime.tree.CommonTree=var2971, $r11=var2465, r3=var2365, null_type=var3928, r12=var3663, z0=var2583, $r9=var2411, $i2=var3027, $r13=var1712, $r14=var2068, $r15=var1748, org.antlr.v4.analysis.LeftRecursiveRuleAltInfo=var1758, $r16=var3467, java.util.LinkedHashMap=var234, $r17=var772, $r18=var2564, java.util.HashMap=var1849, java.lang.Object=var3843}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r4 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer;	r0 := @parameter0: org.antlr.v4.tool.ast.AltAST;	i0 := @parameter1: int;	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>();	r10 = (org.antlr.v4.tool.ast.AltAST) $r1;	$r2 = r10.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	if $r2 == null goto $r11 = null;	$r8 = r10.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	$r11 = virtualinvoke $r8.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	goto [?= r3 = $r11];	r3 = $r11;	r12 = null;	z0 = 0;	$r9 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.GrammarAST stripLeftRecursion(org.antlr.v4.tool.ast.GrammarAST)>(r10);	if $r9 == null goto virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r10);	virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r10);	$i2 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: int nextPrecedence(int)>(i0);	$r13 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.AltAST addPrecedenceArgToRules(org.antlr.v4.tool.ast.AltAST,int)>(r10, $i2);	virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>($r13);	$r14 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>($r13);	$r15 = virtualinvoke $r14.<java.lang.String: java.lang.String trim()>();	$r16 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo;	specialinvoke $r16.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, $r15, r12, r3, z0, r0);	$r16.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: int nextPrec> = $i2;	$r17 = r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.LinkedHashMap binaryAlts>;	$r18 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	virtualinvoke $r17.<java.util.LinkedHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r18, $r16);	return
;block_num 4