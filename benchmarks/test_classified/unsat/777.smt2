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

(declare-sort var2959 0)
(declare-sort var1259 0)
(declare-sort var3121 0)
(declare-sort var168 0)
(declare-sort var698 0)
(declare-sort var201 0)
(declare-sort var3533 0)
(declare-sort var375 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBoundsOfNode/-98686064 (var2959 var3121) var168)
(declare-fun isHighlighted/979820081 (var2959 var3121) Bool)
(declare-fun boxColor/-151695256 (var2959) var698)
(declare-fun borderColor/-151695256 (var2959) var698)
(declare-fun textColor/-151695256 (var2959) var698)
(declare-fun setColor/1206064488 (var1259 var698) void)
(declare-fun getText/1718706454 (var2959 var3121) String)
(declare-fun font/-151695256 (var2959) var201)
(declare-fun getFontMetrics/1328729825 (var375 var201) var3533)
(declare-fun cast-from-var2959-to-var375 (var2959) var375)
(declare-fun x/-707491510 (var168) Real)
(declare-fun cast-from-Real-to-Int (Real) Int)
(declare-fun arcSize/-151695256 (var2959) Int)
(declare-fun nodeWidthPadding/-151695256 (var2959) Int)
(declare-fun y/-707491510 (var168) Real)
(declare-fun getAscent/-437535464 (var3533) Int)
(declare-fun getLeading/764211298 (var3533) Int)
(declare-fun nodeHeightPadding/-151695256 (var2959) Int)
(declare-const null-var2959 var2959)
(declare-const null-var1259 var1259)
(declare-const null-var3121 var3121)
(declare-const null-var698 var698)
(declare-const var3583 var2959) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer 
(assert (not (= var3583 null-var2959)))
(declare-const var3017 var1259) ; Statement: r3 := @parameter0: java.awt.Graphics 
(assert (not (= var3017 null-var1259)))
(declare-const var3258 var3121) ; Statement: r1 := @parameter1: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var3258 null-var3121)))
(assert true)
(define-const var1178 var168 (getBoundsOfNode/-98686064 var3583 var3258)) ; Statement: r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var207 Bool (ite (= 1 0) true false)) ; Statement: z3 = 0 
(define-const var2836 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext 
 ; Statement: if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (= (ite var2836 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3766 Bool (isHighlighted/979820081 var3583 var3258)) ; Statement: $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= (ite var3766 1 0) 0)))) ; Negate: Cond: $z5 != 0  
(define-const var103 var698 (boxColor/-151695256 var3583)) ; Statement: $r14 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color boxColor> 
 ; Statement: if $r14 != null goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= var103 null-var698)))) ; Negate: Cond: $r14 != null  
(define-const var3081 Bool true) ; Statement: $z2 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
 ; Statement: if $z2 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= (ite var3081 1 0) 0)))) ; Negate: Cond: $z2 != 0  
 ; Statement: if z3 == 0 goto $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
(assert (= (ite var207 1 0) 0)) ; Cond: z3 == 0 
(define-const var1237 var698 (borderColor/-151695256 var3583)) ; Statement: $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
 ; Statement: if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert (= var1237 null-var698)) ; Cond: $r20 == null 
(define-const var1821 var698 (textColor/-151695256 var3583)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert true)
;(assert (setColor/1206064488 var3017 var1821)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5) 

(declare-const var3017!1 var1259)
(declare-const var1821!1 var698)
(assert true)
(define-const var504 String (getText/1718706454 var3583 var3258)) ; Statement: $r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var143 = var504.split("\n") ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var1685 var201 (font/-151695256 var3583)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var2934 var3533 (getFontMetrics/1328729825 (cast-from-var2959-to-var375 var3583) var1685)) ; Statement: $r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6) 
(define-const var3900 Real (x/-707491510 var1178)) ; Statement: $d0 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var1402 Int (cast-from-Real-to-Int var3900)) ; Statement: $i2 = (int) $d0 
(define-const var3870 Int (arcSize/-151695256 var3583)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var2662 Int (div var3870 2)) ; Statement: $i1 = $i0 / 2 
(define-const var2058 Int (+ var1402 var2662)) ; Statement: $i4 = $i2 + $i1 
(define-const var292 Int (nodeWidthPadding/-151695256 var3583)) ; Statement: $i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding> 
(define-const var3487 Int (+ var2058 var292)) ; Statement: $i21 = $i4 + $i3 
(define-const var1360 Real (y/-707491510 var1178)) ; Statement: $d1 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var270 Int (cast-from-Real-to-Int var1360)) ; Statement: $i6 = (int) $d1 
(assert true)
(define-const var491 Int (getAscent/-437535464 var2934)) ; Statement: $i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>() 
(define-const var380 Int (+ var270 var491)) ; Statement: $i8 = $i6 + $i5 
(assert true)
(define-const var495 Int (getLeading/764211298 var2934)) ; Statement: $i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>() 
(define-const var3732 Int (+ var380 var495)) ; Statement: $i9 = $i8 + $i7 
(define-const var2823 Int (+ var3732 1)) ; Statement: $i11 = $i9 + 1 
(define-const var3472 Int (nodeHeightPadding/-151695256 var3583)) ; Statement: $i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var3146 Int (+ var2823 var3472)) ; Statement: i32 = $i11 + $i10 
(define-const var234 Int 0) ; Statement: i33 = 0 
(assert true) ; Non Conditional
(define-const var2550 Int (get_split_length var504 "\n" -1)) ; Statement: $i34 = lengthof $r10 
 ; Statement: if i33 >= $i34 goto return 
