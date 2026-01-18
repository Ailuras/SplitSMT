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

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var3303 0)
(declare-sort var2408 0)
(declare-sort var1767 0)
(declare-sort var1109 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun initialized/615252293 (var3303) Bool)
(declare-fun docId/615252293 (var3303) String)
(declare-fun docFilename/615252293 (var3303) String)
(declare-fun docPubDate/615252293 (var3303) String)
(declare-fun sentId/615252293 (var3303) String)
(declare-fun text/615252293 (var3303) String)
(declare-fun origItems/615252293 (var3303) var1767)
(declare-fun var1767_add/328494887 (var1767 var1109) Bool)
(declare-fun cast-from-String-to-var1109 (String) var1109)
(declare-const null-var3303 var3303)
(declare-const null-String String)
(declare-const var3752 var3303) ; Statement: r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent 
(assert (not (= var3752 null-var3303)))
(declare-const var3311 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3311 null-String)))
; split operation: var2479 = var3311.split("\u005cs*\u005c|\u005cs*", 9) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9) 
(define-const var381 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 0)) ; Statement: r2 = r1[0] 
(define-const var1107 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 1)) ; Statement: r3 = r1[1] 
(define-const var558 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 2)) ; Statement: r4 = r1[2] 
(define-const var1324 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 3)) ; Statement: r5 = r1[3] 
(define-const var2037 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 8)) ; Statement: r6 = r1[8] 
(define-const var176 Bool (initialized/615252293 var3752)) ; Statement: $z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized> 
 ; Statement: if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2 
(assert (= (ite var176 1 0) 0)) ; Cond: $z0 == 0 
(declare-const var3752!1 var3303)
(assert (not (= var3752!1 null-var3303)))
(assert (= (docId/615252293 var3752!1) var381)) ; Statement: r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2 
(declare-const var3752!2 var3303)
(assert (not (= var3752!2 null-var3303)))
(assert (= (docFilename/615252293 var3752!2) var1107)) ; Statement: r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docFilename> = r3 
(declare-const var3752!3 var3303)
(assert (not (= var3752!3 null-var3303)))
(assert (= (docPubDate/615252293 var3752!3) var558)) ; Statement: r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docPubDate> = r4 
(declare-const var3752!4 var3303)
(assert (not (= var3752!4 null-var3303)))
(assert (= (sentId/615252293 var3752!4) var1324)) ; Statement: r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String sentId> = r5 
(declare-const var3752!5 var3303)
(assert (not (= var3752!5 null-var3303)))
(assert (= (text/615252293 var3752!5) var2037)) ; Statement: r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String text> = r6 
(declare-const var3752!6 var3303)
(assert (not (= var3752!6 null-var3303)))
(assert (= (initialized/615252293 var3752!6) (ite (= 1 1) true false))) ; Statement: r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized> = 1 
(assert true) ; Non Conditional
(define-const var623 var1767 (origItems/615252293 var3752!6)) ; Statement: $r8 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.util.List origItems> 
;(assert (var1767_add/328494887 var623 (cast-from-String-to-var1109 var3311))) ; Statement: interfaceinvoke $r8.<java.util.List: boolean add(java.lang.Object)>(r0) 

(declare-const var623!1 var1767)
(declare-const var3311!1 String)
(define-const var2203 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 4)) ; Statement: $r13 = r1[4] 
(define-const var140 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 5)) ; Statement: $r14 = r1[5] 
(define-const var1772 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 6)) ; Statement: $r15 = r1[6] 
(define-const var1101 String (get_split_element_re var3311 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "|") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) 9 7)) ; Statement: $r16 = r1[7] 
 ; Statement: if $r13 == null goto return 1 
(assert (= var2203 null-String)) ; Cond: $r13 == null 
 ; Statement: return 1 
; {initialized/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], boolean), docId/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String), docFilename/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String), docPubDate/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String), sentId/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String), text/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String), origItems/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.util.List), var1767_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var1109=([java.lang.String], java.lang.Object)}
; {var3303=edu.stanford.nlp.time.SUTimeMain$TimebankSent, var3752=r7, var3311=r0, var2408=null_type, var2479=r1, var381=r2, var1107=r3, var558=r4, var1324=r5, var2037=r6, var176=$z0, var1767=java.util.List, var623=$r8, var1109=java.lang.Object, var2203=$r13, var140=$r14, var1772=$r15, var1101=$r16}
; {edu.stanford.nlp.time.SUTimeMain$TimebankSent=var3303, r7=var3752, r0=var3311, null_type=var2408, r1=var2479, r2=var381, r3=var1107, r4=var558, r5=var1324, r6=var2037, $z0=var176, java.util.List=var1767, $r8=var623, java.lang.Object=var1109, $r13=var2203, $r14=var140, $r15=var1772, $r16=var1101}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9);	r2 = r1[0];	r3 = r1[1];	r4 = r1[2];	r5 = r1[3];	r6 = r1[8];	$z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized>;	if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2;	r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2;	r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docFilename> = r3;	r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docPubDate> = r4;	r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String sentId> = r5;	r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String text> = r6;	r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized> = 1;	$r8 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.util.List origItems>;	interfaceinvoke $r8.<java.util.List: boolean add(java.lang.Object)>(r0);	$r13 = r1[4];	$r14 = r1[5];	$r15 = r1[6];	$r16 = r1[7];	if $r13 == null goto return 1;	return 1
;block_num 4
(check-sat)
(exit)
