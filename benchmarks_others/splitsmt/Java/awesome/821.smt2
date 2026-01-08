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

(declare-sort var1599 0)
(declare-sort var2413 0)
(declare-sort var1481 0)
(declare-sort var1652 0)
(declare-sort var3034 0)
(declare-sort var119 0)
(declare-sort var2300 0)
(declare-sort var815 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBoundsOfNode/-98686064 (var1599 var1481) var1652)
(declare-fun isHighlighted/979820081 (var1599 var1481) Bool)
(declare-fun highlightedBoxColor/-151695256 (var1599) var3034)
(declare-fun setColor/1206064488 (var2413 var3034) void)
(declare-fun x/-707491510 (var1652) Float64)
(declare-fun cast-from-Float64-to-Int (Float64) Int)
(declare-fun y/-707491510 (var1652) Float64)
(declare-fun width/-707491510 (var1652) Float64)
(declare-fun height/-707491510 (var1652) Float64)
(declare-fun arcSize/-151695256 (var1599) Int)
(declare-fun fillRoundRect/-5515169 (var2413 Int Int Int Int Int Int) void)
(declare-fun borderColor/-151695256 (var1599) var3034)
(declare-fun textColor/-151695256 (var1599) var3034)
(declare-fun getText/1718706454 (var1599 var1481) String)
(declare-fun font/-151695256 (var1599) var119)
(declare-fun getFontMetrics/1328729825 (var815 var119) var2300)
(declare-fun cast-from-var1599-to-var815 (var1599) var815)
(declare-fun nodeWidthPadding/-151695256 (var1599) Int)
(declare-fun getAscent/-437535464 (var2300) Int)
(declare-fun getLeading/764211298 (var2300) Int)
(declare-fun nodeHeightPadding/-151695256 (var1599) Int)
(declare-const null-var1599 var1599)
(declare-const null-var2413 var2413)
(declare-const null-var1481 var1481)
(declare-const null-var3034 var3034)
(declare-const var1985 var1599) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer 
(assert (not (= var1985 null-var1599)))
(declare-const var2981 var2413) ; Statement: r3 := @parameter0: java.awt.Graphics 
(assert (not (= var2981 null-var2413)))
(declare-const var953 var1481) ; Statement: r1 := @parameter1: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var953 null-var1481)))
(assert true)
(define-const var2338 var1652 (getBoundsOfNode/-98686064 var1985 var953)) ; Statement: r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var2055 Bool (ite (= 1 0) true false)) ; Statement: z3 = 0 
(define-const var3940 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext 
 ; Statement: if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (= (ite var3940 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2711 Bool (isHighlighted/979820081 var1985 var953)) ; Statement: $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
(assert (not (= (ite var2711 1 0) 0))) ; Cond: $z5 != 0 
(assert true)
(define-const var577 Bool (isHighlighted/979820081 var1985 var953)) ; Statement: $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1) 
 ; Statement: if $z6 == 0 goto $z1 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
(assert (not (= (ite var577 1 0) 0))) ; Negate: Cond: $z6 == 0  
(define-const var2098 var3034 (highlightedBoxColor/-151695256 var1985)) ; Statement: $r13 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color highlightedBoxColor> 
(assert true)
;(assert (setColor/1206064488 var2981 var2098)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r13) 

(declare-const var2981!1 var2413)
(declare-const var2098!1 var3034)
 ; Statement: goto [?= $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>] 
(assert true) ; Non Conditional
(define-const var487 Float64 (x/-707491510 var2338)) ; Statement: $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var1677 Int (cast-from-Float64-to-Int var487)) ; Statement: $i24 = (int) $d6 
(define-const var2176 Float64 (y/-707491510 var2338)) ; Statement: $d7 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var2427 Int (cast-from-Float64-to-Int var2176)) ; Statement: $i25 = (int) $d7 
(define-const var122 Float64 (width/-707491510 var2338)) ; Statement: $d8 = r2.<java.awt.geom.Rectangle2D$Double: double width> 
(define-const var2701 Int (cast-from-Float64-to-Int var122)) ; Statement: $i26 = (int) $d8 
(define-const var2134 Int (- var2701 1)) ; Statement: $i27 = $i26 - 1 
(define-const var992 Float64 (height/-707491510 var2338)) ; Statement: $d9 = r2.<java.awt.geom.Rectangle2D$Double: double height> 
(define-const var2492 Int (cast-from-Float64-to-Int var992)) ; Statement: $i28 = (int) $d9 
(define-const var2284 Int (- var2492 1)) ; Statement: $i29 = $i28 - 1 
(define-const var3843 Int (arcSize/-151695256 var1985)) ; Statement: $i30 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var373 Int (arcSize/-151695256 var1985)) ; Statement: $i31 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(assert true)
;(assert (fillRoundRect/-5515169 var2981!1 var1677 var2427 var2134 var2284 var3843 var373)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void fillRoundRect(int,int,int,int,int,int)>($i24, $i25, $i27, $i29, $i30, $i31) 

(declare-const var2981!2 var2413)
(declare-const var1677!1 Int)
(declare-const var2427!1 Int)
(declare-const var2134!1 Int)
(declare-const var2284!1 Int)
(declare-const var3843!1 Int)
(declare-const var373!1 Int)
(assert true) ; Non Conditional
(define-const var2083 var3034 (borderColor/-151695256 var1985)) ; Statement: $r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor> 
 ; Statement: if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert (= var2083 null-var3034)) ; Cond: $r20 == null 
