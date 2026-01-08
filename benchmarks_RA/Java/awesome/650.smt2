(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

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

(declare-sort var1761 0)
(declare-sort var2449 0)
(declare-sort var430 0)
(declare-sort var1632 0)
(declare-sort var3034 0)
(declare-sort var2036 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun viewer/-1439921249 (var1761) var430)
(declare-fun font/-151695256 (var430) var1632)
(declare-fun getFontMetrics/1328729825 (var2036 var1632) var3034)
(declare-fun cast-from-var430-to-var2036 (var430) var2036)
(declare-fun getHeight/-2047551061 (var3034) Int)
(declare-fun nodeHeightPadding/-151695256 (var430) Int)
(declare-fun getText/1718706454 (var430 var2449) String)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-const null-var1761 var1761)
(declare-const null-var2449 var2449)
(declare-const var1751 var1761) ; Statement: r0 := @this: org.antlr.v4.gui.TreeViewer$VariableExtentProvide 
(assert (not (= var1751 null-var1761)))
(declare-const var57 var2449) ; Statement: r6 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var57 null-var2449)))
(define-const var2295 var430 (viewer/-1439921249 var1751)) ; Statement: $r3 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var1081 var430 (viewer/-1439921249 var1751)) ; Statement: $r1 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var3175 var1632 (font/-151695256 var1081)) ; Statement: $r2 = $r1.<org.antlr.v4.gui.TreeViewer: java.awt.Font font> 
(assert true)
(define-const var3107 var3034 (getFontMetrics/1328729825 (cast-from-var430-to-var2036 var2295) var3175)) ; Statement: r4 = virtualinvoke $r3.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r2) 
(assert true)
(define-const var3058 Int (getHeight/-2047551061 var3107)) ; Statement: $i2 = virtualinvoke r4.<java.awt.FontMetrics: int getHeight()>() 
(define-const var1290 var430 (viewer/-1439921249 var1751)) ; Statement: $r5 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(define-const var3049 Int (nodeHeightPadding/-151695256 var1290)) ; Statement: $i0 = $r5.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding> 
(define-const var705 Int (* var3049 2)) ; Statement: $i1 = $i0 * 2 
(define-const var1189 Int (+ var3058 var705)) ; Statement: i3 = $i2 + $i1 
(define-const var2555 var430 (viewer/-1439921249 var1751)) ; Statement: $r7 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer> 
(assert true)
(define-const var1862 String (getText/1718706454 var2555 var57)) ; Statement: r8 = virtualinvoke $r7.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r6) 
; split operation: var1556 = var1862.split("\n") ; Statement: r9 = virtualinvoke r8.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var2173 Int (get_split_length var1862 "\n" (- 1))) ; Statement: $i4 = lengthof r9 
(define-const var2594 Int (* var1189 var2173)) ; Statement: $i5 = i3 * $i4 
(define-const var518 Float64 (cast-from-Int-to-Float64 var2594)) ; Statement: $d0 = (double) $i5 
 ; Statement: return $d0 
(check-sat)
; {viewer/-1439921249=([org.antlr.v4.gui.TreeViewer$VariableExtentProvide], org.antlr.v4.gui.TreeViewer), font/-151695256=([org.antlr.v4.gui.TreeViewer], java.awt.Font), getFontMetrics/1328729825=([javax.swing.JComponent, java.awt.Font], java.awt.FontMetrics), cast-from-var430-to-var2036=([org.antlr.v4.gui.TreeViewer], javax.swing.JComponent), getHeight/-2047551061=([java.awt.FontMetrics], int), nodeHeightPadding/-151695256=([org.antlr.v4.gui.TreeViewer], int), getText/1718706454=([org.antlr.v4.gui.TreeViewer, org.antlr.v4.runtime.tree.Tree], java.lang.String), cast-from-Int-to-Float64=([int], double)}
; {var1761=org.antlr.v4.gui.TreeViewer$VariableExtentProvide, var1751=r0, var2449=org.antlr.v4.runtime.tree.Tree, var57=r6, var430=org.antlr.v4.gui.TreeViewer, var2295=$r3, var1081=$r1, var1632=java.awt.Font, var3175=$r2, var3034=java.awt.FontMetrics, var2036=javax.swing.JComponent, var3107=r4, var3058=$i2, var1290=$r5, var3049=$i0, var705=$i1, var1189=i3, var2555=$r7, var1862=r8, var1556=r9, var2173=$i4, var2594=$i5, var518=$d0}
; {org.antlr.v4.gui.TreeViewer$VariableExtentProvide=var1761, r0=var1751, org.antlr.v4.runtime.tree.Tree=var2449, r6=var57, org.antlr.v4.gui.TreeViewer=var430, $r3=var2295, $r1=var1081, java.awt.Font=var1632, $r2=var3175, java.awt.FontMetrics=var3034, javax.swing.JComponent=var2036, r4=var3107, $i2=var3058, $r5=var1290, $i0=var3049, $i1=var705, i3=var1189, $r7=var2555, r8=var1862, r9=var1556, $i4=var2173, $i5=var2594, $d0=var518}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreeViewer$VariableExtentProvide;	r6 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r3 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$r1 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$r2 = $r1.<org.antlr.v4.gui.TreeViewer: java.awt.Font font>;	r4 = virtualinvoke $r3.<org.antlr.v4.gui.TreeViewer: java.awt.FontMetrics getFontMetrics(java.awt.Font)>($r2);	$i2 = virtualinvoke r4.<java.awt.FontMetrics: int getHeight()>();	$r5 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	$i0 = $r5.<org.antlr.v4.gui.TreeViewer: int nodeHeightPadding>;	$i1 = $i0 * 2;	i3 = $i2 + $i1;	$r7 = r0.<org.antlr.v4.gui.TreeViewer$VariableExtentProvide: org.antlr.v4.gui.TreeViewer viewer>;	r8 = virtualinvoke $r7.<org.antlr.v4.gui.TreeViewer: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r6);	r9 = virtualinvoke r8.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$i4 = lengthof r9;	$i5 = i3 * $i4;	$d0 = (double) $i5;	return $d0
;block_num 1
(exit)
