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

(declare-sort var2509 0)
(declare-sort var2548 0)
(declare-sort var2664 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/-791554220 (var2509 var2548) String)
(declare-fun getBoundsOfNode/-1951447090 (var2509 var2548) var2664)
(declare-fun x/-707491510 (var2664) Float64)
(declare-fun nodeWidthPadding/-1930180878 (var2509) Int)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-fun y/-707491510 (var2664) Float64)
(declare-fun nodeHeightPaddingBelow/-1930180878 (var2509) Int)
(declare-const null-var2509 var2509)
(declare-const null-var2548 var2548)
(declare-const var3593 var2509) ; Statement: r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator 
(assert (not (= var3593 null-var2509)))
(declare-const var3507 var2548) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var3507 null-var2548)))
(assert true)
(define-const var1336 String (getText/-791554220 var3593 var3507)) ; Statement: $r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var1010 = var1336.split("\n") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(assert true)
(define-const var2291 var2664 (getBoundsOfNode/-1951447090 var3593 var3507)) ; Statement: r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var385 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
 ; Statement: if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(assert (= (ite var385 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1669 Float64 (x/-707491510 var2291)) ; Statement: $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var1889 Int (nodeWidthPadding/-1930180878 var3593)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding> 
(define-const var168 Float64 (cast-from-Int-to-Float64 var1889)) ; Statement: $d0 = (double) $i0 
(define-const var3134 Float64 (fp.add roundNearestTiesToEven var1669 var168)) ; Statement: $d9 = $d1 + $d0 
(define-const var2215 Float64 (y/-707491510 var2291)) ; Statement: $d3 = r4.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var3027 Int (nodeHeightPaddingBelow/-1930180878 var3593)) ; Statement: $i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow> 
(define-const var71 Float64 (cast-from-Int-to-Float64 var3027)) ; Statement: $d2 = (double) $i1 
(define-const var2322 Float64 (fp.add roundNearestTiesToEven var2215 var71)) ; Statement: d10 = $d3 + $d2 
(define-const var1987 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var1483 Int (get_split_length var1336 "\n" -1)) ; Statement: $i3 = lengthof r3 
 ; Statement: if i2 >= $i3 goto return 
(assert (>= var1987 var1483)) ; Cond: i2 >= $i3 
 ; Statement: return 
(check-sat)
; {getText/-791554220=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.lang.String), getBoundsOfNode/-1951447090=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), nodeWidthPadding/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int), cast-from-Int-to-Float64=([int], double), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), nodeHeightPaddingBelow/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int)}
; {var2509=org.antlr.v4.gui.TreePostScriptGenerator, var3593=r0, var2548=org.antlr.v4.runtime.tree.Tree, var3507=r1, var1336=$r2, var1010=r3, var2664=java.awt.geom.Rectangle2D$Double, var2291=r4, var385=$z0, var1669=$d1, var1889=$i0, var168=$d0, var3134=$d9, var2215=$d3, var3027=$i1, var71=$d2, var2322=d10, var1987=i2, var1483=$i3}
; {org.antlr.v4.gui.TreePostScriptGenerator=var2509, r0=var3593, org.antlr.v4.runtime.tree.Tree=var2548, r1=var3507, $r2=var1336, r3=var1010, java.awt.geom.Rectangle2D$Double=var2664, r4=var2291, $z0=var385, $d1=var1669, $i0=var1889, $d0=var168, $d9=var3134, $d3=var2215, $i1=var3027, $d2=var71, d10=var2322, i2=var1987, $i3=var1483}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator;	r1 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	$z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding>;	$d0 = (double) $i0;	$d9 = $d1 + $d0;	$d3 = r4.<java.awt.geom.Rectangle2D$Double: double y>;	$i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow>;	$d2 = (double) $i1;	d10 = $d3 + $d2;	i2 = 0;	$i3 = lengthof r3;	if i2 >= $i3 goto return;	return
;block_num 4