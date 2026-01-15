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

(declare-sort var3342 0)
(declare-sort var2098 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun initialized/615252293 (var3342) Bool)
(declare-fun docId/615252293 (var3342) String)
(declare-fun sentId/615252293 (var3342) String)
(declare-const null-var3342 var3342)
(declare-const null-String String)
(declare-const var1639 var3342) ; Statement: r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent 
(assert (not (= var1639 null-var3342)))
(declare-const var1786 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1786 null-String)))
; split operation: var2215 = var1786.split("\u005cs*\u005c|\u005cs*", 9) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9) 
(define-const var1417 String (get_split_element_re var1786 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 0)) ; Statement: r2 = r1[0] 
(define-const var1398 String (get_split_element_re var1786 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 1)) ; Statement: r3 = r1[1] 
(define-const var1950 String (get_split_element_re var1786 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 2)) ; Statement: r4 = r1[2] 
(define-const var2986 String (get_split_element_re var1786 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 3)) ; Statement: r5 = r1[3] 
(define-const var1599 String (get_split_element_re var1786 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 8)) ; Statement: r6 = r1[8] 
(define-const var2617 Bool (initialized/615252293 var1639)) ; Statement: $z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized> 
 ; Statement: if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2 
(assert (not (= (ite var2617 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2627 String (docId/615252293 var1639)) ; Statement: $r11 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> 
(assert true)
(define-const var953 Bool (= var1417 var2627)) ; Statement: $z1 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>($r11) 
 ; Statement: if $z1 == 0 goto return 0 
(assert (not (= (ite var953 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3903 String (sentId/615252293 var1639)) ; Statement: $r12 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String sentId> 
(assert true)
(define-const var42 Bool (= var2986 var3903)) ; Statement: $z2 = virtualinvoke r5.<java.lang.String: boolean equals(java.lang.Object)>($r12) 
 ; Statement: if $z2 != 0 goto $r8 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.util.List origItems> 
(assert (not (not (= (ite var42 1 0) 0)))) ; Negate: Cond: $z2 != 0  
 ; Statement: return 0 
(check-sat)
; {initialized/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], boolean), docId/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String), sentId/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String)}
; {var3342=edu.stanford.nlp.time.SUTimeMain$TimebankSent, var1639=r7, var1786=r0, var2098=null_type, var2215=r1, var1417=r2, var1398=r3, var1950=r4, var2986=r5, var1599=r6, var2617=$z0, var2627=$r11, var953=$z1, var3903=$r12, var42=$z2}
; {edu.stanford.nlp.time.SUTimeMain$TimebankSent=var3342, r7=var1639, r0=var1786, null_type=var2098, r1=var2215, r2=var1417, r3=var1398, r4=var1950, r5=var2986, r6=var1599, $z0=var2617, $r11=var2627, $z1=var953, $r12=var3903, $z2=var42}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9);	r2 = r1[0];	r3 = r1[1];	r4 = r1[2];	r5 = r1[3];	r6 = r1[8];	$z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized>;	if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2;	$r11 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId>;	$z1 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>($r11);	if $z1 == 0 goto return 0;	$r12 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String sentId>;	$z2 = virtualinvoke r5.<java.lang.String: boolean equals(java.lang.Object)>($r12);	if $z2 != 0 goto $r8 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.util.List origItems>;	return 0
;block_num 4
(exit)
