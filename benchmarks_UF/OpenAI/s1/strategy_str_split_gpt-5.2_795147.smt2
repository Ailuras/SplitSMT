(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field counts, and empty-field detection

; --- Uninterpreted split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Core string variables (mutated/extended from seed) ---
(declare-const x String)
(declare-const y String)
(declare-const m String)
(declare-const n String)

; CSV-specific variables
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail1 String)
(declare-const tail2 String)

; indices
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)

; numeric parsing helpers
(declare-const idx_empty Int)

; delimiter is comma
(assert (= delim ","))

; Preserve core concatenation structure, and tie it to CSV record
(assert (= (str.++ x y) (str.++ m n)))
(assert (= csv (str.++ x y)))

; Mutate regex constraint: n must be composed of allowed chars (including comma-free payload)
; (keeps the seed's unusual alphabet but makes it consistent and non-empty)
(assert (str.in_re n (re.++ (re.* (str.to_re "a6]_")) (str.to_re "a"))))

; CSV split constraints: enforce exactly 3 fields
(assert (= (num_splits csv delim) 3))

; Valid indices
(assert (= k0 0))
(assert (= k1 1))
(assert (= k2 2))
(assert (and (>= k0 0) (>= k1 0) (>= k2 0)))
(assert (< k0 (num_splits csv delim)))
(assert (< k1 (num_splits csv delim)))
(assert (< k2 (num_splits csv delim)))

; Bind split interface results
(assert (= f0 (split_at csv delim k0)))
(assert (= f1 (split_at csv delim k1)))
(assert (= f2 (split_at csv delim k2)))
(assert (= tail1 (split_rest csv delim k1)))
(assert (= tail2 (split_rest csv delim k2)))

; Detect empty fields: at least one field empty
(assert (or (= f0 "") (= f1 "") (= f2 "")))

; Additional CSV sanity: no commas inside fields (approximate by contains constraints)
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))

; Connect m,n with CSV tail: n appears in the suffix after first comma
(assert (str.contains tail1 n))

; Numeric constraint from seed: make it CSV-related
; x is intended to be numeric field f0, and must parse to an int greater than length of m
(assert (= x f0))
(assert (> (str.to_int x) (str.len m)))

; Ensure x is a decimal numeral (so str.to_int is meaningful)
(assert (str.in_re x (re.++ (str.to_re "-") (re.+ (re.range "0" "9")))))

; Create a deliberate contradiction (UNSAT): if f1 is empty, then csv must contain ",,"
; but also forbid the ",," pattern.
(assert (=> (= f1 "") (str.contains csv ",,")))
(assert (not (str.contains csv ",,")))

; Another way to force potential emptiness location via indexof
(assert (= idx_empty (str.indexof csv ",," 0)))
(assert (or (= idx_empty (- 1)) (>= idx_empty 0)))

(check-sat)


; [GENERATION STATUS: SUCCESS]