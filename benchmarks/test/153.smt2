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

(declare-sort var1946 0)
(declare-sort var738 0)
(declare-sort var3234 0)
(declare-sort var3240 0)
(declare-sort var2303 0)
(declare-sort var442 0)
(declare-sort var2755 0)
(declare-sort var109 0)
(declare-sort var8 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-757091541 (var3240 var738 var3234) void)
(declare-fun cast-from-var1946-to-var3240 (var1946) var3240)
(declare-fun getOptionAST/-2017272787 (var442 String) var2303)
(declare-fun cast-from-var3234-to-var442 (var3234) var442)
(declare-fun var738_getGenerator/-1707420782 (var738) var2755)
(declare-fun getText/1230265107 (var109) String)
(declare-fun cast-from-var3234-to-var109 (var3234) var109)
(declare-fun predicate/-1223160633 (var1946) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun getTarget/-901670451 (var2755) var8)
(declare-fun getTargetStringLiteralFromString/-491001856 (var8 String) String)
(declare-const null-var1946 var1946)
(declare-const null-var738 var738)
(declare-const null-var3234 var3234)
(declare-const var1946-$assertionsDisabled Bool)
(declare-const null-var2303 var2303)
(declare-const var498 var1946) ; Statement: r0 := @this: org.antlr.v4.codegen.model.SemPred 
(assert (not (= var498 null-var1946)))
(declare-const var2365 var738) ; Statement: r1 := @parameter0: org.antlr.v4.codegen.OutputModelFactory 
(assert (not (= var2365 null-var738)))
(declare-const var3725 var3234) ; Statement: r2 := @parameter1: org.antlr.v4.tool.ast.ActionAST 
(assert (not (= var3725 null-var3234)))
(assert true)
;(assert (<init>/-757091541 (cast-from-var1946-to-var3240 var498) var2365 var3725)) ; Statement: specialinvoke r0.<org.antlr.v4.codegen.model.Action: void <init>(org.antlr.v4.codegen.OutputModelFactory,org.antlr.v4.tool.ast.ActionAST)>(r1, r2) 

(declare-const var498!1 var1946)
(declare-const var2365!1 var738)
(declare-const var3725!1 var3234)
(define-const var887 Bool var1946-$assertionsDisabled) ; Statement: $z0 = <org.antlr.v4.codegen.model.SemPred: boolean $assertionsDisabled> 
 ; Statement: if $z0 != 0 goto $r20 = virtualinvoke r2.<org.antlr.v4.tool.ast.ActionAST: org.antlr.v4.tool.ast.GrammarAST getOptionAST(java.lang.String)>("fail") 
