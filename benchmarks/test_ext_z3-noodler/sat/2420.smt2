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

(declare-sort var1029 0)
(declare-sort var2523 0)
(declare-sort var311 0)
(declare-sort var1561 0)
(declare-sort var3863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2523_getText/-2014085613 (var2523) String)
(declare-fun getText/1230265107 (var1561) String)
(declare-fun cast-from-var311-to-var1561 (var311) var1561)
(declare-fun var3863_parseBoolean/746105335 (String) Bool)
(declare-fun grammarCaseInsensitive/2016724089 (var1029) Bool)
(declare-const null-var1029 var1029)
(declare-const null-var2523 var2523)
(declare-const null-var311 var311)
(declare-const null-Int Int)
(declare-const var3449 var1029) ; Statement: r4 := @this: org.antlr.v4.semantics.BasicSemanticChecks 
(assert (not (= var3449 null-var1029)))
(declare-const var1618 var2523) ; Statement: r0 := @parameter0: org.antlr.runtime.Token 
(assert (not (= var1618 null-var2523)))
(declare-const var1764 var311) ; Statement: r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var1764 null-var311)))
(declare-const var2445 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var2445 null-Int)))
(define-const var904 String (var2523_getText/-2014085613 var1618)) ; Statement: r1 = interfaceinvoke r0.<org.antlr.runtime.Token: java.lang.String getText()>() 
(assert true)
(define-const var2555 Bool (= var904 "caseInsensitive")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive") 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var2555 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var271 String (getText/1230265107 (cast-from-var311-to-var1561 var1764))) ; Statement: r3 = virtualinvoke r2.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var2639 Bool (= var271 "true")) ; Statement: $z1 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>("true") 
 ; Statement: if $z1 != 0 goto $z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (not (= (ite var2639 1 0) 0))) ; Cond: $z1 != 0 
(define-const var3831 Bool (var3863_parseBoolean/746105335 var271)) ; Statement: $z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
 ; Statement: if i0 != 25 goto $z2 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: boolean grammarCaseInsensitive> 
(assert (not (not (= var2445 25)))) ; Negate: Cond: i0 != 25  
(declare-const var3449!1 var1029)
(assert (not (= var3449!1 null-var1029)))
(assert (= (grammarCaseInsensitive/2016724089 var3449!1) var3831)) ; Statement: r4.<org.antlr.v4.semantics.BasicSemanticChecks: boolean grammarCaseInsensitive> = $z4 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var2523_getText/-2014085613=([org.antlr.runtime.Token], java.lang.String), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var311-to-var1561=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), var3863_parseBoolean/746105335=([java.lang.String], boolean), grammarCaseInsensitive/2016724089=([org.antlr.v4.semantics.BasicSemanticChecks], boolean)}
; {var1029=org.antlr.v4.semantics.BasicSemanticChecks, var3449=r4, var2523=org.antlr.runtime.Token, var1618=r0, var311=org.antlr.v4.tool.ast.GrammarAST, var1764=r2, var2445=i0, var904=r1, var2555=$z0, var1561=org.antlr.runtime.tree.CommonTree, var271=r3, var2639=$z1, var3863=java.lang.Boolean, var3831=$z4}
; {org.antlr.v4.semantics.BasicSemanticChecks=var1029, r4=var3449, org.antlr.runtime.Token=var2523, r0=var1618, org.antlr.v4.tool.ast.GrammarAST=var311, r2=var1764, i0=var2445, r1=var904, $z0=var2555, org.antlr.runtime.tree.CommonTree=var1561, r3=var271, $z1=var2639, java.lang.Boolean=var3863, $z4=var3831}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r4 := @this: org.antlr.v4.semantics.BasicSemanticChecks;	r0 := @parameter0: org.antlr.runtime.Token;	r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	i0 := @parameter2: int;	r1 = interfaceinvoke r0.<org.antlr.runtime.Token: java.lang.String getText()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive");	if $z0 == 0 goto return;	r3 = virtualinvoke r2.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$z1 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>("true");	if $z1 != 0 goto $z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	if i0 != 25 goto $z2 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: boolean grammarCaseInsensitive>;	r4.<org.antlr.v4.semantics.BasicSemanticChecks: boolean grammarCaseInsensitive> = $z4;	goto [?= (branch)];	goto [?= return];	return
;block_num 6