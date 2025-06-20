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

(declare-sort var3917 0)
(declare-sort var1314 0)
(declare-sort var273 0)
(declare-sort var3931 0)
(declare-sort var2982 0)
(declare-sort var889 0)
(declare-sort var1935 0)
(declare-sort var275 0)
(declare-sort var2503 0)
(declare-sort var2756 0)
(declare-sort var2794 0)
(declare-sort var3302 0)
(declare-sort var1082 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getType/915254816 (var3931) Int)
(declare-fun cast-from-var1314-to-var3931 (var1314) var3931)
(declare-fun gen/1330868947 (var889) var2982)
(declare-fun cast-from-var3917-to-var889 (var3917) var889)
(declare-fun getTarget/-901670451 (var2982) var1935)
(declare-fun token/-354376 (var3931) var275)
(declare-fun var275_getTokenIndex/-1749615135 (var275) Int)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun getImplicitSetLabel/1915945637 (var1935 String) String)
(declare-fun getTokenLabelDecl/1900424113 (var3917 String) var2503)
(declare-fun cast-from-var2503-to-var2756 (var2503) var2756)
(declare-fun isImplicit/1899763636 (var2756) Bool)
(declare-fun var273_getLabels/-115365175 (var273) var2794)
(declare-fun var2794_add/328494887 (var2794 var3302) Bool)
(declare-fun cast-from-var2503-to-var3302 (var2503) var3302)
(declare-fun getCurrentRuleFunction/-1302664678 (var889) var1082)
(declare-fun getAltLabel/-142436163 (var1314) String)
(declare-fun addContextDecl/1255510782 (var1082 String var2503) void)
(declare-const null-var3917 var3917)
(declare-const null-var1314 var1314)
(declare-const null-var273 var273)
(declare-const null-var2756 var2756)
(declare-const var2083 var3917) ; Statement: r1 := @this: org.antlr.v4.codegen.ParserFactory 
(assert (not (= var2083 null-var3917)))
(declare-const var3570 var1314) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var3570 null-var1314)))
(declare-const var1814 var273) ; Statement: r7 := @parameter1: org.antlr.v4.codegen.model.LabeledOp 
(assert (not (= var1814 null-var273)))
(assert true)
(define-const var2321 Int (getType/915254816 (cast-from-var1314-to-var3931 var3570))) ; Statement: $i0 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: int getType()>() 
 ; Statement: if $i0 == 82 goto $r2 = r1.<org.antlr.v4.codegen.ParserFactory: org.antlr.v4.codegen.CodeGenerator gen> 
(assert (= var2321 82)) ; Cond: $i0 == 82 
(define-const var1838 var2982 (gen/1330868947 (cast-from-var3917-to-var889 var2083))) ; Statement: $r2 = r1.<org.antlr.v4.codegen.ParserFactory: org.antlr.v4.codegen.CodeGenerator gen> 
(assert true)
(define-const var3243 var1935 (getTarget/-901670451 var1838)) ; Statement: $r5 = virtualinvoke $r2.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.codegen.Target getTarget()>() 
(define-const var519 var275 (token/-354376 (cast-from-var1314-to-var3931 var3570))) ; Statement: $r3 = r0.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token token> 
(define-const var2016 Int (var275_getTokenIndex/-1749615135 var519)) ; Statement: $i1 = interfaceinvoke $r3.<org.antlr.runtime.Token: int getTokenIndex()>() 
(define-const var555 String (String_valueOf/1240665136 var2016)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var2112 String (getImplicitSetLabel/1915945637 var3243 var555)) ; Statement: $r23 = virtualinvoke $r5.<org.antlr.v4.codegen.Target: java.lang.String getImplicitSetLabel(java.lang.String)>($r4) 
(assert true)
(define-const var577 var2503 (getTokenLabelDecl/1900424113 var2083 var2112)) ; Statement: $r24 = virtualinvoke r1.<org.antlr.v4.codegen.ParserFactory: org.antlr.v4.codegen.model.decl.Decl getTokenLabelDecl(java.lang.String)>($r23) 
(define-const var3159 var2503 var577) ; Statement: r25 = $r24 
(define-const var867 var2756 (cast-from-var2503-to-var2756 var577)) ; Statement: $r6 = (org.antlr.v4.codegen.model.decl.TokenDecl) $r24 
(declare-const var867!1 var2756)
(assert (not (= var867!1 null-var2756)))
(assert (= (isImplicit/1899763636 var867!1) (ite (= 1 1) true false))) ; Statement: $r6.<org.antlr.v4.codegen.model.decl.TokenDecl: boolean isImplicit> = 1 
 ; Statement: goto [?= $r28 = interfaceinvoke r7.<org.antlr.v4.codegen.model.LabeledOp: java.util.List getLabels()>()] 
