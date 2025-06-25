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

(declare-sort var2571 0)
(declare-sort var2280 0)
(declare-sort var1514 0)
(declare-sort var558 0)
(declare-sort var2871 0)
(declare-sort var2449 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun viewer/-1439921249 (var2571) var1514)
(declare-fun font/-151695256 (var1514) var558)
(declare-fun getFontMetrics/1328729825 (var2449 var558) var2871)
(declare-fun cast-from-var1514-to-var2449 (var1514) var2449)
(declare-fun getHeight/-2047551061 (var2871) Int)
(declare-fun nodeHeightPadding/-151695256 (var1514) Int)
(declare-fun getText/1718706454 (var1514 var2280) String)
(declare-fun cast-from-Int-to-Real (Int) Real)
(declare-const null-var2571 var2571)
(declare-const null-var2280 var2280)
(declare-const var1258 var2571) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer$VariableExtentProvide 
(assert (not (= var1258 null-var2571)))
(declare-const var897 var2280) ; Statement: r6 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var897 null-var2280)))
(define-const var3567 var1514 (viewer/-1439921249 var1258)) ; Statement: $r3 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var3071 var1514 (viewer/-1439921249 var1258)) ; Statement: $r1 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var2753 var558 (font/-151695256 var3071)) ; Statement: $r2 = $r1.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var1199 var2871 (getFontMetrics/1328729825 (cast-from-var1514-to-var2449 var3567) var2753)) ; Statement: r4 = virtualinvoke $r3.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r2) 
(assert true)
(define-const var2225 Int (getHeight/-2047551061 var1199)) ; Statement: $i2 = virtualinvoke r4.<java.awt.FontMetrics: int getHeight()>() 
(define-const var2906 var1514 (viewer/-1439921249 var1258)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var2860 Int (nodeHeightPadding/-151695256 var2906)) ; Statement: $i0 = $r5.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var81 Int (* var2860 2)) ; Statement: $i1 = $i0 * 2 
(define-const var1129 Int (+ var2225 var81)) ; Statement: i3 = $i2 + $i1 
(define-const var1303 var1514 (viewer/-1439921249 var1258)) ; Statement: $r7 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(assert true)
(define-const var465 String (getText/1718706454 var1303 var897)) ; Statement: r8 = virtualinvoke $r7.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r6) 
; split operation: var1152 = var465.split("\n") ; Statement: r9 = virtualinvoke r8.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var3160 Int (get_split_length var465 "\n" -1)) ; Statement: $i4 = lengthof r9 
(define-const var2514 Int (* var1129 var3160)) ; Statement: $i5 = i3 * $i4 
(define-const var1913 Real (cast-from-Int-to-Real var2514)) ; Statement: $d0 = (double) $i5 
 ; Statement: return $d0 
(check-sat)
; {viewer/-1439921249=([org.antlr.v4.gui.TreeViewer$VariableExtentProvide], org.antlr.v4.gui.TreeViewer), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var1514-to-var2449=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), getHeight/-2047551061=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), cast-from-Int-to-Real=([int], double)}
; {var2571=org.antlr.v4.gui.TreeViewer$VariableExtentProvide, var1258=r0, var2280=org.antlr.v4.runtime.tree.Tree, var897=r6, var1514=org.antlr.v4.gui.TreeViewer, var3567=$r3, var3071=$r1, var558=java.awt.Font, var2753=$r2, var2871=java.awt.FontMetrics, var2449=javax.swing.JComponent, var1199=r4, var2225=$i2, var2906=$r5, var2860=$i0, var81=$i1, var1129=i3, var1303=$r7, var465=r8, var1152=r9, var3160=$i4, var2514=$i5, var1913=$d0}
; {org.antlr.v4.gui.TreeViewer$VariableExtentProvide=var2571, r0=var1258, org.antlr.v4.runtime.tree.Tree=var2280, r6=var897, org.antlr.v4.gui.TreeViewer=var1514, $r3=var3567, $r1=var3071, java.awt.Font=var558, $r2=var2753, java.awt.FontMetrics=var2871, javax.swing.JComponent=var2449, r4=var1199, $i2=var2225, $r5=var2906, $i0=var2860, $i1=var81, i3=var1129, $r7=var1303, r8=var465, r9=var1152, $i4=var3160, $i5=var2514, $d0=var1913}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer$VariableExtentProvide;	r6 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r3 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$r1 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$r2 = $r1.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	r4 = virtualinvoke $r3.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r2);	$i2 = virtualinvoke r4.<java.awt.FontMetrics: int getHeight()>();	$r5 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$i0 = $r5.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	$i1 = $i0 * 2;	i3 = $i2 + $i1;	$r7 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	r8 = virtualinvoke $r7.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r6);	r9 = virtualinvoke r8.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$i4 = lengthof r9;	$i5 = i3 * $i4;	$d0 = (double) $i5;	return $d0
;block_num 1