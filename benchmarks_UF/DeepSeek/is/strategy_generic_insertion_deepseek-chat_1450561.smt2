(set-logic ALL)
(declare-fun S () String)
(declare-fun J () String)
(declare-fun I () String)
(declare-fun K () String)
(declare-fun H () String)
(declare-fun R () String)
(declare-fun G () String)
(declare-fun U () String)
(declare-fun N () String)
(declare-fun M () String)
(declare-fun P () String)
(declare-fun Q () String)
(assert (= (str.++  G G G I "a" G G G I "b" K "a" J "a" K K J "ab" M M "b" S P "b" S)  (str.++  "a" H "aaaa" I "a" I "aa" M M K "a" M M K "ab" M N M N "b" R Q R Q "b" U U "baa") ))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-fun delimiter () String)
(assert (= delimiter ";"))
(assert (>= (num_splits S delimiter) 3))
(assert (= (split_at S delimiter 0) G))
(assert (= (split_at S delimiter 1) P))
(assert (= (split_rest S delimiter 2) U))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]