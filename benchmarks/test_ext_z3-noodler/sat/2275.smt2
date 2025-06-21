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

(declare-sort var1170 0)
(declare-sort var593 0)
(declare-sort var3247 0)
(declare-sort var2051 0)
(declare-sort var1771 0)
(declare-sort var1383 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun input/-639803156 (var3247) var593)
(declare-fun cast-from-var1170-to-var3247 (var1170) var3247)
(declare-fun var593_LT/2142659000 (var593 Int) var2051)
(declare-fun cast-from-var2051-to-var1771 (var2051) var1771)
(declare-fun getText/1230265107 (var1771) String)
(declare-fun ruleName/699239741 (var1170) String)
(declare-fun state/-639803156 (var3247) var1383)
(declare-fun backtracking/1780090535 (var1383) Int)
(declare-fun failed/1780090535 (var1383) Bool)
(declare-const null-var1170 var1170)
(declare-const null-var1383 var1383)
(declare-const var3304 var1170) ; Statement: r0 := @this: org.antlr.v4.parse.LeftRecursiveRuleWalker 
(assert (not (= var3304 null-var1170)))
(define-const var969 var593 (input/-639803156 (cast-from-var1170-to-var3247 var3304))) ; Statement: $r1 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(define-const var2656 var2051 (var593_LT/2142659000 var969 1)) ; Statement: $r2 = interfaceinvoke $r1.<org.antlr.runtime.tree.TreeNodeStream: java.lang.Object LT(int)>(1) 
(define-const var2121 var1771 (cast-from-var2051-to-var1771 var2656)) ; Statement: $r3 = (org.antlr.runtime.tree.CommonTree) $r2 
(assert true)
(define-const var3894 String (getText/1230265107 var2121)) ; Statement: $r5 = virtualinvoke $r3.<org.antlr.runtime.tree.CommonTree: java.lang.String getText()>() 
(define-const var1359 String (ruleName/699239741 var3304)) ; Statement: $r4 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.String ruleName> 
(assert true)
(define-const var624 Bool (= var3894 var1359)) ; Statement: $z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4) 
 ; Statement: if $z0 != 0 goto $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(assert (not (not (= (ite var624 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var196 var1383 (state/-639803156 (cast-from-var1170-to-var3247 var3304))) ; Statement: $r9 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state> 
(define-const var2595 Int (backtracking/1780090535 var196)) ; Statement: $i0 = $r9.<org.antlr.runtime.RecognizerSharedState: int backtracking> 
 ; Statement: if $i0 <= 0 goto $r13 = new org.antlr.runtime.FailedPredicateException 
(assert (not (<= var2595 0))) ; Negate: Cond: $i0 <= 0  
(define-const var2143 var1383 (state/-639803156 (cast-from-var1170-to-var3247 var3304))) ; Statement: $r12 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state> 
(declare-const var2143!1 var1383)
(assert (not (= var2143!1 null-var1383)))
(assert (= (failed/1780090535 var2143!1) (ite (= 1 1) true false))) ; Statement: $r12.<org.antlr.runtime.RecognizerSharedState: boolean failed> = 1 
 ; Statement: return 
(check-sat)
; {input/-639803156=([org.antlr.runtime.tree.TreeParser], org.antlr.runtime.tree.TreeNodeStream), cast-from-var1170-to-var3247=([org.antlr.v4.parse.LeftRecursiveRuleWalker], org.antlr.runtime.tree.TreeParser), var593_LT/2142659000=([org.antlr.runtime.tree.TreeNodeStream, int], java.lang.Object), cast-from-var2051-to-var1771=([java.lang.Object], org.antlr.runtime.tree.CommonTree), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), ruleName/699239741=([org.antlr.v4.parse.LeftRecursiveRuleWalker], java.lang.String), state/-639803156=([org.antlr.runtime.tree.TreeParser], org.antlr.runtime.RecognizerSharedState), backtracking/1780090535=([org.antlr.runtime.RecognizerSharedState], int), failed/1780090535=([org.antlr.runtime.RecognizerSharedState], boolean)}
; {var1170=org.antlr.v4.parse.LeftRecursiveRuleWalker, var3304=r0, var593=org.antlr.runtime.tree.TreeNodeStream, var3247=org.antlr.runtime.tree.TreeParser, var969=$r1, var2051=java.lang.Object, var2656=$r2, var1771=org.antlr.runtime.tree.CommonTree, var2121=$r3, var3894=$r5, var1359=$r4, var624=$z0, var1383=org.antlr.runtime.RecognizerSharedState, var196=$r9, var2595=$i0, var2143=$r12}
; {org.antlr.v4.parse.LeftRecursiveRuleWalker=var1170, r0=var3304, org.antlr.runtime.tree.TreeNodeStream=var593, org.antlr.runtime.tree.TreeParser=var3247, $r1=var969, java.lang.Object=var2051, $r2=var2656, org.antlr.runtime.tree.CommonTree=var1771, $r3=var2121, $r5=var3894, $r4=var1359, $z0=var624, org.antlr.runtime.RecognizerSharedState=var1383, $r9=var196, $i0=var2595, $r12=var2143}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.antlr.v4.parse.LeftRecursiveRuleWalker;	$r1 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r2 = interfaceinvoke $r1.<org.antlr.runtime.tree.TreeNodeStream: java.lang.Object LT(int)>(1);	$r3 = (org.antlr.runtime.tree.CommonTree) $r2;	$r5 = virtualinvoke $r3.<org.antlr.runtime.tree.CommonTree: java.lang.String getText()>();	$r4 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.String ruleName>;	$z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4);	if $z0 != 0 goto $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r9 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state>;	$i0 = $r9.<org.antlr.runtime.RecognizerSharedState: int backtracking>;	if $i0 <= 0 goto $r13 = new org.antlr.runtime.FailedPredicateException;	$r12 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state>;	$r12.<org.antlr.runtime.RecognizerSharedState: boolean failed> = 1;	return
;block_num 3