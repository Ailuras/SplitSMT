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

(declare-sort var3458 0)
(declare-sort var1910 0)
(declare-sort var206 0)
(declare-sort var2578 0)
(declare-sort var290 0)
(declare-sort var50 0)
(declare-sort var1426 0)
(declare-sort var813 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBoundsOfNode/-98686064 (var3458 var206) var2578)
(declare-fun isHighlighted/979820081 (var3458 var206) Bool)
(declare-fun highlightedBoxColor/-151695256 (var3458) var290)
(declare-fun setColor/1206064488 (var1910 var290) void)
(declare-fun x/-707491510 (var2578) Float64)
(declare-fun cast-from-Float64-to-Int (Float64) Int)
(declare-fun y/-707491510 (var2578) Float64)
(declare-fun width/-707491510 (var2578) Float64)
(declare-fun height/-707491510 (var2578) Float64)
(declare-fun arcSize/-151695256 (var3458) Int)
(declare-fun fillRoundRect/-5515169 (var1910 Int Int Int Int Int Int) void)
(declare-fun borderColor/-151695256 (var3458) var290)
(declare-fun textColor/-151695256 (var3458) var290)
(declare-fun getText/1718706454 (var3458 var206) String)
(declare-fun font/-151695256 (var3458) var50)
(declare-fun getFontMetrics/1328729825 (var813 var50) var1426)
(declare-fun cast-from-var3458-to-var813 (var3458) var813)
(declare-fun nodeWidthPadding/-151695256 (var3458) Int)
(declare-fun getAscent/-437535464 (var1426) Int)
(declare-fun getLeading/764211298 (var1426) Int)
(declare-fun nodeHeightPadding/-151695256 (var3458) Int)
(declare-const null-var3458 var3458)
(declare-const null-var1910 var1910)
(declare-const null-var206 var206)
(declare-const null-var290 var290)
(declare-const var928 var3458) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer 
(assert (not (= var928 null-var3458)))
(declare-const var3130 var1910) ; Statement: r3 := @parameter0: java.awt.Graphics 
(assert (not (= var3130 null-var1910)))
(declare-const var3864 var206) ; Statement: r1 := @parameter1: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var3864 null-var206)))
(assert true)
(define-const var3251 var2578 (getBoundsOfNode/-98686064 var928 var3864)) ; Statement: r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var321 Bool (ite (= 1 0) true false)) ; Statement: z3 = 0 
(define-const var60 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext 
 ; Statement: if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (= (ite var60 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1847 Bool (isHighlighted/979820081 var928 var3864)) ; Statement: $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (= (ite var1847 1 0) 0))) ; Cond: $z5 != 0 
(assert true)
(define-const var1732 Bool (isHighlighted/979820081 var928 var3864)) ; Statement: $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z6 == 0 goto $z1 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
(assert (not (= (ite var1732 1 0) 0))) ; Negate: Cond: $z6 == 0  
(define-const var3554 var290 (highlightedBoxColor/-151695256 var928)) ; Statement: $r13 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color highlightedBoxColor> 
(assert true)
;(assert (setColor/1206064488 var3130 var3554)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r13) 

(declare-const var3130!1 var1910)
(declare-const var3554!1 var290)
 ; Statement: goto [?= $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>] 
