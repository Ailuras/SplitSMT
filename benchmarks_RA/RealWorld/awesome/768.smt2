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
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

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

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var3293 0)
(declare-sort var3586 0)
(declare-sort var1110 0)
(declare-sort var1444 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/-791554220 (var3293 var3586) String)
(declare-fun getBoundsOfNode/-1951447090 (var3293 var3586) var1110)
(declare-fun doc/-1930180878 (var3293) var1444)
(declare-fun x/-707491510 (var1110) Float64)
(declare-fun y/-707491510 (var1110) Float64)
(declare-fun width/-707491510 (var1110) Float64)
(declare-fun height/-707491510 (var1110) Float64)
(declare-fun highlight/-1835093399 (var1444 Float64 Float64 Float64 Float64) void)
(declare-fun nodeWidthPadding/-1930180878 (var3293) Int)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-fun nodeHeightPaddingBelow/-1930180878 (var3293) Int)
(declare-const null-var3293 var3293)
(declare-const null-var3586 var3586)
(declare-const var1203 var3293) ; Statement: r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator 
(assert (not (= var1203 null-var3293)))
(declare-const var371 var3586) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var371 null-var3586)))
(assert true)
(define-const var2493 String (getText/-791554220 var1203 var371)) ; Statement: $r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var3587 = var2493.split("\n") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(assert true)
(define-const var763 var1110 (getBoundsOfNode/-1951447090 var1203 var371)) ; Statement: r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var2982 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
 ; Statement: if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(assert (not (= (ite var2982 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var411 var1444 (doc/-1930180878 var1203)) ; Statement: $r8 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc> 
(define-const var2167 Float64 (x/-707491510 var763)) ; Statement: $d8 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var3462 Float64 (y/-707491510 var763)) ; Statement: $d7 = r4.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var2596 Float64 (width/-707491510 var763)) ; Statement: $d6 = r4.<java.awt.geom.Rectangle2D$Double: double width> 
(define-const var2799 Float64 (height/-707491510 var763)) ; Statement: $d5 = r4.<java.awt.geom.Rectangle2D$Double: double height> 
(assert true)
;(assert (highlight/-1835093399 var411 var2167 var3462 var2596 var2799)) ; Statement: virtualinvoke $r8.<org.antlr.v4.gui.PostScriptDocument: void highlight(double,double,double,double)>($d8, $d7, $d6, $d5) 

(declare-const var411!1 var1444)
(declare-const var2167!1 Float64)
(declare-const var3462!1 Float64)
(declare-const var2596!1 Float64)
(declare-const var2799!1 Float64)
(assert true) ; Non Conditional
(define-const var1050 Float64 (x/-707491510 var763)) ; Statement: $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var374 Int (nodeWidthPadding/-1930180878 var1203)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding> 
(define-const var1345 Float64 (cast-from-Int-to-Float64 var374)) ; Statement: $d0 = (double) $i0 
(define-const var2607 Float64 (fp.add roundNearestTiesToEven var1050 var1345)) ; Statement: $d9 = $d1 + $d0 
(define-const var2967 Float64 (y/-707491510 var763)) ; Statement: $d3 = r4.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var3888 Int (nodeHeightPaddingBelow/-1930180878 var1203)) ; Statement: $i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow> 
(define-const var3870 Float64 (cast-from-Int-to-Float64 var3888)) ; Statement: $d2 = (double) $i1 
(define-const var2130 Float64 (fp.add roundNearestTiesToEven var2967 var3870)) ; Statement: d10 = $d3 + $d2 
(define-const var3757 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var1027 Int (get_split_length_re var2493 (str.to_re "\u{0A}") (- 1))) ; Statement: $i3 = lengthof r3 
 ; Statement: if i2 >= $i3 goto return 
(assert (>= var3757 var1027)) ; Cond: i2 >= $i3 
 ; Statement: return 
; {getText/-791554220=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.lang.String), getBoundsOfNode/-1951447090=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), doc/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], org.antlr.v4.gui.PostScriptDocument), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), width/-707491510=([java.awt.geom.Rectangle2D$Double], double), height/-707491510=([java.awt.geom.Rectangle2D$Double], double), highlight/-1835093399=([org.antlr.v4.gui.PostScriptDocument, double, double, double, double], void), nodeWidthPadding/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int), cast-from-Int-to-Float64=([int], double), nodeHeightPaddingBelow/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int)}
; {var3293=org.antlr.v4.gui.TreePostScriptGenerator, var1203=r0, var3586=org.antlr.v4.runtime.tree.Tree, var371=r1, var2493=$r2, var3587=r3, var1110=java.awt.geom.Rectangle2D$Double, var763=r4, var2982=$z0, var1444=org.antlr.v4.gui.PostScriptDocument, var411=$r8, var2167=$d8, var3462=$d7, var2596=$d6, var2799=$d5, var1050=$d1, var374=$i0, var1345=$d0, var2607=$d9, var2967=$d3, var3888=$i1, var3870=$d2, var2130=d10, var3757=i2, var1027=$i3}
; {org.antlr.v4.gui.TreePostScriptGenerator=var3293, r0=var1203, org.antlr.v4.runtime.tree.Tree=var3586, r1=var371, $r2=var2493, r3=var3587, java.awt.geom.Rectangle2D$Double=var1110, r4=var763, $z0=var2982, org.antlr.v4.gui.PostScriptDocument=var1444, $r8=var411, $d8=var2167, $d7=var3462, $d6=var2596, $d5=var2799, $d1=var1050, $i0=var374, $d0=var1345, $d9=var2607, $d3=var2967, $i1=var3888, $d2=var3870, d10=var2130, i2=var3757, $i3=var1027}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator;	r1 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	$z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$r8 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc>;	$d8 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$d7 = r4.<java.awt.geom.Rectangle2D$Double: double y>;	$d6 = r4.<java.awt.geom.Rectangle2D$Double: double width>;	$d5 = r4.<java.awt.geom.Rectangle2D$Double: double height>;	virtualinvoke $r8.<org.antlr.v4.gui.PostScriptDocument: void highlight(double,double,double,double)>($d8, $d7, $d6, $d5);	$d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding>;	$d0 = (double) $i0;	$d9 = $d1 + $d0;	$d3 = r4.<java.awt.geom.Rectangle2D$Double: double y>;	$i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow>;	$d2 = (double) $i1;	d10 = $d3 + $d2;	i2 = 0;	$i3 = lengthof r3;	if i2 >= $i3 goto return;	return
;block_num 5
(check-sat)
(exit)
