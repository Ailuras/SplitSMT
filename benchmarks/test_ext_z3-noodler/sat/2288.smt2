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

(declare-sort var860 0)
(declare-sort var564 0)
(declare-sort var223 0)
(declare-sort var3800 0)
(declare-sort var410 0)
(declare-sort var37 0)
(declare-sort var214 0)
(declare-sort var3788 0)
(declare-sort var2957 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun input/-639803156 (var223) var564)
(declare-fun cast-from-var860-to-var223 (var860) var223)
(declare-fun var564_LT/2142659000 (var564 Int) var3800)
(declare-fun cast-from-var3800-to-var410 (var3800) var410)
(declare-fun getText/1230265107 (var410) String)
(declare-fun ruleName/699239741 (var860) String)
(declare-fun state/-639803156 (var223) var37)
(declare-fun backtracking/1780090535 (var37) Int)
(declare-fun var214-init () var214)
(declare-fun cast-from-var564-to-var3788 (var564) var3788)
(declare-fun <init>/288558081 (var214 var3788 String String) void)
(declare-fun cast-from-var214-to-var2957 (var214) var2957)
(declare-const null-var860 var860)
(declare-const var343 var860) ; Statement: r0 := @this: org.antlr.v4.parse.LeftRecursiveRuleWalker 
(assert (not (= var343 null-var860)))
(define-const var103 var564 (input/-639803156 (cast-from-var860-to-var223 var343))) ; Statement: $r1 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(define-const var1576 var3800 (var564_LT/2142659000 var103 1)) ; Statement: $r2 = interfaceinvoke $r1.<org.antlr.runtime.tree.TreeNodeStream: java.lang.Object LT(int)>(1) 
(define-const var1610 var410 (cast-from-var3800-to-var410 var1576)) ; Statement: $r3 = (org.antlr.runtime.tree.CommonTree) $r2 
(assert true)
(define-const var2627 String (getText/1230265107 var1610)) ; Statement: $r5 = virtualinvoke $r3.<org.antlr.runtime.tree.CommonTree: java.lang.String getText()>() 
(define-const var459 String (ruleName/699239741 var343)) ; Statement: $r4 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.String ruleName> 
(assert true)
(define-const var2840 Bool (= var2627 var459)) ; Statement: $z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4) 
 ; Statement: if $z0 != 0 goto $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(assert (not (not (= (ite var2840 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1470 var37 (state/-639803156 (cast-from-var860-to-var223 var343))) ; Statement: $r9 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state> 
(define-const var211 Int (backtracking/1780090535 var1470)) ; Statement: $i0 = $r9.<org.antlr.runtime.RecognizerSharedState: int backtracking> 
 ; Statement: if $i0 <= 0 goto $r13 = new org.antlr.runtime.FailedPredicateException 
(assert (<= var211 0)) ; Cond: $i0 <= 0 
(define-const var415 var214 var214-init) ; Statement: $r13 = new org.antlr.runtime.FailedPredicateException 
(define-const var1054 var564 (input/-639803156 (cast-from-var860-to-var223 var343))) ; Statement: $r11 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(define-const var1848 var3788 (cast-from-var564-to-var3788 var1054)) ; Statement: $r14 = (org.antlr.runtime.IntStream) $r11 
(assert true)
;(assert (<init>/288558081 var415 var1848 "recurseNoLabel" "((CommonTree)input.LT(1)).getText().equals(ruleName)")) ; Statement: specialinvoke $r13.<org.antlr.runtime.FailedPredicateException: void <init>(org.antlr.runtime.IntStream,java.lang.String,java.lang.String)>($r14, "recurseNoLabel", "((CommonTree)input.LT(1)).getText().equals(ruleName)") 

(declare-const var415!1 var214)
(declare-const var1848!1 var3788)
(declare-const var1350 String)
(declare-const var2892 String)
(define-const var356 var2957 (cast-from-var214-to-var2957 var415!1)) ; Statement: $r15 = (java.lang.Throwable) $r13 
 ; Statement: throw $r15 
(check-sat)
; {input/-639803156=([org.antlr.runtime.tree.TreeParser], org.antlr.runtime.tree.TreeNodeStream), cast-from-var860-to-var223=([org.antlr.v4.parse.LeftRecursiveRuleWalker], org.antlr.runtime.tree.TreeParser), var564_LT/2142659000=([org.antlr.runtime.tree.TreeNodeStream, int], java.lang.Object), cast-from-var3800-to-var410=([java.lang.Object], org.antlr.runtime.tree.CommonTree), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), ruleName/699239741=([org.antlr.v4.parse.LeftRecursiveRuleWalker], java.lang.String), state/-639803156=([org.antlr.runtime.tree.TreeParser], org.antlr.runtime.RecognizerSharedState), backtracking/1780090535=([org.antlr.runtime.RecognizerSharedState], int), var214-init=([], org.antlr.runtime.FailedPredicateException), cast-from-var564-to-var3788=([org.antlr.runtime.tree.TreeNodeStream], org.antlr.runtime.IntStream), <init>/288558081=([org.antlr.runtime.FailedPredicateException, org.antlr.runtime.IntStream, java.lang.String, java.lang.String], void), cast-from-var214-to-var2957=([org.antlr.runtime.FailedPredicateException], java.lang.Throwable)}
; {var860=org.antlr.v4.parse.LeftRecursiveRuleWalker, var343=r0, var564=org.antlr.runtime.tree.TreeNodeStream, var223=org.antlr.runtime.tree.TreeParser, var103=$r1, var3800=java.lang.Object, var1576=$r2, var410=org.antlr.runtime.tree.CommonTree, var1610=$r3, var2627=$r5, var459=$r4, var2840=$z0, var37=org.antlr.runtime.RecognizerSharedState, var1470=$r9, var211=$i0, var214=org.antlr.runtime.FailedPredicateException, var415=$r13, var1054=$r11, var3788=org.antlr.runtime.IntStream, var1848=$r14, var1350="recurseNoLabel", var2892="((CommonTree)input.LT(1)).getText().equals(ruleName)", var2957=java.lang.Throwable, var356=$r15}
; {org.antlr.v4.parse.LeftRecursiveRuleWalker=var860, r0=var343, org.antlr.runtime.tree.TreeNodeStream=var564, org.antlr.runtime.tree.TreeParser=var223, $r1=var103, java.lang.Object=var3800, $r2=var1576, org.antlr.runtime.tree.CommonTree=var410, $r3=var1610, $r5=var2627, $r4=var459, $z0=var2840, org.antlr.runtime.RecognizerSharedState=var37, $r9=var1470, $i0=var211, org.antlr.runtime.FailedPredicateException=var214, $r13=var415, $r11=var1054, org.antlr.runtime.IntStream=var3788, $r14=var1848, "recurseNoLabel"=var1350, "((CommonTree)input.LT(1)).getText().equals(ruleName)"=var2892, java.lang.Throwable=var2957, $r15=var356}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.antlr.v4.parse.LeftRecursiveRuleWalker;	$r1 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r2 = interfaceinvoke $r1.<org.antlr.runtime.tree.TreeNodeStream: java.lang.Object LT(int)>(1);	$r3 = (org.antlr.runtime.tree.CommonTree) $r2;	$r5 = virtualinvoke $r3.<org.antlr.runtime.tree.CommonTree: java.lang.String getText()>();	$r4 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.String ruleName>;	$z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4);	if $z0 != 0 goto $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r9 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state>;	$i0 = $r9.<org.antlr.runtime.RecognizerSharedState: int backtracking>;	if $i0 <= 0 goto $r13 = new org.antlr.runtime.FailedPredicateException;	$r13 = new org.antlr.runtime.FailedPredicateException;	$r11 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r14 = (org.antlr.runtime.IntStream) $r11;	specialinvoke $r13.<org.antlr.runtime.FailedPredicateException: void <init>(org.antlr.runtime.IntStream,java.lang.String,java.lang.String)>($r14, "recurseNoLabel", "((CommonTree)input.LT(1)).getText().equals(ruleName)");	$r15 = (java.lang.Throwable) $r13;	throw $r15
;block_num 3