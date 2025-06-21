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

(declare-sort var3479 0)
(declare-sort var934 0)
(declare-sort var3714 0)
(declare-sort var2303 0)
(declare-sort var425 0)
(declare-sort var1678 0)
(declare-sort var3245 0)
(declare-sort var3658 0)
(declare-sort var1980 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var934_getText/-2014085613 (var934) String)
(declare-fun getText/1230265107 (var2303) String)
(declare-fun cast-from-var3714-to-var2303 (var3714) var2303)
(declare-fun g/2016724089 (var3479) var425)
(declare-fun tool/976633046 (var425) var1678)
(declare-fun errMgr/-858771875 (var1678) var3245)
(declare-fun fileName/976633046 (var425) String)
(declare-fun getToken/1202842992 (var2303) var934)
(declare-fun arr-var1980-init () (Array Int var1980))
(declare-fun cast-from-String-to-var1980 (String) var1980)
(declare-fun grammarError/-1996540265 (var3245 var3658 String var934 (Array Int var1980)) void)
(declare-const null-var3479 var3479)
(declare-const null-var934 var934)
(declare-const null-var3714 var3714)
(declare-const null-Int Int)
(declare-const var3658-ILLEGAL_OPTION_VALUE var3658)
(declare-const null-__Array__Int__var1980__ (Array Int var1980))
(declare-const var1565 var3479) ; Statement: r4 := @this: org.antlr.v4.semantics.BasicSemanticChecks 
(assert (not (= var1565 null-var3479)))
(declare-const var2628 var934) ; Statement: r0 := @parameter0: org.antlr.runtime.Token 
(assert (not (= var2628 null-var934)))
(declare-const var2510 var3714) ; Statement: r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var2510 null-var3714)))
(declare-const var2269 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var2269 null-Int)))
(define-const var2393 String (var934_getText/-2014085613 var2628)) ; Statement: r1 = interfaceinvoke r0.<org.antlr.runtime.Token: java.lang.String getText()>() 
(assert true)
(define-const var3864 Bool (= var2393 "caseInsensitive")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive") 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var3864 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2188 String (getText/1230265107 (cast-from-var3714-to-var2303 var2510))) ; Statement: r3 = virtualinvoke r2.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var2526 Bool (= var2188 "true")) ; Statement: $z1 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>("true") 
 ; Statement: if $z1 != 0 goto $z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (not (not (= (ite var2526 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(assert true)
(define-const var2512 Bool (= var2188 "false")) ; Statement: $z3 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>("false") 
 ; Statement: if $z3 == 0 goto $r13 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g> 
(assert (= (ite var2512 1 0) 0)) ; Cond: $z3 == 0 
(define-const var2126 var425 (g/2016724089 var1565)) ; Statement: $r13 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g> 
(define-const var3587 var1678 (tool/976633046 var2126)) ; Statement: $r14 = $r13.<org.antlr.v4.tool.Grammar: org.antlr.v4.Tool tool> 
(define-const var3436 var3245 (errMgr/-858771875 var3587)) ; Statement: $r16 = $r14.<org.antlr.v4.Tool: org.antlr.v4.tool.ErrorManager errMgr> 
(define-const var3014 var3658 var3658-ILLEGAL_OPTION_VALUE) ; Statement: $r17 = <org.antlr.v4.tool.ErrorType: org.antlr.v4.tool.ErrorType ILLEGAL_OPTION_VALUE> 
(define-const var3493 var425 (g/2016724089 var1565)) ; Statement: $r15 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g> 
(define-const var556 String (fileName/976633046 var3493)) ; Statement: $r18 = $r15.<org.antlr.v4.tool.Grammar: java.lang.String fileName> 
(assert true)
(define-const var2905 var934 (getToken/1202842992 (cast-from-var3714-to-var2303 var2510))) ; Statement: $r20 = virtualinvoke r2.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token getToken()>() 
(define-const var3552 (Array Int var1980) arr-var1980-init) ; Statement: $r19 = newarray (java.lang.Object)[2] 
(declare-const var3552!1 (Array Int var1980))
(assert (not (= var3552!1 null-__Array__Int__var1980__)))
(assert (= (select var3552!1 0) (cast-from-String-to-var1980 var2393))) ; Statement: $r19[0] = r1 
(declare-const var3552!2 (Array Int var1980))
(assert (not (= var3552!2 null-__Array__Int__var1980__)))
(assert (= (select var3552!2 1) (cast-from-String-to-var1980 var2188))) ; Statement: $r19[1] = r3 
(assert true)
;(assert (grammarError/-1996540265 var3436 var3014 var556 var2905 var3552!2)) ; Statement: virtualinvoke $r16.<org.antlr.v4.tool.ErrorManager: void grammarError(org.antlr.v4.tool.ErrorType,java.lang.String,org.antlr.runtime.Token,java.lang.Object[])>($r17, $r18, $r20, $r19) 

(declare-const var3436!1 var3245)
(declare-const var3014!1 var3658)
(declare-const var556!1 String)
(declare-const var2905!1 var934)
(declare-const var3552!3 (Array Int var1980))
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var934_getText/-2014085613=([org.antlr.runtime.Token], java.lang.String), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var3714-to-var2303=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), g/2016724089=([org.antlr.v4.semantics.BasicSemanticChecks], org.antlr.v4.tool.Grammar), tool/976633046=([org.antlr.v4.tool.Grammar], org.antlr.v4.Tool), errMgr/-858771875=([org.antlr.v4.Tool], org.antlr.v4.tool.ErrorManager), fileName/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), getToken/1202842992=([org.antlr.runtime.tree.CommonTree], org.antlr.runtime.Token), arr-var1980-init=([], java.lang.Object[]), cast-from-String-to-var1980=([java.lang.String], java.lang.Object), grammarError/-1996540265=([org.antlr.v4.tool.ErrorManager, org.antlr.v4.tool.ErrorType, java.lang.String, org.antlr.runtime.Token, java.lang.Object[]], void)}
; {var3479=org.antlr.v4.semantics.BasicSemanticChecks, var1565=r4, var934=org.antlr.runtime.Token, var2628=r0, var3714=org.antlr.v4.tool.ast.GrammarAST, var2510=r2, var2269=i0, var2393=r1, var3864=$z0, var2303=org.antlr.runtime.tree.CommonTree, var2188=r3, var2526=$z1, var2512=$z3, var425=org.antlr.v4.tool.Grammar, var2126=$r13, var1678=org.antlr.v4.Tool, var3587=$r14, var3245=org.antlr.v4.tool.ErrorManager, var3436=$r16, var3658=org.antlr.v4.tool.ErrorType, var3014=$r17, var3493=$r15, var556=$r18, var2905=$r20, var1980=java.lang.Object, var3552=$r19}
; {org.antlr.v4.semantics.BasicSemanticChecks=var3479, r4=var1565, org.antlr.runtime.Token=var934, r0=var2628, org.antlr.v4.tool.ast.GrammarAST=var3714, r2=var2510, i0=var2269, r1=var2393, $z0=var3864, org.antlr.runtime.tree.CommonTree=var2303, r3=var2188, $z1=var2526, $z3=var2512, org.antlr.v4.tool.Grammar=var425, $r13=var2126, org.antlr.v4.Tool=var1678, $r14=var3587, org.antlr.v4.tool.ErrorManager=var3245, $r16=var3436, org.antlr.v4.tool.ErrorType=var3658, $r17=var3014, $r15=var3493, $r18=var556, $r20=var2905, java.lang.Object=var1980, $r19=var3552}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 3}
;stmts r4 := @this: org.antlr.v4.semantics.BasicSemanticChecks;	r0 := @parameter0: org.antlr.runtime.Token;	r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	i0 := @parameter2: int;	r1 = interfaceinvoke r0.<org.antlr.runtime.Token: java.lang.String getText()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive");	if $z0 == 0 goto return;	r3 = virtualinvoke r2.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$z1 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>("true");	if $z1 != 0 goto $z4 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z3 = virtualinvoke r3.<java.lang.String: boolean equals(java.lang.Object)>("false");	if $z3 == 0 goto $r13 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g>;	$r13 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g>;	$r14 = $r13.<org.antlr.v4.tool.Grammar: org.antlr.v4.Tool tool>;	$r16 = $r14.<org.antlr.v4.Tool: org.antlr.v4.tool.ErrorManager errMgr>;	$r17 = <org.antlr.v4.tool.ErrorType: org.antlr.v4.tool.ErrorType ILLEGAL_OPTION_VALUE>;	$r15 = r4.<org.antlr.v4.semantics.BasicSemanticChecks: org.antlr.v4.tool.Grammar g>;	$r18 = $r15.<org.antlr.v4.tool.Grammar: java.lang.String fileName>;	$r20 = virtualinvoke r2.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token getToken()>();	$r19 = newarray (java.lang.Object)[2];	$r19[0] = r1;	$r19[1] = r3;	virtualinvoke $r16.<org.antlr.v4.tool.ErrorManager: void grammarError(org.antlr.v4.tool.ErrorType,java.lang.String,org.antlr.runtime.Token,java.lang.Object[])>($r17, $r18, $r20, $r19);	return
;block_num 5