(assert true) ; Non Conditional
(define-const var1207 Float64 (x/-707491510 var3251)) ; Statement: $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var3595 Int (cast-from-Float64-to-Int var1207)) ; Statement: $i24 = (int) $d6 
(define-const var2043 Float64 (y/-707491510 var3251)) ; Statement: $d7 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var3228 Int (cast-from-Float64-to-Int var2043)) ; Statement: $i25 = (int) $d7 
(define-const var1996 Float64 (width/-707491510 var3251)) ; Statement: $d8 = r2.<java.awt.geom.Rectangle2D$Double: double width> 
(define-const var3876 Int (cast-from-Float64-to-Int var1996)) ; Statement: $i26 = (int) $d8 
(define-const var397 Int (- var3876 1)) ; Statement: $i27 = $i26 - 1 
(define-const var3175 Float64 (height/-707491510 var3251)) ; Statement: $d9 = r2.<java.awt.geom.Rectangle2D$Double: double height> 
(define-const var2720 Int (cast-from-Float64-to-Int var3175)) ; Statement: $i28 = (int) $d9 
(define-const var3217 Int (- var2720 1)) ; Statement: $i29 = $i28 - 1 
(define-const var251 Int (arcSize/-151695256 var928)) ; Statement: $i30 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var2718 Int (arcSize/-151695256 var928)) ; Statement: $i31 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(assert true)
;(assert (fillRoundRect/-5515169 var3130!1 var3595 var3228 var397 var3217 var251 var2718)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void fillRoundRect(int,int,int,int,int,int)>($i24, $i25, $i27, $i29, $i30, $i31) 

(declare-const var3130!2 var1910)
(declare-const var3595!1 Int)
(declare-const var3228!1 Int)
(declare-const var397!1 Int)
(declare-const var3217!1 Int)
(declare-const var251!1 Int)
(declare-const var2718!1 Int)
(assert true) ; Non Conditional
(define-const var2818 var290 (borderColor/-151695256 var928)) ; Statement: $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
 ; Statement: if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert (= var2818 null-var290)) ; Cond: $r20 == null 
(define-const var3454 var290 (textColor/-151695256 var928)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert true)
;(assert (setColor/1206064488 var3130!2 var3454)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5) 

(declare-const var3130!3 var1910)
(declare-const var3454!1 var290)
(assert true)
(define-const var1904 String (getText/1718706454 var928 var3864)) ; Statement: $r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var2827 = var1904.split("\n") ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var2975 var50 (font/-151695256 var928)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var1615 var1426 (getFontMetrics/1328729825 (cast-from-var3458-to-var813 var928) var2975)) ; Statement: $r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6) 
(define-const var3493 Float64 (x/-707491510 var3251)) ; Statement: $d0 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var3237 Int (cast-from-Float64-to-Int var3493)) ; Statement: $i2 = (int) $d0 
(define-const var1599 Int (arcSize/-151695256 var928)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var1870 Int (div var1599 2)) ; Statement: $i1 = $i0 / 2 
(define-const var1513 Int (+ var3237 var1870)) ; Statement: $i4 = $i2 + $i1 
(define-const var2410 Int (nodeWidthPadding/-151695256 var928)) ; Statement: $i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding> 
(define-const var3358 Int (+ var1513 var2410)) ; Statement: $i21 = $i4 + $i3 
(define-const var393 Float64 (y/-707491510 var3251)) ; Statement: $d1 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var2758 Int (cast-from-Float64-to-Int var393)) ; Statement: $i6 = (int) $d1 
(assert true)
(define-const var3464 Int (getAscent/-437535464 var1615)) ; Statement: $i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>() 
(define-const var1093 Int (+ var2758 var3464)) ; Statement: $i8 = $i6 + $i5 
(assert true)
(define-const var3073 Int (getLeading/764211298 var1615)) ; Statement: $i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>() 
(define-const var2167 Int (+ var1093 var3073)) ; Statement: $i9 = $i8 + $i7 
(define-const var3214 Int (+ var2167 1)) ; Statement: $i11 = $i9 + 1 
(define-const var3027 Int (nodeHeightPadding/-151695256 var928)) ; Statement: $i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var146 Int (+ var3214 var3027)) ; Statement: i32 = $i11 + $i10 
(define-const var3902 Int 0) ; Statement: i33 = 0 
(assert true) ; Non Conditional
(define-const var1368 Int (get_split_length var1904 "\n" -1)) ; Statement: $i34 = lengthof $r10 
 ; Statement: if i33 >= $i34 goto return 
(assert (>= var3902 var1368)) ; Cond: i33 >= $i34 
 ; Statement: return 
