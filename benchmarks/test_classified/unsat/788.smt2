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

(declare-sort var2856 0)
(declare-sort var3662 0)
(declare-sort var1750 0)
(declare-sort var2763 0)
(declare-sort var468 0)
(declare-sort var3554 0)
(declare-sort var392 0)
(declare-sort var1921 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBoundsOfNode/-98686064 (var2856 var1750) var2763)
(declare-fun isHighlighted/979820081 (var2856 var1750) Bool)
(declare-fun highlightedBoxColor/-151695256 (var2856) var468)
(declare-fun setColor/1206064488 (var3662 var468) void)
(declare-fun x/-707491510 (var2763) Real)
(declare-fun cast-from-Real-to-Int (Real) Int)
(declare-fun y/-707491510 (var2763) Real)
(declare-fun width/-707491510 (var2763) Real)
(declare-fun height/-707491510 (var2763) Real)
(declare-fun arcSize/-151695256 (var2856) Int)
(declare-fun fillRoundRect/-5515169 (var3662 Int Int Int Int Int Int) void)
(declare-fun borderColor/-151695256 (var2856) var468)
(declare-fun textColor/-151695256 (var2856) var468)
(declare-fun getText/1718706454 (var2856 var1750) String)
(declare-fun font/-151695256 (var2856) var3554)
(declare-fun getFontMetrics/1328729825 (var1921 var3554) var392)
(declare-fun cast-from-var2856-to-var1921 (var2856) var1921)
(declare-fun nodeWidthPadding/-151695256 (var2856) Int)
(declare-fun getAscent/-437535464 (var392) Int)
(declare-fun getLeading/764211298 (var392) Int)
(declare-fun nodeHeightPadding/-151695256 (var2856) Int)
(declare-const null-var2856 var2856)
(declare-const null-var3662 var3662)
(declare-const null-var1750 var1750)
(declare-const null-var468 var468)
(declare-const var2181 var2856) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer 
(assert (not (= var2181 null-var2856)))
(declare-const var2177 var3662) ; Statement: r3 := @parameter0: java.awt.Graphics 
(assert (not (= var2177 null-var3662)))
(declare-const var2457 var1750) ; Statement: r1 := @parameter1: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var2457 null-var1750)))
(assert true)
(define-const var3948 var2763 (getBoundsOfNode/-98686064 var2181 var2457)) ; Statement: r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var2430 Bool (ite (= 1 0) true false)) ; Statement: z3 = 0 
(define-const var3472 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext 
 ; Statement: if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (= (ite var3472 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var764 Bool (isHighlighted/979820081 var2181 var2457)) ; Statement: $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (= (ite var764 1 0) 0))) ; Cond: $z5 != 0 
(assert true)
(define-const var3370 Bool (isHighlighted/979820081 var2181 var2457)) ; Statement: $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z6 == 0 goto $z1 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
(assert (not (= (ite var3370 1 0) 0))) ; Negate: Cond: $z6 == 0  
(define-const var434 var468 (highlightedBoxColor/-151695256 var2181)) ; Statement: $r13 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color highlightedBoxColor> 
(assert true)
;(assert (setColor/1206064488 var2177 var434)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r13) 

(declare-const var2177!1 var3662)
(declare-const var434!1 var468)
 ; Statement: goto [?= $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>] 
