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

(declare-sort var2043 0)
(declare-sort var551 0)
(declare-sort var165 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var165) String)
(declare-fun cast-from-var551-to-var165 (var551) var165)
(declare-const null-var2043 var2043)
(declare-const null-var551 var551)
(declare-const var489 var2043) ; Statement: r5 := @this: org.antlr.v4.semantics.RuleCollector 
(assert (not (= var489 null-var2043)))
(declare-const var1087 var551) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var1087 null-var551)))
(declare-const var2166 var551) ; Statement: r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var2166 null-var551)))
(assert true)
(define-const var329 String (getText/1230265107 (cast-from-var551-to-var165 var1087))) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>() 
(assert true)
(define-const var3761 Bool (= var329 "caseInsensitive")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive") 
 ; Statement: if $z0 == 0 goto return null 
(assert (= (ite var3761 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return null 
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var551-to-var165=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree)}
; {var2043=org.antlr.v4.semantics.RuleCollector, var489=r5, var551=org.antlr.v4.tool.ast.GrammarAST, var1087=r0, var2166=r2, var165=org.antlr.runtime.tree.CommonTree, var329=r1, var3761=$z0}
; {org.antlr.v4.semantics.RuleCollector=var2043, r5=var489, org.antlr.v4.tool.ast.GrammarAST=var551, r0=var1087, r2=var2166, org.antlr.runtime.tree.CommonTree=var165, r1=var329, $z0=var3761}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r5 := @this: org.antlr.v4.semantics.RuleCollector;	r0 := @parameter0: org.antlr.v4.tool.ast.GrammarAST;	r2 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.GrammarAST: java.lang.String getText()>();	$z0 = virtualinvoke r1.<java.lang.String: boolean equals(java.lang.Object)>("caseInsensitive");	if $z0 == 0 goto return null;	return null
;block_num 2