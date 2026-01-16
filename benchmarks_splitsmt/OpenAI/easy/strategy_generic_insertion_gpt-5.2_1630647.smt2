(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "LIST]SpamBlockerUtilityTry2FindBasicHost:User-Agent:AcmeprotocolSpy\u{a}")))

; --- START CONSTRAINT ---

(declare-const pre_nl String)
(declare-const post_nl String)

(assert (>= (str.num_splits X "\u{a}") 2))
(assert (= pre_nl (str.split_at X "\u{a}" 0)))
(assert (= post_nl (str.split_at X "\u{a}" 1)))
(assert (= post_nl (str.split_rest X "\u{a}" 1)))
(assert (str.prefixof "LIST]" pre_nl))
(assert (str.contains pre_nl "User-Agent:"))
(assert (str.contains post_nl "AcmeprotocolSpy"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
