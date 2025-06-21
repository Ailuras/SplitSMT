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

(declare-sort var954 0)
(declare-sort var2185 0)
(declare-sort var1342 0)
(declare-sort var3550 0)
(declare-sort var3981 0)
(declare-sort var3659 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-fun newState/204731583 (var3550 var3981) var1342)
(declare-fun cast-from-var954-to-var3550 (var954) var3550)
(declare-fun epsilon/-162914384 (var3550 var1342 var1342) void)
(declare-fun var3659-init () var3659)
(declare-fun <init>/-2068117735 (var3659 var1342 var1342) void)
(declare-const null-var954 var954)
(declare-const null-String String)
(declare-const null-NullType var2185)
(declare-const null-var3981 var3981)
(declare-const var3653 var954) ; Statement: r4 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var3653 null-var954)))
(declare-const var3381 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3381 null-String)))
(assert true)
(define-const var3271 String (trim/-847153721 var3381)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var3557 Bool (isEmpty/-1285796103 var3271)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r12 = new org.antlr.v4.tool.ast.ActionAST 
(assert (not (= (ite var3557 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3075 var1342 (newState/204731583 (cast-from-var954-to-var3550 var3653) null-var3981)) ; Statement: r9 = virtualinvoke r4.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.runtime.atn.ATNState newState(org.antlr.v4.tool.ast.GrammarAST)>(null) 
(assert true)
(define-const var128 var1342 (newState/204731583 (cast-from-var954-to-var3550 var3653) null-var3981)) ; Statement: r7 = virtualinvoke r4.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.runtime.atn.ATNState newState(org.antlr.v4.tool.ast.GrammarAST)>(null) 
(assert true)
;(assert (epsilon/-162914384 (cast-from-var954-to-var3550 var3653) var3075 var128)) ; Statement: virtualinvoke r4.<org.antlr.v4.automata.LexerATNFactory: void epsilon(org.antlr.v4.runtime.atn.ATNState,org.antlr.v4.runtime.atn.ATNState)>(r9, r7) 

(declare-const var3653!1 var954)
(declare-const var3075!1 var1342)
(declare-const var128!1 var1342)
(define-const var1913 var3659 var3659-init) ; Statement: $r10 = new org.antlr.v4.automata.ATNFactory$Handle 
(assert true)
;(assert (<init>/-2068117735 var1913 var3075!1 var128!1)) ; Statement: specialinvoke $r10.<org.antlr.v4.automata.ATNFactory$Handle: void <init>(org.antlr.v4.runtime.atn.ATNState,org.antlr.v4.runtime.atn.ATNState)>(r9, r7) 

(declare-const var1913!1 var3659)
(declare-const var3075!2 var1342)
(declare-const var128!2 var1342)
 ; Statement: return $r10 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean), newState/204731583=([org.antlr.v4.automata.ParserATNFactory, org.antlr.v4.tool.ast.GrammarAST], org.antlr.v4.runtime.atn.ATNState), cast-from-var954-to-var3550=([org.antlr.v4.automata.LexerATNFactory], org.antlr.v4.automata.ParserATNFactory), epsilon/-162914384=([org.antlr.v4.automata.ParserATNFactory, org.antlr.v4.runtime.atn.ATNState, org.antlr.v4.runtime.atn.ATNState], void), var3659-init=([], org.antlr.v4.automata.ATNFactory$Handle), <init>/-2068117735=([org.antlr.v4.automata.ATNFactory$Handle, org.antlr.v4.runtime.atn.ATNState, org.antlr.v4.runtime.atn.ATNState], void)}
; {var954=org.antlr.v4.automata.LexerATNFactory, var3653=r4, var3381=r0, var2185=null_type, var3271=$r1, var3557=$z0, var1342=org.antlr.v4.runtime.atn.ATNState, var3550=org.antlr.v4.automata.ParserATNFactory, var3981=org.antlr.v4.tool.ast.GrammarAST, var3075=r9, var128=r7, var3659=org.antlr.v4.automata.ATNFactory$Handle, var1913=$r10}
; {org.antlr.v4.automata.LexerATNFactory=var954, r4=var3653, r0=var3381, null_type=var2185, $r1=var3271, $z0=var3557, org.antlr.v4.runtime.atn.ATNState=var1342, org.antlr.v4.automata.ParserATNFactory=var3550, org.antlr.v4.tool.ast.GrammarAST=var3981, r9=var3075, r7=var128, org.antlr.v4.automata.ATNFactory$Handle=var3659, $r10=var1913}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: boolean isEmpty()>": 1}
;stmts r4 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r12 = new org.antlr.v4.tool.ast.ActionAST;	r9 = virtualinvoke r4.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.runtime.atn.ATNState newState(org.antlr.v4.tool.ast.GrammarAST)>(null);	r7 = virtualinvoke r4.<org.antlr.v4.automata.LexerATNFactory: org.antlr.v4.runtime.atn.ATNState newState(org.antlr.v4.tool.ast.GrammarAST)>(null);	virtualinvoke r4.<org.antlr.v4.automata.LexerATNFactory: void epsilon(org.antlr.v4.runtime.atn.ATNState,org.antlr.v4.runtime.atn.ATNState)>(r9, r7);	$r10 = new org.antlr.v4.automata.ATNFactory$Handle;	specialinvoke $r10.<org.antlr.v4.automata.ATNFactory$Handle: void <init>(org.antlr.v4.runtime.atn.ATNState,org.antlr.v4.runtime.atn.ATNState)>(r9, r7);	return $r10
;block_num 2