(assert (not (= (ite var887 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var3745 var2303 (getOptionAST/-2017272787 (cast-from-var3234-to-var442 var3725!1) "fail")) ; Statement: $r20 = virtualinvoke r2.<org.antlr.v4.tool.ast.ActionAST: org.antlr.v4.tool.ast.GrammarAST getOptionAST(java.lang.String)>("fail") 
(define-const var3919 var2755 (var738_getGenerator/-1707420782 var2365!1)) ; Statement: $r21 = interfaceinvoke r1.<org.antlr.v4.codegen.OutputModelFactory: org.antlr.v4.codegen.CodeGenerator getGenerator()>() 
(assert true)
(define-const var3470 String (getText/1230265107 (cast-from-var3234-to-var109 var3725!1))) ; Statement: $r3 = virtualinvoke r2.<org.antlr.v4.tool.ast.ActionAST: java.lang.String getText()>() 
(declare-const var498!2 var1946)
(assert (not (= var498!2 null-var1946)))
(assert (= (predicate/-1223160633 var498!2) var3470)) ; Statement: r0.<org.antlr.v4.codegen.model.SemPred: java.lang.String predicate> = $r3 
(define-const var2343 String (predicate/-1223160633 var498!2)) ; Statement: $r4 = r0.<org.antlr.v4.codegen.model.SemPred: java.lang.String predicate> 
(assert true)
(define-const var3540 Bool (startsWith/-1785782452 var2343 "{")) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean startsWith(java.lang.String)>("{") 
 ; Statement: if $z1 == 0 goto $r23 = virtualinvoke $r21.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.codegen.Target getTarget()>() 
(assert (= (ite var3540 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var2428 var8 (getTarget/-901670451 var3919)) ; Statement: $r23 = virtualinvoke $r21.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.codegen.Target getTarget()>() 
(define-const var1972 String (predicate/-1223160633 var498!2)) ; Statement: $r24 = r0.<org.antlr.v4.codegen.model.SemPred: java.lang.String predicate> 
(assert true)
(define-const var2442 String (getTargetStringLiteralFromString/-491001856 var2428 var1972)) ; Statement: $r25 = virtualinvoke $r23.<org.antlr.v4.codegen.Target: java.lang.String getTargetStringLiteralFromString(java.lang.String)>($r24) 
(declare-const var498!3 var1946)
(assert (not (= var498!3 null-var1946)))
(assert (= (predicate/-1223160633 var498!3) var2442)) ; Statement: r0.<org.antlr.v4.codegen.model.SemPred: java.lang.String predicate> = $r25 
 ; Statement: if $r20 != null goto $z2 = $r20 instanceof org.antlr.v4.tool.ast.ActionAST 
(assert (not (not (= var3745 null-var2303)))) ; Negate: Cond: $r20 != null  
 ; Statement: return 
(check-sat)
; {<init>/-757091541=([org.antlr.v4.codegen.model.Action, org.antlr.v4.codegen.OutputModelFactory, org.antlr.v4.tool.ast.ActionAST], void), cast-from-var1946-to-var3240=([org.antlr.v4.codegen.model.SemPred], org.antlr.v4.codegen.model.Action), getOptionAST/-2017272787=([org.antlr.v4.tool.ast.GrammarASTWithOptions, java.lang.String], org.antlr.v4.tool.ast.GrammarAST), cast-from-var3234-to-var442=([org.antlr.v4.tool.ast.ActionAST], org.antlr.v4.tool.ast.GrammarASTWithOptions), var738_getGenerator/-1707420782=([org.antlr.v4.codegen.OutputModelFactory], org.antlr.v4.codegen.CodeGenerator), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var3234-to-var109=([org.antlr.v4.tool.ast.ActionAST], org.antlr.runtime.tree.CommonTree), predicate/-1223160633=([org.antlr.v4.codegen.model.SemPred], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), getTarget/-901670451=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.codegen.Target), getTargetStringLiteralFromString/-491001856=([org.antlr.v4.codegen.Target, java.lang.String], java.lang.String)}
; {var1946=org.antlr.v4.codegen.model.SemPred, var498=r0, var738=org.antlr.v4.codegen.OutputModelFactory, var2365=r1, var3234=org.antlr.v4.tool.ast.ActionAST, var3725=r2, var3240=org.antlr.v4.codegen.model.Action, var887=$z0, var2303=org.antlr.v4.tool.ast.GrammarAST, var442=org.antlr.v4.tool.ast.GrammarASTWithOptions, var3745=$r20, var2755=org.antlr.v4.codegen.CodeGenerator, var3919=$r21, var109=org.antlr.runtime.tree.CommonTree, var3470=$r3, var2343=$r4, var3540=$z1, var8=org.antlr.v4.codegen.Target, var2428=$r23, var1972=$r24, var2442=$r25}
; {org.antlr.v4.codegen.model.SemPred=var1946, r0=var498, org.antlr.v4.codegen.OutputModelFactory=var738, r1=var2365, org.antlr.v4.tool.ast.ActionAST=var3234, r2=var3725, org.antlr.v4.codegen.model.Action=var3240, $z0=var887, org.antlr.v4.tool.ast.GrammarAST=var2303, org.antlr.v4.tool.ast.GrammarASTWithOptions=var442, $r20=var3745, org.antlr.v4.codegen.CodeGenerator=var2755, $r21=var3919, org.antlr.runtime.tree.CommonTree=var109, $r3=var3470, $r4=var2343, $z1=var3540, org.antlr.v4.codegen.Target=var8, $r23=var2428, $r24=var1972, $r25=var2442}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.model.SemPred;	r1 := @parameter0: org.antlr.v4.codegen.OutputModelFactory;	r2 := @parameter1: org.antlr.v4.tool.ast.ActionAST;	specialinvoke r0.<org.antlr.v4.codegen.model.Action: void <init>(org.antlr.v4.codegen.OutputModelFactory,org.antlr.v4.tool.ast.ActionAST)>(r1, r2);	$z0 = <org.antlr.v4.codegen.model.SemPred: boolean $assertionsDisabled>;	if $z0 != 0 goto $r20 = virtualinvoke r2.<org.antlr.v4.tool.ast.ActionAST: org.antlr.v4.tool.ast.GrammarAST getOptionAST(java.lang.String)>("fail");	$r20 = virtualinvoke r2.<org.antlr.v4.tool.ast.ActionAST: org.antlr.v4.tool.ast.GrammarAST getOptionAST(java.lang.String)>("fail");	$r21 = interfaceinvoke r1.<org.antlr.v4.codegen.OutputModelFactory: org.antlr.v4.codegen.CodeGenerator getGenerator()>();	$r3 = virtualinvoke r2.<org.antlr.v4.tool.ast.ActionAST: java.lang.String getText()>();	r0.<org.antlr.v4.codegen.model.SemPred: java.lang.String predicate> = $r3;	$r4 = r0.<org.antlr.v4.codegen.model.SemPred: java.lang.String predicate>;	$z1 = virtualinvoke $r4.<java.lang.String: boolean startsWith(java.lang.String)>("{");	if $z1 == 0 goto $r23 = virtualinvoke $r21.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.codegen.Target getTarget()>();	$r23 = virtualinvoke $r21.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.codegen.Target getTarget()>();	$r24 = r0.<org.antlr.v4.codegen.model.SemPred: java.lang.String predicate>;	$r25 = virtualinvoke $r23.<org.antlr.v4.codegen.Target: java.lang.String getTargetStringLiteralFromString(java.lang.String)>($r24);	r0.<org.antlr.v4.codegen.model.SemPred: java.lang.String predicate> = $r25;	if $r20 != null goto $z2 = $r20 instanceof org.antlr.v4.tool.ast.ActionAST;	return
;block_num 4