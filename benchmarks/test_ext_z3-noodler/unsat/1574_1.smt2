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

(declare-sort var709 0)
(declare-sort var59 0)
(declare-sort var473 0)
(declare-sort var19 0)
(declare-sort var1215 0)
(declare-sort var3850 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var473) String)
(declare-fun cast-from-var59-to-var473 (var59) var473)
(declare-fun getToken/1202842992 (var473) var19)
(declare-fun checkCommands/-1613994210 (var709 String var19) void)
(declare-fun cast-from-var1215-to-var3850 (var1215) var3850)
(declare-const null-var709 var709)
(declare-const null-var59 var59)
(declare-const var1215-INSTANCE var1215)
(declare-const var3932 var709) ; Statement: r2 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var3932 null-var709)))
(declare-const var96 var59) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var96 null-var59)))
(declare-const var97 var59) ; Statement: r11 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var97 null-var59)))
(assert true)
(define-const var2159 String (getText/1230265107 (cast-from-var59-to-var473 var96))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var2067 var19 (getToken/1202842992 (cast-from-var59-to-var473 var96))) ; Statement: $r3 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token getToken()>() 
(assert true)
;(assert (checkCommands/-1613994210 var3932 var2159 var2067)) ; Statement: virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: void checkCommands(java.lang.String,org.antlr.runtime.Token)>(r1, $r3) 

(declare-const var3932!1 var709)
(declare-const var2159!1 String)
(declare-const var2067!1 var19)
(define-const var3394 String "skip") ; Statement: $r4 = "skip" 
(assert true)
(define-const var1385 Bool (= var3394 var2159!1)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 == 0 goto $r5 = "more" 
(assert (not (= (ite var1385 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: if r11 != null goto $r5 = "more" 
(assert (not (not (= var97 null-var59)))) ; Negate: Cond: r11 != null  
(define-const var2358 var1215 var1215-INSTANCE) ; Statement: $r22 = <org.antlr.v4.runtime.atn.LexerSkipAction: org.antlr.v4.runtime.atn.LexerSkipAction INSTANCE> 
(define-const var2724 var3850 (cast-from-var1215-to-var3850 var2358)) ; Statement: $r35 = (org.antlr.v4.runtime.atn.LexerAction) $r22 
 ; Statement: return $r35 
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var59-to-var473=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), getToken/1202842992=([org.antlr.runtime.tree.CommonTree], org.antlr.runtime.Token), checkCommands/-1613994210=([org.antlr.v4.automata.LexerATNFactory, java.lang.String, org.antlr.runtime.Token], void), cast-from-var1215-to-var3850=([org.antlr.v4.runtime.atn.LexerSkipAction], org.antlr.v4.runtime.atn.LexerAction)}
; {var709=org.antlr.v4.automata.LexerATNFactory, var3932=r2, var59=org.antlr.v4.tool.ast.GrammarAST, var96=r0, var97=r11, var473=org.antlr.runtime.tree.CommonTree, var2159=r1, var19=org.antlr.runtime.Token, var2067=$r3, var3394=$r4, var1385=$z0, var1215=org.antlr.v4.runtime.atn.LexerSkipAction, var2358=$r22, var3850=org.antlr.v4.runtime.atn.LexerAction, var2724=$r35}
; {org.antlr.v4.automata.LexerATNFactory=var709, r2=var3932, org.antlr.v4.tool.ast.GrammarAST=var59, r0=var96, r11=var97, org.antlr.runtime.tree.CommonTree=var473, r1=var2159, org.antlr.runtime.Token=var19, $r3=var2067, $r4=var3394, $z0=var1385, org.antlr.v4.runtime.atn.LexerSkipAction=var1215, $r22=var2358, org.antlr.v4.runtime.atn.LexerAction=var3850, $r35=var2724}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST;	r11 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$r3 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token getToken()>();	virtualinvoke r2.<org.antlr.v4.automata.LexerATNFactory: void checkCommands(java.lang.String,org.antlr.runtime.Token)>(r1, $r3);	$r4 = "skip";	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 == 0 goto $r5 = "more";	if r11 != null goto $r5 = "more";	$r22 = <org.antlr.v4.runtime.atn.LexerSkipAction: org.antlr.v4.runtime.atn.LexerSkipAction INSTANCE>;	$r35 = (org.antlr.v4.runtime.atn.LexerAction) $r22;	return $r35
;block_num 3