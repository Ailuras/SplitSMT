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

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(declare-sort var2706 0)
(declare-sort var223 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var223_slurpFile/458402865 (String) String)
(declare-fun arr-__Array__Int__Float64__-init () (Array Int (Array Int Float64)))
(declare-fun getLength-Arr-Float64-2 ((Array Int (Array Int Float64))) Int)
(declare-const null-String String)
(declare-const var3162 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3162 null-String)))
(define-const var3422 String (var223_slurpFile/458402865 var3162)) ; Statement: r1 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.lang.String slurpFile(java.lang.String)>(r0) 
; split operation: var2510 = var3422.split("[\r\n]+") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[\r\n]+") 
(define-const var791 Int (get_split_length_re var3422 (re.+ (re.union (str.to_re "\u{0D}") (str.to_re "\u{0A}"))) (- 1))) ; Statement: $i0 = lengthof r2 
(define-const var1408 (Array Int (Array Int Float64)) arr-__Array__Int__Float64__-init) ; Statement: r3 = newarray (double[])[$i0] 
(define-const var394 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
(define-const var27 Int (getLength-Arr-Float64-2 var1408)) ; Statement: $i1 = lengthof r3 
 ; Statement: if i4 >= $i1 goto return r3 
(assert (>= var394 var27)) ; Cond: i4 >= $i1 
 ; Statement: return r3 
; {var223_slurpFile/458402865=([java.lang.String], java.lang.String), arr-__Array__Int__Float64__-init=([], double[][]), getLength-Arr-Float64-2=([double[][]], int)}
; {var3162=r0, var2706=null_type, var223=edu.stanford.nlp.io.IOUtils, var3422=r1, var2510=r2, var791=$i0, var1408=r3, var394=i4, var27=$i1}
; {r0=var3162, null_type=var2706, edu.stanford.nlp.io.IOUtils=var223, r1=var3422, r2=var2510, $i0=var791, r3=var1408, i4=var394, $i1=var27}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.lang.String slurpFile(java.lang.String)>(r0);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[\r\n]+");	$i0 = lengthof r2;	r3 = newarray (double[])[$i0];	i4 = 0;	$i1 = lengthof r3;	if i4 >= $i1 goto return r3;	return r3
;block_num 3
(check-sat)
(exit)
