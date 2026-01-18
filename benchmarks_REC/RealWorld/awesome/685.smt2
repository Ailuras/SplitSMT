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

(declare-sort var1897 0)
(declare-sort var2730 0)
(declare-sort var2615 0)
(declare-sort var3458 0)
(declare-sort var1560 0)
(declare-sort var3151 0)
(declare-sort var1476 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1476!class ClassObject)
(declare-fun var2615-init () var2615)
(declare-fun <init>/-325640736 (var2615) void)
(declare-fun flags/769901519 (var1897) var3458)
(declare-fun backgroundSymbol/-179725236 (var3458) String)
(declare-fun entitySubclassification/-179725236 (var3458) String)
(declare-fun intern/-179725236 (var3458) Bool)
(declare-fun var1560_entitySubclassify/209045334 (var3151 ClassObject String String Bool) void)
(declare-fun cast-from-var2615-to-var3151 (var2615) var3151)
(declare-const null-var1897 var1897)
(declare-const null-String String)
(declare-const var1451 var1897) ; Statement: r3 := @this: edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter 
(assert (not (= var1451 null-var1897)))
(declare-const var740 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var740 null-String)))
(define-const var3377 var2615 var2615-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3377)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var3377!1 var2615)
; split operation: var3646 = var740.split("\n") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var2280 Int (get_split_length_re var740 (str.to_re "\u{0A}") (- 1))) ; Statement: i0 = lengthof r2 
(define-const var930 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r4 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags> 
(assert (>= var930 var2280)) ; Cond: i1 >= i0 
(define-const var3816 var3458 (flags/769901519 var1451)) ; Statement: $r4 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags> 
(define-const var3194 String (backgroundSymbol/-179725236 var3816)) ; Statement: $r8 = $r4.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String backgroundSymbol> 
(define-const var3321 var3458 (flags/769901519 var1451)) ; Statement: $r5 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags> 
(define-const var1342 String (entitySubclassification/-179725236 var3321)) ; Statement: $r7 = $r5.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String entitySubclassification> 
(define-const var3896 var3458 (flags/769901519 var1451)) ; Statement: $r6 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags> 
(define-const var2057 Bool (intern/-179725236 var3896)) ; Statement: $z0 = $r6.<edu.stanford.nlp.sequences.SeqClassifierFlags: boolean intern> 
;(assert (var1560_entitySubclassify/209045334 (cast-from-var2615-to-var3151 var3377!1) var1476!class var3194 var1342 var2057)) ; Statement: staticinvoke <edu.stanford.nlp.sequences.IOBUtils: void entitySubclassify(java.util.List,java.lang.Class,java.lang.String,java.lang.String,boolean)>($r0, class "Ledu/stanford/nlp/ling/CoreAnnotations$AnswerAnnotation;", $r8, $r7, $z0) 

(declare-const var3377!2 var2615)
(declare-const var1501 ClassObject)
(declare-const var3194!1 String)
(declare-const var1342!1 String)
(declare-const var2057!1 Bool)
 ; Statement: return $r0 
; {var2615-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), flags/769901519=([edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter], edu.stanford.nlp.sequences.SeqClassifierFlags), backgroundSymbol/-179725236=([edu.stanford.nlp.sequences.SeqClassifierFlags], java.lang.String), entitySubclassification/-179725236=([edu.stanford.nlp.sequences.SeqClassifierFlags], java.lang.String), intern/-179725236=([edu.stanford.nlp.sequences.SeqClassifierFlags], boolean), var1560_entitySubclassify/209045334=([java.util.List, java.lang.Class, java.lang.String, java.lang.String, boolean], void), cast-from-var2615-to-var3151=([java.util.ArrayList], java.util.List)}
; {var1897=edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter, var1451=r3, var740=r1, var2730=null_type, var2615=java.util.ArrayList, var3377=$r0, var3646=r2, var2280=i0, var930=i1, var3458=edu.stanford.nlp.sequences.SeqClassifierFlags, var3816=$r4, var3194=$r8, var3321=$r5, var1342=$r7, var3896=$r6, var2057=$z0, var1560=edu.stanford.nlp.sequences.IOBUtils, var3151=java.util.List, var1476=edu.stanford.nlp.ling.CoreAnnotations$AnswerAnnotation, var1501=class "Ledu/stanford/nlp/ling/CoreAnnotations$AnswerAnnotation;"}
; {edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter=var1897, r3=var1451, r1=var740, null_type=var2730, java.util.ArrayList=var2615, $r0=var3377, r2=var3646, i0=var2280, i1=var930, edu.stanford.nlp.sequences.SeqClassifierFlags=var3458, $r4=var3816, $r8=var3194, $r5=var3321, $r7=var1342, $r6=var3896, $z0=var2057, edu.stanford.nlp.sequences.IOBUtils=var1560, java.util.List=var3151, edu.stanford.nlp.ling.CoreAnnotations$AnswerAnnotation=var1476, class "Ledu/stanford/nlp/ling/CoreAnnotations$AnswerAnnotation;"=var1501}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter;	r1 := @parameter0: java.lang.String;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	i0 = lengthof r2;	i1 = 0;	if i1 >= i0 goto $r4 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;	$r4 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;	$r8 = $r4.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String backgroundSymbol>;	$r5 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;	$r7 = $r5.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String entitySubclassification>;	$r6 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;	$z0 = $r6.<edu.stanford.nlp.sequences.SeqClassifierFlags: boolean intern>;	staticinvoke <edu.stanford.nlp.sequences.IOBUtils: void entitySubclassify(java.util.List,java.lang.Class,java.lang.String,java.lang.String,boolean)>($r0, class "Ledu/stanford/nlp/ling/CoreAnnotations$AnswerAnnotation;", $r8, $r7, $z0);	return $r0
;block_num 3
(check-sat)
(exit)
