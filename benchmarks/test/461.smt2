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

(declare-sort var1930 0)
(declare-sort var3612 0)
(declare-sort var3829 0)
(declare-sort var2753 0)
(declare-sort var607 0)
(declare-sort var1934 0)
(declare-sort var2821 0)
(declare-sort var1977 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun dupTree/-239505906 (var3829) var3829)
(declare-fun cast-from-var3612-to-var3829 (var3612) var3829)
(declare-fun cast-from-var3829-to-var3612 (var3829) var3612)
(declare-fun altLabel/-134158986 (var3612) var3829)
(declare-fun stripLeftRecursion/-314147500 (var1930 var3829) var3829)
(declare-fun stripAltLabel/568044820 (var1930 var3829) void)
(declare-fun text/779296631 (var1930 var3829) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var607-init () var607)
(declare-fun <init>/64382128 (var607 Int String String String Bool var3612) void)
(declare-fun suffixAlts/-164356992 (var1930) var1934)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun put/-1127386829 (var2821 var1977 var1977) var1977)
(declare-fun cast-from-var1934-to-var2821 (var1934) var2821)
(declare-fun cast-from-Int-to-var1977 (Int) var1977)
(declare-fun cast-from-var607-to-var1977 (var607) var1977)
(declare-const null-var1930 var1930)
(declare-const null-var3612 var3612)
(declare-const null-Int Int)
(declare-const null-var3829 var3829)
(declare-const null-String String)
(declare-const var3653 var1930) ; Statement: r5 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer 
(assert (not (= var3653 null-var1930)))
(declare-const var961 var3612) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.AltAST 
(assert (not (= var961 null-var3612)))
(declare-const var2993 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2993 null-Int)))
(assert true)
(define-const var110 var3829 (dupTree/-239505906 (cast-from-var3612-to-var3829 var961))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>() 
(define-const var3525 var3612 (cast-from-var3829-to-var3612 var110)) ; Statement: r2 = (org.antlr.v4.tool.ast.AltAST) $r1 
(define-const var1347 var3829 (altLabel/-134158986 var3525)) ; Statement: $r3 = r2.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
 ; Statement: if $r3 == null goto $r11 = null 
(assert (= var1347 null-var3829)) ; Cond: $r3 == null 
(define-const var1915 String null-String) ; Statement: $r11 = null 
(assert true) ; Non Conditional
(define-const var536 String var1915) ; Statement: r4 = $r11 
(define-const var2349 String null-String) ; Statement: r12 = null 
(define-const var1117 Bool (ite (= 1 0) true false)) ; Statement: z0 = 0 
(assert true)
(define-const var2594 var3829 (stripLeftRecursion/-314147500 var3653 (cast-from-var3612-to-var3829 var3525))) ; Statement: $r10 = virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.GrammarAST stripLeftRecursion(org.antlr.v4.tool.ast.GrammarAST)>(r2) 
 ; Statement: if $r10 == null goto virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r2) 
(assert (= var2594 null-var3829)) ; Cond: $r10 == null 
(assert true)
;(assert (stripAltLabel/568044820 var3653 (cast-from-var3612-to-var3829 var3525))) ; Statement: virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r2) 

(declare-const var3653!1 var1930)
(declare-const var3525!1 var3612)
(assert true)
(define-const var599 String (text/779296631 var3653!1 (cast-from-var3612-to-var3829 var3525!1))) ; Statement: $r13 = virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>(r2) 
(assert true)
(define-const var2390 String (trim/-847153721 var599)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.String: java.lang.String trim()>() 
(define-const var3583 var607 var607-init) ; Statement: $r15 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo 
(assert true)
;(assert (<init>/64382128 var3583 var2993 var2390 var2349 var536 var1117 var961)) ; Statement: specialinvoke $r15.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, $r14, r12, r4, z0, r0) 

