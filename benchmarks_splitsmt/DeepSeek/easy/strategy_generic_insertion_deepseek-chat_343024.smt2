(set-logic ALL)
(declare-fun S () String)
(declare-fun J () String)
(declare-fun I () String)
(declare-fun K () String)
(declare-fun H () String)
(declare-fun V () String)
(declare-fun G () String)
(declare-fun R () String)
(declare-fun U () String)
(declare-fun O () String)
(declare-fun M () String)
(declare-fun P () String)
(assert (= (str.++  G I I "aaaa" I "a" G I I "aaaa" I "b" K K K J "b" O P "b" P S "b" V)  (str.++  "a" H I "aaa" I "a" M M M J M M M J "b" M M M "a" M M M "ab" R "a" R "ab" U U "baa") ))

; --- START CONSTRAINT ---
(declare-fun delimiter () String)
(assert (= delimiter ":"))
(assert (>= (str.num_splits S delimiter) 3))
(assert (= (str.split_at S delimiter 0) G))
(assert (= (str.split_at S delimiter 1) I))
(assert (= (str.split_rest S delimiter 2) V))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
