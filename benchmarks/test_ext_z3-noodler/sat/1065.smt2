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

(declare-sort var1214 0)
(declare-sort var908 0)
(declare-sort var2582 0)
(declare-sort var440 0)
(declare-sort var3154 0)
(declare-sort var1942 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var2582) String)
(declare-fun cast-from-var908-to-var2582 (var908) var2582)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var440-init () var440)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun <init>/-359238852 (var440 (Array Int Int)) void)
(declare-fun mode/1638333704 (var3154) var1942)
(declare-const null-var1214 var1214)
(declare-const null-var908 var908)
(declare-const var3154-NONE var3154)
(declare-const var1942-ERROR var1942)
(declare-const var811 var1214) ; Statement: r5 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var811 null-var1214)))
(declare-const var455 var908) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var455 null-var908)))
(assert true)
(define-const var3659 String (getText/1230265107 (cast-from-var908-to-var2582 var455))) ; Statement: r49 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var1156 Int (length/-134980193 var3659)) ; Statement: $i0 = virtualinvoke r49.<java.lang.String: int length()>() 
(define-const var2176 Int (- var1156 1)) ; Statement: $i1 = $i0 - 1 
(assert (and true (and (>= 1 0) (>= (str.len var3659) var2176) (>= var2176 1))))
(define-const var906 String (substring/-1240304868 var3659 1 var2176)) ; Statement: r50 = virtualinvoke r49.<java.lang.String: java.lang.String substring(int,int)>(1, $i1) 
(define-const var2968 var440 var440-init) ; Statement: $r1 = new org.antlr.v4.runtime.misc.IntervalSet 
(define-const var438 (Array Int Int) arr-Int-init) ; Statement: $r2 = newarray (int)[0] 
(assert true)
;(assert (<init>/-359238852 var2968 var438)) ; Statement: specialinvoke $r1.<org.antlr.v4.runtime.misc.IntervalSet: void <init>(int[])>($r2) 

(declare-const var2968!1 var440)
(declare-const var438!1 (Array Int Int))
(define-const var388 var3154 var3154-NONE) ; Statement: r51 = <org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState NONE> 
(assert true)
(define-const var2731 Int (length/-134980193 var906)) ; Statement: i2 = virtualinvoke r50.<java.lang.String: int length()>() 
(define-const var47 Int 0) ; Statement: i13 = 0 
(assert true) ; Non Conditional
 ; Statement: if i13 >= i2 goto $r4 = r51.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode mode> 
(assert (>= var47 var2731)) ; Cond: i13 >= i2 
(define-const var1973 var1942 (mode/1638333704 var388)) ; Statement: $r4 = r51.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode mode> 
(define-const var1480 var1942 var1942-ERROR) ; Statement: $r3 = <org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode ERROR> 
 ; Statement: if $r4 != $r3 goto virtualinvoke r5.<org.antlr.v4.automata.LexerATNFactory: void applyPrevState(org.antlr.v4.tool.ast.GrammarAST,org.antlr.v4.runtime.misc.IntervalSet,org.antlr.v4.automata.LexerATNFactory$CharSetParseState)>(r0, $r1, r51) 
(assert (not (not (= var1973 var1480)))) ; Negate: Cond: $r4 != $r3  
(define-const var1526 var440 var440-init) ; Statement: $r14 = new org.antlr.v4.runtime.misc.IntervalSet 
(define-const var2037 (Array Int Int) arr-Int-init) ; Statement: $r15 = newarray (int)[0] 
(assert true)
;(assert (<init>/-359238852 var1526 var2037)) ; Statement: specialinvoke $r14.<org.antlr.v4.runtime.misc.IntervalSet: void <init>(int[])>($r15) 

(declare-const var1526!1 var440)
(declare-const var2037!1 (Array Int Int))
 ; Statement: return $r14 
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var908-to-var2582=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var440-init=([], org.antlr.v4.runtime.misc.IntervalSet), arr-Int-init=([], int[]), <init>/-359238852=([org.antlr.v4.runtime.misc.IntervalSet, int[]], void), mode/1638333704=([org.antlr.v4.automata.LexerATNFactory$CharSetParseState], org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode)}
; {var1214=org.antlr.v4.automata.LexerATNFactory, var811=r5, var908=org.antlr.v4.tool.ast.GrammarAST, var455=r0, var2582=org.antlr.runtime.tree.CommonTree, var3659=r49, var1156=$i0, var2176=$i1, var906=r50, var440=org.antlr.v4.runtime.misc.IntervalSet, var2968=$r1, var438=$r2, var3154=org.antlr.v4.automata.LexerATNFactory$CharSetParseState, var388=r51, var2731=i2, var47=i13, var1942=org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode, var1973=$r4, var1480=$r3, var1526=$r14, var2037=$r15}
; {org.antlr.v4.automata.LexerATNFactory=var1214, r5=var811, org.antlr.v4.tool.ast.GrammarAST=var908, r0=var455, org.antlr.runtime.tree.CommonTree=var2582, r49=var3659, $i0=var1156, $i1=var2176, r50=var906, org.antlr.v4.runtime.misc.IntervalSet=var440, $r1=var2968, $r2=var438, org.antlr.v4.automata.LexerATNFactory$CharSetParseState=var3154, r51=var388, i2=var2731, i13=var47, org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode=var1942, $r4=var1973, $r3=var1480, $r14=var1526, $r15=var2037}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 2,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r5 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST;	r49 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$i0 = virtualinvoke r49.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r50 = virtualinvoke r49.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	$r1 = new org.antlr.v4.runtime.misc.IntervalSet;	$r2 = newarray (int)[0];	specialinvoke $r1.<org.antlr.v4.runtime.misc.IntervalSet: void <init>(int[])>($r2);	r51 = <org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState NONE>;	i2 = virtualinvoke r50.<java.lang.String: int length()>();	i13 = 0;	if i13 >= i2 goto $r4 = r51.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode mode>;	$r4 = r51.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode mode>;	$r3 = <org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode ERROR>;	if $r4 != $r3 goto virtualinvoke r5.<org.antlr.v4.automata.LexerATNFactory: void applyPrevState(org.antlr.v4.tool.ast.GrammarAST,org.antlr.v4.runtime.misc.IntervalSet,org.antlr.v4.automata.LexerATNFactory$CharSetParseState)>(r0, $r1, r51);	$r14 = new org.antlr.v4.runtime.misc.IntervalSet;	$r15 = newarray (int)[0];	specialinvoke $r14.<org.antlr.v4.runtime.misc.IntervalSet: void <init>(int[])>($r15);	return $r14
;block_num 4