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
(declare-fun literal_1 () String)
(declare-fun b_literal_1 () Bool)
(declare-fun sigmaStar_2256 () String)
(declare-fun b_sigmaStar_2256 () Bool)
(declare-fun atkPtn () String)
(declare-fun x_23 () String)
(declare-fun b_x_23 () Bool)
(declare-fun x_27 () String)
(declare-fun b_x_27 () Bool)
(declare-fun x_31 () String)
(declare-fun b_x_31 () Bool)
(declare-fun x_35 () String)
(declare-fun b_x_35 () Bool)
(declare-fun x_36 () String)
(declare-fun b_x_36 () Bool)
(declare-fun sink () String)
(declare-fun atk_sigmaStar_1 () String)
(declare-fun atk_sigmaStar_2 () String)
(declare-fun atk_sink () String)
(declare-fun sigmaStar_n0 () String)
(declare-fun b_sigmaStar_n0 () Bool)
(assert (and b_literal_1 (= literal_1 "\u{53}\u{45}\u{43}\u{55}\u{52}\u{49}\u{54}\u{59}\u{20}\u{57}\u{41}\u{52}\u{4e}\u{49}\u{4e}\u{47}\u{3a}\u{20}\u{6c}\u{6f}\u{67}\u{67}\u{65}\u{64}\u{20}\u{69}\u{6e}\u{74}\u{72}\u{75}\u{73}\u{69}\u{6f}\u{6e}\u{20}\u{61}\u{74}\u{74}\u{65}\u{6d}\u{70}\u{74}\u{20}\u{61}\u{67}\u{61}\u{69}\u{6e}\u{73}\u{74}\u{20}\u{6c}\u{69}\u{62}\u{2f}\u{61}\u{64}\u{6f}\u{64}\u{62}\u{2f}\u{74}\u{65}\u{73}\u{74}\u{73}\u{2f}\u{74}\u{6d}\u{73}\u{73}\u{71}\u{6c}\u{2e}\u{70}\u{68}\u{70}")))
(assert (str.in_re atkPtn (str.to_re "vbscript:")))
(assert (= atk_sink (str.++ atk_sigmaStar_1 (str.++ atkPtn atk_sigmaStar_2))))
(assert (= b_x_23 (or (and (= x_23 literal_1) b_literal_1) (and (= x_23 sigmaStar_2256) b_sigmaStar_2256) ) ))
(assert (= b_x_27 (and (= x_27 (str.replace x_23 "\'" "\'") ) b_x_23) ))
(assert (= b_x_31 (and (= x_31 (str.replace x_27 "\""" """") ) b_x_27) ))
(assert (= b_x_35 (and (= x_35 (str.replace x_31 "\\" "\") ) b_x_31) ))
(assert (= b_x_36 (or (and (= x_36 sigmaStar_n0) b_sigmaStar_n0) (and (= x_36 x_35) b_x_35) ) ))
(assert (and (= sink x_36) (= sink atk_sink) b_x_36))
(assert (> 20 (+ (str.len x_36) (str.len sink)) ) )

; --- START CONSTRAINT ---
; str_split interface signatures

; New helper variables
(declare-fun vb_prefix () String)
(declare-fun vb_suffix () String)

; Decompose sink around the vbscript: marker
(assert (= vb_prefix (split_at sink "vbscript:" 0)))
(assert (= vb_suffix (split_rest sink "vbscript:" 1)))
(assert (>= (num_splits sink "vbscript:") 2))

; Marker should not be at the very beginning
(assert (> (str.len vb_prefix) 0))

; Keep suffix small to respect existing length bound
(assert (<= (str.len vb_suffix) 6))

; Ensure the split is consistent with reconstruction
(assert (= sink (str.++ vb_prefix (str.++ "vbscript:" vb_suffix))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
