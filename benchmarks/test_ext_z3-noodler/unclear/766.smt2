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

(declare-sort var853 0)
(declare-sort var1642 0)
(declare-sort var3868 0)
(declare-sort var910 0)
(declare-sort var1829 0)
(declare-sort var3737 0)
(declare-sort var1066 0)
(declare-sort var1505 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBoundsOfNode/-98686064 (var853 var3868) var910)
(declare-fun isHighlighted/979820081 (var853 var3868) Bool)
(declare-fun boxColor/-151695256 (var853) var1829)
(declare-fun borderColor/-151695256 (var853) var1829)
(declare-fun textColor/-151695256 (var853) var1829)
(declare-fun setColor/1206064488 (var1642 var1829) void)
(declare-fun getText/1718706454 (var853 var3868) String)
(declare-fun font/-151695256 (var853) var3737)
(declare-fun getFontMetrics/1328729825 (var1505 var3737) var1066)
(declare-fun cast-from-var853-to-var1505 (var853) var1505)
(declare-fun x/-707491510 (var910) Float64)
(declare-fun cast-from-Float64-to-Int (Float64) Int)
(declare-fun arcSize/-151695256 (var853) Int)
(declare-fun nodeWidthPadding/-151695256 (var853) Int)
(declare-fun y/-707491510 (var910) Float64)
(declare-fun getAscent/-437535464 (var1066) Int)
(declare-fun getLeading/764211298 (var1066) Int)
(declare-fun nodeHeightPadding/-151695256 (var853) Int)
(declare-const null-var853 var853)
(declare-const null-var1642 var1642)
(declare-const null-var3868 var3868)
(declare-const null-var1829 var1829)
(declare-const var117 var853) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer 
(assert (not (= var117 null-var853)))
(declare-const var3008 var1642) ; Statement: r3 := @parameter0: java.awt.Graphics 
(assert (not (= var3008 null-var1642)))
(declare-const var2401 var3868) ; Statement: r1 := @parameter1: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var2401 null-var3868)))
(assert true)
(define-const var2903 var910 (getBoundsOfNode/-98686064 var117 var2401)) ; Statement: r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var2069 Bool (ite (= 1 0) true false)) ; Statement: z3 = 0 
(define-const var2475 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext 
 ; Statement: if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (= (ite var2475 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var22 Bool (isHighlighted/979820081 var117 var2401)) ; Statement: $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= (ite var22 1 0) 0)))) ; Negate: Cond: $z5 != 0  
(define-const var1949 var1829 (boxColor/-151695256 var117)) ; Statement: $r14 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color boxColor> 
 ; Statement: if $r14 != null goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= var1949 null-var1829)))) ; Negate: Cond: $r14 != null  
(define-const var3595 Bool true) ; Statement: $z2 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
 ; Statement: if $z2 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (not (= (ite var3595 1 0) 0)))) ; Negate: Cond: $z2 != 0  
 ; Statement: if z3 == 0 goto $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
(assert (= (ite var2069 1 0) 0)) ; Cond: z3 == 0 
(define-const var587 var1829 (borderColor/-151695256 var117)) ; Statement: $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
 ; Statement: if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert (= var587 null-var1829)) ; Cond: $r20 == null 
(define-const var2223 var1829 (textColor/-151695256 var117)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert true)
;(assert (setColor/1206064488 var3008 var2223)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5) 

(declare-const var3008!1 var1642)
(declare-const var2223!1 var1829)
(assert true)
(define-const var1896 String (getText/1718706454 var117 var2401)) ; Statement: $r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var630 = var1896.split("\n") ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var2029 var3737 (font/-151695256 var117)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var1711 var1066 (getFontMetrics/1328729825 (cast-from-var853-to-var1505 var117) var2029)) ; Statement: $r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6) 
(define-const var2584 Float64 (x/-707491510 var2903)) ; Statement: $d0 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var3515 Int (cast-from-Float64-to-Int var2584)) ; Statement: $i2 = (int) $d0 
(define-const var1316 Int (arcSize/-151695256 var117)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var3234 Int (div var1316 2)) ; Statement: $i1 = $i0 / 2 
(define-const var2671 Int (+ var3515 var3234)) ; Statement: $i4 = $i2 + $i1 
(define-const var3402 Int (nodeWidthPadding/-151695256 var117)) ; Statement: $i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding> 
(define-const var3044 Int (+ var2671 var3402)) ; Statement: $i21 = $i4 + $i3 
(define-const var682 Float64 (y/-707491510 var2903)) ; Statement: $d1 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var365 Int (cast-from-Float64-to-Int var682)) ; Statement: $i6 = (int) $d1 
(assert true)
(define-const var2112 Int (getAscent/-437535464 var1711)) ; Statement: $i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>() 
(define-const var3106 Int (+ var365 var2112)) ; Statement: $i8 = $i6 + $i5 
(assert true)
(define-const var3906 Int (getLeading/764211298 var1711)) ; Statement: $i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>() 
(define-const var939 Int (+ var3106 var3906)) ; Statement: $i9 = $i8 + $i7 
(define-const var1825 Int (+ var939 1)) ; Statement: $i11 = $i9 + 1 
(define-const var1948 Int (nodeHeightPadding/-151695256 var117)) ; Statement: $i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var1064 Int (+ var1825 var1948)) ; Statement: i32 = $i11 + $i10 
(define-const var1375 Int 0) ; Statement: i33 = 0 
(assert true) ; Non Conditional
(define-const var2373 Int (get_split_length var1896 "\n" -1)) ; Statement: $i34 = lengthof $r10 
 ; Statement: if i33 >= $i34 goto return 
