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

(declare-sort var3725 0)
(declare-sort var1163 0)
(declare-sort var2950 0)
(declare-sort var2849 0)
(declare-sort var1623 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ruleNames/-349602559 (var3725) var2950)
(declare-fun var2849_getNodeText/446178904 (var1163 var2950) String)
(declare-fun String_valueOf/-333372740 (var1623) String)
(declare-fun cast-from-String-to-var1623 (String) var1623)
(declare-const null-var3725 var3725)
(declare-const null-var1163 var1163)
(declare-const var2958 var3725) ; Statement: r1 := @this: org.antlr.v4.gui.TreeViewer$DefaultTreeTextProvider 
(assert (not (= var2958 null-var3725)))
(declare-const var2696 var1163) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var2696 null-var1163)))
(define-const var3059 var2950 (ruleNames/-349602559 var2958)) ; Statement: $r2 = r1.<org.antlr.v4.gui.TreeViewer$DefaultTreeTextProvider: java.util.List ruleNames> 
(define-const var614 String (var2849_getNodeText/446178904 var2696 var3059)) ; Statement: $r3 = staticinvoke <org.antlr.v4.runtime.tree.Trees: java.lang.String getNodeText(org.antlr.v4.runtime.tree.Tree,java.util.List)>(r0, $r2) 
(define-const var835 String (String_valueOf/-333372740 (cast-from-String-to-var1623 var614))) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r3) 
 ; Statement: return $r4 
(check-sat)
; {ruleNames/-349602559=([org.antlr.v4.gui.TreeViewer$DefaultTreeTextProvider], java.util.List), var2849_getNodeText/446178904=([org.antlr.v4.runtime.tree.Tree, java.util.List], java.lang.String), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-String-to-var1623=([java.lang.String], java.lang.Object)}
; {var3725=org.antlr.v4.gui.TreeViewer$DefaultTreeTextProvider, var2958=r1, var1163=org.antlr.v4.runtime.tree.Tree, var2696=r0, var2950=java.util.List, var3059=$r2, var2849=org.antlr.v4.runtime.tree.Trees, var614=$r3, var1623=java.lang.Object, var835=$r4}
; {org.antlr.v4.gui.TreeViewer$DefaultTreeTextProvider=var3725, r1=var2958, org.antlr.v4.runtime.tree.Tree=var1163, r0=var2696, java.util.List=var2950, $r2=var3059, org.antlr.v4.runtime.tree.Trees=var2849, $r3=var614, java.lang.Object=var1623, $r4=var835}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: org.antlr.v4.gui.TreeViewer$DefaultTreeTextProvider;	r0 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = r1.<org.antlr.v4.gui.TreeViewer$DefaultTreeTextProvider: java.util.List ruleNames>;	$r3 = staticinvoke <org.antlr.v4.runtime.tree.Trees: java.lang.String getNodeText(org.antlr.v4.runtime.tree.Tree,java.util.List)>(r0, $r2);	$r4 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r3);	return $r4
;block_num 1