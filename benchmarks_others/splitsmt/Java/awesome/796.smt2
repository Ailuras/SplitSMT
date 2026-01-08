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

(declare-sort var2188 0)
(declare-sort var3407 0)
(declare-sort var1340 0)
(declare-sort var1385 0)
(declare-sort var1634 0)
(declare-sort var3670 0)
(declare-sort var3291 0)
(declare-sort var2511 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBoundsOfNode/-98686064 (var2188 var1340) var1385)
(declare-fun isHighlighted/979820081 (var2188 var1340) Bool)
(declare-fun boxColor/-151695256 (var2188) var1634)
(declare-fun borderColor/-151695256 (var2188) var1634)
(declare-fun textColor/-151695256 (var2188) var1634)
(declare-fun setColor/1206064488 (var3407 var1634) void)
(declare-fun getText/1718706454 (var2188 var1340) String)
(declare-fun font/-151695256 (var2188) var3670)
(declare-fun getFontMetrics/1328729825 (var2511 var3670) var3291)
(declare-fun cast-from-var2188-to-var2511 (var2188) var2511)
(declare-fun x/-707491510 (var1385) Float64)
(declare-fun cast-from-Float64-to-Int (Float64) Int)
(declare-fun arcSize/-151695256 (var2188) Int)
(declare-fun nodeWidthPadding/-151695256 (var2188) Int)
(declare-fun y/-707491510 (var1385) Float64)
(declare-fun getAscent/-437535464 (var3291) Int)
(declare-fun getLeading/764211298 (var3291) Int)
(declare-fun nodeHeightPadding/-151695256 (var2188) Int)
(declare-const null-var2188 var2188)
(declare-const null-var3407 var3407)
(declare-const null-var1340 var1340)
(declare-const null-var1634 var1634)
(declare-const var2156 var2188) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer 
(assert (not (= var2156 null-var2188)))
(declare-const var3203 var3407) ; Statement: r3 := @parameter0: java.awt.Graphics 
(assert (not (= var3203 null-var3407)))
(declare-const var2560 var1340) ; Statement: r1 := @parameter1: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var2560 null-var1340)))
(assert true)
(define-const var1757 var1385 (getBoundsOfNode/-98686064 var2156 var2560)) ; Statement: r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var3050 Bool (ite (= 1 0) true false)) ; Statement: z3 = 0 
(define-const var1063 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext 
 ; Statement: if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (= (ite var1063 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1995 Bool (isHighlighted/979820081 var2156 var2560)) ; Statement: $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= (ite var1995 1 0) 0)))) ; Negate: Cond: $z5 != 0  
(define-const var3021 var1634 (boxColor/-151695256 var2156)) ; Statement: $r14 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color boxColor> 
 ; Statement: if $r14 != null goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= var3021 null-var1634)))) ; Negate: Cond: $r14 != null  
(define-const var490 Bool true) ; Statement: $z2 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
 ; Statement: if $z2 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= (ite var490 1 0) 0)))) ; Negate: Cond: $z2 != 0  
 ; Statement: if z3 == 0 goto $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
(assert (= (ite var3050 1 0) 0)) ; Cond: z3 == 0 
(define-const var258 var1634 (borderColor/-151695256 var2156)) ; Statement: $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
 ; Statement: if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert (= var258 null-var1634)) ; Cond: $r20 == null 
(define-const var471 var1634 (textColor/-151695256 var2156)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert true)
;(assert (setColor/1206064488 var3203 var471)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5) 

