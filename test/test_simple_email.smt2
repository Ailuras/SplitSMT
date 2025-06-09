(set-logic QF_S)

        ; "\"\"",                       // Empty string
        ; "\"Hello, World!\"",          // Simple string
        ; "\"String with \\\"quotes\\\"\"", // String with escaped quotes
        ; "\"String with \\\\backslash\"",  // String with escaped backslash
        ; "\"Multi-line\nstring\""      // Multi-line string

(declare-fun x () String)
(assert (= x ""))

(declare-fun x1 () String)
(assert (= x1 "Hello, World!"))

(declare-fun x2 () String)
(assert (= x2 "String with ""quotes"""))

(declare-fun x3 () String)
(assert (= x3 "String with \\backslash"))

(declare-fun x4 () String)
(assert (= x4 "Multi-line\nstring"))

(check-sat)
(get-model)