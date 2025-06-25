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

(declare-sort var2672 0)
(declare-sort var332 0)
(declare-sort var2139 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/-791554220 (var2672 var332) String)
(declare-fun getBoundsOfNode/-1951447090 (var2672 var332) var2139)
(declare-fun x/-707491510 (var2139) Real)
(declare-fun nodeWidthPadding/-1930180878 (var2672) Int)
(declare-fun cast-from-Int-to-Real (Int) Real)
(declare-fun y/-707491510 (var2139) Real)
(declare-fun nodeHeightPaddingBelow/-1930180878 (var2672) Int)
(declare-const null-var2672 var2672)
(declare-const null-var332 var332)
(declare-const var1487 var2672) ; Statement: r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator 
(assert (not (= var1487 null-var2672)))
(declare-const var3393 var332) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var3393 null-var332)))
(assert true)
(define-const var3876 String (getText/-791554220 var1487 var3393)) ; Statement: $r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var259 = var3876.split("\n") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(assert true)
(define-const var761 var2139 (getBoundsOfNode/-1951447090 var1487 var3393)) ; Statement: r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var1919 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
 ; Statement: if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(assert (= (ite var1919 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3269 Real (x/-707491510 var761)) ; Statement: $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var2197 Int (nodeWidthPadding/-1930180878 var1487)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding> 
(define-const var3969 Real (cast-from-Int-to-Real var2197)) ; Statement: $d0 = (double) $i0 
(define-const var3487 Real (+ round var3269 var3969)) ; Statement: $d9 = $d1 + $d0 
(define-const var2565 Real (y/-707491510 var761)) ; Statement: $d3 = r4.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var651 Int (nodeHeightPaddingBelow/-1930180878 var1487)) ; Statement: $i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow> 
(define-const var2677 Real (cast-from-Int-to-Real var651)) ; Statement: $d2 = (double) $i1 
(define-const var3780 Real (+ round var2565 var2677)) ; Statement: d10 = $d3 + $d2 
(define-const var3481 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var3810 Int (get_split_length var3876 "\n" -1)) ; Statement: $i3 = lengthof r3 
 ; Statement: if i2 >= $i3 goto return 
(assert (>= var3481 var3810)) ; Cond: i2 >= $i3 
 ; Statement: return 
(check-sat)
; {getText/-791554220=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.lang.String), getBoundsOfNode/-1951447090=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), nodeWidthPadding/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int), cast-from-Int-to-Real=([int], double), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), nodeHeightPaddingBelow/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int)}
; {var2672=org.antlr.v4.gui.TreePostScriptGenerator, var1487=r0, var332=org.antlr.v4.runtime.tree.Tree, var3393=r1, var3876=$r2, var259=r3, var2139=java.awt.geom.Rectangle2D$Double, var761=r4, var1919=$z0, var3269=$d1, var2197=$i0, var3969=$d0, var3487=$d9, var2565=$d3, var651=$i1, var2677=$d2, var3780=d10, var3481=i2, var3810=$i3}
; {org.antlr.v4.gui.TreePostScriptGenerator=var2672, r0=var1487, org.antlr.v4.runtime.tree.Tree=var332, r1=var3393, $r2=var3876, r3=var259, java.awt.geom.Rectangle2D$Double=var2139, r4=var761, $z0=var1919, $d1=var3269, $i0=var2197, $d0=var3969, $d9=var3487, $d3=var2565, $i1=var651, $d2=var2677, d10=var3780, i2=var3481, $i3=var3810}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator;	r1 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	$z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding>;	$d0 = (double) $i0;	$d9 = $d1 + $d0;	$d3 = r4.<java.awt.geom.Rectangle2D$Double: double y>;	$i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow>;	$d2 = (double) $i1;	d10 = $d3 + $d2;	i2 = 0;	$i3 = lengthof r3;	if i2 >= $i3 goto return;	return
;block_num 4