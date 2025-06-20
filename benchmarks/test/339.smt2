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

(declare-sort var3090 0)
(declare-sort var3004 0)
(declare-sort var173 0)
(declare-sort var2301 0)
(declare-sort var827 0)
(declare-sort var2845 0)
(declare-sort var892 0)
(declare-sort var2871 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun dupTree/-239505906 (var173) var173)
(declare-fun cast-from-var3004-to-var173 (var3004) var173)
(declare-fun cast-from-var173-to-var3004 (var173) var3004)
(declare-fun stripAltLabel/568044820 (var3090 var173) void)
(declare-fun precedence/-1319549247 (var3090 Int) Int)
(declare-fun addPrecedenceArgToRules/-2101804795 (var3090 var3004 Int) var3004)
(declare-fun text/779296631 (var3090 var173) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun altLabel/-134158986 (var3004) var173)
(declare-fun getText/1230265107 (var2301) String)
(declare-fun cast-from-var173-to-var2301 (var173) var2301)
(declare-fun var827-init () var827)
(declare-fun <init>/64382128 (var827 Int String String String Bool var3004) void)
(declare-fun nextPrec/92480221 (var827) Int)
(declare-fun prefixAndOtherAlts/-164356992 (var3090) var892)
(declare-fun var892_add/328494887 (var892 var2871) Bool)
(declare-fun cast-from-var827-to-var2871 (var827) var2871)
(declare-const null-var3090 var3090)
(declare-const null-var3004 var3004)
(declare-const null-Int Int)
(declare-const null-var173 var173)
(declare-const null-NullType var2845)
(declare-const null-String String)
(declare-const null-var827 var827)
(declare-const var3345 var3090) ; Statement: r2 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer 
(assert (not (= var3345 null-var3090)))
(declare-const var2736 var3004) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.AltAST 
(assert (not (= var2736 null-var3004)))
(declare-const var2806 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2806 null-Int)))
(assert true)
(define-const var970 var173 (dupTree/-239505906 (cast-from-var3004-to-var173 var2736))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>() 
(define-const var3982 var3004 (cast-from-var173-to-var3004 var970)) ; Statement: r7 = (org.antlr.v4.tool.ast.AltAST) $r1 
(assert true)
;(assert (stripAltLabel/568044820 var3345 (cast-from-var3004-to-var173 var3982))) ; Statement: virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r7) 

(declare-const var3345!1 var3090)
(declare-const var3982!1 var3004)
(assert true)
(define-const var1151 Int (precedence/-1319549247 var3345!1 var2806)) ; Statement: i1 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: int precedence(int)>(i0) 
(assert true)
(define-const var1628 var3004 (addPrecedenceArgToRules/-2101804795 var3345!1 var3982!1 var1151)) ; Statement: r8 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.AltAST addPrecedenceArgToRules(org.antlr.v4.tool.ast.AltAST,int)>(r7, i1) 
(assert true)
(define-const var2271 String (text/779296631 var3345!1 (cast-from-var3004-to-var173 var1628))) ; Statement: r9 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>(r8) 
(assert true)
(define-const var1756 String (trim/-847153721 var2271)) ; Statement: r10 = virtualinvoke r9.<java.lang.String: java.lang.String trim()>() 
(define-const var119 var173 (altLabel/-134158986 var1628)) ; Statement: $r3 = r8.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
 ; Statement: if $r3 == null goto $r11 = null 
(assert (not (= var119 null-var173))) ; Negate: Cond: $r3 == null  
(define-const var3611 var173 (altLabel/-134158986 var1628)) ; Statement: $r6 = r8.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
(assert true)
(define-const var1501 String (getText/1230265107 (cast-from-var173-to-var2301 var3611))) ; Statement: $r11 = virtualinvoke $r6.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
 ; Statement: goto [?= $r4 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo] 
(assert true) ; Non Conditional
(define-const var1405 var827 var827-init) ; Statement: $r4 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo 
(assert true)
;(assert (<init>/64382128 var1405 var2806 var1756 null-String var1501 (ite (= 1 0) true false) var2736)) ; Statement: specialinvoke $r4.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, r10, null, $r11, 0, r0) 

