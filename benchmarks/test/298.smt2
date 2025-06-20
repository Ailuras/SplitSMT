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

(declare-sort var2198 0)
(declare-sort var1730 0)
(declare-sort var3512 0)
(declare-sort var3047 0)
(declare-sort var1408 0)
(declare-sort var81 0)
(declare-sort var1470 0)
(declare-sort var2091 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun dupTree/-239505906 (var3512) var3512)
(declare-fun cast-from-var1730-to-var3512 (var1730) var3512)
(declare-fun cast-from-var3512-to-var1730 (var3512) var1730)
(declare-fun altLabel/-134158986 (var1730) var3512)
(declare-fun stripLeftRecursion/-314147500 (var2198 var3512) var3512)
(declare-fun stripAltLabel/568044820 (var2198 var3512) void)
(declare-fun nextPrecedence/579164756 (var2198 Int) Int)
(declare-fun addPrecedenceArgToRules/-2101804795 (var2198 var1730 Int) var1730)
(declare-fun text/779296631 (var2198 var3512) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1408-init () var1408)
(declare-fun <init>/64382128 (var1408 Int String String String Bool var1730) void)
(declare-fun nextPrec/92480221 (var1408) Int)
(declare-fun binaryAlts/-164356992 (var2198) var81)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun put/-1127386829 (var1470 var2091 var2091) var2091)
(declare-fun cast-from-var81-to-var1470 (var81) var1470)
(declare-fun cast-from-Int-to-var2091 (Int) var2091)
(declare-fun cast-from-var1408-to-var2091 (var1408) var2091)
(declare-const null-var2198 var2198)
(declare-const null-var1730 var1730)
(declare-const null-Int Int)
(declare-const null-var3512 var3512)
(declare-const null-String String)
(declare-const null-var1408 var1408)
(declare-const var2083 var2198) ; Statement: r4 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer 
(assert (not (= var2083 null-var2198)))
(declare-const var2008 var1730) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.AltAST 
(assert (not (= var2008 null-var1730)))
(declare-const var3167 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3167 null-Int)))
(assert true)
(define-const var2326 var3512 (dupTree/-239505906 (cast-from-var1730-to-var3512 var2008))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>() 
(define-const var1082 var1730 (cast-from-var3512-to-var1730 var2326)) ; Statement: r10 = (org.antlr.v4.tool.ast.AltAST) $r1 
(define-const var2530 var3512 (altLabel/-134158986 var1082)) ; Statement: $r2 = r10.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
 ; Statement: if $r2 == null goto $r11 = null 
(assert (= var2530 null-var3512)) ; Cond: $r2 == null 
(define-const var3573 String null-String) ; Statement: $r11 = null 
(assert true) ; Non Conditional
(define-const var2991 String var3573) ; Statement: r3 = $r11 
(define-const var475 String null-String) ; Statement: r12 = null 
(define-const var3725 Bool (ite (= 1 0) true false)) ; Statement: z0 = 0 
(assert true)
(define-const var3201 var3512 (stripLeftRecursion/-314147500 var2083 (cast-from-var1730-to-var3512 var1082))) ; Statement: $r9 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.GrammarAST stripLeftRecursion(org.antlr.v4.tool.ast.GrammarAST)>(r10) 
 ; Statement: if $r9 == null goto virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r10) 
(assert (= var3201 null-var3512)) ; Cond: $r9 == null 
(assert true)
;(assert (stripAltLabel/568044820 var2083 (cast-from-var1730-to-var3512 var1082))) ; Statement: virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r10) 

(declare-const var2083!1 var2198)
(declare-const var1082!1 var1730)
(assert true)
(define-const var2739 Int (nextPrecedence/579164756 var2083!1 var3167)) ; Statement: $i2 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: int nextPrecedence(int)>(i0) 
(assert true)
(define-const var2336 var1730 (addPrecedenceArgToRules/-2101804795 var2083!1 var1082!1 var2739)) ; Statement: $r13 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.AltAST addPrecedenceArgToRules(org.antlr.v4.tool.ast.AltAST,int)>(r10, $i2) 
(assert true)
;(assert (stripAltLabel/568044820 var2083!1 (cast-from-var1730-to-var3512 var2336))) ; Statement: virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>($r13) 

(declare-const var2083!2 var2198)
(declare-const var2336!1 var1730)
(assert true)
(define-const var3833 String (text/779296631 var2083!2 (cast-from-var1730-to-var3512 var2336!1))) ; Statement: $r14 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>($r13) 
(assert true)
(define-const var3835 String (trim/-847153721 var3833)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.String: java.lang.String trim()>() 
(define-const var3461 var1408 var1408-init) ; Statement: $r16 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo 
(assert true)
;(assert (<init>/64382128 var3461 var3167 var3835 var475 var2991 var3725 var2008)) ; Statement: specialinvoke $r16.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, $r15, r12, r3, z0, r0) 

