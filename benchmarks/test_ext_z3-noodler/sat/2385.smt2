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

(declare-sort var3808 0)
(declare-sort var1037 0)
(declare-sort var312 0)
(declare-sort var43 0)
(declare-sort var2303 0)
(declare-sort var1331 0)
(declare-sort var1534 0)
(declare-sort var88 0)
(declare-sort var1283 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var312) String)
(declare-fun cast-from-var1037-to-var312 (var1037) var312)
(declare-fun g/2016724089 (var3808) var43)
(declare-fun tool/976633046 (var43) var2303)
(declare-fun errMgr/-858771875 (var2303) var1331)
(declare-fun fileName/976633046 (var43) String)
(declare-fun token/-354376 (var312) var88)
(declare-fun arr-var1283-init () (Array Int var1283))
(declare-fun cast-from-String-to-var1283 (String) var1283)
(declare-fun grammarError/-1996540265 (var1331 var1534 String var88 (Array Int var1283)) void)
(declare-const null-var3808 var3808)
(declare-const null-var1037 var1037)
(declare-const var1534-EMPTY_STRINGS_AND_SETS_NOT_ALLOWED var1534)
(declare-const null-__Array__Int__var1283__ (Array Int var1283))
(declare-const var2490 var3808) ; Statement: r2 := @this: org.antlr.v4.semantics.BasicSemanticChecks 
(assert (not (= var2490 null-var3808)))
(declare-const var284 var1037) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var284 null-var1037)))
(assert true)
(define-const var2296 String (getText/1230265107 (cast-from-var1037-to-var312 var284))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var932 Bool (= var2296 "\u0027\u0027")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("\'\'") 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var932 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2826 var43 (g/2016724089 var2490)) ; Statement: $r3 = r2.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g> 
(define-const var2525 var2303 (tool/976633046 var2826)) ; Statement: $r4 = $r3.<org.antlr.v4.tool.Grammar: org.antlr.v4.Tool tool> 
(define-const var2474 var1331 (errMgr/-858771875 var2525)) ; Statement: $r10 = $r4.<org.antlr.v4.Tool: org.antlr.v4.tool.ErrorManager errMgr> 
(define-const var3388 var1534 var1534-EMPTY_STRINGS_AND_SETS_NOT_ALLOWED) ; Statement: $r9 = <org.antlr.v4.tool.ErrorType: org.antlr.v4.tool.ErrorType EMPTY_STRINGS_AND_SETS_NOT_ALLOWED> 
(define-const var3900 var43 (g/2016724089 var2490)) ; Statement: $r5 = r2.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g> 
(define-const var3062 String (fileName/976633046 var3900)) ; Statement: $r8 = $r5.<org.antlr.v4.tool.Grammar: java.lang.String fileName> 
(define-const var3768 var88 (token/-354376 (cast-from-var1037-to-var312 var284))) ; Statement: $r7 = r0.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token token> 
(define-const var2882 (Array Int var1283) arr-var1283-init) ; Statement: $r6 = newarray (java.lang.Object)[1] 
(declare-const var2882!1 (Array Int var1283))
(assert (not (= var2882!1 null-__Array__Int__var1283__)))
(assert (= (select var2882!1 0) (cast-from-String-to-var1283 "\u0027\u0027"))) ; Statement: $r6[0] = "\'\'" 
(assert true)
;(assert (grammarError/-1996540265 var2474 var3388 var3062 var3768 var2882!1)) ; Statement: virtualinvoke $r10.<org.antlr.v4.tool.ErrorManager: void grammarError(org.antlr.v4.tool.ErrorType,java.lang.String,org.antlr.runtime.Token,java.lang.Object[])>($r9, $r8, $r7, $r6) 

(declare-const var2474!1 var1331)
(declare-const var3388!1 var1534)
(declare-const var3062!1 String)
(declare-const var3768!1 var88)
(declare-const var2882!2 (Array Int var1283))
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var1037-to-var312=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), g/2016724089=([org.antlr.v4.semantics.BasicSemanticChecks], org.antlr.v4.tool.Grammar), tool/976633046=([org.antlr.v4.tool.Grammar], org.antlr.v4.Tool), errMgr/-858771875=([org.antlr.v4.Tool], org.antlr.v4.tool.ErrorManager), fileName/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), token/-354376=([org.antlr.runtime.tree.CommonTree], org.antlr.runtime.Token), arr-var1283-init=([], java.lang.Object[]), cast-from-String-to-var1283=([java.lang.String], java.lang.Object), grammarError/-1996540265=([org.antlr.v4.tool.ErrorManager, org.antlr.v4.tool.ErrorType, java.lang.String, org.antlr.runtime.Token, java.lang.Object[]], void)}
; {var3808=org.antlr.v4.semantics.BasicSemanticChecks, var2490=r2, var1037=org.antlr.v4.tool.ast.GrammarAST, var284=r0, var312=org.antlr.runtime.tree.CommonTree, var2296=r1, var932=$z0, var43=org.antlr.v4.tool.Grammar, var2826=$r3, var2303=org.antlr.v4.Tool, var2525=$r4, var1331=org.antlr.v4.tool.ErrorManager, var2474=$r10, var1534=org.antlr.v4.tool.ErrorType, var3388=$r9, var3900=$r5, var3062=$r8, var88=org.antlr.runtime.Token, var3768=$r7, var1283=java.lang.Object, var2882=$r6}
; {org.antlr.v4.semantics.BasicSemanticChecks=var3808, r2=var2490, org.antlr.v4.tool.ast.GrammarAST=var1037, r0=var284, org.antlr.runtime.tree.CommonTree=var312, r1=var2296, $z0=var932, org.antlr.v4.tool.Grammar=var43, $r3=var2826, org.antlr.v4.Tool=var2303, $r4=var2525, org.antlr.v4.tool.ErrorManager=var1331, $r10=var2474, org.antlr.v4.tool.ErrorType=var1534, $r9=var3388, $r5=var3900, $r8=var3062, org.antlr.runtime.Token=var88, $r7=var3768, java.lang.Object=var1283, $r6=var2882}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.antlr.v4.semantics.BasicSemanticChecks;	r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST;	r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("\'\'");	if $z0 == 0 goto return;	$r3 = r2.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g>;	$r4 = $r3.<org.antlr.v4.tool.Grammar: org.antlr.v4.Tool tool>;	$r10 = $r4.<org.antlr.v4.Tool: org.antlr.v4.tool.ErrorManager errMgr>;	$r9 = <org.antlr.v4.tool.ErrorType: org.antlr.v4.tool.ErrorType EMPTY_STRINGS_AND_SETS_NOT_ALLOWED>;	$r5 = r2.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g>;	$r8 = $r5.<org.antlr.v4.tool.Grammar: java.lang.String fileName>;	$r7 = r0.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token token>;	$r6 = newarray (java.lang.Object)[1];	$r6[0] = "\'\'";	virtualinvoke $r10.<org.antlr.v4.tool.ErrorManager: void grammarError(org.antlr.v4.tool.ErrorType,java.lang.String,org.antlr.runtime.Token,java.lang.Object[])>($r9, $r8, $r7, $r6);	return
;block_num 3