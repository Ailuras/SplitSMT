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

(declare-sort var2197 0)
(declare-sort var1904 0)
(declare-sort var1142 0)
(declare-sort var3170 0)
(declare-sort var3720 0)
(declare-sort var3262 0)
(declare-sort var1182 0)
(declare-sort var3870 0)
(declare-sort var3830 0)
(declare-sort var2502 0)
(declare-sort var2500 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun val$ruleToAST/67230739 (var2197) var3170)
(declare-fun getText/1230265107 (var3720) String)
(declare-fun cast-from-var1904-to-var3720 (var1904) var3720)
(declare-fun var3170_get/1088891777 (var3170 var3262) var3262)
(declare-fun cast-from-String-to-var3262 (String) var3262)
(declare-fun cast-from-var3262-to-var1182 (var3262) var1182)
(declare-fun getToken/1202842992 (var3720) var3870)
(declare-fun var3870_getInputStream/-1985324798 (var3870) var3830)
(declare-fun var3830_getSourceName/-286570653 (var3830) String)
(declare-fun currentRuleName/-641282007 (var2502) String)
(declare-fun cast-from-var2197-to-var2502 (var2197) var2502)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-fun var2500_isUpperCase/-385658622 (Int) Bool)
(declare-const null-var2197 var2197)
(declare-const null-var1904 var1904)
(declare-const null-var1142 var1142)
(declare-const null-var1182 var1182)
(declare-const var3989 var2197) ; Statement: r0 := @this: org.antlr.v4.Tool$1UndefChecker 
(assert (not (= var3989 null-var2197)))
(declare-const var1384 var1904) ; Statement: r1 := @parameter0: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var1384 null-var1904)))
(declare-const var2277 var1142) ; Statement: r24 := @parameter1: org.antlr.v4.tool.ast.ActionAST 
(assert (not (= var2277 null-var1142)))
(define-const var275 var3170 (val$ruleToAST/67230739 var3989)) ; Statement: $r2 = r0.<org.antlr.v4.Tool$1UndefChecker: java.util.Map val$ruleToAST> 
(assert true)
(define-const var2489 String (getText/1230265107 (cast-from-var1904-to-var3720 var1384))) ; Statement: $r3 = virtualinvoke r1.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(define-const var1890 var3262 (var3170_get/1088891777 var275 (cast-from-String-to-var3262 var2489))) ; Statement: $r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r3) 
(define-const var2540 var1182 (cast-from-var3262-to-var1182 var1890)) ; Statement: r5 = (org.antlr.v4.tool.ast.RuleAST) $r4 
(assert true)
(define-const var12 var3870 (getToken/1202842992 (cast-from-var1904-to-var3720 var1384))) ; Statement: $r6 = virtualinvoke r1.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token getToken()>() 
(define-const var3891 var3830 (var3870_getInputStream/-1985324798 var12)) ; Statement: $r7 = interfaceinvoke $r6.<org.antlr.runtime.Token: org.antlr.runtime.CharStream getInputStream()>() 
(define-const var1345 String (var3830_getSourceName/-286570653 var3891)) ; Statement: r8 = interfaceinvoke $r7.<org.antlr.runtime.CharStream: java.lang.String getSourceName()>() 
(define-const var2451 String (currentRuleName/-641282007 (cast-from-var2197-to-var2502 var3989))) ; Statement: $r9 = r0.<org.antlr.v4.Tool$1UndefChecker: java.lang.String currentRuleName> 
(assert (and true (and (> (str.len var2451) 0) (<= 0 0))))
(define-const var261 Int (charAt/698050440 var2451 0)) ; Statement: $c0 = virtualinvoke $r9.<java.lang.String: char charAt(int)>(0) 
(define-const var361 Bool (var2500_isUpperCase/-385658622 var261)) ; Statement: $z0 = staticinvoke <java.lang.Character: boolean isUpperCase(char)>($c0) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var361 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r5 != null goto return 
(assert (not (= var2540 null-var1182))) ; Cond: r5 != null 
 ; Statement: return 