(assert (>= var234 var2550)) ; Cond: i33 >= $i34 
 ; Statement: return 
(check-sat)
; {getBoundsOfNode/-98686064=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), isHighlighted/979820081=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], boolean), boxColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), borderColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), textColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), setColor/1206064488=([java.awt.Graphics, java.awt.Color], void), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var2959-to-var375=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), cast-from-Real-to-Int=([double], int), arcSize/-151695256=([org.antlr.v4.gui.TreeViewer], int), nodeWidthPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), getAscent/-437535464=([java.awt.FontMetrics], int), getLeading/764211298=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int)}
; {var2959=org.antlr.v4.gui.TreeViewer, var3583=r0, var1259=java.awt.Graphics, var3017=r3, var3121=org.antlr.v4.runtime.tree.Tree, var3258=r1, var168=java.awt.geom.Rectangle2D$Double, var1178=r2, var207=z3, var2836=$z0, var3766=$z5, var698=java.awt.Color, var103=$r14, var3081=$z2, var1237=$r20, var1821=$r5, var504=$r9, var143=$r10, var201=java.awt.Font, var1685=$r6, var3533=java.awt.FontMetrics, var375=javax.swing.JComponent, var2934=$r11, var3900=$d0, var1402=$i2, var3870=$i0, var2662=$i1, var2058=$i4, var292=$i3, var3487=$i21, var1360=$d1, var270=$i6, var491=$i5, var380=$i8, var495=$i7, var3732=$i9, var2823=$i11, var3472=$i10, var3146=i32, var234=i33, var2550=$i34}
; {org.antlr.v4.gui.TreeViewer=var2959, r0=var3583, java.awt.Graphics=var1259, r3=var3017, org.antlr.v4.runtime.tree.Tree=var3121, r1=var3258, java.awt.geom.Rectangle2D$Double=var168, r2=var1178, z3=var207, $z0=var2836, $z5=var3766, java.awt.Color=var698, $r14=var103, $z2=var3081, $r20=var1237, $r5=var1821, $r9=var504, $r10=var143, java.awt.Font=var201, $r6=var1685, java.awt.FontMetrics=var3533, javax.swing.JComponent=var375, $r11=var2934, $d0=var3900, $i2=var1402, $i0=var3870, $i1=var2662, $i4=var2058, $i3=var292, $i21=var3487, $d1=var1360, $i6=var270, $i5=var491, $i8=var380, $i7=var495, $i9=var3732, $i11=var2823, $i10=var3472, i32=var3146, i33=var234, $i34=var2550}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer;	r3 := @parameter0: java.awt.Graphics;	r1 := @parameter1: org.antlr.v4.runtime.tree.Tree;	r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	z3 = 0;	$z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext;	if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$r14 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color boxColor>;	if $r14 != null goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z2 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	if $z2 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if z3 == 0 goto $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	$r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	$r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5);	$r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	$r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6);	$d0 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i2 = (int) $d0;	$i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i1 = $i0 / 2;	$i4 = $i2 + $i1;	$i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding>;	$i21 = $i4 + $i3;	$d1 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i6 = (int) $d1;	$i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>();	$i8 = $i6 + $i5;	$i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>();	$i9 = $i8 + $i7;	$i11 = $i9 + 1;	$i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	i32 = $i11 + $i10;	i33 = 0;	$i34 = lengthof $r10;	if i33 >= $i34 goto return;	return
;block_num 9