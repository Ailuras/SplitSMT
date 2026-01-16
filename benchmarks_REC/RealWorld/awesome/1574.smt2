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

(declare-sort var1383 0)
(declare-sort var3968 0)
(declare-sort var1095 0)
(declare-sort var3067 0)
(declare-sort var251 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun tlp/-1510366313 (var3067) var1095)
(declare-fun cast-from-var1383-to-var3067 (var1383) var3067)
(declare-fun var1095_morphFeatureSpec/-1525671968 (var1095) var251)
(declare-fun morphoSpec/-974673759 (var1383) var251)
(declare-fun toString/1418588163 (var251) String)
(declare-const null-var1383 var1383)
(declare-const null-String String)
(declare-const var2468 var1383) ; Statement: r2 := @this: edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams 
(assert (not (= var2468 null-var1383)))
(declare-const var1863 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1863 null-String)))
; split operation: var1352 = var1863.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2336 var1095 (tlp/-1510366313 (cast-from-var1383-to-var3067 var2468))) ; Statement: $r3 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.trees.TreebankLanguagePack tlp> 
(define-const var452 var251 (var1095_morphFeatureSpec/-1525671968 var2336)) ; Statement: $r4 = interfaceinvoke $r3.<edu.stanford.nlp.trees.TreebankLanguagePack: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphFeatureSpec()>() 
(declare-const var2468!1 var1383)
(assert (not (= var2468!1 null-var1383)))
(assert (= (morphoSpec/-974673759 var2468!1) var452)) ; Statement: r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> = $r4 
(define-const var2684 Int (get_split_length var1863 "," (- 1))) ; Statement: i0 = lengthof r1 
(define-const var3129 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r5 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> 
(assert (>= var3129 var2684)) ; Cond: i1 >= i0 
(define-const var2704 var251 (morphoSpec/-974673759 var2468!1)) ; Statement: $r5 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> 
(assert true)
(define-const var1511 String (toString/1418588163 var2704)) ; Statement: $r6 = virtualinvoke $r5.<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>() 
 ; Statement: return $r6 
; {tlp/-1510366313=([edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams], edu.stanford.nlp.trees.TreebankLanguagePack), cast-from-var1383-to-var3067=([edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams], edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams), var1095_morphFeatureSpec/-1525671968=([edu.stanford.nlp.trees.TreebankLanguagePack], edu.stanford.nlp.international.morph.MorphoFeatureSpecification), morphoSpec/-974673759=([edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams], edu.stanford.nlp.international.morph.MorphoFeatureSpecification), toString/1418588163=([edu.stanford.nlp.international.morph.MorphoFeatureSpecification], java.lang.String)}
; {var1383=edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams, var2468=r2, var1863=r0, var3968=null_type, var1352=r1, var1095=edu.stanford.nlp.trees.TreebankLanguagePack, var3067=edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams, var2336=$r3, var251=edu.stanford.nlp.international.morph.MorphoFeatureSpecification, var452=$r4, var2684=i0, var3129=i1, var2704=$r5, var1511=$r6}
; {edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams=var1383, r2=var2468, r0=var1863, null_type=var3968, r1=var1352, edu.stanford.nlp.trees.TreebankLanguagePack=var1095, edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams=var3067, $r3=var2336, edu.stanford.nlp.international.morph.MorphoFeatureSpecification=var251, $r4=var452, i0=var2684, i1=var3129, $r5=var2704, $r6=var1511}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @this: edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r3 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.trees.TreebankLanguagePack tlp>;	$r4 = interfaceinvoke $r3.<edu.stanford.nlp.trees.TreebankLanguagePack: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphFeatureSpec()>();	r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> = $r4;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto $r5 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec>;	$r5 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec>;	$r6 = virtualinvoke $r5.<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>();	return $r6
;block_num 3
(check-sat)
(exit)