(declare-const var3583!1 var607)
(declare-const var2993!1 Int)
(declare-const var2390!1 String)
(declare-const var2349!1 String)
(declare-const var536!1 String)
(declare-const var1117!1 Bool)
(declare-const var961!1 var3612)
(define-const var2212 var1934 (suffixAlts/-164356992 var3653!1)) ; Statement: $r16 = r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.LinkedHashMap suffixAlts> 
(define-const var1567 Int (Int_valueOf/-1371140006 var2993!1)) ; Statement: $r17 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(assert true)
;(assert (put/-1127386829 (cast-from-var1934-to-var2821 var2212) (cast-from-Int-to-var1977 var1567) (cast-from-var607-to-var1977 var3583!1))) ; Statement: virtualinvoke $r16.<java.util.LinkedHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r17, $r15) 

(declare-const var2212!1 var1934)
(declare-const var1567!1 Int)
(declare-const var3583!2 var607)
 ; Statement: return 
(check-sat)
; {dupTree/-239505906=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var3612-to-var3829=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var3829-to-var3612=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.AltAST), altLabel/-134158986=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), stripLeftRecursion/-314147500=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), stripAltLabel/568044820=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], void), text/779296631=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var607-init=([], org.antlr.v4.analysis.LeftRecursiveRuleAltInfo), <init>/64382128=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, int, java.lang.String, java.lang.String, java.lang.String, boolean, org.antlr.v4.tool.ast.AltAST], void), suffixAlts/-164356992=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer], java.util.LinkedHashMap), Int_valueOf/-1371140006=([int], java.lang.Integer), put/-1127386829=([java.util.HashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var1934-to-var2821=([java.util.LinkedHashMap], java.util.HashMap), cast-from-Int-to-var1977=([java.lang.Integer], java.lang.Object), cast-from-var607-to-var1977=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], java.lang.Object)}
; {var1930=org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, var3653=r5, var3612=org.antlr.v4.tool.ast.AltAST, var961=r0, var2993=i0, var3829=org.antlr.v4.tool.ast.GrammarAST, var110=$r1, var3525=r2, var1347=$r3, var2753=null_type, var1915=$r11, var536=r4, var2349=r12, var1117=z0, var2594=$r10, var599=$r13, var2390=$r14, var607=org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, var3583=$r15, var1934=java.util.LinkedHashMap, var2212=$r16, var1567=$r17, var2821=java.util.HashMap, var1977=java.lang.Object}
; {org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer=var1930, r5=var3653, org.antlr.v4.tool.ast.AltAST=var3612, r0=var961, i0=var2993, org.antlr.v4.tool.ast.GrammarAST=var3829, $r1=var110, r2=var3525, $r3=var1347, null_type=var2753, $r11=var1915, r4=var536, r12=var2349, z0=var1117, $r10=var2594, $r13=var599, $r14=var2390, org.antlr.v4.analysis.LeftRecursiveRuleAltInfo=var607, $r15=var3583, java.util.LinkedHashMap=var1934, $r16=var2212, $r17=var1567, java.util.HashMap=var2821, java.lang.Object=var1977}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r5 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer;	r0 := @parameter0: org.antlr.v4.tool.ast.AltAST;	i0 := @parameter1: int;	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>();	r2 = (org.antlr.v4.tool.ast.AltAST) $r1;	$r3 = r2.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	if $r3 == null goto $r11 = null;	$r11 = null;	r4 = $r11;	r12 = null;	z0 = 0;	$r10 = virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.GrammarAST stripLeftRecursion(org.antlr.v4.tool.ast.GrammarAST)>(r2);	if $r10 == null goto virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r2);	virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r2);	$r13 = virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>(r2);	$r14 = virtualinvoke $r13.<java.lang.String: java.lang.String trim()>();	$r15 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo;	specialinvoke $r15.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, $r14, r12, r4, z0, r0);	$r16 = r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.LinkedHashMap suffixAlts>;	$r17 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	virtualinvoke $r16.<java.util.LinkedHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r17, $r15);	return
;block_num 4