(assert true) ; Non Conditional
(define-const var2588 var2794 (var273_getLabels/-115365175 var1814)) ; Statement: $r28 = interfaceinvoke r7.<org.antlr.v4.codegen.model.LabeledOp: java.util.List getLabels()>() 
;(assert (var2794_add/328494887 var2588 (cast-from-var2503-to-var3302 var3159))) ; Statement: interfaceinvoke $r28.<java.util.List: boolean add(java.lang.Object)>(r25) 

(declare-const var2588!1 var2794)
(declare-const var3159!1 var2503)
(assert true)
(define-const var1088 var1082 (getCurrentRuleFunction/-1302664678 (cast-from-var3917-to-var889 var2083))) ; Statement: $r29 = virtualinvoke r1.<org.antlr.v4.codegen.ParserFactory: org.antlr.v4.codegen.model.RuleFunction getCurrentRuleFunction()>() 
(assert true)
(define-const var2184 String (getAltLabel/-142436163 var3570)) ; Statement: $r30 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getAltLabel()>() 
(assert true)
;(assert (addContextDecl/1255510782 var1088 var2184 var3159!1)) ; Statement: virtualinvoke $r29.<org.antlr.v4.codegen.model.RuleFunction: void addContextDecl(java.lang.String,org.antlr.v4.codegen.model.decl.Decl)>($r30, r25) 

(declare-const var1088!1 var1082)
(declare-const var2184!1 String)
(declare-const var3159!2 var2503)
 ; Statement: return 
