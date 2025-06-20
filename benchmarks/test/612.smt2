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

(declare-sort var321 0)
(declare-sort var3232 0)
(declare-sort var3444 0)
(declare-sort var3108 0)
(declare-sort var2027 0)
(declare-sort var286 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun viewer/-1439921249 (var321) var3444)
(declare-fun font/-151695256 (var3444) var3108)
(declare-fun getFontMetrics/1328729825 (var286 var3108) var2027)
(declare-fun cast-from-var3444-to-var286 (var3444) var286)
(declare-fun getHeight/-2047551061 (var2027) Int)
(declare-fun nodeHeightPadding/-151695256 (var3444) Int)
(declare-fun getText/1718706454 (var3444 var3232) String)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-const null-var321 var321)
(declare-const null-var3232 var3232)
(declare-const var3621 var321) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer$VariableExtentProvide 
(assert (not (= var3621 null-var321)))
(declare-const var1695 var3232) ; Statement: r6 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var1695 null-var3232)))
(define-const var2466 var3444 (viewer/-1439921249 var3621)) ; Statement: $r3 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var2972 var3444 (viewer/-1439921249 var3621)) ; Statement: $r1 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var467 var3108 (font/-151695256 var2972)) ; Statement: $r2 = $r1.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var2393 var2027 (getFontMetrics/1328729825 (cast-from-var3444-to-var286 var2466) var467)) ; Statement: r4 = virtualinvoke $r3.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r2) 
(assert true)
(define-const var102 Int (getHeight/-2047551061 var2393)) ; Statement: $i2 = virtualinvoke r4.<java.awt.FontMetrics: int getHeight()>() 
(define-const var3406 var3444 (viewer/-1439921249 var3621)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var2041 Int (nodeHeightPadding/-151695256 var3406)) ; Statement: $i0 = $r5.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var995 Int (* var2041 2)) ; Statement: $i1 = $i0 * 2 
(define-const var3534 Int (+ var102 var995)) ; Statement: i3 = $i2 + $i1 
(define-const var3373 var3444 (viewer/-1439921249 var3621)) ; Statement: $r7 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(assert true)
(define-const var37 String (getText/1718706454 var3373 var1695)) ; Statement: r8 = virtualinvoke $r7.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r6) 
; split operation: var2010 = var37.split("\n") ; Statement: r9 = virtualinvoke r8.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var2769 Int (get_split_length var37 "\n" -1)) ; Statement: $i4 = lengthof r9 
(define-const var164 Int (* var3534 var2769)) ; Statement: $i5 = i3 * $i4 
(define-const var1745 Float64 (cast-from-Int-to-Float64 var164)) ; Statement: $d0 = (double) $i5 
 ; Statement: return $d0 
(check-sat)
; {viewer/-1439921249=([org.antlr.v4.gui.TreeViewer$VariableExtentProvide], org.antlr.v4.gui.TreeViewer), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var3444-to-var286=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), getHeight/-2047551061=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), cast-from-Int-to-Float64=([int], double)}
; {var321=org.antlr.v4.gui.TreeViewer$VariableExtentProvide, var3621=r0, var3232=org.antlr.v4.runtime.tree.Tree, var1695=r6, var3444=org.antlr.v4.gui.TreeViewer, var2466=$r3, var2972=$r1, var3108=java.awt.Font, var467=$r2, var2027=java.awt.FontMetrics, var286=javax.swing.JComponent, var2393=r4, var102=$i2, var3406=$r5, var2041=$i0, var995=$i1, var3534=i3, var3373=$r7, var37=r8, var2010=r9, var2769=$i4, var164=$i5, var1745=$d0}
; {org.antlr.v4.gui.TreeViewer$VariableExtentProvide=var321, r0=var3621, org.antlr.v4.runtime.tree.Tree=var3232, r6=var1695, org.antlr.v4.gui.TreeViewer=var3444, $r3=var2466, $r1=var2972, java.awt.Font=var3108, $r2=var467, java.awt.FontMetrics=var2027, javax.swing.JComponent=var286, r4=var2393, $i2=var102, $r5=var3406, $i0=var2041, $i1=var995, i3=var3534, $r7=var3373, r8=var37, r9=var2010, $i4=var2769, $i5=var164, $d0=var1745}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer$VariableExtentProvide;	r6 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r3 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$r1 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$r2 = $r1.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	r4 = virtualinvoke $r3.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r2);	$i2 = virtualinvoke r4.<java.awt.FontMetrics: int getHeight()>();	$r5 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$i0 = $r5.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	$i1 = $i0 * 2;	i3 = $i2 + $i1;	$r7 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	r8 = virtualinvoke $r7.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r6);	r9 = virtualinvoke r8.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$i4 = lengthof r9;	$i5 = i3 * $i4;	$d0 = (double) $i5;	return $d0
;block_num 1