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

(declare-sort var40 0)
(declare-sort var322 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var40 var40)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1356 var40) ; Statement: r10 := @parameter0: edu.stanford.nlp.util.CollectionValuedMap 
(assert (not (= var1356 null-var40)))
(declare-const var1202 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1202 null-String)))
(declare-const var1437 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var1437 null-Bool)))
 ; Statement: if r0 != null goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(assert (not (= var1202 null-String))) ; Cond: r0 != null 
(assert true)
(define-const var2212 String (trim/-847153721 var1202)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
; split operation: var1214 = var2212.split("\u005cs*,\u005cs*") ; Statement: $r33 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*,\\s*") 
(assert true) ; Non Conditional
(declare-const var1214 (Array Int String))
(define-const var2299 (Array Int String) var1214) ; Statement: r2 = $r33 
(define-const var1252 Int (get_split_length_re var2212 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re ",") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: $i1 = lengthof $r33 
(define-const var661 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto return 
(assert (>= var661 var1252)) ; Cond: i2 >= $i1 
 ; Statement: return 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String)}
; {var40=edu.stanford.nlp.util.CollectionValuedMap, var1356=r10, var1202=r0, var322=null_type, var1437=z1, var2212=$r1, var1214=$r33, var2299=r2, var1252=$i1, var661=i2}
; {edu.stanford.nlp.util.CollectionValuedMap=var40, r10=var1356, r0=var1202, null_type=var322, z1=var1437, $r1=var2212, $r33=var1214, r2=var2299, $i1=var1252, i2=var661}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r10 := @parameter0: edu.stanford.nlp.util.CollectionValuedMap;	r0 := @parameter1: java.lang.String;	z1 := @parameter2: boolean;	if r0 != null goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r33 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*,\\s*");	r2 = $r33;	$i1 = lengthof $r33;	i2 = 0;	if i2 >= $i1 goto return;	return
;block_num 5
(exit)
