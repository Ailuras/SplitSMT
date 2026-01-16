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

(declare-sort var3290 0)
(declare-sort var2910 0)
(declare-sort var1398 0)
(declare-sort var459 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun loadTextClassifier/2023711293 (var1398 var2910) void)
(declare-fun cast-from-var3290-to-var1398 (var3290) var1398)
(declare-fun readLine/150542008 (var2910) String)
(declare-fun var459-init () var459)
(declare-fun <init>/-1084991535 (var459 String) void)
(declare-const null-var3290 var3290)
(declare-const null-var2910 var2910)
(declare-const var1556 var3290) ; Statement: r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierNonlinear 
(assert (not (= var1556 null-var3290)))
(declare-const var2102 var2910) ; Statement: r1 := @parameter0: java.io.BufferedReader 
(assert (not (= var2102 null-var2910)))
(assert true)
;(assert (loadTextClassifier/2023711293 (cast-from-var3290-to-var1398 var1556) var2102)) ; Statement: specialinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifier: void loadTextClassifier(java.io.BufferedReader)>(r1) 

(declare-const var1556!1 var3290)
(declare-const var2102!1 var2910)
(assert true)
(define-const var132 String (readLine/150542008 var2102!1)) ; Statement: r83 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>() 
; split operation: var1879 = var132.split("\u005ct") ; Statement: r84 = virtualinvoke r83.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t") 
(define-const var2030 String (get_split_element var132 "\u{09}" (- 1) 0)) ; Statement: $r2 = r84[0] 
(assert true)
(define-const var3491 Bool (= var2030 "nodeFeatureIndicesMap.size()=")) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("nodeFeatureIndicesMap.size()=") 
 ; Statement: if $z0 != 0 goto $r3 = r84[1] 
(assert (not (not (= (ite var3491 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3235 var459 var459-init) ; Statement: $r82 = new java.lang.RuntimeException 
(assert true)
;(assert (<init>/-1084991535 var3235 "format error in nodeFeatureIndicesMap")) ; Statement: specialinvoke $r82.<java.lang.RuntimeException: void <init>(java.lang.String)>("format error in nodeFeatureIndicesMap") 

(declare-const var3235!1 var459)
(declare-const var3501 String)
 ; Statement: throw $r82 
; {loadTextClassifier/2023711293=([edu.stanford.nlp.ie.crf.CRFClassifier, java.io.BufferedReader], void), cast-from-var3290-to-var1398=([edu.stanford.nlp.ie.crf.CRFClassifierNonlinear], edu.stanford.nlp.ie.crf.CRFClassifier), readLine/150542008=([java.io.BufferedReader], java.lang.String), var459-init=([], java.lang.RuntimeException), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3290=edu.stanford.nlp.ie.crf.CRFClassifierNonlinear, var1556=r0, var2910=java.io.BufferedReader, var2102=r1, var1398=edu.stanford.nlp.ie.crf.CRFClassifier, var132=r83, var1879=r84, var2030=$r2, var3491=$z0, var459=java.lang.RuntimeException, var3235=$r82, var3501="format error in nodeFeatureIndicesMap"}
; {edu.stanford.nlp.ie.crf.CRFClassifierNonlinear=var3290, r0=var1556, java.io.BufferedReader=var2910, r1=var2102, edu.stanford.nlp.ie.crf.CRFClassifier=var1398, r83=var132, r84=var1879, $r2=var2030, $z0=var3491, java.lang.RuntimeException=var459, $r82=var3235, "format error in nodeFeatureIndicesMap"=var3501}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierNonlinear;	r1 := @parameter0: java.io.BufferedReader;	specialinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifier: void loadTextClassifier(java.io.BufferedReader)>(r1);	r83 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>();	r84 = virtualinvoke r83.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t");	$r2 = r84[0];	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("nodeFeatureIndicesMap.size()=");	if $z0 != 0 goto $r3 = r84[1];	$r82 = new java.lang.RuntimeException;	specialinvoke $r82.<java.lang.RuntimeException: void <init>(java.lang.String)>("format error in nodeFeatureIndicesMap");	throw $r82
;block_num 2
(check-sat)
(exit)
