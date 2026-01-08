(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(declare-sort var1741 0)
(declare-sort var3761 0)
(declare-sort var3638 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/-791554220 (var1741 var3761) String)
(declare-fun getBoundsOfNode/-1951447090 (var1741 var3761) var3638)
(declare-fun x/-707491510 (var3638) Float64)
(declare-fun nodeWidthPadding/-1930180878 (var1741) Int)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-fun y/-707491510 (var3638) Float64)
(declare-fun nodeHeightPaddingBelow/-1930180878 (var1741) Int)
(declare-const null-var1741 var1741)
(declare-const null-var3761 var3761)
(declare-const var384 var1741) ; Statement: r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator 
(assert (not (= var384 null-var1741)))
(declare-const var820 var3761) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var820 null-var3761)))
(assert true)
(define-const var653 String (getText/-791554220 var384 var820)) ; Statement: $r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var3304 = var653.split("\n") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(assert true)
(define-const var3138 var3638 (getBoundsOfNode/-1951447090 var384 var820)) ; Statement: r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var733 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
 ; Statement: if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(assert (= (ite var733 1 0) 0)) ; Cond: $z0 == 0 
(define-const var460 Float64 (x/-707491510 var3138)) ; Statement: $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var651 Int (nodeWidthPadding/-1930180878 var384)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding> 
(define-const var631 Float64 (cast-from-Int-to-Float64 var651)) ; Statement: $d0 = (double) $i0 
(define-const var1246 Float64 (fp.add roundNearestTiesToEven var460 var631)) ; Statement: $d9 = $d1 + $d0 
(define-const var3018 Float64 (y/-707491510 var3138)) ; Statement: $d3 = r4.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var788 Int (nodeHeightPaddingBelow/-1930180878 var384)) ; Statement: $i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow> 
(define-const var2369 Float64 (cast-from-Int-to-Float64 var788)) ; Statement: $d2 = (double) $i1 
(define-const var3920 Float64 (fp.add roundNearestTiesToEven var3018 var2369)) ; Statement: d10 = $d3 + $d2 
(define-const var3099 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var2809 Int (get_split_length var653 "\n" -1)) ; Statement: $i3 = lengthof r3 
 ; Statement: if i2 >= $i3 goto return 
(assert (>= var3099 var2809)) ; Cond: i2 >= $i3 
 ; Statement: return 
(check-sat)
; {getText/-791554220=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.lang.String), getBoundsOfNode/-1951447090=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), nodeWidthPadding/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int), cast-from-Int-to-Float64=([int], double), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), nodeHeightPaddingBelow/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int)}
; {var1741=org.antlr.v4.gui.TreePostScriptGenerator, var384=r0, var3761=org.antlr.v4.runtime.tree.Tree, var820=r1, var653=$r2, var3304=r3, var3638=java.awt.geom.Rectangle2D$Double, var3138=r4, var733=$z0, var460=$d1, var651=$i0, var631=$d0, var1246=$d9, var3018=$d3, var788=$i1, var2369=$d2, var3920=d10, var3099=i2, var2809=$i3}
; {org.antlr.v4.gui.TreePostScriptGenerator=var1741, r0=var384, org.antlr.v4.runtime.tree.Tree=var3761, r1=var820, $r2=var653, r3=var3304, java.awt.geom.Rectangle2D$Double=var3638, r4=var3138, $z0=var733, $d1=var460, $i0=var651, $d0=var631, $d9=var1246, $d3=var3018, $i1=var788, $d2=var2369, d10=var3920, i2=var3099, $i3=var2809}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator;	r1 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	$z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding>;	$d0 = (double) $i0;	$d9 = $d1 + $d0;	$d3 = r4.<java.awt.geom.Rectangle2D$Double: double y>;	$i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow>;	$d2 = (double) $i1;	d10 = $d3 + $d2;	i2 = 0;	$i3 = lengthof r3;	if i2 >= $i3 goto return;	return
;block_num 4
