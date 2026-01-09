(set-logic ALL)

; CSV Processing scenario: comma-separated fields, correct field counts, and empty-field detection

; Original seed variables
(declare-fun B () String)
(declare-fun A () String)
(declare-fun J () String)
(declare-fun C () String)

; str_split interface (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; New CSV-related variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const suffix_from_2 String)

; --- Mutated/extended core structure from seed ---
(assert (= (str.++ "dbefbfbae" B "cc" J "dcbcfbe")
           (str.++ "dbefbfbaeb" C A "cbfbafcfdfcadcbcfbe")))

; keep the second seed constraint unchanged
(assert (= (str.++ "fbfedbbcd" A "adeabed" A "dfafccdcfdddabcbfaff")
           (str.++ "fbfedbbcdeeadeabedeedfafccdcfdddabcbfaff" "")))

; slightly mutate third seed constraint by adding a harmless length guard later
(assert (= (str.++ "cddaadaaddfbccdaafacaeadbcfadbfeedfcceca" "")
           (str.++ "cddaadaaddfbccdaafacaeadbcfadbf" A "dfcceca")))

; length constraints (mutated/extended)
(assert (<= (str.len A) 4))
(assert (<= (* (str.len B) 12) 468))
(assert (>= (* (str.len J) 8) 88))
(assert (<= (* (str.len J) 3) 69))
(assert (>= (* (str.len C) 19) 95))

; extra seed-related guard to keep A small but non-negative (strings already non-negative)
(assert (<= (str.len A) (str.len B)))

; --- CSV processing constraints ---
(assert (= delim ","))

; Build a CSV line from the seed strings as fields: C, A, B, J
; This also enforces that comma splitting should yield 4 segments.
(assert (= csv_line (str.++ C delim A delim B delim J)))

; Relate fields to the split interface
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= suffix_from_2 (split_rest csv_line delim 2)))

; Expected number of fields: 4
(assert (= (num_splits csv_line delim) 4))

; Ensure first three extracted fields match originals
(assert (= f0 C))
(assert (= f1 A))
(assert (= f2 B))

; Empty-field detection: require at least one empty field among the middle ones (A or B)
(assert (or (= A "") (= B "")))

; Additional consistency checks
(assert (not (str.contains csv_line ",,")))
; The above combined with (or (= A "") (= B "")) creates tension typical of empty-field checks.

; Keep indices natural and within a reasonable bound (interface discipline)
(assert (and (<= 0 0) (<= 0 1) (<= 0 2)))
(assert (<= 2 (num_splits csv_line delim)))

(check-sat)


; [GENERATION STATUS: SUCCESS]