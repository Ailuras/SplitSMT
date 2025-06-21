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

(declare-sort var3786 0)
(declare-sort var3750 0)
(declare-sort var431 0)
(declare-sort var3252 0)
(declare-sort var2826 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3750_getText/-2014085613 (var3750) String)
(declare-fun getText/1230265107 (var3252) String)
(declare-fun cast-from-var431-to-var3252 (var431) var3252)
(declare-fun var2826_parseBoolean/746105335 (String) Bool)
(declare-fun grammarCaseInsensitive/2016724089 (var3786) Bool)
(declare-const null-var3786 var3786)
(declare-const null-var3750 var3750)
(declare-const null-var431 var431)
(declare-const null-Int Int)
(declare-const var3831 var3786) ; Statement: r4 := @this: org.antlr.v4.semantics.BasicSemanticChecks 
(assert (not (= var3831 null-var3786)))
(declare-const var2157 var3750) ; Statement: r0 := @parameter0: org.antlr.runtime.Token 
(assert (not (= var2157 null-var3750)))
(declare-const var1527 var431) ; Statement: r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var1527 null-var431)))
(declare-const var1427 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var1427 null-Int)))
(define-const var448 String (var3750_getText/-2014085613 var2157)) ; Statement: r1 = interfaceinvoke r0.<org.antlr.runtime.Token: java.lang.String getText()>() 
(assert true)
(define-const var3584 Bool (= var448 "caseInsensitive")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive") 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var3584 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2820 String (getText/1230265107 (cast-from-var431-to-var3252 var1527))) ; Statement: r3 = virtualinvoke r2.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var1013 Bool (= var2820 "true")) ; Statement: $z1 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>("true") 
 ; Statement: if $z1 != 0 goto $z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (not (= (ite var1013 1 0) 0))) ; Cond: $z1 != 0 
(define-const var2377 Bool (var2826_parseBoolean/746105335 var2820)) ; Statement: $z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
 ; Statement: if i0 != 25 goto $z2 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: boolean grammarCaseInsensitive> 
(assert (not (= var1427 25))) ; Cond: i0 != 25 
(define-const var2407 Bool (grammarCaseInsensitive/2016724089 var3831)) ; Statement: $z2 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: boolean grammarCaseInsensitive> 
 ; Statement: if $z2 != $z4 goto (branch) 
(assert (not (= var2407 var2377))) ; Cond: $z2 != $z4 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var3750_getText/-2014085613=([org.antlr.runtime.Token], java.lang.String), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var431-to-var3252=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), var2826_parseBoolean/746105335=([java.lang.String], boolean), grammarCaseInsensitive/2016724089=([org.antlr.v4.semantics.BasicSemanticChecks], boolean)}
; {var3786=org.antlr.v4.semantics.BasicSemanticChecks, var3831=r4, var3750=org.antlr.runtime.Token, var2157=r0, var431=org.antlr.v4.tool.ast.GrammarAST, var1527=r2, var1427=i0, var448=r1, var3584=$z0, var3252=org.antlr.runtime.tree.CommonTree, var2820=r3, var1013=$z1, var2826=java.lang.Boolean, var2377=$z4, var2407=$z2}
; {org.antlr.v4.semantics.BasicSemanticChecks=var3786, r4=var3831, org.antlr.runtime.Token=var3750, r0=var2157, org.antlr.v4.tool.ast.GrammarAST=var431, r2=var1527, i0=var1427, r1=var448, $z0=var3584, org.antlr.runtime.tree.CommonTree=var3252, r3=var2820, $z1=var1013, java.lang.Boolean=var2826, $z4=var2377, $z2=var2407}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r4 := @this: org.antlr.v4.semantics.BasicSemanticChecks;	r0 := @parameter0: org.antlr.runtime.Token;	r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	i0 := @parameter2: int;	r1 = interfaceinvoke r0.<org.antlr.runtime.Token: java.lang.String getText()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive");	if $z0 == 0 goto return;	r3 = virtualinvoke r2.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$z1 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>("true");	if $z1 != 0 goto $z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	if i0 != 25 goto $z2 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: boolean grammarCaseInsensitive>;	$z2 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: boolean grammarCaseInsensitive>;	if $z2 != $z4 goto (branch);	goto [?= return];	return
;block_num 6