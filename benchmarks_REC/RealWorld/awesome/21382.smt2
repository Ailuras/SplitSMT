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

(declare-sort var1098 0)
(declare-sort var2080 0)
(declare-sort var3002 0)
(declare-sort var3010 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPhrase/-292787131 (var3002) String)
(declare-fun var2080_containsKey/1421819118 (var2080 var3010) Bool)
(declare-fun cast-from-var3002-to-var3010 (var3002) var3010)
(declare-const null-var1098 var1098)
(declare-const null-var2080 var2080)
(declare-const null-var3002 var3002)
(declare-const null-Float64 Float64)
(declare-const var1889 var1098) ; Statement: r3 := @this: edu.stanford.nlp.patterns.PhraseScorer 
(assert (not (= var1889 null-var1098)))
(declare-const var3981 var2080) ; Statement: r6 := @parameter0: edu.stanford.nlp.stats.Counter 
(assert (not (= var3981 null-var2080)))
(declare-const var2772 var3002) ; Statement: r0 := @parameter1: edu.stanford.nlp.patterns.CandidatePhrase 
(assert (not (= var2772 null-var3002)))
(declare-const var1986 Float64) ; Statement: d2 := @parameter2: double 
(assert (not (= var1986 null-Float64)))
(assert true)
(define-const var1172 String (getPhrase/-292787131 var2772)) ; Statement: $r1 = virtualinvoke r0.<edu.stanford.nlp.patterns.CandidatePhrase: java.lang.String getPhrase()>() 
; split operation: var3189 = var1172.split("\u005cs+") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1276 Int (get_split_length_re var1172 (re.+ (re.union (str.to_re " ") (str.to_re "\u{09}"))) (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 >= 2 goto d4 = 0.0 
(assert (not (>= var1276 2))) ; Negate: Cond: $i0 >= 2  
(define-const var2585 Bool (var2080_containsKey/1421819118 var3981 (cast-from-var3002-to-var3010 var2772))) ; Statement: $z2 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: boolean containsKey(java.lang.Object)>(r0) 
 ; Statement: if $z2 == 0 goto return d2 
(assert (= (ite var2585 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return d2 
(check-sat)
; {getPhrase/-292787131=([edu.stanford.nlp.patterns.CandidatePhrase], java.lang.String), var2080_containsKey/1421819118=([edu.stanford.nlp.stats.Counter, java.lang.Object], boolean), cast-from-var3002-to-var3010=([edu.stanford.nlp.patterns.CandidatePhrase], java.lang.Object)}
; {var1098=edu.stanford.nlp.patterns.PhraseScorer, var1889=r3, var2080=edu.stanford.nlp.stats.Counter, var3981=r6, var3002=edu.stanford.nlp.patterns.CandidatePhrase, var2772=r0, var1986=d2, var1172=$r1, var3189=r2, var1276=$i0, var3010=java.lang.Object, var2585=$z2}
; {edu.stanford.nlp.patterns.PhraseScorer=var1098, r3=var1889, edu.stanford.nlp.stats.Counter=var2080, r6=var3981, edu.stanford.nlp.patterns.CandidatePhrase=var3002, r0=var2772, d2=var1986, $r1=var1172, r2=var3189, $i0=var1276, java.lang.Object=var3010, $z2=var2585}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: edu.stanford.nlp.patterns.PhraseScorer;	r6 := @parameter0: edu.stanford.nlp.stats.Counter;	r0 := @parameter1: edu.stanford.nlp.patterns.CandidatePhrase;	d2 := @parameter2: double;	$r1 = virtualinvoke r0.<edu.stanford.nlp.patterns.CandidatePhrase: java.lang.String getPhrase()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$i0 = lengthof r2;	if $i0 >= 2 goto d4 = 0.0;	$z2 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: boolean containsKey(java.lang.Object)>(r0);	if $z2 == 0 goto return d2;	return d2
;block_num 3
(exit)
