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

(declare-sort var39 0)
(declare-sort var548 0)
(declare-sort var3982 0)
(declare-sort var1638 0)
(declare-sort var2731 0)
(declare-sort var2601 0)
(declare-sort var212 0)
(declare-sort var3388 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun input/-639803156 (var3982) var548)
(declare-fun cast-from-var39-to-var3982 (var39) var3982)
(declare-fun var548_LT/2142659000 (var548 Int) var1638)
(declare-fun cast-from-var1638-to-var2731 (var1638) var2731)
(declare-fun getText/1230265107 (var2731) String)
(declare-fun ruleName/699239741 (var39) String)
(declare-fun cast-from-var548-to-var212 (var548) var212)
(declare-fun match/-1938936256 (var3982 var212 Int var2601) var1638)
(declare-fun state/-639803156 (var3982) var3388)
(declare-fun failed/1780090535 (var3388) Bool)
(declare-const null-var39 var39)
(declare-const var39-FOLLOW_RULE_REF_in_recurseNoLabel726 var2601)
(declare-const var1954 var39) ; Statement: r0 := @this: org.antlr.v4.parse.LeftRecursiveRuleWalker 
(assert (not (= var1954 null-var39)))
(define-const var194 var548 (input/-639803156 (cast-from-var39-to-var3982 var1954))) ; Statement: $r1 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(define-const var1176 var1638 (var548_LT/2142659000 var194 1)) ; Statement: $r2 = interfaceinvoke $r1.<org.antlr.runtime.tree.TreeNodeStream: java.lang.Object LT(int)>(1) 
(define-const var879 var2731 (cast-from-var1638-to-var2731 var1176)) ; Statement: $r3 = (org.antlr.runtime.tree.CommonTree) $r2 
(assert true)
(define-const var3483 String (getText/1230265107 var879)) ; Statement: $r5 = virtualinvoke $r3.<org.antlr.runtime.tree.CommonTree: java.lang.String getText()>() 
(define-const var3712 String (ruleName/699239741 var1954)) ; Statement: $r4 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.String ruleName> 
(assert true)
(define-const var1323 Bool (= var3483 var3712)) ; Statement: $z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4) 
 ; Statement: if $z0 != 0 goto $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(assert (not (= (ite var1323 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2194 var548 (input/-639803156 (cast-from-var39-to-var3982 var1954))) ; Statement: $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input> 
(define-const var1260 var2601 var39-FOLLOW_RULE_REF_in_recurseNoLabel726) ; Statement: $r6 = <org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.BitSet FOLLOW_RULE_REF_in_recurseNoLabel726> 
(define-const var645 var212 (cast-from-var548-to-var212 var2194)) ; Statement: $r16 = (org.antlr.runtime.IntStream) $r7 
(assert true)
;(assert (match/-1938936256 (cast-from-var39-to-var3982 var1954) var645 54 var1260)) ; Statement: virtualinvoke r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.Object match(org.antlr.runtime.IntStream,int,org.antlr.runtime.BitSet)>($r16, 54, $r6) 

(declare-const var1954!1 var39)
(declare-const var645!1 var212)
(declare-const var3342 Int)
(declare-const var1260!1 var2601)
(define-const var2127 var3388 (state/-639803156 (cast-from-var39-to-var3982 var1954!1))) ; Statement: $r8 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state> 
(define-const var1545 Bool (failed/1780090535 var2127)) ; Statement: $z1 = $r8.<org.antlr.runtime.RecognizerSharedState: boolean failed> 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var1545 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {input/-639803156=([org.antlr.runtime.tree.TreeParser], org.antlr.runtime.tree.TreeNodeStream), cast-from-var39-to-var3982=([org.antlr.v4.parse.LeftRecursiveRuleWalker], org.antlr.runtime.tree.TreeParser), var548_LT/2142659000=([org.antlr.runtime.tree.TreeNodeStream, int], java.lang.Object), cast-from-var1638-to-var2731=([java.lang.Object], org.antlr.runtime.tree.CommonTree), getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), ruleName/699239741=([org.antlr.v4.parse.LeftRecursiveRuleWalker], java.lang.String), cast-from-var548-to-var212=([org.antlr.runtime.tree.TreeNodeStream], org.antlr.runtime.IntStream), match/-1938936256=([org.antlr.runtime.tree.TreeParser, org.antlr.runtime.IntStream, int, org.antlr.runtime.BitSet], java.lang.Object), state/-639803156=([org.antlr.runtime.tree.TreeParser], org.antlr.runtime.RecognizerSharedState), failed/1780090535=([org.antlr.runtime.RecognizerSharedState], boolean)}
; {var39=org.antlr.v4.parse.LeftRecursiveRuleWalker, var1954=r0, var548=org.antlr.runtime.tree.TreeNodeStream, var3982=org.antlr.runtime.tree.TreeParser, var194=$r1, var1638=java.lang.Object, var1176=$r2, var2731=org.antlr.runtime.tree.CommonTree, var879=$r3, var3483=$r5, var3712=$r4, var1323=$z0, var2194=$r7, var2601=org.antlr.runtime.BitSet, var1260=$r6, var212=org.antlr.runtime.IntStream, var645=$r16, var3342=54, var3388=org.antlr.runtime.RecognizerSharedState, var2127=$r8, var1545=$z1}
; {org.antlr.v4.parse.LeftRecursiveRuleWalker=var39, r0=var1954, org.antlr.runtime.tree.TreeNodeStream=var548, org.antlr.runtime.tree.TreeParser=var3982, $r1=var194, java.lang.Object=var1638, $r2=var1176, org.antlr.runtime.tree.CommonTree=var2731, $r3=var879, $r5=var3483, $r4=var3712, $z0=var1323, $r7=var2194, org.antlr.runtime.BitSet=var2601, $r6=var1260, org.antlr.runtime.IntStream=var212, $r16=var645, 54=var3342, org.antlr.runtime.RecognizerSharedState=var3388, $r8=var2127, $z1=var1545}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.antlr.v4.parse.LeftRecursiveRuleWalker;	$r1 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r2 = interfaceinvoke $r1.<org.antlr.runtime.tree.TreeNodeStream: java.lang.Object LT(int)>(1);	$r3 = (org.antlr.runtime.tree.CommonTree) $r2;	$r5 = virtualinvoke $r3.<org.antlr.runtime.tree.CommonTree: java.lang.String getText()>();	$r4 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.String ruleName>;	$z0 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>($r4);	if $z0 != 0 goto $r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r7 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.tree.TreeNodeStream input>;	$r6 = <org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.BitSet FOLLOW_RULE_REF_in_recurseNoLabel726>;	$r16 = (org.antlr.runtime.IntStream) $r7;	virtualinvoke r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: java.lang.Object match(org.antlr.runtime.IntStream,int,org.antlr.runtime.BitSet)>($r16, 54, $r6);	$r8 = r0.<org.antlr.v4.parse.LeftRecursiveRuleWalker: org.antlr.runtime.RecognizerSharedState state>;	$z1 = $r8.<org.antlr.runtime.RecognizerSharedState: boolean failed>;	if $z1 == 0 goto return;	return
;block_num 3