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

(declare-sort var3350 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun arr-Int-init () (Array Int Int))
(declare-const null-String String)
(declare-const var717 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var717 null-String)))
; split operation: var1022 = var717.split("[,;]") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var2610 Int 0) ; Statement: i9 = 0 
(define-const var1463 Int (get_split_length var717 "[,;]" (- 1))) ; Statement: $i0 = lengthof r1 
(define-const var1739 (Array Int String) arr-String-init) ; Statement: r2 = newarray (java.lang.String)[$i0] 
(define-const var1049 Int (get_split_length var717 "[,;]" (- 1))) ; Statement: $i1 = lengthof r1 
(define-const var1876 (Array Int Int) arr-Int-init) ; Statement: r3 = newarray (int)[$i1] 
(define-const var2112 Int 0) ; Statement: i10 = 0 
(assert true) ; Non Conditional
(define-const var1217 Int (get_split_length var717 "[,;]" (- 1))) ; Statement: $i2 = lengthof r1 
 ; Statement: if i10 >= $i2 goto $i3 = i9 + 1 
(assert (>= var2112 var1217)) ; Cond: i10 >= $i2 
(define-const var3635 Int (+ var2610 1)) ; Statement: $i3 = i9 + 1 
(define-const var1143 (Array Int String) arr-String-init) ; Statement: r10 = newarray (java.lang.String)[$i3] 
(define-const var1042 Int 0) ; Statement: i12 = 0 
(assert true) ; Non Conditional
(define-const var2678 Int (get_split_length var717 "[,;]" (- 1))) ; Statement: $i4 = lengthof r1 
 ; Statement: if i12 >= $i4 goto return r10 
(assert (>= var1042 var2678)) ; Cond: i12 >= $i4 
 ; Statement: return r10 
(check-sat)
; {arr-String-init=([], java.lang.String[]), arr-Int-init=([], int[])}
; {var717=r0, var3350=null_type, var1022=r1, var2610=i9, var1463=$i0, var1739=r2, var1049=$i1, var1876=r3, var2112=i10, var1217=$i2, var3635=$i3, var1143=r10, var1042=i12, var2678=$i4}
; {r0=var717, null_type=var3350, r1=var1022, i9=var2610, $i0=var1463, r2=var1739, $i1=var1049, r3=var1876, i10=var2112, $i2=var1217, $i3=var3635, r10=var1143, i12=var1042, $i4=var2678}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	i9 = 0;	$i0 = lengthof r1;	r2 = newarray (java.lang.String)[$i0];	$i1 = lengthof r1;	r3 = newarray (int)[$i1];	i10 = 0;	$i2 = lengthof r1;	if i10 >= $i2 goto $i3 = i9 + 1;	$i3 = i9 + 1;	r10 = newarray (java.lang.String)[$i3];	i12 = 0;	$i4 = lengthof r1;	if i12 >= $i4 goto return r10;	return r10
;block_num 5
(exit)
