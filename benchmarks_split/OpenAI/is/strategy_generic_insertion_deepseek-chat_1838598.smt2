(set-logic ALL)
(declare-fun L () String)
(declare-fun F () String)
(declare-fun E () String)
(declare-fun J () String)
(assert (= (str.++  "ieafbhdibeaghgcga" E "af" J "bebgfb" L "egdfbf" J "ffaahbdeeg" J "iifbi" J "id" J "fafg")  (str.++  "iea" F "bi" J "idcfafg") ))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun S () String)
(declare-fun T () String)

(assert (= S (str.++ "ieafbhdibeaghgcga" E "af" J "bebgfb" L "egdfbf" J "ffaahbdeeg" J "iifbi" J "id" J "fafg")))
(assert (= T (str.++ "iea" F "bi" J "idcfafg")))
(assert (= S T))

; Split both sides at delimiter "id" and relate segments
(assert (>= (num_splits S "id") 2))
(assert (>= (num_splits T "id") 2))
(assert (= (split_at S "id" 0) (split_at T "id" 0)))
(assert (= (split_rest S "id" 1) (split_rest T "id" 1)))

; Additional consistency: the segment immediately after the first "id" matches
(assert (>= (num_splits S "id") 3))
(assert (>= (num_splits T "id") 3))
(assert (= (split_at S "id" 1) (split_at T "id" 1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]