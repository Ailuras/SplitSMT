(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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

(declare-sort var3763 0)
(declare-sort var1099 0)
(declare-sort var2182 0)
(declare-sort var3356 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2182!class ClassObject)
(declare-const var3356!class ClassObject)
(declare-fun var1099_fillOptions/-926000568 (ClassObject var3763) void)
(declare-const null-var3763 var3763)
(declare-const var2182-ignoreRels String)
(declare-const var2182-allowedTagsForTrigger String)
(declare-const var2374 var3763) ; Statement: r0 := @parameter0: java.util.Properties 
(assert (not (= var2374 null-var3763)))
;(assert (var1099_fillOptions/-926000568 var2182!class var2374)) ; Statement: staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/dep/DepPatternFactory;", r0) 

(declare-const var3951 ClassObject)
(declare-const var2374!1 var3763)
;(assert (var1099_fillOptions/-926000568 var3356!class var2374!1)) ; Statement: staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/PatternFactory;", r0) 

(declare-const var941 ClassObject)
(declare-const var2374!2 var3763)
(define-const var527 String var2182-ignoreRels) ; Statement: $r1 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String ignoreRels> 
; split operation: var1788 = var527.split("[,;]") ; Statement: r7 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var2137 Int (get_split_length var527 "[,;]" (- 1))) ; Statement: i0 = lengthof r7 
(define-const var3780 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r2 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String allowedTagsForTrigger> 
(assert (>= var3780 var2137)) ; Cond: i1 >= i0 
(define-const var2432 String var2182-allowedTagsForTrigger) ; Statement: $r2 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String allowedTagsForTrigger> 
; split operation: var999 = var2432.split("[,;]") ; Statement: r9 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var3485 Int (get_split_length var2432 "[,;]" (- 1))) ; Statement: i2 = lengthof r9 
(define-const var1395 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i2 goto return 
(assert (>= var1395 var3485)) ; Cond: i3 >= i2 
 ; Statement: return 
(check-sat)
; {var1099_fillOptions/-926000568=([java.lang.Class, java.util.Properties], void)}
; {var3763=java.util.Properties, var2374=r0, var1099=edu.stanford.nlp.util.ArgumentParser, var2182=edu.stanford.nlp.patterns.dep.DepPatternFactory, var3951=class "Ledu/stanford/nlp/patterns/dep/DepPatternFactory;", var3356=edu.stanford.nlp.patterns.PatternFactory, var941=class "Ledu/stanford/nlp/patterns/PatternFactory;", var527=$r1, var1788=r7, var2137=i0, var3780=i1, var2432=$r2, var999=r9, var3485=i2, var1395=i3}
; {java.util.Properties=var3763, r0=var2374, edu.stanford.nlp.util.ArgumentParser=var1099, edu.stanford.nlp.patterns.dep.DepPatternFactory=var2182, class "Ledu/stanford/nlp/patterns/dep/DepPatternFactory;"=var3951, edu.stanford.nlp.patterns.PatternFactory=var3356, class "Ledu/stanford/nlp/patterns/PatternFactory;"=var941, $r1=var527, r7=var1788, i0=var2137, i1=var3780, $r2=var2432, r9=var999, i2=var3485, i3=var1395}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.util.Properties;	staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/dep/DepPatternFactory;", r0);	staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/PatternFactory;", r0);	$r1 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String ignoreRels>;	r7 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	i0 = lengthof r7;	i1 = 0;	if i1 >= i0 goto $r2 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String allowedTagsForTrigger>;	$r2 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String allowedTagsForTrigger>;	r9 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	i2 = lengthof r9;	i3 = 0;	if i3 >= i2 goto return;	return
;block_num 5
(exit)
