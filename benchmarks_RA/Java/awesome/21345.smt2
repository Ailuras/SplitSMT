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

(declare-sort var2680 0)
(declare-sort var3031 0)
(declare-sort var290 0)
(declare-sort var1894 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPhrase/-292787131 (var290) String)
(declare-fun var3031_containsKey/1421819118 (var3031 var1894) Bool)
(declare-fun cast-from-var290-to-var1894 (var290) var1894)
(declare-fun var3031_getCount/958668014 (var3031 var1894) Float64)
(declare-const null-var2680 var2680)
(declare-const null-var3031 var3031)
(declare-const null-var290 var290)
(declare-const null-Float64 Float64)
(declare-const var886 var2680) ; Statement: r3 := @this: edu.stanford.nlp.patterns.PhraseScorer 
(assert (not (= var886 null-var2680)))
(declare-const var3592 var3031) ; Statement: r6 := @parameter0: edu.stanford.nlp.stats.Counter 
(assert (not (= var3592 null-var3031)))
(declare-const var795 var290) ; Statement: r0 := @parameter1: edu.stanford.nlp.patterns.CandidatePhrase 
(assert (not (= var795 null-var290)))
(declare-const var1760 Float64) ; Statement: d2 := @parameter2: double 
(assert (not (= var1760 null-Float64)))
(assert true)
(define-const var3246 String (getPhrase/-292787131 var795)) ; Statement: $r1 = virtualinvoke r0.<edu.stanford.nlp.patterns.CandidatePhrase: java.lang.String getPhrase()>() 
; split operation: var2202 = var3246.split("\u005cs+") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var3086 Int (get_split_length var3246 "\u005cs+" (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 >= 2 goto d4 = 0.0 
(assert (not (>= var3086 2))) ; Negate: Cond: $i0 >= 2  
(define-const var732 Bool (var3031_containsKey/1421819118 var3592 (cast-from-var290-to-var1894 var795))) ; Statement: $z2 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: boolean containsKey(java.lang.Object)>(r0) 
 ; Statement: if $z2 == 0 goto return d2 
(assert (not (= (ite var732 1 0) 0))) ; Negate: Cond: $z2 == 0  
(define-const var120 Float64 (var3031_getCount/958668014 var3592 (cast-from-var290-to-var1894 var795))) ; Statement: $d3 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: double getCount(java.lang.Object)>(r0) 
 ; Statement: return $d3 
(check-sat)
; {getPhrase/-292787131=([edu.stanford.nlp.patterns.CandidatePhrase], java.lang.String), var3031_containsKey/1421819118=([edu.stanford.nlp.stats.Counter, java.lang.Object], boolean), cast-from-var290-to-var1894=([edu.stanford.nlp.patterns.CandidatePhrase], java.lang.Object), var3031_getCount/958668014=([edu.stanford.nlp.stats.Counter, java.lang.Object], double)}
; {var2680=edu.stanford.nlp.patterns.PhraseScorer, var886=r3, var3031=edu.stanford.nlp.stats.Counter, var3592=r6, var290=edu.stanford.nlp.patterns.CandidatePhrase, var795=r0, var1760=d2, var3246=$r1, var2202=r2, var3086=$i0, var1894=java.lang.Object, var732=$z2, var120=$d3}
; {edu.stanford.nlp.patterns.PhraseScorer=var2680, r3=var886, edu.stanford.nlp.stats.Counter=var3031, r6=var3592, edu.stanford.nlp.patterns.CandidatePhrase=var290, r0=var795, d2=var1760, $r1=var3246, r2=var2202, $i0=var3086, java.lang.Object=var1894, $z2=var732, $d3=var120}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: edu.stanford.nlp.patterns.PhraseScorer;	r6 := @parameter0: edu.stanford.nlp.stats.Counter;	r0 := @parameter1: edu.stanford.nlp.patterns.CandidatePhrase;	d2 := @parameter2: double;	$r1 = virtualinvoke r0.<edu.stanford.nlp.patterns.CandidatePhrase: java.lang.String getPhrase()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$i0 = lengthof r2;	if $i0 >= 2 goto d4 = 0.0;	$z2 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: boolean containsKey(java.lang.Object)>(r0);	if $z2 == 0 goto return d2;	$d3 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: double getCount(java.lang.Object)>(r0);	return $d3
;block_num 3
(exit)