(define-const var438 var3034 (textColor/-151695256 var1985)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor> 
(assert true)
;(assert (setColor/1206064488 var2981!2 var438)) ; Statement: virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5) 

(declare-const var2981!3 var2413)
(declare-const var438!1 var3034)
(assert true)
(define-const var3793 String (getText/1718706454 var1985 var953)) ; Statement: $r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var1922 = var3793.split("\n") ; Statement: $r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var1309 var119 (font/-151695256 var1985)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var3085 var2300 (getFontMetrics/1328729825 (cast-from-var1599-to-var815 var1985) var1309)) ; Statement: $r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6) 
(define-const var2850 Float64 (x/-707491510 var2338)) ; Statement: $d0 = r2.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var2805 Int (cast-from-Float64-to-Int var2850)) ; Statement: $i2 = (int) $d0 
(define-const var3609 Int (arcSize/-151695256 var1985)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize> 
(define-const var190 Int (div var3609 2)) ; Statement: $i1 = $i0 / 2 
(define-const var165 Int (+ var2805 var190)) ; Statement: $i4 = $i2 + $i1 
(define-const var1104 Int (nodeWidthPadding/-151695256 var1985)) ; Statement: $i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding> 
(define-const var3412 Int (+ var165 var1104)) ; Statement: $i21 = $i4 + $i3 
(define-const var13 Float64 (y/-707491510 var2338)) ; Statement: $d1 = r2.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var553 Int (cast-from-Float64-to-Int var13)) ; Statement: $i6 = (int) $d1 
(assert true)
(define-const var1293 Int (getAscent/-437535464 var3085)) ; Statement: $i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>() 
(define-const var2290 Int (+ var553 var1293)) ; Statement: $i8 = $i6 + $i5 
(assert true)
(define-const var3600 Int (getLeading/764211298 var3085)) ; Statement: $i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>() 
(define-const var1823 Int (+ var2290 var3600)) ; Statement: $i9 = $i8 + $i7 
(define-const var3983 Int (+ var1823 1)) ; Statement: $i11 = $i9 + 1 
(define-const var3768 Int (nodeHeightPadding/-151695256 var1985)) ; Statement: $i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var3581 Int (+ var3983 var3768)) ; Statement: i32 = $i11 + $i10 
(define-const var1770 Int 0) ; Statement: i33 = 0 
(assert true) ; Non Conditional
(define-const var2114 Int (get_split_length var3793 "\n" -1)) ; Statement: $i34 = lengthof $r10 
 ; Statement: if i33 >= $i34 goto return 
(assert (>= var1770 var2114)) ; Cond: i33 >= $i34 
 ; Statement: return 
