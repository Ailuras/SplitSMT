(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var655 0)
(declare-sort var2689 0)
(declare-sort var2503 0)
(declare-sort var2914 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/1762336425 (var655) var2503)
(declare-fun getText/-791554220 (var2503 var2689) String)
(declare-fun doc/-1930180878 (var2503) var2914)
(declare-fun getLineHeight/1985812787 (var2914) Real)
(declare-fun nodeHeightPaddingAbove/-1930180878 (var2503) Int)
(declare-fun cast-from-Int-to-Real (Int) Real)
(declare-fun nodeHeightPaddingBelow/-1930180878 (var2503) Int)
(declare-const null-var655 var655)
(declare-const null-var2689 var2689)
(declare-const var832 var655) ; Statement: r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide 
(assert (not (= var832 null-var655)))
(declare-const var2832 var2689) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var2832 null-var2689)))
(define-const var1415 var2503 (this$0/1762336425 var832)) ; Statement: $r2 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(assert true)
(define-const var2728 String (getText/-791554220 var1415 var2832)) ; Statement: r3 = virtualinvoke $r2.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var613 var2503 (this$0/1762336425 var832)) ; Statement: $r4 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var2592 var2914 (doc/-1930180878 var613)) ; Statement: $r5 = $r4.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc> 
(assert true)
(define-const var2306 Real (getLineHeight/1985812787 var2592)) ; Statement: $d1 = virtualinvoke $r5.<org.antlr.v4.gui.PostScriptDocument: double getLineHeight()>() 
(define-const var2548 var2503 (this$0/1762336425 var832)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var2028 Int (nodeHeightPaddingAbove/-1930180878 var2548)) ; Statement: $i0 = $r6.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingAbove> 
(define-const var2407 Real (cast-from-Int-to-Real var2028)) ; Statement: $d0 = (double) $i0 
(define-const var2577 Real (+ round var2306 var2407)) ; Statement: $d3 = $d1 + $d0 
(define-const var3235 var2503 (this$0/1762336425 var832)) ; Statement: $r7 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var3705 Int (nodeHeightPaddingBelow/-1930180878 var3235)) ; Statement: $i1 = $r7.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow> 
(define-const var1792 Real (cast-from-Int-to-Real var3705)) ; Statement: $d2 = (double) $i1 
(define-const var2057 Real (+ round var2577 var1792)) ; Statement: d4 = $d3 + $d2 
; split operation: var2861 = var2728.split("\n") ; Statement: r8 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var1358 Int (get_split_length var2728 "\n" -1)) ; Statement: $i2 = lengthof r8 
(define-const var1240 Real (cast-from-Int-to-Real var1358)) ; Statement: $d5 = (double) $i2 
(define-const var1253 Real (* round var2057 var1240)) ; Statement: $d6 = d4 * $d5 
 ; Statement: return $d6 
(check-sat)
; {this$0/1762336425=([org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide], org.antlr.v4.gui.TreePostScriptGenerator), getText/-791554220=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.lang.String), doc/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], org.antlr.v4.gui.PostScriptDocument), getLineHeight/1985812787=([org.antlr.v4.gui.PostScriptDocument], double), nodeHeightPaddingAbove/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int), cast-from-Int-to-Real=([int], double), nodeHeightPaddingBelow/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int)}
; {var655=org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide, var832=r0, var2689=org.antlr.v4.runtime.tree.Tree, var2832=r1, var2503=org.antlr.v4.gui.TreePostScriptGenerator, var1415=$r2, var2728=r3, var613=$r4, var2914=org.antlr.v4.gui.PostScriptDocument, var2592=$r5, var2306=$d1, var2548=$r6, var2028=$i0, var2407=$d0, var2577=$d3, var3235=$r7, var3705=$i1, var1792=$d2, var2057=d4, var2861=r8, var1358=$i2, var1240=$d5, var1253=$d6}
; {org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide=var655, r0=var832, org.antlr.v4.runtime.tree.Tree=var2689, r1=var2832, org.antlr.v4.gui.TreePostScriptGenerator=var2503, $r2=var1415, r3=var2728, $r4=var613, org.antlr.v4.gui.PostScriptDocument=var2914, $r5=var2592, $d1=var2306, $r6=var2548, $i0=var2028, $d0=var2407, $d3=var2577, $r7=var3235, $i1=var3705, $d2=var1792, d4=var2057, r8=var2861, $i2=var1358, $d5=var1240, $d6=var1253}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide;	r1 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	r3 = virtualinvoke $r2.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r4 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$r5 = $r4.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc>;	$d1 = virtualinvoke $r5.<org.antlr.v4.gui.PostScriptDocument: double getLineHeight()>();	$r6 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$i0 = $r6.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingAbove>;	$d0 = (double) $i0;	$d3 = $d1 + $d0;	$r7 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$i1 = $r7.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow>;	$d2 = (double) $i1;	d4 = $d3 + $d2;	r8 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$i2 = lengthof r8;	$d5 = (double) $i2;	$d6 = d4 * $d5;	return $d6
;block_num 1