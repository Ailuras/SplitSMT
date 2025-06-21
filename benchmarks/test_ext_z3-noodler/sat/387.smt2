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

(declare-sort var936 0)
(declare-sort var1207 0)
(declare-sort var3424 0)
(declare-sort var1216 0)
(declare-sort var3702 0)
(declare-sort var443 0)
(declare-sort var1822 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun dupTree/-239505906 (var3424) var3424)
(declare-fun cast-from-var1207-to-var3424 (var1207) var3424)
(declare-fun cast-from-var3424-to-var1207 (var3424) var1207)
(declare-fun stripAltLabel/568044820 (var936 var3424) void)
(declare-fun precedence/-1319549247 (var936 Int) Int)
(declare-fun addPrecedenceArgToRules/-2101804795 (var936 var1207 Int) var1207)
(declare-fun text/779296631 (var936 var3424) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun altLabel/-134158986 (var1207) var3424)
(declare-fun var3702-init () var3702)
(declare-fun <init>/64382128 (var3702 Int String String String Bool var1207) void)
(declare-fun nextPrec/92480221 (var3702) Int)
(declare-fun prefixAndOtherAlts/-164356992 (var936) var443)
(declare-fun var443_add/328494887 (var443 var1822) Bool)
(declare-fun cast-from-var3702-to-var1822 (var3702) var1822)
(declare-const null-var936 var936)
(declare-const null-var1207 var1207)
(declare-const null-Int Int)
(declare-const null-var3424 var3424)
(declare-const null-String String)
(declare-const null-NullType var1216)
(declare-const null-var3702 var3702)
(declare-const var38 var936) ; Statement: r2 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer 
(assert (not (= var38 null-var936)))
(declare-const var945 var1207) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.AltAST 
(assert (not (= var945 null-var1207)))
(declare-const var3085 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3085 null-Int)))
(assert true)
(define-const var1731 var3424 (dupTree/-239505906 (cast-from-var1207-to-var3424 var945))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>() 
(define-const var3927 var1207 (cast-from-var3424-to-var1207 var1731)) ; Statement: r7 = (org.antlr.v4.tool.ast.AltAST) $r1 
(assert true)
;(assert (stripAltLabel/568044820 var38 (cast-from-var1207-to-var3424 var3927))) ; Statement: virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r7) 

(declare-const var38!1 var936)
(declare-const var3927!1 var1207)
(assert true)
(define-const var644 Int (precedence/-1319549247 var38!1 var3085)) ; Statement: i1 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: int precedence(int)>(i0) 
(assert true)
(define-const var3626 var1207 (addPrecedenceArgToRules/-2101804795 var38!1 var3927!1 var644)) ; Statement: r8 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.AltAST addPrecedenceArgToRules(org.antlr.v4.tool.ast.AltAST,int)>(r7, i1) 
(assert true)
(define-const var668 String (text/779296631 var38!1 (cast-from-var1207-to-var3424 var3626))) ; Statement: r9 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>(r8) 
(assert true)
(define-const var1890 String (trim/-847153721 var668)) ; Statement: r10 = virtualinvoke r9.<java.lang.String: java.lang.String trim()>() 
(define-const var1909 var3424 (altLabel/-134158986 var3626)) ; Statement: $r3 = r8.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
 ; Statement: if $r3 == null goto $r11 = null 
(assert (= var1909 null-var3424)) ; Cond: $r3 == null 
(define-const var1590 String null-String) ; Statement: $r11 = null 
(assert true) ; Non Conditional
(define-const var3632 var3702 var3702-init) ; Statement: $r4 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo 
(assert true)
;(assert (<init>/64382128 var3632 var3085 var1890 null-String var1590 (ite (= 1 0) true false) var945)) ; Statement: specialinvoke $r4.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, r10, null, $r11, 0, r0) 

(declare-const var3632!1 var3702)
(declare-const var3085!1 Int)
(declare-const var1890!1 String)
(declare-const var2573 var1216)
(declare-const var1590!1 String)
(declare-const var2492 Int)
(declare-const var945!1 var1207)
(declare-const var3632!2 var3702)
(assert (not (= var3632!2 null-var3702)))
(assert (= (nextPrec/92480221 var3632!2) var644)) ; Statement: $r4.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: int nextPrec> = i1 
(define-const var2816 var443 (prefixAndOtherAlts/-164356992 var38!1)) ; Statement: $r5 = r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.List prefixAndOtherAlts> 
;(assert (var443_add/328494887 var2816 (cast-from-var3702-to-var1822 var3632!2))) ; Statement: interfaceinvoke $r5.<java.util.List: boolean add(java.lang.Object)>($r4) 

(declare-const var2816!1 var443)
(declare-const var3632!3 var3702)
 ; Statement: return 
(check-sat)
; {dupTree/-239505906=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var1207-to-var3424=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var3424-to-var1207=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.AltAST), stripAltLabel/568044820=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], void), precedence/-1319549247=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, int], int), addPrecedenceArgToRules/-2101804795=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.AltAST, int], org.antlr.v4.tool.ast.AltAST), text/779296631=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), altLabel/-134158986=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), var3702-init=([], org.antlr.v4.analysis.LeftRecursiveRuleAltInfo), <init>/64382128=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, int, java.lang.String, java.lang.String, java.lang.String, boolean, org.antlr.v4.tool.ast.AltAST], void), nextPrec/92480221=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], int), prefixAndOtherAlts/-164356992=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer], java.util.List), var443_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var3702-to-var1822=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], java.lang.Object)}
; {var936=org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, var38=r2, var1207=org.antlr.v4.tool.ast.AltAST, var945=r0, var3085=i0, var3424=org.antlr.v4.tool.ast.GrammarAST, var1731=$r1, var3927=r7, var644=i1, var3626=r8, var668=r9, var1890=r10, var1909=$r3, var1216=null_type, var1590=$r11, var3702=org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, var3632=$r4, var2573=null, var2492=0, var443=java.util.List, var2816=$r5, var1822=java.lang.Object}
; {org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer=var936, r2=var38, org.antlr.v4.tool.ast.AltAST=var1207, r0=var945, i0=var3085, org.antlr.v4.tool.ast.GrammarAST=var3424, $r1=var1731, r7=var3927, i1=var644, r8=var3626, r9=var668, r10=var1890, $r3=var1909, null_type=var1216, $r11=var1590, org.antlr.v4.analysis.LeftRecursiveRuleAltInfo=var3702, $r4=var3632, null=var2573, 0=var2492, java.util.List=var443, $r5=var2816, java.lang.Object=var1822}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r2 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer;	r0 := @parameter0: org.antlr.v4.tool.ast.AltAST;	i0 := @parameter1: int;	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>();	r7 = (org.antlr.v4.tool.ast.AltAST) $r1;	virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r7);	i1 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: int precedence(int)>(i0);	r8 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.AltAST addPrecedenceArgToRules(org.antlr.v4.tool.ast.AltAST,int)>(r7, i1);	r9 = virtualinvoke r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>(r8);	r10 = virtualinvoke r9.<java.lang.String: java.lang.String trim()>();	$r3 = r8.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	if $r3 == null goto $r11 = null;	$r11 = null;	$r4 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo;	specialinvoke $r4.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, r10, null, $r11, 0, r0);	$r4.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: int nextPrec> = i1;	$r5 = r2.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.List prefixAndOtherAlts>;	interfaceinvoke $r5.<java.util.List: boolean add(java.lang.Object)>($r4);	return
;block_num 3