(check-sat)
; {getBoundsOfNode/-98686064=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), isHighlighted/979820081=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], boolean), highlightedBoxColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), setColor/1206064488=([java.awt.Graphics, java.awt.Color], void), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), cast-from-Float64-to-Int=([double], int), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), width/-707491510=([java.awt.geom.Rectangle2D$Double], double), height/-707491510=([java.awt.geom.Rectangle2D$Double], double), arcSize/-151695256=([org.antlr.v4.gui.TreeViewer], int), fillRoundRect/-5515169=([java.awt.Graphics, int, int, int, int, int, int], void), borderColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), textColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var3458-to-var813=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), nodeWidthPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), getAscent/-437535464=([java.awt.FontMetrics], int), getLeading/764211298=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int)}
; {var3458=org.antlr.v4.gui.TreeViewer, var928=r0, var1910=java.awt.Graphics, var3130=r3, var206=org.antlr.v4.runtime.tree.Tree, var3864=r1, var2578=java.awt.geom.Rectangle2D$Double, var3251=r2, var321=z3, var60=$z0, var1847=$z5, var1732=$z6, var290=java.awt.Color, var3554=$r13, var1207=$d6, var3595=$i24, var2043=$d7, var3228=$i25, var1996=$d8, var3876=$i26, var397=$i27, var3175=$d9, var2720=$i28, var3217=$i29, var251=$i30, var2718=$i31, var2818=$r20, var3454=$r5, var1904=$r9, var2827=$r10, var50=java.awt.Font, var2975=$r6, var1426=java.awt.FontMetrics, var813=javax.swing.JComponent, var1615=$r11, var3493=$d0, var3237=$i2, var1599=$i0, var1870=$i1, var1513=$i4, var2410=$i3, var3358=$i21, var393=$d1, var2758=$i6, var3464=$i5, var1093=$i8, var3073=$i7, var2167=$i9, var3214=$i11, var3027=$i10, var146=i32, var3902=i33, var1368=$i34}
; {org.antlr.v4.gui.TreeViewer=var3458, r0=var928, java.awt.Graphics=var1910, r3=var3130, org.antlr.v4.runtime.tree.Tree=var206, r1=var3864, java.awt.geom.Rectangle2D$Double=var2578, r2=var3251, z3=var321, $z0=var60, $z5=var1847, $z6=var1732, java.awt.Color=var290, $r13=var3554, $d6=var1207, $i24=var3595, $d7=var2043, $i25=var3228, $d8=var1996, $i26=var3876, $i27=var397, $d9=var3175, $i28=var2720, $i29=var3217, $i30=var251, $i31=var2718, $r20=var2818, $r5=var3454, $r9=var1904, $r10=var2827, java.awt.Font=var50, $r6=var2975, java.awt.FontMetrics=var1426, javax.swing.JComponent=var813, $r11=var1615, $d0=var3493, $i2=var3237, $i0=var1599, $i1=var1870, $i4=var1513, $i3=var2410, $i21=var3358, $d1=var393, $i6=var2758, $i5=var3464, $i8=var1093, $i7=var3073, $i9=var2167, $i11=var3214, $i10=var3027, i32=var146, i33=var3902, $i34=var1368}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer;	r3 := @parameter0: java.awt.Graphics;	r1 := @parameter1: org.antlr.v4.runtime.tree.Tree;	r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	z3 = 0;	$z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext;	if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z6 == 0 goto $z1 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	$r13 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color highlightedBoxColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r13);	goto [?= $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>];	$d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i24 = (int) $d6;	$d7 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i25 = (int) $d7;	$d8 = r2.<java.awt.geom.Rectangle2D$Double: double width>;	$i26 = (int) $d8;	$i27 = $i26 - 1;	$d9 = r2.<java.awt.geom.Rectangle2D$Double: double height>;	$i28 = (int) $d9;	$i29 = $i28 - 1;	$i30 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i31 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	virtualinvoke r3.<java.awt.Graphics: void fillRoundRect(int,int,int,int,int,int)>($i24, $i25, $i27, $i29, $i30, $i31);	$r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	$r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5);	$r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	$r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6);	$d0 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i2 = (int) $d0;	$i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i1 = $i0 / 2;	$i4 = $i2 + $i1;	$i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding>;	$i21 = $i4 + $i3;	$d1 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i6 = (int) $d1;	$i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>();	$i8 = $i6 + $i5;	$i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>();	$i9 = $i8 + $i7;	$i11 = $i9 + 1;	$i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	i32 = $i11 + $i10;	i33 = 0;	$i34 = lengthof $r10;	if i33 >= $i34 goto return;	return
;block_num 9