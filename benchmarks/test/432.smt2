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

(declare-sort var2436 0)
(declare-sort var165 0)
(declare-sort var3135 0)
(declare-sort var2584 0)
(declare-sort var2772 0)
(declare-sort var1385 0)
(declare-sort var2194 0)
(declare-sort var3182 0)
(declare-sort var2426 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun dupTree/-239505906 (var3135) var3135)
(declare-fun cast-from-var165-to-var3135 (var165) var3135)
(declare-fun cast-from-var3135-to-var165 (var3135) var165)
(declare-fun altLabel/-134158986 (var165) var3135)
(declare-fun getText/1230265107 (var2584) String)
(declare-fun cast-from-var3135-to-var2584 (var3135) var2584)
(declare-fun stripLeftRecursion/-314147500 (var2436 var3135) var3135)
(declare-fun stripAltLabel/568044820 (var2436 var3135) void)
(declare-fun text/779296631 (var2436 var3135) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1385-init () var1385)
(declare-fun <init>/64382128 (var1385 Int String String String Bool var165) void)
(declare-fun suffixAlts/-164356992 (var2436) var2194)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun put/-1127386829 (var3182 var2426 var2426) var2426)
(declare-fun cast-from-var2194-to-var3182 (var2194) var3182)
(declare-fun cast-from-Int-to-var2426 (Int) var2426)
(declare-fun cast-from-var1385-to-var2426 (var1385) var2426)
(declare-const null-var2436 var2436)
(declare-const null-var165 var165)
(declare-const null-Int Int)
(declare-const null-var3135 var3135)
(declare-const null-String String)
(declare-const var2402 var2436) ; Statement: r5 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer 
(assert (not (= var2402 null-var2436)))
(declare-const var1590 var165) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.AltAST 
(assert (not (= var1590 null-var165)))
(declare-const var1502 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1502 null-Int)))
(assert true)
(define-const var2444 var3135 (dupTree/-239505906 (cast-from-var165-to-var3135 var1590))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>() 
(define-const var3062 var165 (cast-from-var3135-to-var165 var2444)) ; Statement: r2 = (org.antlr.v4.tool.ast.AltAST) $r1 
(define-const var486 var3135 (altLabel/-134158986 var3062)) ; Statement: $r3 = r2.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
 ; Statement: if $r3 == null goto $r11 = null 
(assert (not (= var486 null-var3135))) ; Negate: Cond: $r3 == null  
(define-const var286 var3135 (altLabel/-134158986 var3062)) ; Statement: $r9 = r2.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel> 
(assert true)
(define-const var1276 String (getText/1230265107 (cast-from-var3135-to-var2584 var286))) ; Statement: $r11 = virtualinvoke $r9.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
 ; Statement: goto [?= r4 = $r11] 
(assert true) ; Non Conditional
(define-const var2181 String var1276) ; Statement: r4 = $r11 
(define-const var525 String null-String) ; Statement: r12 = null 
(define-const var2936 Bool (ite (= 1 0) true false)) ; Statement: z0 = 0 
(assert true)
(define-const var3557 var3135 (stripLeftRecursion/-314147500 var2402 (cast-from-var165-to-var3135 var3062))) ; Statement: $r10 = virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.GrammarAST stripLeftRecursion(org.antlr.v4.tool.ast.GrammarAST)>(r2) 
 ; Statement: if $r10 == null goto virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r2) 
(assert (= var3557 null-var3135)) ; Cond: $r10 == null 
(assert true)
;(assert (stripAltLabel/568044820 var2402 (cast-from-var165-to-var3135 var3062))) ; Statement: virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r2) 

(declare-const var2402!1 var2436)
(declare-const var3062!1 var165)
(assert true)
(define-const var2304 String (text/779296631 var2402!1 (cast-from-var165-to-var3135 var3062!1))) ; Statement: $r13 = virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>(r2) 
(assert true)
(define-const var164 String (trim/-847153721 var2304)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.String: java.lang.String trim()>() 
(define-const var1957 var1385 var1385-init) ; Statement: $r15 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo 
(assert true)
;(assert (<init>/64382128 var1957 var1502 var164 var525 var2181 var2936 var1590)) ; Statement: specialinvoke $r15.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, $r14, r12, r4, z0, r0) 

(declare-const var1957!1 var1385)
(declare-const var1502!1 Int)
(declare-const var164!1 String)
(declare-const var525!1 String)
(declare-const var2181!1 String)
(declare-const var2936!1 Bool)
(declare-const var1590!1 var165)
(define-const var2201 var2194 (suffixAlts/-164356992 var2402!1)) ; Statement: $r16 = r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.LinkedHashMap suffixAlts> 
(define-const var404 Int (Int_valueOf/-1371140006 var1502!1)) ; Statement: $r17 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(assert true)
;(assert (put/-1127386829 (cast-from-var2194-to-var3182 var2201) (cast-from-Int-to-var2426 var404) (cast-from-var1385-to-var2426 var1957!1))) ; Statement: virtualinvoke $r16.<java.util.LinkedHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r17, $r15) 

