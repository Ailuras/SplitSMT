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

; Uninterpreted string-split interface

; -----------------------
; SAT instance: complex-but-valid email
; -----------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const domain_left_ok String)
(declare-const tld_ok String)
(declare-const org_ok String)
(declare-const userpart_ok String)
(declare-const tag_ok String)
(declare-const local_prefix_ok String)
(declare-const local_suffix_ok String)

(assert (= email_ok "user.name+tag-01@sub.mail.example.co.uk"))

; Split by '@' into local and domain
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= (num_splits email_ok "@") 2))
(assert (>= (str.len local_ok) 1))
(assert (>= (str.len domain_ok) 1))

; Local-part constraints: ensure it contains '.' and '+' (not first char for '.')
(assert (str.contains local_ok "."))
(assert (str.contains local_ok "+"))
(assert (not (= (str.at local_ok 0) ".")))

; Use split operations to reflect structure local := userpart_ok + '+' + tag_ok, and userpart_ok has at least 2 dot-separated segments
(assert (= userpart_ok (split_at local_ok "+" 0)))
(assert (= tag_ok (split_at local_ok "+" 1)))
(assert (>= (num_splits local_ok "+") 2))
(assert (>= (str.len tag_ok) 1))

(assert (= local_prefix_ok (split_at userpart_ok "." 0)))
(assert (= local_suffix_ok (split_at userpart_ok "." 1)))
(assert (>= (num_splits userpart_ok ".") 2))
(assert (>= (str.len local_prefix_ok) 1))
(assert (>= (str.len local_suffix_ok) 1))

; Domain constraints: require at least 3 dot-separated labels, and a non-empty TLD with length >= 2
(assert (>= (num_splits domain_ok ".") 3))
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))
(assert (>= (str.len tld_ok) 2))

; Also constrain that the last two labels look like "co.uk" for this example
(assert (= domain_left_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 2))))
(assert (= domain_left_ok "co"))
(assert (= tld_ok "uk"))

; Ensure earlier part contains "example" somewhere (structure check)
(assert (str.contains domain_ok "example"))

; Additional structural checks using split_rest
(assert (= org_ok (split_at domain_ok "." 2)))
(assert (= org_ok "example"))
(assert (str.contains (split_rest domain_ok "." 2) "example"))

; -----------------------
; UNSAT instance: contradictory email constraints
; -----------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

(assert (= email_bad "abc@x.y"))

; Enforce exactly 2 parts at '@'
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= (num_splits email_bad "@") 2))

; Require domain to have at least 3 dot-separated labels (but "x.y" has only 2)
(assert (>= (num_splits domain_bad ".") 3))

; Require TLD length >= 5, also incompatible with "y"
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))
(assert (>= (str.len tld_bad) 5))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
