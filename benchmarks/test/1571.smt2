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

(declare-sort var1452 0)
(declare-sort var2988 0)
(declare-sort var262 0)
(declare-sort var3094 0)
(declare-sort var1855 0)
(declare-sort var2004 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var262) String)
(declare-fun cast-from-var2988-to-var262 (var2988) var262)
(declare-fun _ruleRef/548533400 (var1855 var2004) var3094)
(declare-fun cast-from-var1452-to-var1855 (var1452) var1855)
(declare-fun cast-from-var2988-to-var2004 (var2988) var2004)
(declare-const null-var1452 var1452)
(declare-const null-var2988 var2988)
(declare-const var171 var1452) ; Statement: r2 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var171 null-var1452)))
(declare-const var229 var2988) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.TerminalAST 
(assert (not (= var229 null-var2988)))
(assert true)
(define-const var233 String (getText/1230265107 (cast-from-var2988-to-var262 var229))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.TerminalAST: java.lang.String getText()>() 
(assert true)
(define-const var2729 Bool (= var233 "EOF")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("EOF") 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.automata.ATNFactory$Handle _ruleRef(org.antlr.v4.tool.ast.GrammarAST)>(r0) 
(assert (= (ite var2729 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var123 var3094 (_ruleRef/548533400 (cast-from-var1452-to-var1855 var171) (cast-from-var2988-to-var2004 var229))) ; Statement: $r3 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.automata.ATNFactory$Handle _ruleRef(org.antlr.v4.tool.ast.GrammarAST)>(r0) 
 ; Statement: return $r3 
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var2988-to-var262=([org.antlr.v4.tool.ast.TerminalAST], org.antlr.runtime.tree.CommonTree), _ruleRef/548533400=([org.antlr.v4.automata.ParserATNFactory, org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.automata.ATNFactory$Handle), cast-from-var1452-to-var1855=([org.antlr.v4.automata.LexerATNFactory], org.antlr.v4.automata.ParserATNFactory), cast-from-var2988-to-var2004=([org.antlr.v4.tool.ast.TerminalAST], org.antlr.v4.tool.ast.GrammarAST)}
; {var1452=org.antlr.v4.automata.LexerATNFactory, var171=r2, var2988=org.antlr.v4.tool.ast.TerminalAST, var229=r0, var262=org.antlr.runtime.tree.CommonTree, var233=$r1, var2729=$z0, var3094=org.antlr.v4.automata.ATNFactory$Handle, var1855=org.antlr.v4.automata.ParserATNFactory, var2004=org.antlr.v4.tool.ast.GrammarAST, var123=$r3}
; {org.antlr.v4.automata.LexerATNFactory=var1452, r2=var171, org.antlr.v4.tool.ast.TerminalAST=var2988, r0=var229, org.antlr.runtime.tree.CommonTree=var262, $r1=var233, $z0=var2729, org.antlr.v4.automata.ATNFactory$Handle=var3094, org.antlr.v4.automata.ParserATNFactory=var1855, org.antlr.v4.tool.ast.GrammarAST=var2004, $r3=var123}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: org.antlr.v4.tool.ast.TerminalAST;	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.TerminalAST: java.lang.String getText()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("EOF");	if $z0 == 0 goto $r3 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.automata.ATNFactory$Handle _ruleRef(org.antlr.v4.tool.ast.GrammarAST)>(r0);	$r3 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.automata.ATNFactory$Handle _ruleRef(org.antlr.v4.tool.ast.GrammarAST)>(r0);	return $r3
;block_num 2