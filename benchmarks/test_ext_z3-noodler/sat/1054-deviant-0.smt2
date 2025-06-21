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

(declare-sort var2612 0)
(declare-sort var819 0)
(declare-sort var2211 0)
(declare-sort var785 0)
(declare-sort var2502 0)
(declare-sort var2205 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var2211) String)
(declare-fun cast-from-var819-to-var2211 (var819) var2211)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var785-init () var785)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun <init>/-359238852 (var785 (Array Int Int)) void)
(declare-fun mode/1638333704 (var2502) var2205)
(declare-const null-var2612 var2612)
(declare-const null-var819 var819)
(declare-const var2502-NONE var2502)
(declare-const var2205-ERROR var2205)
(declare-const var1604 var2612) ; Statement: r5 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var1604 null-var2612)))
(declare-const var1473 var819) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var1473 null-var819)))
(assert true)
(define-const var3738 String (getText/1230265107 (cast-from-var819-to-var2211 var1473))) ; Statement: r49 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var320 Int (length/-134980193 var3738)) ; Statement: $i0 = virtualinvoke r49.<java.lang.String: int length()>() 
(define-const var1758 Int (- var320 1)) ; Statement: $i1 = $i0 - 1 
(assert (not (and true (and (>= 1 0) (>= (str.len var3738) var1758) (>= var1758 1)))))
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var819-to-var2211=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var785-init=([], org.antlr.v4.runtime.misc.IntervalSet), arr-Int-init=([], int[]), <init>/-359238852=([org.antlr.v4.runtime.misc.IntervalSet, int[]], void), mode/1638333704=([org.antlr.v4.automata.LexerATNFactory$CharSetParseState], org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode)}
; {var2612=org.antlr.v4.automata.LexerATNFactory, var1604=r5, var819=org.antlr.v4.tool.ast.GrammarAST, var1473=r0, var2211=org.antlr.runtime.tree.CommonTree, var3738=r49, var320=$i0, var1758=$i1, var1308=r50, var785=org.antlr.v4.runtime.misc.IntervalSet, var2440=$r1, var1567=$r2, var2502=org.antlr.v4.automata.LexerATNFactory$CharSetParseState, var519=r51, var1158=i2, var1561=i13, var2205=org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode, var1266=$r17, var3861=$r16, var2041=$r47, var1784=$r48}
; {org.antlr.v4.automata.LexerATNFactory=var2612, r5=var1604, org.antlr.v4.tool.ast.GrammarAST=var819, r0=var1473, org.antlr.runtime.tree.CommonTree=var2211, r49=var3738, $i0=var320, $i1=var1758, r50=var1308, org.antlr.v4.runtime.misc.IntervalSet=var785, $r1=var2440, $r2=var1567, org.antlr.v4.automata.LexerATNFactory$CharSetParseState=var2502, r51=var519, i2=var1158, i13=var1561, org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode=var2205, $r17=var1266, $r16=var3861, $r47=var2041, $r48=var1784}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 2,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r5 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST;	r49 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$i0 = virtualinvoke r49.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r50 = virtualinvoke r49.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	$r1 = new org.antlr.v4.runtime.misc.IntervalSet;	$r2 = newarray (int)[0];	specialinvoke $r1.<org.antlr.v4.runtime.misc.IntervalSet: void <init>(int[])>($r2);	r51 = <org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState NONE>;	i2 = virtualinvoke r50.<java.lang.String: int length()>();	i13 = 0;	if i13 >= i2 goto $r4 = r51.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode mode>;	$r17 = r51.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode mode>;	$r16 = <org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode ERROR>;	if $r17 != $r16 goto i3 = virtualinvoke r50.<java.lang.String: int codePointAt(int)>(i13);	$r47 = new org.antlr.v4.runtime.misc.IntervalSet;	$r48 = newarray (int)[0];	specialinvoke $r47.<org.antlr.v4.runtime.misc.IntervalSet: void <init>(int[])>($r48);	return $r47
;block_num 4