(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

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
