(set-logic ALL)
(declare-fun L () String)
(declare-fun F () String)
(declare-fun E () String)
(declare-fun J () String)
(assert (= (str.++  "ieafbhdibeaghgcga" E "af" J "bebgfb" L "egdfbf" J "ffaahbdeeg" J "iifbi" J "id" J "fafg")  (str.++  "iea" F "bi" J "idcfafg") ))

; --- START CONSTRAINT ---

(declare-fun S () String)
(declare-fun T () String)

(assert (= S (str.++ "ieafbhdibeaghgcga" E "af" J "bebgfb" L "egdfbf" J "ffaahbdeeg" J "iifbi" J "id" J "fafg")))
(assert (= T (str.++ "iea" F "bi" J "idcfafg")))
(assert (= S T))

; Split both sides at delimiter "id" and relate segments
(assert (>= (str.num_splits S "id") 2))
(assert (>= (str.num_splits T "id") 2))
(assert (= (str.split_at S "id" 0) (str.split_at T "id" 0)))
(assert (= (str.split_rest S "id" 1) (str.split_rest T "id" 1)))

; Additional consistency: the segment immediately after the first "id" matches
(assert (>= (str.num_splits S "id") 3))
(assert (>= (str.num_splits T "id") 3))
(assert (= (str.split_at S "id" 1) (str.split_at T "id" 1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