(declare-const var2201!1 var2194)
(declare-const var404!1 Int)
(declare-const var1957!2 var1385)
 ; Statement: return 
(check-sat)
; {dupTree/-239505906=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var165-to-var3135=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), cast-from-var3135-to-var165=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.AltAST), altLabel/-134158986=([org.antlr.v4.tool.ast.AltAST], org.antlr.v4.tool.ast.GrammarAST), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var3135-to-var2584=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), stripLeftRecursion/-314147500=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.tool.ast.GrammarAST), stripAltLabel/568044820=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], void), text/779296631=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, org.antlr.v4.tool.ast.GrammarAST], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var1385-init=([], org.antlr.v4.analysis.LeftRecursiveRuleAltInfo), <init>/64382128=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, int, java.lang.String, java.lang.String, java.lang.String, boolean, org.antlr.v4.tool.ast.AltAST], void), suffixAlts/-164356992=([org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer], java.util.LinkedHashMap), Int_valueOf/-1371140006=([int], java.lang.Integer), put/-1127386829=([java.util.HashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var2194-to-var3182=([java.util.LinkedHashMap], java.util.HashMap), cast-from-Int-to-var2426=([java.lang.Integer], java.lang.Object), cast-from-var1385-to-var2426=([org.antlr.v4.analysis.LeftRecursiveRuleAltInfo], java.lang.Object)}
; {var2436=org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer, var2402=r5, var165=org.antlr.v4.tool.ast.AltAST, var1590=r0, var1502=i0, var3135=org.antlr.v4.tool.ast.GrammarAST, var2444=$r1, var3062=r2, var486=$r3, var286=$r9, var2584=org.antlr.runtime.tree.CommonTree, var1276=$r11, var2181=r4, var2772=null_type, var525=r12, var2936=z0, var3557=$r10, var2304=$r13, var164=$r14, var1385=org.antlr.v4.analysis.LeftRecursiveRuleAltInfo, var1957=$r15, var2194=java.util.LinkedHashMap, var2201=$r16, var404=$r17, var3182=java.util.HashMap, var2426=java.lang.Object}
; {org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer=var2436, r5=var2402, org.antlr.v4.tool.ast.AltAST=var165, r0=var1590, i0=var1502, org.antlr.v4.tool.ast.GrammarAST=var3135, $r1=var2444, r2=var3062, $r3=var486, $r9=var286, org.antlr.runtime.tree.CommonTree=var2584, $r11=var1276, r4=var2181, null_type=var2772, r12=var525, z0=var2936, $r10=var3557, $r13=var2304, $r14=var164, org.antlr.v4.analysis.LeftRecursiveRuleAltInfo=var1385, $r15=var1957, java.util.LinkedHashMap=var2194, $r16=var2201, $r17=var404, java.util.HashMap=var3182, java.lang.Object=var2426}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r5 := @this: org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer;	r0 := @parameter0: org.antlr.v4.tool.ast.AltAST;	i0 := @parameter1: int;	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST dupTree()>();	r2 = (org.antlr.v4.tool.ast.AltAST) $r1;	$r3 = r2.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	if $r3 == null goto $r11 = null;	$r9 = r2.<org.antlr.v4.tool.ast.AltAST: org.antlr.v4.tool.ast.GrammarAST altLabel>;	$r11 = virtualinvoke $r9.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	goto [?= r4 = $r11];	r4 = $r11;	r12 = null;	z0 = 0;	$r10 = virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: org.antlr.v4.tool.ast.GrammarAST stripLeftRecursion(org.antlr.v4.tool.ast.GrammarAST)>(r2);	if $r10 == null goto virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r2);	virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: void stripAltLabel(org.antlr.v4.tool.ast.GrammarAST)>(r2);	$r13 = virtualinvoke r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.lang.String text(org.antlr.v4.tool.ast.GrammarAST)>(r2);	$r14 = virtualinvoke $r13.<java.lang.String: java.lang.String trim()>();	$r15 = new org.antlr.v4.analysis.LeftRecursiveRuleAltInfo;	specialinvoke $r15.<org.antlr.v4.analysis.LeftRecursiveRuleAltInfo: void <init>(int,java.lang.String,java.lang.String,java.lang.String,boolean,org.antlr.v4.tool.ast.AltAST)>(i0, $r14, r12, r4, z0, r0);	$r16 = r5.<org.antlr.v4.analysis.LeftRecursiveRuleAnalyzer: java.util.LinkedHashMap suffixAlts>;	$r17 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	virtualinvoke $r16.<java.util.LinkedHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r17, $r15);	return
;block_num 4