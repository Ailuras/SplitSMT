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

(declare-sort var3490 0)
(declare-sort var2471 0)
(declare-sort var1859 0)
(declare-sort var412 0)
(declare-sort var2857 0)
(declare-sort var3501 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun type/2097393683 (var1859) var412)
(declare-fun element/2097393683 (var1859) var2857)
(declare-fun getText/1230265107 (var3501) String)
(declare-fun cast-from-var2857-to-var3501 (var2857) var3501)
(declare-const null-var3490 var3490)
(declare-const null-var2471 var2471)
(declare-const null-var1859 var1859)
(declare-const var2261 var3490) ; Statement: r15 := @this: org.antlr.v4.semantics.SymbolChecks 
(assert (not (= var2261 null-var3490)))
(declare-const var2304 var2471) ; Statement: r8 := @parameter0: org.antlr.v4.tool.Rule 
(assert (not (= var2304 null-var2471)))
(declare-const var2345 var1859) ; Statement: r0 := @parameter1: org.antlr.v4.tool.LabelElementPair 
(assert (not (= var2345 null-var1859)))
(declare-const var3893 var1859) ; Statement: r1 := @parameter2: org.antlr.v4.tool.LabelElementPair 
(assert (not (= var3893 null-var1859)))
(define-const var2016 var412 (type/2097393683 var2345)) ; Statement: $r3 = r0.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.LabelType type> 
(define-const var2574 var412 (type/2097393683 var3893)) ; Statement: $r2 = r1.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.LabelType type> 
 ; Statement: if $r3 == $r2 goto $r53 = r0.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.ast.GrammarAST element> 
(assert (= var2016 var2574)) ; Cond: $r3 == $r2 
(define-const var2694 var2857 (element/2097393683 var2345)) ; Statement: $r53 = r0.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.ast.GrammarAST element> 
(assert true)
(define-const var1662 String (getText/1230265107 (cast-from-var2857-to-var3501 var2694))) ; Statement: $r54 = virtualinvoke $r53.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(define-const var2680 var2857 (element/2097393683 var3893)) ; Statement: $r55 = r1.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.ast.GrammarAST element> 
(assert true)
(define-const var3148 String (getText/1230265107 (cast-from-var2857-to-var3501 var2680))) ; Statement: $r56 = virtualinvoke $r55.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var839 Bool (= var1662 var3148)) ; Statement: $z8 = virtualinvoke $r54.<java.lang.String: boolean equals(java.lang.Object)>($r56) 
 ; Statement: if $z8 != 0 goto return 
(assert (not (= (ite var839 1 0) 0))) ; Cond: $z8 != 0 
 ; Statement: return 
(check-sat)
; {type/2097393683=([org.antlr.v4.tool.LabelElementPair], org.antlr.v4.tool.LabelType), element/2097393683=([org.antlr.v4.tool.LabelElementPair], org.antlr.v4.tool.ast.GrammarAST), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var2857-to-var3501=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree)}
; {var3490=org.antlr.v4.semantics.SymbolChecks, var2261=r15, var2471=org.antlr.v4.tool.Rule, var2304=r8, var1859=org.antlr.v4.tool.LabelElementPair, var2345=r0, var3893=r1, var412=org.antlr.v4.tool.LabelType, var2016=$r3, var2574=$r2, var2857=org.antlr.v4.tool.ast.GrammarAST, var2694=$r53, var3501=org.antlr.runtime.tree.CommonTree, var1662=$r54, var2680=$r55, var3148=$r56, var839=$z8}
; {org.antlr.v4.semantics.SymbolChecks=var3490, r15=var2261, org.antlr.v4.tool.Rule=var2471, r8=var2304, org.antlr.v4.tool.LabelElementPair=var1859, r0=var2345, r1=var3893, org.antlr.v4.tool.LabelType=var412, $r3=var2016, $r2=var2574, org.antlr.v4.tool.ast.GrammarAST=var2857, $r53=var2694, org.antlr.runtime.tree.CommonTree=var3501, $r54=var1662, $r55=var2680, $r56=var3148, $z8=var839}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r15 := @this: org.antlr.v4.semantics.SymbolChecks;	r8 := @parameter0: org.antlr.v4.tool.Rule;	r0 := @parameter1: org.antlr.v4.tool.LabelElementPair;	r1 := @parameter2: org.antlr.v4.tool.LabelElementPair;	$r3 = r0.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.LabelType type>;	$r2 = r1.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.LabelType type>;	if $r3 == $r2 goto $r53 = r0.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.ast.GrammarAST element>;	$r53 = r0.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.ast.GrammarAST element>;	$r54 = virtualinvoke $r53.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$r55 = r1.<org.antlr.v4.tool.LabelElementPair: org.antlr.v4.tool.ast.GrammarAST element>;	$r56 = virtualinvoke $r55.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$z8 = virtualinvoke $r54.<java.lang.String: boolean equals(java.lang.Object)>($r56);	if $z8 != 0 goto return;	return
;block_num 3