(declare-const var3461!1 var1408)
(declare-const var3167!1 Int)
(declare-const var3835!1 String)
(declare-const var475!1 String)
(declare-const var2991!1 String)
(declare-const var3725!1 Bool)
(declare-const var2008!1 var1730)
(declare-const var3461!2 var1408)
(assert (not (= var3461!2 null-var1408)))
(assert (= (nextPrec/92480221 var3461!2) var2739)) ; Statement: $r16.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: int nextPrec> = $i2 
(define-const var1190 var81 (binaryAlts/-164356992 var2083!2)) ; Statement: $r17 = r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.LinkedHashMap binaryAlts> 
(define-const var3460 Int (Int_valueOf/-1371140006 var3167!1)) ; Statement: $r18 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(assert true)
;(assert (put/-1127386829 (cast-from-var81-to-var1470 var1190) (cast-from-Int-to-var2091 var3460) (cast-from-var1408-to-var2091 var3461!2))) ; Statement: virtualinvoke $r17.<java.util.LinkedHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r18, $r16) 

(declare-const var1190!1 var81)
(declare-const var3460!1 Int)
(declare-const var3461!3 var1408)
 ; Statement: return 
(check-sat)
; {dupTree/-239505906=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var1730-to-var3512=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var3512-to-var1730=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.AltAST), altLabel/-134158986=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), stripLeftRecursion/-314147500=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), stripAltLabel/568044820=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], void), nextPrecedence/579164756=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, int], int), addPrecedenceArgToRules/-2101804795=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.AltAST, int], org.antlr.v4.tool.ast.AltAST), text/779296631=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var1408-init=([], org.antlr.v4.analysis.LeftRecursiveRuleAltInfo), <init>/64382128=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, int, java.lang.String, java.lang.String, java.lang.String, boolean, org.antlr.v4.tool.ast.AltAST], void), nextPrec/92480221=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], int), binaryAlts/-164356992=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer], java.util.LinkedHashMap), Int_valueOf/-1371140006=([int], java.lang.Integer), put/-1127386829=([java.util.HashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var81-to-var1470=([java.util.LinkedHashMap], java.util.HashMap), cast-from-Int-to-var2091=([java.lang.Integer], java.lang.Object), cast-from-var1408-to-var2091=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], java.lang.Object)}
; {var2198=org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, var2083=r4, var1730=org.antlr.v4.tool.ast.AltAST, var2008=r0, var3167=i0, var3512=org.antlr.v4.tool.ast.GrammarAST, var2326=$r1, var1082=r10, var2530=$r2, var3047=null_type, var3573=$r11, var2991=r3, var475=r12, var3725=z0, var3201=$r9, var2739=$i2, var2336=$r13, var3833=$r14, var3835=$r15, var1408=org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, var3461=$r16, var81=java.util.LinkedHashMap, var1190=$r17, var3460=$r18, var1470=java.util.HashMap, var2091=java.lang.Object}
; {org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer=var2198, r4=var2083, org.antlr.v4.tool.ast.AltAST=var1730, r0=var2008, i0=var3167, org.antlr.v4.tool.ast.GrammarAST=var3512, $r1=var2326, r10=var1082, $r2=var2530, null_type=var3047, $r11=var3573, r3=var2991, r12=var475, z0=var3725, $r9=var3201, $i2=var2739, $r13=var2336, $r14=var3833, $r15=var3835, org.antlr.v4.analysis.LeftRecursiveRuleAltInfo=var1408, $r16=var3461, java.util.LinkedHashMap=var81, $r17=var1190, $r18=var3460, java.util.HashMap=var1470, java.lang.Object=var2091}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r4 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer;	r0 := @parameter0: org.antlr.v4.tool.ast.AltAST;	i0 := @parameter1: int;	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>();	r10 = (org.antlr.v4.tool.ast.AltAST) $r1;	$r2 = r10.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	if $r2 == null goto $r11 = null;	$r11 = null;	r3 = $r11;	r12 = null;	z0 = 0;	$r9 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.GrammarAST stripLeftRecursion(org.antlr.v4.tool.ast.GrammarAST)>(r10);	if $r9 == null goto virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r10);	virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r10);	$i2 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: int nextPrecedence(int)>(i0);	$r13 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.AltAST addPrecedenceArgToRules(org.antlr.v4.tool.ast.AltAST,int)>(r10, $i2);	virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>($r13);	$r14 = virtualinvoke r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>($r13);	$r15 = virtualinvoke $r14.<java.lang.String: java.lang.String trim()>();	$r16 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo;	specialinvoke $r16.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, $r15, r12, r3, z0, r0);	$r16.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: int nextPrec> = $i2;	$r17 = r4.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.LinkedHashMap binaryAlts>;	$r18 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	virtualinvoke $r17.<java.util.LinkedHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r18, $r16);	return
;block_num 4