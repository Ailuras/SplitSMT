(set-logic ALL)

; --- Uninterpreted split interface (CSV) ---

; --- Seed-like variables (kept core structure, repurposed as CSV pipeline) ---
(declare-fun sigmaStar_751 () String)        ; raw CSV line (may contain CR/LF)
(declare-fun b_sigmaStar_751 () Bool)
(declare-fun atkPtn () String)              ; suspicious token that must appear in a field
(declare-fun x_12 () String)                ; after CR removal
(declare-fun b_x_12 () Bool)
(declare-fun x_16 () String)                ; after LF removal
(declare-fun b_x_16 () Bool)
(declare-fun sink () String)                ; sanitized CSV line
(declare-fun atk_sigmaStar_1 () String)
(declare-fun atk_sigmaStar_2 () String)
(declare-fun atk_sink () String)

; --- Additional CSV variables ---
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_after_2 String)
(declare-const emptyField Bool)
(declare-const hasTrailingComma Bool)

; --- Delimiter is comma ---
(assert (= delim ","))

; --- Suspicious token modeled as in the seed (kept, but now must land inside a CSV field) ---
(assert (str.in_re atkPtn (re.++ (re.union (str.to_re "%27") (str.to_re "'")) (str.to_re "union"))))

; --- Attacker-controlled construction of the final line ---
(assert (= atk_sink (str.++ atk_sigmaStar_1 (str.++ atkPtn atk_sigmaStar_2))))

; --- CR/LF stripping pipeline preserved from seed ---
(assert (= b_x_12 (and (= x_12 (str.replace sigmaStar_751 "\u{d}" "")) b_sigmaStar_751)))
(assert (= b_x_16 (and (= x_16 (str.replace x_12 "\u{a}" "")) b_x_12)))

; --- Core linkage: sanitized line equals attacker line, enable pipeline ---
(assert (and (= sink x_16) (= sink atk_sink) b_x_16))

; --- CSV structure constraints ---
; Require at least 3 fields (two commas) after splitting by comma.
(assert (>= (str.num_splits sink delim) 3))

; Bind first three fields and the rest.
(assert (= field0 (str.split_at sink delim 0)))
(assert (= field1 (str.split_at sink delim 1)))
(assert (= field2 (str.split_at sink delim 2)))
(assert (= rest_after_2 (str.split_rest sink delim 2)))

; Detect empty fields: either the middle field empty or a leading empty field.
(assert (= emptyField (or (= field1 "") (= field0 ""))))

; Enforce that we actually detect an empty field.
(assert emptyField)

; Detect trailing comma: last segment empty means trailing comma in CSV.
(assert (= hasTrailingComma (= (str.split_at sink delim (- (str.num_splits sink delim) 1)) "")))

; Disallow trailing comma while still having an empty field elsewhere.
(assert (not hasTrailingComma))

; Ensure suspicious token appears in a specific field (e.g., third field) and not in others.
(assert (str.contains field2 atkPtn))
(assert (not (str.contains field0 atkPtn)))
(assert (not (str.contains field1 atkPtn)))

; Field content sanity: no commas inside individual fields (simple CSV, no quoting).
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))

; Size constraints, adapted from seed but made CSV-relevant.
(assert (< 30 (+ (str.len sigmaStar_751) (str.len sink))))
(assert (< (str.len sink) 120))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
