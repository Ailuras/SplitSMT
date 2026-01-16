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

(declare-sort var3522 0)
(declare-sort var1673 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun splitRegex/-1299977600 (var3522) String)
(declare-fun arr-String-init () (Array Int String))
(declare-const null-var3522 var3522)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3495 var3522) ; Statement: r1 := @this: edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1 
(assert (not (= var3495 null-var3522)))
(declare-const var3713 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3713 null-String)))
(assert true)
(define-const var2630 String (trim/-847153721 var3713)) ; Statement: $r3 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(define-const var1867 String (splitRegex/-1299977600 var3495)) ; Statement: $r2 = r1.<edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1: java.lang.String splitRegex> 
; split operation: var2653 = var2630.split(var1867) ; Statement: r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>($r2) 
(define-const var3995 Int (get_split_length var2630 var1867 (- 1))) ; Statement: $i0 = lengthof r4 
 ; Statement: if $i0 != 2 goto $r5 = newarray (java.lang.String)[1] 
(assert (not (= var3995 2))) ; Cond: $i0 != 2 
(define-const var283 (Array Int String) arr-String-init) ; Statement: $r5 = newarray (java.lang.String)[1] 
(declare-const var283!1 (Array Int String))
(assert (not (= var283!1 null-__Array__Int__String__)))
(assert (= (select var283!1 0) var3713)) ; Statement: $r5[0] = r0 
 ; Statement: return $r5 
; {trim/-847153721=([java.lang.String], java.lang.String), splitRegex/-1299977600=([edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1], java.lang.String), arr-String-init=([], java.lang.String[])}
; {var3522=edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1, var3495=r1, var3713=r0, var1673=null_type, var2630=$r3, var1867=$r2, var2653=r4, var3995=$i0, var283=$r5}
; {edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1=var3522, r1=var3495, r0=var3713, null_type=var1673, $r3=var2630, $r2=var1867, r4=var2653, $i0=var3995, $r5=var283}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1;	r0 := @parameter0: java.lang.String;	$r3 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r2 = r1.<edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1: java.lang.String splitRegex>;	r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>($r2);	$i0 = lengthof r4;	if $i0 != 2 goto $r5 = newarray (java.lang.String)[1];	$r5 = newarray (java.lang.String)[1];	$r5[0] = r0;	return $r5
;block_num 2
(check-sat)
(exit)