(assert (>= var1375 var2373)) ; Cond: i33 >= $i34 
 ; Statement: return 
(check-sat)
; {getBoundsOfNode/-98686064=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), isHighlighted/979820081=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], boolean), boxColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), borderColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), textColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), setColor/1206064488=([java.awt.Graphics, java.awt.Color], void), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var853-to-var1505=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), cast-from-Float64-to-Int=([double], int), arcSize/-151695256=([org.antlr.v4.gui.TreeViewer], int), nodeWidthPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), getAscent/-437535464=([java.awt.FontMetrics], int), getLeading/764211298=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int)}
; {var853=org.antlr.v4.gui.TreeViewer, var117=r0, var1642=java.awt.Graphics, var3008=r3, var3868=org.antlr.v4.runtime.tree.Tree, var2401=r1, var910=java.awt.geom.Rectangle2D$Double, var2903=r2, var2069=z3, var2475=$z0, var22=$z5, var1829=java.awt.Color, var1949=$r14, var3595=$z2, var587=$r20, var2223=$r5, var1896=$r9, var630=$r10, var3737=java.awt.Font, var2029=$r6, var1066=java.awt.FontMetrics, var1505=javax.swing.JComponent, var1711=$r11, var2584=$d0, var3515=$i2, var1316=$i0, var3234=$i1, var2671=$i4, var3402=$i3, var3044=$i21, var682=$d1, var365=$i6, var2112=$i5, var3106=$i8, var3906=$i7, var939=$i9, var1825=$i11, var1948=$i10, var1064=i32, var1375=i33, var2373=$i34}
; {org.antlr.v4.gui.TreeViewer=var853, r0=var117, java.awt.Graphics=var1642, r3=var3008, org.antlr.v4.runtime.tree.Tree=var3868, r1=var2401, java.awt.geom.Rectangle2D$Double=var910, r2=var2903, z3=var2069, $z0=var2475, $z5=var22, java.awt.Color=var1829, $r14=var1949, $z2=var3595, $r20=var587, $r5=var2223, $r9=var1896, $r10=var630, java.awt.Font=var3737, $r6=var2029, java.awt.FontMetrics=var1066, javax.swing.JComponent=var1505, $r11=var1711, $d0=var2584, $i2=var3515, $i0=var1316, $i1=var3234, $i4=var2671, $i3=var3402, $i21=var3044, $d1=var682, $i6=var365, $i5=var2112, $i8=var3106, $i7=var3906, $i9=var939, $i11=var1825, $i10=var1948, i32=var1064, i33=var1375, $i34=var2373}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer;	r3 := @parameter0: java.awt.Graphics;	r1 := @parameter1: org.antlr.v4.runtime.tree.Tree;	r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	z3 = 0;	$z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext;	if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$r14 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color boxColor>;	if $r14 != null goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z2 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	if $z2 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if z3 == 0 goto $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	$r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	$r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5);	$r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	$r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6);	$d0 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i2 = (int) $d0;	$i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i1 = $i0 / 2;	$i4 = $i2 + $i1;	$i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding>;	$i21 = $i4 + $i3;	$d1 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i6 = (int) $d1;	$i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>();	$i8 = $i6 + $i5;	$i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>();	$i9 = $i8 + $i7;	$i11 = $i9 + 1;	$i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	i32 = $i11 + $i10;	i33 = 0;	$i34 = lengthof $r10;	if i33 >= $i34 goto return;	return
;block_num 9