(check-sat)
; {getType/915254816=([org.antlr.runtime.tree.CommonTree], int), cast-from-var1314-to-var3931=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), gen/1330868947=([org.antlr.v4.codegen.DefaultOutputModelFactory], org.antlr.v4.codegen.CodeGenerator), cast-from-var3917-to-var889=([org.antlr.v4.codegen.ParserFactory], org.antlr.v4.codegen.DefaultOutputModelFactory), getTarget/-901670451=([org.antlr.v4.codegen.CodeGenerator], org.antlr.v4.codegen.Target), token/-354376=([org.antlr.runtime.tree.CommonTree], org.antlr.runtime.Token), var275_getTokenIndex/-1749615135=([org.antlr.runtime.Token], int), String_valueOf/1240665136=([int], java.lang.String), getImplicitSetLabel/1915945637=([org.antlr.v4.codegen.Target, java.lang.String], java.lang.String), getTokenLabelDecl/1900424113=([org.antlr.v4.codegen.ParserFactory, java.lang.String], org.antlr.v4.codegen.model.decl.Decl), cast-from-var2503-to-var2756=([org.antlr.v4.codegen.model.decl.Decl], org.antlr.v4.codegen.model.decl.TokenDecl), isImplicit/1899763636=([org.antlr.v4.codegen.model.decl.TokenDecl], boolean), var273_getLabels/-115365175=([org.antlr.v4.codegen.model.LabeledOp], java.util.List), var2794_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var2503-to-var3302=([org.antlr.v4.codegen.model.decl.Decl], java.lang.Object), getCurrentRuleFunction/-1302664678=([org.antlr.v4.codegen.DefaultOutputModelFactory], org.antlr.v4.codegen.model.RuleFunction), getAltLabel/-142436163=([org.antlr.v4.tool.ast.GrammarAST], java.lang.String), addContextDecl/1255510782=([org.antlr.v4.codegen.model.RuleFunction, java.lang.String, org.antlr.v4.codegen.model.decl.Decl], void)}
; {var3917=org.antlr.v4.codegen.ParserFactory, var2083=r1, var1314=org.antlr.v4.tool.ast.GrammarAST, var3570=r0, var273=org.antlr.v4.codegen.model.LabeledOp, var1814=r7, var3931=org.antlr.runtime.tree.CommonTree, var2321=$i0, var2982=org.antlr.v4.codegen.CodeGenerator, var889=org.antlr.v4.codegen.DefaultOutputModelFactory, var1838=$r2, var1935=org.antlr.v4.codegen.Target, var3243=$r5, var275=org.antlr.runtime.Token, var519=$r3, var2016=$i1, var555=$r4, var2112=$r23, var2503=org.antlr.v4.codegen.model.decl.Decl, var577=$r24, var3159=r25, var2756=org.antlr.v4.codegen.model.decl.TokenDecl, var867=$r6, var2794=java.util.List, var2588=$r28, var3302=java.lang.Object, var1082=org.antlr.v4.codegen.model.RuleFunction, var1088=$r29, var2184=$r30}
; {org.antlr.v4.codegen.ParserFactory=var3917, r1=var2083, org.antlr.v4.tool.ast.GrammarAST=var1314, r0=var3570, org.antlr.v4.codegen.model.LabeledOp=var273, r7=var1814, org.antlr.runtime.tree.CommonTree=var3931, $i0=var2321, org.antlr.v4.codegen.CodeGenerator=var2982, org.antlr.v4.codegen.DefaultOutputModelFactory=var889, $r2=var1838, org.antlr.v4.codegen.Target=var1935, $r5=var3243, org.antlr.runtime.Token=var275, $r3=var519, $i1=var2016, $r4=var555, $r23=var2112, org.antlr.v4.codegen.model.decl.Decl=var2503, $r24=var577, r25=var3159, org.antlr.v4.codegen.model.decl.TokenDecl=var2756, $r6=var867, java.util.List=var2794, $r28=var2588, java.lang.Object=var3302, org.antlr.v4.codegen.model.RuleFunction=var1082, $r29=var1088, $r30=var2184}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r1 := @this: org.antlr.v4.codegen.ParserFactory;	r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST;	r7 := @parameter1: org.antlr.v4.codegen.model.LabeledOp;	$i0 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: int getType()>();	if $i0 == 82 goto $r2 = r1.<org.antlr.v4.codegen.ParserFactory: org.antlr.v4.codegen.CodeGenerator gen>;	$r2 = r1.<org.antlr.v4.codegen.ParserFactory: org.antlr.v4.codegen.CodeGenerator gen>;	$r5 = virtualinvoke $r2.<org.antlr.v4.codegen.CodeGenerator: org.antlr.v4.codegen.Target getTarget()>();	$r3 = r0.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token token>;	$i1 = interfaceinvoke $r3.<org.antlr.runtime.Token: int getTokenIndex()>();	$r4 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r23 = virtualinvoke $r5.<org.antlr.v4.codegen.Target: java.lang.String getImplicitSetLabel(java.lang.String)>($r4);	$r24 = virtualinvoke r1.<org.antlr.v4.codegen.ParserFactory: org.antlr.v4.codegen.model.decl.Decl getTokenLabelDecl(java.lang.String)>($r23);	r25 = $r24;	$r6 = (org.antlr.v4.codegen.model.decl.TokenDecl) $r24;	$r6.<org.antlr.v4.codegen.model.decl.TokenDecl: boolean isImplicit> = 1;	goto [?= $r28 = interfaceinvoke r7.<org.antlr.v4.codegen.model.LabeledOp: java.util.List getLabels()>()];	$r28 = interfaceinvoke r7.<org.antlr.v4.codegen.model.LabeledOp: java.util.List getLabels()>();	interfaceinvoke $r28.<java.util.List: boolean add(java.lang.Object)>(r25);	$r29 = virtualinvoke r1.<org.antlr.v4.codegen.ParserFactory: org.antlr.v4.codegen.model.RuleFunction getCurrentRuleFunction()>();	$r30 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getAltLabel()>();	virtualinvoke $r29.<org.antlr.v4.codegen.model.RuleFunction: void addContextDecl(java.lang.String,org.antlr.v4.codegen.model.decl.Decl)>($r30, r25);	return
;block_num 3