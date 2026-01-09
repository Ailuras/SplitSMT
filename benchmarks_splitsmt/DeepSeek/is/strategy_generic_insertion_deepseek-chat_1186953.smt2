(set-logic ALL)
(declare-fun L () String)
(declare-fun F () String)
(declare-fun E () String)
(declare-fun J () String)
(assert (= (str.++  "ieafbhdibeaghgcga" E "af" J "bebgfb" L "egdfbf" J "ffaahbdeeg" J "iifbi" J "id" J "fafg")  (str.++  "iea" F "bi" J "idcfafg") ))

; --- START CONSTRAINT ---
; Declare interface function signatures for str_split operations
; Declare new variables for split results
(declare-const split_result_0 String)
(declare-const split_result_1 String)
(declare-const split_count Int)
; Assert constraints using str_split operations
(assert (= split_result_0 (str.split_at L ":" 0)))
(assert (= split_result_1 (str.split_at L ":" 1)))
(assert (= split_count (str.num_splits L ":")))
(assert (>= split_count 2))
(assert (= (str.split_rest L ":" 2) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