(assert true) ; Non Conditional
(define-const var3942 Real (x/-707491510 var3948)) ; Statement: $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var682 Int (cast-from-Real-to-Int var3942)) ; Statement: $i24 = (int) $d6 
(define-const var646 Real (y/-707491510 var3948)) ; Statement: $d7 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var2440 Int (cast-from-Real-to-Int var646)) ; Statement: $i25 = (int) $d7 
(define-const var3825 Real (width/-707491510 var3948)) ; Statement: $d8 = r2.<java.awt.geom.Rectangle2D$Double: double width> 
(define-const var1964 Int (cast-from-Real-to-Int var3825)) ; Statement: $i26 = (int) $d8 
(define-const var3064 Int (- var1964 1)) ; Statement: $i27 = $i26 - 1 
(define-const var242 Real (height/-707491510 var3948)) ; Statement: $d9 = r2.<java.awt.geom.Rectangle2D$Double: double height> 
(define-const var2409 Int (cast-from-Real-to-Int var242)) ; Statement: $i28 = (int) $d9 
(define-const var3468 Int (- var2409 1)) ; Statement: $i29 = $i28 - 1 
(define-const var3259 Int (arcSize/-151695256 var2181)) ; Statement: $i30 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var3049 Int (arcSize/-151695256 var2181)) ; Statement: $i31 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(assert true)
;(assert (fillRoundRect/-5515169 var2177!1 var682 var2440 var3064 var3468 var3259 var3049)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void fillRoundRect(int,int,int,int,int,int)>($i24, $i25, $i27, $i29, $i30, $i31) 

(declare-const var2177!2 var3662)
(declare-const var682!1 Int)
(declare-const var2440!1 Int)
(declare-const var3064!1 Int)
(declare-const var3468!1 Int)
(declare-const var3259!1 Int)
(declare-const var3049!1 Int)
(assert true) ; Non Conditional
(define-const var667 var468 (borderColor/-151695256 var2181)) ; Statement: $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
 ; Statement: if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert (= var667 null-var468)) ; Cond: $r20 == null 
(define-const var1742 var468 (textColor/-151695256 var2181)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert true)
;(assert (setColor/1206064488 var2177!2 var1742)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5) 

(declare-const var2177!3 var3662)
(declare-const var1742!1 var468)
(assert true)
(define-const var1554 String (getText/1718706454 var2181 var2457)) ; Statement: $r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var3843 = var1554.split("\n") ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var239 var3554 (font/-151695256 var2181)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var1829 var392 (getFontMetrics/1328729825 (cast-from-var2856-to-var1921 var2181) var239)) ; Statement: $r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6) 
(define-const var2392 Real (x/-707491510 var3948)) ; Statement: $d0 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var69 Int (cast-from-Real-to-Int var2392)) ; Statement: $i2 = (int) $d0 
(define-const var1653 Int (arcSize/-151695256 var2181)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var251 Int (div var1653 2)) ; Statement: $i1 = $i0 / 2 
(define-const var3072 Int (+ var69 var251)) ; Statement: $i4 = $i2 + $i1 
(define-const var1915 Int (nodeWidthPadding/-151695256 var2181)) ; Statement: $i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding> 
(define-const var1025 Int (+ var3072 var1915)) ; Statement: $i21 = $i4 + $i3 
(define-const var3074 Real (y/-707491510 var3948)) ; Statement: $d1 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var1135 Int (cast-from-Real-to-Int var3074)) ; Statement: $i6 = (int) $d1 
(assert true)
(define-const var3209 Int (getAscent/-437535464 var1829)) ; Statement: $i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>() 
(define-const var869 Int (+ var1135 var3209)) ; Statement: $i8 = $i6 + $i5 
(assert true)
(define-const var718 Int (getLeading/764211298 var1829)) ; Statement: $i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>() 
(define-const var3147 Int (+ var869 var718)) ; Statement: $i9 = $i8 + $i7 
(define-const var1169 Int (+ var3147 1)) ; Statement: $i11 = $i9 + 1 
(define-const var3661 Int (nodeHeightPadding/-151695256 var2181)) ; Statement: $i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var759 Int (+ var1169 var3661)) ; Statement: i32 = $i11 + $i10 
(define-const var2236 Int 0) ; Statement: i33 = 0 
(assert true) ; Non Conditional
(define-const var1992 Int (get_split_length var1554 "\n" -1)) ; Statement: $i34 = lengthof $r10 
 ; Statement: if i33 >= $i34 goto return 
(assert (>= var2236 var1992)) ; Cond: i33 >= $i34 
 ; Statement: return 