(declare-const var3203!1 var3407)
(declare-const var471!1 var1634)
(assert true)
(define-const var260 String (getText/1718706454 var2156 var2560)) ; Statement: $r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var670 = var260.split("\n") ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var222 var3670 (font/-151695256 var2156)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var1160 var3291 (getFontMetrics/1328729825 (cast-from-var2188-to-var2511 var2156) var222)) ; Statement: $r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6) 
(define-const var3921 Float64 (x/-707491510 var1757)) ; Statement: $d0 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var2270 Int (cast-from-Float64-to-Int var3921)) ; Statement: $i2 = (int) $d0 
(define-const var1116 Int (arcSize/-151695256 var2156)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var503 Int (div var1116 2)) ; Statement: $i1 = $i0 / 2 
(define-const var2565 Int (+ var2270 var503)) ; Statement: $i4 = $i2 + $i1 
(define-const var2933 Int (nodeWidthPadding/-151695256 var2156)) ; Statement: $i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding> 
(define-const var817 Int (+ var2565 var2933)) ; Statement: $i21 = $i4 + $i3 
(define-const var2631 Float64 (y/-707491510 var1757)) ; Statement: $d1 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var1978 Int (cast-from-Float64-to-Int var2631)) ; Statement: $i6 = (int) $d1 
(assert true)
(define-const var3356 Int (getAscent/-437535464 var1160)) ; Statement: $i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>() 
(define-const var2279 Int (+ var1978 var3356)) ; Statement: $i8 = $i6 + $i5 
(assert true)
(define-const var2945 Int (getLeading/764211298 var1160)) ; Statement: $i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>() 
(define-const var3858 Int (+ var2279 var2945)) ; Statement: $i9 = $i8 + $i7 
(define-const var1788 Int (+ var3858 1)) ; Statement: $i11 = $i9 + 1 
(define-const var193 Int (nodeHeightPadding/-151695256 var2156)) ; Statement: $i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var3518 Int (+ var1788 var193)) ; Statement: i32 = $i11 + $i10 
(define-const var647 Int 0) ; Statement: i33 = 0 
(assert true) ; Non Conditional
(define-const var1108 Int (get_split_length var260 "\n" -1)) ; Statement: $i34 = lengthof $r10 
 ; Statement: if i33 >= $i34 goto return 
(assert (>= var647 var1108)) ; Cond: i33 >= $i34 
 ; Statement: return 
(check-sat)
; {getBoundsOfNode/-98686064=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), isHighlighted/979820081=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], boolean), boxColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), borderColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), textColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), setColor/1206064488=([java.awt.Graphics, java.awt.Color], void), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var2188-to-var2511=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), cast-from-Float64-to-Int=([double], int), arcSize/-151695256=([org.antlr.v4.gui.TreeViewer], int), nodeWidthPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), getAscent/-437535464=([java.awt.FontMetrics], int), getLeading/764211298=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int)}
; {var2188=org.antlr.v4.gui.TreeViewer, var2156=r0, var3407=java.awt.Graphics, var3203=r3, var1340=org.antlr.v4.runtime.tree.Tree, var2560=r1, var1385=java.awt.geom.Rectangle2D$Double, var1757=r2, var3050=z3, var1063=$z0, var1995=$z5, var1634=java.awt.Color, var3021=$r14, var490=$z2, var258=$r20, var471=$r5, var260=$r9, var670=$r10, var3670=java.awt.Font, var222=$r6, var3291=java.awt.FontMetrics, var2511=javax.swing.JComponent, var1160=$r11, var3921=$d0, var2270=$i2, var1116=$i0, var503=$i1, var2565=$i4, var2933=$i3, var817=$i21, var2631=$d1, var1978=$i6, var3356=$i5, var2279=$i8, var2945=$i7, var3858=$i9, var1788=$i11, var193=$i10, var3518=i32, var647=i33, var1108=$i34}
; {org.antlr.v4.gui.TreeViewer=var2188, r0=var2156, java.awt.Graphics=var3407, r3=var3203, org.antlr.v4.runtime.tree.Tree=var1340, r1=var2560, java.awt.geom.Rectangle2D$Double=var1385, r2=var1757, z3=var3050, $z0=var1063, $z5=var1995, java.awt.Color=var1634, $r14=var3021, $z2=var490, $r20=var258, $r5=var471, $r9=var260, $r10=var670, java.awt.Font=var3670, $r6=var222, java.awt.FontMetrics=var3291, javax.swing.JComponent=var2511, $r11=var1160, $d0=var3921, $i2=var2270, $i0=var1116, $i1=var503, $i4=var2565, $i3=var2933, $i21=var817, $d1=var2631, $i6=var1978, $i5=var3356, $i8=var2279, $i7=var2945, $i9=var3858, $i11=var1788, $i10=var193, i32=var3518, i33=var647, $i34=var1108}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer;	r3 := @parameter0: java.awt.Graphics;	r1 := @parameter1: org.antlr.v4.runtime.tree.Tree;	r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	z3 = 0;	$z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext;	if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$r14 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color boxColor>;	if $r14 != null goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z2 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	if $z2 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if z3 == 0 goto $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	$r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	$r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5);	$r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	$r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6);	$d0 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i2 = (int) $d0;	$i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i1 = $i0 / 2;	$i4 = $i2 + $i1;	$i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding>;	$i21 = $i4 + $i3;	$d1 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i6 = (int) $d1;	$i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>();	$i8 = $i6 + $i5;	$i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>();	$i9 = $i8 + $i7;	$i11 = $i9 + 1;	$i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	i32 = $i11 + $i10;	i33 = 0;	$i34 = lengthof $r10;	if i33 >= $i34 goto return;	return
;block_num 9
