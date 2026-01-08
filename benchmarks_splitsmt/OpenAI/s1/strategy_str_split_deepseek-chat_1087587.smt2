(set-logic ALL)

; Uninterpreted interface operations for string splitting

; Seed-derived symbols (mutated/extended)
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_103698 String)

; Email validation symbols
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)
(declare-const rest_labels String)
(declare-const dot_count_dom Int)
(declare-const at_count Int)
(declare-const at_idx Int)
(declare-const local_len Int)
(declare-const domain_len Int)

; Preserve core structure: keep a Boolean tying to the original input, but no longer force exact seed string
(assert (= T_1 (= var_0xINPUT_103698 email)))
(assert T_1)

; Basic email split at '@'
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= at_count (str.num_splits email "@")))

; Exactly one '@' => two segments
(assert (= at_count 2))

; Local and domain must be non-empty
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (> local_len 0))
(assert (> domain_len 0))

; Disallow extra '@' anywhere: the second segment must not contain '@'
(assert (= (str.num_splits domain "@") 1))

; Domain structure split by '.'
(assert (= dot_count_dom (str.num_splits domain ".")))
(assert (>= dot_count_dom 2))
(assert (= first_label (str.split_at domain "." 0)))
(assert (= tld (str.split_at domain "." (- dot_count_dom 1))))
(assert (= rest_labels (str.split_rest domain "." 1)))

; Each required component must be non-empty
(assert (> (str.len first_label) 0))
(assert (> (str.len tld) 0))

; No empty label: domain cannot start or end with '.' and cannot contain '..'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))
(assert (not (str.contains domain "..")))

; TLD constraints: length at least 2, and must not contain '.'
(assert (>= (str.len tld) 2))
(assert (= (str.num_splits tld ".") 1))

; Local part constraints: cannot start/end with '.', cannot contain consecutive dots
(assert (not (str.prefixof "." local)))
(assert (not (str.suffixof "." local)))
(assert (not (str.contains local "..")))

; Ensure '@' occurs in a valid position in the full email using index bounds
(assert (= at_idx (str.indexof email "@" 0)))
(assert (>= at_idx 1))
(assert (< at_idx (- (str.len email) 1)))

; SAT instance: provide a concrete satisfying example
(assert (= email "user.name+tag@example.co.uk"))

; Also include an UNSAT branch guarded by a boolean to demonstrate diversity without forcing UNSAT
(declare-const make_unsat Bool)
(assert (or (not make_unsat)
            (and
              (= email "bad..local@.example..com")
              (not (str.contains local ".."))
              (not (str.prefixof "." domain))
              (not (str.contains domain "..")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
