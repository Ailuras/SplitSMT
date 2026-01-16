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

(declare-sort var1627 0)
(declare-sort var257 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun initialized/615252293 (var1627) Bool)
(declare-fun docId/615252293 (var1627) String)
(declare-const null-var1627 var1627)
(declare-const null-String String)
(declare-const var1881 var1627) ; Statement: r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent 
(assert (not (= var1881 null-var1627)))
(declare-const var552 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var552 null-String)))
; split operation: var1703 = var552.split("\u005cs*\u005c|\u005cs*", 9) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9) 
(define-const var2298 String (get_split_element_re var552 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 0)) ; Statement: r2 = r1[0] 
(define-const var70 String (get_split_element_re var552 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 1)) ; Statement: r3 = r1[1] 
(define-const var2047 String (get_split_element_re var552 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 2)) ; Statement: r4 = r1[2] 
(define-const var3605 String (get_split_element_re var552 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 3)) ; Statement: r5 = r1[3] 
(define-const var2149 String (get_split_element_re var552 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 8)) ; Statement: r6 = r1[8] 
(define-const var459 Bool (initialized/615252293 var1881)) ; Statement: $z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized> 
 ; Statement: if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2 
(assert (not (= (ite var459 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var601 String (docId/615252293 var1881)) ; Statement: $r11 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> 
(assert true)
(define-const var2771 Bool (= var2298 var601)) ; Statement: $z1 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>($r11) 
 ; Statement: if $z1 == 0 goto return 0 
(assert (= (ite var2771 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 0 
; {initialized/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], boolean), docId/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String)}
; {var1627=edu.stanford.nlp.time.SUTimeMain$TimebankSent, var1881=r7, var552=r0, var257=null_type, var1703=r1, var2298=r2, var70=r3, var2047=r4, var3605=r5, var2149=r6, var459=$z0, var601=$r11, var2771=$z1}
; {edu.stanford.nlp.time.SUTimeMain$TimebankSent=var1627, r7=var1881, r0=var552, null_type=var257, r1=var1703, r2=var2298, r3=var70, r4=var2047, r5=var3605, r6=var2149, $z0=var459, $r11=var601, $z1=var2771}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9);	r2 = r1[0];	r3 = r1[1];	r4 = r1[2];	r5 = r1[3];	r6 = r1[8];	$z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized>;	if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2;	$r11 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId>;	$z1 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>($r11);	if $z1 == 0 goto return 0;	return 0
;block_num 3
(check-sat)
(exit)