(check-sat)
; {getBoundsOfNode/-98686064=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), isHighlighted/979820081=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], boolean), highlightedBoxColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), setColor/1206064488=([java.awt.Graphics, java.awt.Color], void), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), cast-from-Real-to-Int=([double], int), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), width/-707491510=([java.awt.geom.Rectangle2D$Double], double), height/-707491510=([java.awt.geom.Rectangle2D$Double], double), arcSize/-151695256=([org.antlr.v4.gui.TreeViewer], int), fillRoundRect/-5515169=([java.awt.Graphics, int, int, int, int, int, int], void), borderColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), textColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var2856-to-var1921=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), nodeWidthPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), getAscent/-437535464=([java.awt.FontMetrics], int), getLeading/764211298=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int)}
; {var2856=org.antlr.v4.gui.TreeViewer, var2181=r0, var3662=java.awt.Graphics, var2177=r3, var1750=org.antlr.v4.runtime.tree.Tree, var2457=r1, var2763=java.awt.geom.Rectangle2D$Double, var3948=r2, var2430=z3, var3472=$z0, var764=$z5, var3370=$z6, var468=java.awt.Color, var434=$r13, var3942=$d6, var682=$i24, var646=$d7, var2440=$i25, var3825=$d8, var1964=$i26, var3064=$i27, var242=$d9, var2409=$i28, var3468=$i29, var3259=$i30, var3049=$i31, var667=$r20, var1742=$r5, var1554=$r9, var3843=$r10, var3554=java.awt.Font, var239=$r6, var392=java.awt.FontMetrics, var1921=javax.swing.JComponent, var1829=$r11, var2392=$d0, var69=$i2, var1653=$i0, var251=$i1, var3072=$i4, var1915=$i3, var1025=$i21, var3074=$d1, var1135=$i6, var3209=$i5, var869=$i8, var718=$i7, var3147=$i9, var1169=$i11, var3661=$i10, var759=i32, var2236=i33, var1992=$i34}
; {org.antlr.v4.gui.TreeViewer=var2856, r0=var2181, java.awt.Graphics=var3662, r3=var2177, org.antlr.v4.runtime.tree.Tree=var1750, r1=var2457, java.awt.geom.Rectangle2D$Double=var2763, r2=var3948, z3=var2430, $z0=var3472, $z5=var764, $z6=var3370, java.awt.Color=var468, $r13=var434, $d6=var3942, $i24=var682, $d7=var646, $i25=var2440, $d8=var3825, $i26=var1964, $i27=var3064, $d9=var242, $i28=var2409, $i29=var3468, $i30=var3259, $i31=var3049, $r20=var667, $r5=var1742, $r9=var1554, $r10=var3843, java.awt.Font=var3554, $r6=var239, java.awt.FontMetrics=var392, javax.swing.JComponent=var1921, $r11=var1829, $d0=var2392, $i2=var69, $i0=var1653, $i1=var251, $i4=var3072, $i3=var1915, $i21=var1025, $d1=var3074, $i6=var1135, $i5=var3209, $i8=var869, $i7=var718, $i9=var3147, $i11=var1169, $i10=var3661, i32=var759, i33=var2236, $i34=var1992}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer;	r3 := @parameter0: java.awt.Graphics;	r1 := @parameter1: org.antlr.v4.runtime.tree.Tree;	r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	z3 = 0;	$z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext;	if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z6 == 0 goto $z1 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	$r13 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color highlightedBoxColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r13);	goto [?= $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>];	$d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i24 = (int) $d6;	$d7 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i25 = (int) $d7;	$d8 = r2.<java.awt.geom.Rectangle2D$Double: double width>;	$i26 = (int) $d8;	$i27 = $i26 - 1;	$d9 = r2.<java.awt.geom.Rectangle2D$Double: double height>;	$i28 = (int) $d9;	$i29 = $i28 - 1;	$i30 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i31 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	virtualinvoke r3.<java.awt.Graphics: void fillRoundRect(int,int,int,int,int,int)>($i24, $i25, $i27, $i29, $i30, $i31);	$r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	$r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5);	$r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	$r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6);	$d0 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i2 = (int) $d0;	$i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i1 = $i0 / 2;	$i4 = $i2 + $i1;	$i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding>;	$i21 = $i4 + $i3;	$d1 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i6 = (int) $d1;	$i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>();	$i8 = $i6 + $i5;	$i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>();	$i9 = $i8 + $i7;	$i11 = $i9 + 1;	$i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	i32 = $i11 + $i10;	i33 = 0;	$i34 = lengthof $r10;	if i33 >= $i34 goto return;	return
;block_num 9