(check-sat)
; {getBoundsOfNode/-98686064=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), isHighlighted/979820081=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], boolean), highlightedBoxColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), setColor/1206064488=([java.awt.Graphics, java.awt.Color], void), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), cast-from-Float64-to-Int=([double], int), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), width/-707491510=([java.awt.geom.Rectangle2D$Double], double), height/-707491510=([java.awt.geom.Rectangle2D$Double], double), arcSize/-151695256=([org.antlr.v4.gui.TreeViewer], int), fillRoundRect/-5515169=([java.awt.Graphics, int, int, int, int, int, int], void), borderColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), textColor/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Color), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var1599-to-var815=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), nodeWidthPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), getAscent/-437535464=([java.awt.FontMetrics], int), getLeading/764211298=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int)}
; {var1599=org.antlr.v4.gui.TreeViewer, var1985=r0, var2413=java.awt.Graphics, var2981=r3, var1481=org.antlr.v4.runtime.tree.Tree, var953=r1, var1652=java.awt.geom.Rectangle2D$Double, var2338=r2, var2055=z3, var3940=$z0, var2711=$z5, var577=$z6, var3034=java.awt.Color, var2098=$r13, var487=$d6, var1677=$i24, var2176=$d7, var2427=$i25, var122=$d8, var2701=$i26, var2134=$i27, var992=$d9, var2492=$i28, var2284=$i29, var3843=$i30, var373=$i31, var2083=$r20, var438=$r5, var3793=$r9, var1922=$r10, var119=java.awt.Font, var1309=$r6, var2300=java.awt.FontMetrics, var815=javax.swing.JComponent, var3085=$r11, var2850=$d0, var2805=$i2, var3609=$i0, var190=$i1, var165=$i4, var1104=$i3, var3412=$i21, var13=$d1, var553=$i6, var1293=$i5, var2290=$i8, var3600=$i7, var1823=$i9, var3983=$i11, var3768=$i10, var3581=i32, var1770=i33, var2114=$i34}
; {org.antlr.v4.gui.TreeViewer=var1599, r0=var1985, java.awt.Graphics=var2413, r3=var2981, org.antlr.v4.runtime.tree.Tree=var1481, r1=var953, java.awt.geom.Rectangle2D$Double=var1652, r2=var2338, z3=var2055, $z0=var3940, $z5=var2711, $z6=var577, java.awt.Color=var3034, $r13=var2098, $d6=var487, $i24=var1677, $d7=var2176, $i25=var2427, $d8=var122, $i26=var2701, $i27=var2134, $d9=var992, $i28=var2492, $i29=var2284, $i30=var3843, $i31=var373, $r20=var2083, $r5=var438, $r9=var3793, $r10=var1922, java.awt.Font=var119, $r6=var1309, java.awt.FontMetrics=var2300, javax.swing.JComponent=var815, $r11=var3085, $d0=var2850, $i2=var2805, $i0=var3609, $i1=var190, $i4=var165, $i3=var1104, $i21=var3412, $d1=var13, $i6=var553, $i5=var1293, $i8=var2290, $i7=var3600, $i9=var1823, $i11=var3983, $i10=var3768, i32=var3581, i33=var1770, $i34=var2114}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer;	r3 := @parameter0: java.awt.Graphics;	r1 := @parameter1: org.antlr.v4.runtime.tree.Tree;	r2 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	z3 = 0;	$z0 = r1 instanceof org.antlr.v4.runtime.ParserRuleContext;	if $z0 == 0 goto $z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z5 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z5 != 0 goto $z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	$z6 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: boolean isHighlighted(org.antlr.v4.runtime.tree.Tree)>(r1);	if $z6 == 0 goto $z1 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	$r13 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color highlightedBoxColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r13);	goto [?= $d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>];	$d6 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i24 = (int) $d6;	$d7 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i25 = (int) $d7;	$d8 = r2.<java.awt.geom.Rectangle2D$Double: double width>;	$i26 = (int) $d8;	$i27 = $i26 - 1;	$d9 = r2.<java.awt.geom.Rectangle2D$Double: double height>;	$i28 = (int) $d9;	$i29 = $i28 - 1;	$i30 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i31 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	virtualinvoke r3.<java.awt.Graphics: void fillRoundRect(int,int,int,int,int,int)>($i24, $i25, $i27, $i29, $i30, $i31);	$r20 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color borderColor>;	if $r20 == null goto $r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	$r5 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Color textColor>;	virtualinvoke r3.<java.awt.Graphics: void setColor(java.awt.Color)>($r5);	$r9 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r10 = virtualinvoke $r9.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r6 = r0.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	$r11 = virtualinvoke r0.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r6);	$d0 = r2.<java.awt.geom.Rectangle2D$Double: double x>;	$i2 = (int) $d0;	$i0 = r0.<org.antlr.v4.gui.TreeViewer: int arcSize>;	$i1 = $i0 / 2;	$i4 = $i2 + $i1;	$i3 = r0.<org.antlr.v4.gui.TreeViewer: int nodeWidthPadding>;	$i21 = $i4 + $i3;	$d1 = r2.<java.awt.geom.Rectangle2D$Double: double y>;	$i6 = (int) $d1;	$i5 = virtualinvoke $r11.<java.awt.FontMetrics: int getAscent()>();	$i8 = $i6 + $i5;	$i7 = virtualinvoke $r11.<java.awt.FontMetrics: int getLeading()>();	$i9 = $i8 + $i7;	$i11 = $i9 + 1;	$i10 = r0.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	i32 = $i11 + $i10;	i33 = 0;	$i34 = lengthof $r10;	if i33 >= $i34 goto return;	return
;block_num 9
