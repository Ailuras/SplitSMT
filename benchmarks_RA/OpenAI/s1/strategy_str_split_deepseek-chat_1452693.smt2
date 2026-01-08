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

; --- Uninterpreted split interface (CSV) ---

; --- Seed-like variables (kept core structure, repurposed as CSV pipeline) ---
(declare-fun sigmaStar_751 () String)        ; raw CSV line (may contain CR/LF)
(declare-fun b_sigmaStar_751 () Bool)
(declare-fun atkPtn () String)              ; suspicious token that must appear in a field
(declare-fun x_12 () String)                ; after CR removal
(declare-fun b_x_12 () Bool)
(declare-fun x_16 () String)                ; after LF removal
(declare-fun b_x_16 () Bool)
(declare-fun sink () String)                ; sanitized CSV line
(declare-fun atk_sigmaStar_1 () String)
(declare-fun atk_sigmaStar_2 () String)
(declare-fun atk_sink () String)

; --- Additional CSV variables ---
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_after_2 String)
(declare-const emptyField Bool)
(declare-const hasTrailingComma Bool)

; --- Delimiter is comma ---
(assert (= delim ","))

; --- Suspicious token modeled as in the seed (kept, but now must land inside a CSV field) ---
(assert (str.in_re atkPtn (re.++ (re.union (str.to_re "%27") (str.to_re "'")) (str.to_re "union"))))

; --- Attacker-controlled construction of the final line ---
(assert (= atk_sink (str.++ atk_sigmaStar_1 (str.++ atkPtn atk_sigmaStar_2))))

; --- CR/LF stripping pipeline preserved from seed ---
(assert (= b_x_12 (and (= x_12 (str.replace sigmaStar_751 "\u{d}" "")) b_sigmaStar_751)))
(assert (= b_x_16 (and (= x_16 (str.replace x_12 "\u{a}" "")) b_x_12)))

; --- Core linkage: sanitized line equals attacker line, enable pipeline ---
(assert (and (= sink x_16) (= sink atk_sink) b_x_16))

; --- CSV structure constraints ---
; Require at least 3 fields (two commas) after splitting by comma.
(assert (>= (num_splits sink delim) 3))

; Bind first three fields and the rest.
(assert (= field0 (split_at sink delim 0)))
(assert (= field1 (split_at sink delim 1)))
(assert (= field2 (split_at sink delim 2)))
(assert (= rest_after_2 (split_rest sink delim 2)))

; Detect empty fields: either the middle field empty or a leading empty field.
(assert (= emptyField (or (= field1 "") (= field0 ""))))

; Enforce that we actually detect an empty field.
(assert emptyField)

; Detect trailing comma: last segment empty means trailing comma in CSV.
(assert (= hasTrailingComma (= (split_at sink delim (- (num_splits sink delim) 1)) "")))

; Disallow trailing comma while still having an empty field elsewhere.
(assert (not hasTrailingComma))

; Ensure suspicious token appears in a specific field (e.g., third field) and not in others.
(assert (str.contains field2 atkPtn))
(assert (not (str.contains field0 atkPtn)))
(assert (not (str.contains field1 atkPtn)))

; Field content sanity: no commas inside individual fields (simple CSV, no quoting).
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))

; Size constraints, adapted from seed but made CSV-relevant.
(assert (< 30 (+ (str.len sigmaStar_751) (str.len sink))))
(assert (< (str.len sink) 120))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
