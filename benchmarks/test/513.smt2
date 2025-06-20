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

(declare-sort var2513 0)
(declare-sort var3512 0)
(declare-sort var1859 0)
(declare-sort var3260 0)
(declare-sort var315 0)
(declare-sort var1552 0)
(declare-sort var2398 0)
(declare-sort var1614 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-fun var1859-init () var1859)
(declare-fun var3260-init () var3260)
(declare-fun <init>/1754656984 (var3260 Int String) void)
(declare-fun cast-from-var3260-to-var315 (var3260) var315)
(declare-fun <init>/437142474 (var1859 var315) void)
(declare-fun currentRule/1021783303 (var2398) var1552)
(declare-fun cast-from-var2513-to-var2398 (var2513) var2398)
(declare-fun currentOuterAlt/1021783303 (var2398) Int)
(declare-fun defineActionInAlt/-1377797707 (var1552 Int var1859) void)
(declare-fun action/545720762 (var2513 var1859) var1614)
(declare-const null-var2513 var2513)
(declare-const null-String String)
(declare-const var1059 var2513) ; Statement: r4 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var1059 null-var2513)))
(declare-const var942 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var942 null-String)))
(assert true)
(define-const var1523 String (trim/-847153721 var942)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var1202 Bool (isEmpty/-1285796103 var1523)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r12 = new org.antlr.v4.tool.ast.ActionAST 
(assert (= (ite var1202 1 0) 0)) ; Cond: $z0 == 0 
(define-const var739 var1859 var1859-init) ; Statement: $r12 = new org.antlr.v4.tool.ast.ActionAST 
(define-const var479 var3260 var3260-init) ; Statement: $r11 = new org.antlr.runtime.CommonToken 
(assert true)
;(assert (<init>/1754656984 var479 4 var942)) ; Statement: specialinvoke $r11.<org.antlr.runtime.CommonToken: void <init>(int,java.lang.String)>(4, r0) 

(declare-const var479!1 var3260)
(declare-const var844 Int)
(declare-const var942!1 String)
(define-const var580 var315 (cast-from-var3260-to-var315 var479!1)) ; Statement: $r13 = (org.antlr.runtime.Token) $r11 
(assert true)
;(assert (<init>/437142474 var739 var580)) ; Statement: specialinvoke $r12.<org.antlr.v4.tool.ast.ActionAST: void <init>(org.antlr.runtime.Token)>($r13) 

(declare-const var739!1 var1859)
(declare-const var580!1 var315)
(define-const var181 var1552 (currentRule/1021783303 (cast-from-var2513-to-var2398 var1059))) ; Statement: $r5 = r4.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.tool.Rule currentRule> 
(define-const var1840 Int (currentOuterAlt/1021783303 (cast-from-var2513-to-var2398 var1059))) ; Statement: $i0 = r4.<org.antlr.v4.automata.LexerATNFactory: int currentOuterAlt> 
(assert true)
;(assert (defineActionInAlt/-1377797707 var181 var1840 var739!1)) ; Statement: virtualinvoke $r5.<org.antlr.v4.tool.Rule: void defineActionInAlt(int,org.antlr.v4.tool.ast.ActionAST)>($i0, $r12) 

(declare-const var181!1 var1552)
(declare-const var1840!1 Int)
(declare-const var739!2 var1859)
(assert true)
(define-const var2068 var1614 (action/545720762 var1059 var739!2)) ; Statement: $r6 = virtualinvoke r4.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.automata.ATNFactory$Handle action(org.antlr.v4.tool.ast.ActionAST)>($r12) 
 ; Statement: return $r6 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean), var1859-init=([], org.antlr.v4.tool.ast.ActionAST), var3260-init=([], org.antlr.runtime.CommonToken), <init>/1754656984=([org.antlr.runtime.CommonToken, int, java.lang.String], void), cast-from-var3260-to-var315=([org.antlr.runtime.CommonToken], org.antlr.runtime.Token), <init>/437142474=([org.antlr.v4.tool.ast.ActionAST, org.antlr.runtime.Token], void), currentRule/1021783303=([org.antlr.v4.automata.ParserATNFactory], org.antlr.v4.tool.Rule), cast-from-var2513-to-var2398=([org.antlr.v4.automata.LexerATNFactory], org.antlr.v4.automata.ParserATNFactory), currentOuterAlt/1021783303=([org.antlr.v4.automata.ParserATNFactory], int), defineActionInAlt/-1377797707=([org.antlr.v4.tool.Rule, int, org.antlr.v4.tool.ast.ActionAST], void), action/545720762=([org.antlr.v4.automata.LexerATNFactory, org.antlr.v4.tool.ast.ActionAST], org.antlr.v4.automata.ATNFactory$Handle)}
; {var2513=org.antlr.v4.automata.LexerATNFactory, var1059=r4, var942=r0, var3512=null_type, var1523=$r1, var1202=$z0, var1859=org.antlr.v4.tool.ast.ActionAST, var739=$r12, var3260=org.antlr.runtime.CommonToken, var479=$r11, var844=4, var315=org.antlr.runtime.Token, var580=$r13, var1552=org.antlr.v4.tool.Rule, var2398=org.antlr.v4.automata.ParserATNFactory, var181=$r5, var1840=$i0, var1614=org.antlr.v4.automata.ATNFactory$Handle, var2068=$r6}
; {org.antlr.v4.automata.LexerATNFactory=var2513, r4=var1059, r0=var942, null_type=var3512, $r1=var1523, $z0=var1202, org.antlr.v4.tool.ast.ActionAST=var1859, $r12=var739, org.antlr.runtime.CommonToken=var3260, $r11=var479, 4=var844, org.antlr.runtime.Token=var315, $r13=var580, org.antlr.v4.tool.Rule=var1552, org.antlr.v4.automata.ParserATNFactory=var2398, $r5=var181, $i0=var1840, org.antlr.v4.automata.ATNFactory$Handle=var1614, $r6=var2068}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: boolean isEmpty()>": 1}
;stmts r4 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r12 = new org.antlr.v4.tool.ast.ActionAST;	$r12 = new org.antlr.v4.tool.ast.ActionAST;	$r11 = new org.antlr.runtime.CommonToken;	specialinvoke $r11.<org.antlr.runtime.CommonToken: void <init>(int,java.lang.String)>(4, r0);	$r13 = (org.antlr.runtime.Token) $r11;	specialinvoke $r12.<org.antlr.v4.tool.ast.ActionAST: void <init>(org.antlr.runtime.Token)>($r13);	$r5 = r4.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.tool.Rule currentRule>;	$i0 = r4.<org.antlr.v4.automata.LexerATNFactory: int currentOuterAlt>;	virtualinvoke $r5.<org.antlr.v4.tool.Rule: void defineActionInAlt(int,org.antlr.v4.tool.ast.ActionAST)>($i0, $r12);	$r6 = virtualinvoke r4.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.automata.ATNFactory$Handle action(org.antlr.v4.tool.ast.ActionAST)>($r12);	return $r6
;block_num 2