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

(declare-sort var849 0)
(declare-sort var2847 0)
(declare-sort var1733 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var1733) String)
(declare-fun cast-from-var2847-to-var1733 (var2847) var1733)
(declare-const null-var849 var849)
(declare-const null-var2847 var2847)
(declare-const var3824 var849) ; Statement: r2 := @this: org.antlr.v4.semantics.BasicSemanticChecks 
(assert (not (= var3824 null-var849)))
(declare-const var661 var2847) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var661 null-var2847)))
(assert true)
(define-const var814 String (getText/1230265107 (cast-from-var2847-to-var1733 var661))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var3473 Bool (= var814 "\u0027\u0027")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("\'\'") 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3473 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var2847-to-var1733=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree)}
; {var849=org.antlr.v4.semantics.BasicSemanticChecks, var3824=r2, var2847=org.antlr.v4.tool.ast.GrammarAST, var661=r0, var1733=org.antlr.runtime.tree.CommonTree, var814=r1, var3473=$z0}
; {org.antlr.v4.semantics.BasicSemanticChecks=var849, r2=var3824, org.antlr.v4.tool.ast.GrammarAST=var2847, r0=var661, org.antlr.runtime.tree.CommonTree=var1733, r1=var814, $z0=var3473}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.antlr.v4.semantics.BasicSemanticChecks;	r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST;	r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("\'\'");	if $z0 == 0 goto return;	return
;block_num 2