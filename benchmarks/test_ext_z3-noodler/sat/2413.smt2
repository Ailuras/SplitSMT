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

(declare-sort var3662 0)
(declare-sort var1070 0)
(declare-sort var3811 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1070_getText/-2014085613 (var1070) String)
(declare-const null-var3662 var3662)
(declare-const null-var1070 var1070)
(declare-const null-var3811 var3811)
(declare-const null-Int Int)
(declare-const var3740 var3662) ; Statement: r4 := @this: org.antlr.v4.semantics.BasicSemanticChecks 
(assert (not (= var3740 null-var3662)))
(declare-const var315 var1070) ; Statement: r0 := @parameter0: org.antlr.runtime.Token 
(assert (not (= var315 null-var1070)))
(declare-const var1900 var3811) ; Statement: r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var1900 null-var3811)))
(declare-const var3457 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var3457 null-Int)))
(define-const var495 String (var1070_getText/-2014085613 var315)) ; Statement: r1 = interfaceinvoke r0.<org.antlr.runtime.Token: java.lang.String getText()>() 
(assert true)
(define-const var1432 Bool (= var495 "caseInsensitive")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive") 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var1432 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var1070_getText/-2014085613=([org.antlr.runtime.Token], java.lang.String)}
; {var3662=org.antlr.v4.semantics.BasicSemanticChecks, var3740=r4, var1070=org.antlr.runtime.Token, var315=r0, var3811=org.antlr.v4.tool.ast.GrammarAST, var1900=r2, var3457=i0, var495=r1, var1432=$z0}
; {org.antlr.v4.semantics.BasicSemanticChecks=var3662, r4=var3740, org.antlr.runtime.Token=var1070, r0=var315, org.antlr.v4.tool.ast.GrammarAST=var3811, r2=var1900, i0=var3457, r1=var495, $z0=var1432}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.antlr.v4.semantics.BasicSemanticChecks;	r0 := @parameter0: org.antlr.runtime.Token;	r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	i0 := @parameter2: int;	r1 = interfaceinvoke r0.<org.antlr.runtime.Token: java.lang.String getText()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive");	if $z0 == 0 goto return;	return
;block_num 2