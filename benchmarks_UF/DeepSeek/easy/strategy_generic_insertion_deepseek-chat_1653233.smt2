(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun A () String)
(declare-fun J () String)
(assert (= (str.++  "bfe" J "c" J "caedcfde" J J J "d" J "adcdcad" J "e" J "ad" J "ad" J "dcdbd")  (str.++  "bfe" J "c" J "cae" A "adcdcadfefad" J "adfdcdbd") ))
(assert (= (str.++  J "eadaabedcecdafdeeedaeccdb" J "fddaada" J "df" J "ef")  (str.++  J "eadaabedcecdafdeeedaeccdb" J J "ddaada" J "dffe" J) ))
(assert (= (str.++  "ceddbbebcd" J J "bccfcde" J "e" J "cadaaeccddbca" J "aade")  (str.++  "ceddbbebcd" J J "bccfcde" J "e" J "cadaaeccddbcafaade") ))
(assert (<=(* (str.len J) 18) 18))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (num_splits A delimiter) 3))
(assert (= (split_at A delimiter 0) "protocol"))
(assert (= (split_at A delimiter 1) "host"))
(assert (= (split_rest A delimiter 2) "path"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
