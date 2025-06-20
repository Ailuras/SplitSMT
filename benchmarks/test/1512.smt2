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

(declare-sort var137 0)
(declare-sort var962 0)
(declare-sort var1200 0)
(declare-sort var3211 0)
(declare-sort var93 0)
(declare-sort var229 0)
(declare-sort var438 0)
(declare-sort var1457 0)
(declare-sort var3951 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var1200) String)
(declare-fun cast-from-var962-to-var1200 (var962) var1200)
(declare-fun newState/204731583 (var93 var229) var3211)
(declare-fun cast-from-var137-to-var93 (var137) var93)
(declare-fun cast-from-var962-to-var229 (var962) var229)
(declare-fun var438-init () var438)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun <init>/1119754900 (var438 var3211 Int) void)
(declare-fun cast-from-var438-to-var1457 (var438) var1457)
(declare-fun addTransition/648921640 (var3211 var1457) void)
(declare-fun var3951-init () var3951)
(declare-fun <init>/-2068117735 (var3951 var3211 var3211) void)
(declare-const null-var137 var137)
(declare-const null-var962 var962)
(declare-const var1159 var137) ; Statement: r2 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var1159 null-var137)))
(declare-const var478 var962) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.TerminalAST 
(assert (not (= var478 null-var962)))
(assert true)
(define-const var3391 String (getText/1230265107 (cast-from-var962-to-var1200 var478))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.TerminalAST: java.lang.String getText()>() 
(assert true)
(define-const var1198 Bool (= var3391 "EOF")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("EOF") 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.automata.ATNFactory$Handle _ruleRef(org.antlr.v4.tool.ast.GrammarAST)>(r0) 
(assert (not (= (ite var1198 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2894 var3211 (newState/204731583 (cast-from-var137-to-var93 var1159) (cast-from-var962-to-var229 var478))) ; Statement: r4 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.runtime.atn.ATNState newState(org.antlr.v4.tool.ast.GrammarAST)>(r0) 
(assert true)
(define-const var3984 var3211 (newState/204731583 (cast-from-var137-to-var93 var1159) (cast-from-var962-to-var229 var478))) ; Statement: r5 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.runtime.atn.ATNState newState(org.antlr.v4.tool.ast.GrammarAST)>(r0) 
(define-const var2516 var438 var438-init) ; Statement: $r8 = new org.antlr.v4.runtime.atn.AtomTransition 
(define-const var1009 Int (cast-from-Int-to-Int -1)) ; Statement: $i1 = (int) -1 
(assert true)
;(assert (<init>/1119754900 var2516 var3984 var1009)) ; Statement: specialinvoke $r8.<org.antlr.v4.runtime.atn.AtomTransition: void <init>(org.antlr.v4.runtime.atn.ATNState,int)>(r5, $i1) 

(declare-const var2516!1 var438)
(declare-const var3984!1 var3211)
(declare-const var1009!1 Int)
(define-const var227 var1457 (cast-from-var438-to-var1457 var2516!1)) ; Statement: $r10 = (org.antlr.v4.runtime.atn.Transition) $r8 
(assert true)
;(assert (addTransition/648921640 var2894 var227)) ; Statement: virtualinvoke r4.<org.antlr.v4.runtime.atn.ATNState: void addTransition(org.antlr.v4.runtime.atn.Transition)>($r10) 

(declare-const var2894!1 var3211)
(declare-const var227!1 var1457)
(define-const var618 var3951 var3951-init) ; Statement: $r9 = new org.antlr.v4.automata.ATNFactory$Handle 
(assert true)
;(assert (<init>/-2068117735 var618 var2894!1 var3984!1)) ; Statement: specialinvoke $r9.<org.antlr.v4.automata.ATNFactory$Handle: void <init>(org.antlr.v4.runtime.atn.ATNState,org.antlr.v4.runtime.atn.ATNState)>(r4, r5) 

(declare-const var618!1 var3951)
(declare-const var2894!2 var3211)
(declare-const var3984!2 var3211)
 ; Statement: return $r9 
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var962-to-var1200=([org.antlr.v4.tool.ast.TerminalAST], org.antlr.runtime.tree.CommonTree), newState/204731583=([org.antlr.v4.automata.ParserATNFactory, org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.runtime.atn.ATNState), cast-from-var137-to-var93=([org.antlr.v4.automata.LexerATNFactory], org.antlr.v4.automata.ParserATNFactory), cast-from-var962-to-var229=([org.antlr.v4.tool.ast.TerminalAST], org.antlr.v4.tool.ast.GrammarAST), var438-init=([], org.antlr.v4.runtime.atn.AtomTransition), cast-from-Int-to-Int=([int], int), <init>/1119754900=([org.antlr.v4.runtime.atn.AtomTransition, org.antlr.v4.runtime.atn.ATNState, int], void), cast-from-var438-to-var1457=([org.antlr.v4.runtime.atn.AtomTransition], org.antlr.v4.runtime.atn.Transition), addTransition/648921640=([org.antlr.v4.runtime.atn.ATNState, org.antlr.v4.runtime.atn.Transition], void), var3951-init=([], org.antlr.v4.automata.ATNFactory$Handle), <init>/-2068117735=([org.antlr.v4.automata.ATNFactory$Handle, org.antlr.v4.runtime.atn.ATNState, org.antlr.v4.runtime.atn.ATNState], void)}
; {var137=org.antlr.v4.automata.LexerATNFactory, var1159=r2, var962=org.antlr.v4.tool.ast.TerminalAST, var478=r0, var1200=org.antlr.runtime.tree.CommonTree, var3391=$r1, var1198=$z0, var3211=org.antlr.v4.runtime.atn.ATNState, var93=org.antlr.v4.automata.ParserATNFactory, var229=org.antlr.v4.tool.ast.GrammarAST, var2894=r4, var3984=r5, var438=org.antlr.v4.runtime.atn.AtomTransition, var2516=$r8, var1009=$i1, var1457=org.antlr.v4.runtime.atn.Transition, var227=$r10, var3951=org.antlr.v4.automata.ATNFactory$Handle, var618=$r9}
; {org.antlr.v4.automata.LexerATNFactory=var137, r2=var1159, org.antlr.v4.tool.ast.TerminalAST=var962, r0=var478, org.antlr.runtime.tree.CommonTree=var1200, $r1=var3391, $z0=var1198, org.antlr.v4.runtime.atn.ATNState=var3211, org.antlr.v4.automata.ParserATNFactory=var93, org.antlr.v4.tool.ast.GrammarAST=var229, r4=var2894, r5=var3984, org.antlr.v4.runtime.atn.AtomTransition=var438, $r8=var2516, $i1=var1009, org.antlr.v4.runtime.atn.Transition=var1457, $r10=var227, org.antlr.v4.automata.ATNFactory$Handle=var3951, $r9=var618}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: org.antlr.v4.tool.ast.TerminalAST;	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.TerminalAST: java.lang.String getText()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("EOF");	if $z0 == 0 goto $r3 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.automata.ATNFactory$Handle _ruleRef(org.antlr.v4.tool.ast.GrammarAST)>(r0);	r4 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.runtime.atn.ATNState newState(org.antlr.v4.tool.ast.GrammarAST)>(r0);	r5 = virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.runtime.atn.ATNState newState(org.antlr.v4.tool.ast.GrammarAST)>(r0);	$r8 = new org.antlr.v4.runtime.atn.AtomTransition;	$i1 = (int) -1;	specialinvoke $r8.<org.antlr.v4.runtime.atn.AtomTransition: void <init>(org.antlr.v4.runtime.atn.ATNState,int)>(r5, $i1);	$r10 = (org.antlr.v4.runtime.atn.Transition) $r8;	virtualinvoke r4.<org.antlr.v4.runtime.atn.ATNState: void addTransition(org.antlr.v4.runtime.atn.Transition)>($r10);	$r9 = new org.antlr.v4.automata.ATNFactory$Handle;	specialinvoke $r9.<org.antlr.v4.automata.ATNFactory$Handle: void <init>(org.antlr.v4.runtime.atn.ATNState,org.antlr.v4.runtime.atn.ATNState)>(r4, r5);	return $r9
;block_num 2