(declare-const var1405!1 var827)
(declare-const var2806!1 Int)
(declare-const var1756!1 String)
(declare-const var40 var2845)
(declare-const var1501!1 String)
(declare-const var2964 Int)
(declare-const var2736!1 var3004)
(declare-const var1405!2 var827)
(assert (not (= var1405!2 null-var827)))
(assert (= (nextPrec/92480221 var1405!2) var1151)) ; Statement: $r4.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: int nextPrec> = i1 
(define-const var2662 var892 (prefixAndOtherAlts/-164356992 var3345!1)) ; Statement: $r5 = r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.List prefixAndOtherAlts> 
;(assert (var892_add/328494887 var2662 (cast-from-var827-to-var2871 var1405!2))) ; Statement: interfaceinvoke $r5.<java.util.List: boolean add(java.lang.Object)>($r4) 

(declare-const var2662!1 var892)
(declare-const var1405!3 var827)
 ; Statement: return 
(check-sat)
; {dupTree/-239505906=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var3004-to-var173=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var173-to-var3004=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.AltAST), stripAltLabel/568044820=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], void), precedence/-1319549247=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, int], int), addPrecedenceArgToRules/-2101804795=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.AltAST, int], org.antlr.v4.tool.ast.AltAST), text/779296631=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), altLabel/-134158986=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var173-to-var2301=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), var827-init=([], org.antlr.v4.analysis.LeftRecursiveRuleAltInfo), <init>/64382128=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, int, java.lang.String, java.lang.String, java.lang.String, boolean, org.antlr.v4.tool.ast.AltAST], void), nextPrec/92480221=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], int), prefixAndOtherAlts/-164356992=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer], java.util.List), var892_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var827-to-var2871=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], java.lang.Object)}
; {var3090=org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, var3345=r2, var3004=org.antlr.v4.tool.ast.AltAST, var2736=r0, var2806=i0, var173=org.antlr.v4.tool.ast.GrammarAST, var970=$r1, var3982=r7, var1151=i1, var1628=r8, var2271=r9, var1756=r10, var119=$r3, var3611=$r6, var2301=org.antlr.runtime.tree.CommonTree, var1501=$r11, var827=org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, var1405=$r4, var2845=null_type, var40=null, var2964=0, var892=java.util.List, var2662=$r5, var2871=java.lang.Object}
; {org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer=var3090, r2=var3345, org.antlr.v4.tool.ast.AltAST=var3004, r0=var2736, i0=var2806, org.antlr.v4.tool.ast.GrammarAST=var173, $r1=var970, r7=var3982, i1=var1151, r8=var1628, r9=var2271, r10=var1756, $r3=var119, $r6=var3611, org.antlr.runtime.tree.CommonTree=var2301, $r11=var1501, org.antlr.v4.analysis.LeftRecursiveRuleAltInfo=var827, $r4=var1405, null_type=var2845, null=var40, 0=var2964, java.util.List=var892, $r5=var2662, java.lang.Object=var2871}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r2 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer;	r0 := @parameter0: org.antlr.v4.tool.ast.AltAST;	i0 := @parameter1: int;	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>();	r7 = (org.antlr.v4.tool.ast.AltAST) $r1;	virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r7);	i1 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: int precedence(int)>(i0);	r8 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.AltAST addPrecedenceArgToRules(org.antlr.v4.tool.ast.AltAST,int)>(r7, i1);	r9 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>(r8);	r10 = virtualinvoke r9.<java.lang.String: java.lang.String trim()>();	$r3 = r8.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	if $r3 == null goto $r11 = null;	$r6 = r8.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	$r11 = virtualinvoke $r6.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	goto [?= $r4 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo];	$r4 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo;	specialinvoke $r4.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, r10, null, $r11, 0, r0);	$r4.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: int nextPrec> = i1;	$r5 = r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.List prefixAndOtherAlts>;	interfaceinvoke $r5.<java.util.List: boolean add(java.lang.Object)>($r4);	return
;block_num 3