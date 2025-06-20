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

(declare-sort var1424 0)
(declare-sort var2656 0)
(declare-sort var1601 0)
(declare-sort var1233 0)
(declare-sort var1325 0)
(declare-sort var3376 0)
(declare-sort var959 0)
(declare-sort var1858 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun input/-639803156 (var1601) var2656)
(declare-fun cast-from-var1424-to-var1601 (var1424) var1601)
(declare-fun var2656_LT/2142659000 (var2656 Int) var1233)
(declare-fun cast-from-var1233-to-var1325 (var1233) var1325)
(declare-fun getText/1230265107 (var1325) String)
(declare-fun ruleName/699239741 (var1424) String)
(declare-fun cast-from-var2656-to-var959 (var2656) var959)
(declare-fun match/-1938936256 (var1601 var959 Int var3376) var1233)
(declare-fun state/-639803156 (var1601) var1858)
(declare-fun failed/1780090535 (var1858) Bool)
(declare-const null-var1424 var1424)
(declare-const var1424-FOLLOW_RULE_REF_in_recurseNoLabel726 var3376)
(declare-const var1239 var1424) ; Statement: r0 := @this: org.antlr.v4.parse.LeftRecursiveRuleWalker 
(assert (not (= var1239 null-var1424)))
(define-const var912 var2656 (input/-639803156 (cast-from-var1424-to-var1601 var1239))) ; Statement: $r1 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(define-const var2561 var1233 (var2656_LT/2142659000 var912 1)) ; Statement: $r2 = interfaceinvoke $r1.<org.antlr.runtime.tree.TreeNodeStream: java.lang.Object LT(int)>(1) 
(define-const var485 var1325 (cast-from-var1233-to-var1325 var2561)) ; Statement: $r3 = (org.antlr.runtime.tree.CommonTree) $r2 
(assert true)
(define-const var3712 String (getText/1230265107 var485)) ; Statement: $r5 = virtualinvoke $r3.<org.antlr.runtime.tree.CommonTree: java.lang.String getText()>() 
(define-const var2358 String (ruleName/699239741 var1239)) ; Statement: $r4 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.String ruleName> 
(assert true)
(define-const var1182 Bool (= var3712 var2358)) ; Statement: $z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4) 
 ; Statement: if $z0 != 0 goto $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(assert (not (= (ite var1182 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3646 var2656 (input/-639803156 (cast-from-var1424-to-var1601 var1239))) ; Statement: $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(define-const var3693 var3376 var1424-FOLLOW_RULE_REF_in_recurseNoLabel726) ; Statement: $r6 = <org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.BitSet FOLLOW_RULE_REF_in_recurseNoLabel726> 
(define-const var2497 var959 (cast-from-var2656-to-var959 var3646)) ; Statement: $r16 = (org.antlr.runtime.IntStream) $r7 
(assert true)
;(assert (match/-1938936256 (cast-from-var1424-to-var1601 var1239) var2497 54 var3693)) ; Statement: virtualinvoke r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.Object match(org.antlr.runtime.IntStream,int,org.antlr.runtime.BitSet)>($r16, 54, $r6) 

(declare-const var1239!1 var1424)
(declare-const var2497!1 var959)
(declare-const var1781 Int)
(declare-const var3693!1 var3376)
(define-const var2299 var1858 (state/-639803156 (cast-from-var1424-to-var1601 var1239!1))) ; Statement: $r8 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state> 
(define-const var2750 Bool (failed/1780090535 var2299)) ; Statement: $z1 = $r8.<org.antlr.runtime.RecognizerSharedState: boolean failed> 
 ; Statement: if $z1 == 0 goto return 
(assert (not (= (ite var2750 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return 
(check-sat)
; {input/-639803156=([org.antlr.runtime.tree.TreeParser], org.antlr.runtime.tree.TreeNodeStream), cast-from-var1424-to-var1601=([org.antlr.v4.parse.LeftRecursiveRuleWalker], org.antlr.runtime.tree.TreeParser), var2656_LT/2142659000=([org.antlr.runtime.tree.TreeNodeStream, int], java.lang.Object), cast-from-var1233-to-var1325=([java.lang.Object], org.antlr.runtime.tree.CommonTree), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), ruleName/699239741=([org.antlr.v4.parse.LeftRecursiveRuleWalker], java.lang.String), cast-from-var2656-to-var959=([org.antlr.runtime.tree.TreeNodeStream], org.antlr.runtime.IntStream), match/-1938936256=([org.antlr.runtime.tree.TreeParser, org.antlr.runtime.IntStream, int, org.antlr.runtime.BitSet], java.lang.Object), state/-639803156=([org.antlr.runtime.tree.TreeParser], org.antlr.runtime.RecognizerSharedState), failed/1780090535=([org.antlr.runtime.RecognizerSharedState], boolean)}
; {var1424=org.antlr.v4.parse.LeftRecursiveRuleWalker, var1239=r0, var2656=org.antlr.runtime.tree.TreeNodeStream, var1601=org.antlr.runtime.tree.TreeParser, var912=$r1, var1233=java.lang.Object, var2561=$r2, var1325=org.antlr.runtime.tree.CommonTree, var485=$r3, var3712=$r5, var2358=$r4, var1182=$z0, var3646=$r7, var3376=org.antlr.runtime.BitSet, var3693=$r6, var959=org.antlr.runtime.IntStream, var2497=$r16, var1781=54, var1858=org.antlr.runtime.RecognizerSharedState, var2299=$r8, var2750=$z1}
; {org.antlr.v4.parse.LeftRecursiveRuleWalker=var1424, r0=var1239, org.antlr.runtime.tree.TreeNodeStream=var2656, org.antlr.runtime.tree.TreeParser=var1601, $r1=var912, java.lang.Object=var1233, $r2=var2561, org.antlr.runtime.tree.CommonTree=var1325, $r3=var485, $r5=var3712, $r4=var2358, $z0=var1182, $r7=var3646, org.antlr.runtime.BitSet=var3376, $r6=var3693, org.antlr.runtime.IntStream=var959, $r16=var2497, 54=var1781, org.antlr.runtime.RecognizerSharedState=var1858, $r8=var2299, $z1=var2750}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.antlr.v4.parse.LeftRecursiveRuleWalker;	$r1 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r2 = interfaceinvoke $r1.<org.antlr.runtime.tree.TreeNodeStream: java.lang.Object LT(int)>(1);	$r3 = (org.antlr.runtime.tree.CommonTree) $r2;	$r5 = virtualinvoke $r3.<org.antlr.runtime.tree.CommonTree: java.lang.String getText()>();	$r4 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.String ruleName>;	$z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4);	if $z0 != 0 goto $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r6 = <org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.BitSet FOLLOW_RULE_REF_in_recurseNoLabel726>;	$r16 = (org.antlr.runtime.IntStream) $r7;	virtualinvoke r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.Object match(org.antlr.runtime.IntStream,int,org.antlr.runtime.BitSet)>($r16, 54, $r6);	$r8 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state>;	$z1 = $r8.<org.antlr.runtime.RecognizerSharedState: boolean failed>;	if $z1 == 0 goto return;	return
;block_num 3