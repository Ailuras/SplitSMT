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

(declare-sort var1869 0)
(declare-sort var296 0)
(declare-sort var1960 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/1230265107 (var1960) String)
(declare-fun cast-from-var296-to-var1960 (var296) var1960)
(declare-const null-var1869 var1869)
(declare-const null-var296 var296)
(declare-const var2099 var1869) ; Statement: r3 := @this: org.antlr.v4.Tool$1UndefChecker 
(assert (not (= var2099 null-var1869)))
(declare-const var1690 var296) ; Statement: r0 := @parameter0: org.antlr.v4.tool.ast.TerminalAST 
(assert (not (= var1690 null-var296)))
(define-const var2943 String "EOF") ; Statement: $r2 = "EOF" 
(assert true)
(define-const var3566 String (getText/1230265107 (cast-from-var296-to-var1960 var1690))) ; Statement: $r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.TerminalAST: java.lang.String getText()>() 
(assert true)
(define-const var2654 Bool (= var2943 var3566)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = r3.<org.antlr.v4.Tool$1UndefChecker: org.antlr.v4.tool.Grammar val$g> 
(assert (not (= (ite var2654 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 
(check-sat)
; {getText/1230265107=([org.antlr.runtime.tree.CommonTree], java.lang.String), cast-from-var296-to-var1960=([org.antlr.v4.tool.ast.TerminalAST], org.antlr.runtime.tree.CommonTree)}
; {var1869=org.antlr.v4.Tool$1UndefChecker, var2099=r3, var296=org.antlr.v4.tool.ast.TerminalAST, var1690=r0, var2943=$r2, var1960=org.antlr.runtime.tree.CommonTree, var3566=$r1, var2654=$z0}
; {org.antlr.v4.Tool$1UndefChecker=var1869, r3=var2099, org.antlr.v4.tool.ast.TerminalAST=var296, r0=var1690, $r2=var2943, org.antlr.runtime.tree.CommonTree=var1960, $r1=var3566, $z0=var2654}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.antlr.v4.Tool$1UndefChecker;	r0 := @parameter0: org.antlr.v4.tool.ast.TerminalAST;	$r2 = "EOF";	$r1 = virtualinvoke r0.<org.antlr.v4.tool.ast.TerminalAST: java.lang.String getText()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r4 = r3.<org.antlr.v4.Tool$1UndefChecker: org.antlr.v4.tool.Grammar val$g>;	return
;block_num 2