(check-sat)
; {val$ruleToAST/67230739=([org.antlr.v4.Tool$1UndefChecker], java.util.Map), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var1904-to-var3720=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), var3170_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3262=([java.lang.String], java.lang.Object), cast-from-var3262-to-var1182=([java.lang.Object], org.antlr.v4.tool.ast.RuleAST), getToken/1202842992=([org.antlr.runtime.tree.CommonTree], org.antlr.runtime.Token), var3870_getInputStream/-1985324798=([org.antlr.runtime.Token], org.antlr.runtime.CharStream), var3830_getSourceName/-286570653=([org.antlr.runtime.CharStream], java.lang.String), currentRuleName/-641282007=([org.antlr.v4.parse.GrammarTreeVisitor], java.lang.String), cast-from-var2197-to-var2502=([org.antlr.v4.Tool$1UndefChecker], org.antlr.v4.parse.GrammarTreeVisitor), charAt/698050440=([java.lang.String, int], char), var2500_isUpperCase/-385658622=([char], boolean)}
; {var2197=org.antlr.v4.Tool$1UndefChecker, var3989=r0, var1904=org.antlr.v4.tool.ast.GrammarAST, var1384=r1, var1142=org.antlr.v4.tool.ast.ActionAST, var2277=r24, var3170=java.util.Map, var275=$r2, var3720=org.antlr.runtime.tree.CommonTree, var2489=$r3, var3262=java.lang.Object, var1890=$r4, var1182=org.antlr.v4.tool.ast.RuleAST, var2540=r5, var3870=org.antlr.runtime.Token, var12=$r6, var3830=org.antlr.runtime.CharStream, var3891=$r7, var1345=r8, var2502=org.antlr.v4.parse.GrammarTreeVisitor, var2451=$r9, var261=$c0, var2500=java.lang.Character, var361=$z0}
; {org.antlr.v4.Tool$1UndefChecker=var2197, r0=var3989, org.antlr.v4.tool.ast.GrammarAST=var1904, r1=var1384, org.antlr.v4.tool.ast.ActionAST=var1142, r24=var2277, java.util.Map=var3170, $r2=var275, org.antlr.runtime.tree.CommonTree=var3720, $r3=var2489, java.lang.Object=var3262, $r4=var1890, org.antlr.v4.tool.ast.RuleAST=var1182, r5=var2540, org.antlr.runtime.Token=var3870, $r6=var12, org.antlr.runtime.CharStream=var3830, $r7=var3891, r8=var1345, org.antlr.v4.parse.GrammarTreeVisitor=var2502, $r9=var2451, $c0=var261, java.lang.Character=var2500, $z0=var361}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @this: org.antlr.v4.Tool$1UndefChecker;	r1 := @parameter0: org.antlr.v4.tool.ast.GrammarAST;	r24 := @parameter1: org.antlr.v4.tool.ast.ActionAST;	$r2 = r0.<org.antlr.v4.Tool$1UndefChecker: java.util.Map val$ruleToAST>;	$r3 = virtualinvoke r1.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r3);	r5 = (org.antlr.v4.tool.ast.RuleAST) $r4;	$r6 = virtualinvoke r1.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token getToken()>();	$r7 = interfaceinvoke $r6.<org.antlr.runtime.Token: org.antlr.runtime.CharStream getInputStream()>();	r8 = interfaceinvoke $r7.<org.antlr.runtime.CharStream: java.lang.String getSourceName()>();	$r9 = r0.<org.antlr.v4.Tool$1UndefChecker: java.lang.String currentRuleName>;	$c0 = virtualinvoke $r9.<java.lang.String: char charAt(int)>(0);	$z0 = staticinvoke <java.lang.Character: boolean isUpperCase(char)>($c0);	if $z0 == 0 goto (branch);	if r5 != null goto return;	return
;block_num 3