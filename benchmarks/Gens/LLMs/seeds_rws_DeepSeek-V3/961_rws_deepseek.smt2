(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV processing with alternative constraints
 Focus: Field validation with multiple delimiters and complex splits
|)

; Declare input line and multiple delimiters
(declare-const data_line String)
(declare-const primary_delim String)
(declare-const secondary_delim String)
(declare-const escape_char String)

(assert (or (= primary_delim ",") (= primary_delim "\t") (= primary_delim ";") (= primary_delim "|")))
(assert (or (= secondary_delim ":") (= secondary_delim "-") (= secondary_delim "_") (= secondary_delim ".")))
(assert (= escape_char "\\"))

; Complex field count validation with escape handling
(declare-const unescaped_line String)
(assert (= unescaped_line (str.replace_all data_line (str.++ escape_char primary_delim) "")))
(assert (= (str.num_splits unescaped_line primary_delim) 4))

; Extract all fields with nested splits for complex parsing
(declare-const f0 String) ; Record type with subtype
(declare-const f1 String) ; Timestamp with components
(declare-const f2 String) ; Value with units
(declare-const f3 String) ; Status with details

(assert (= f0 (str.split_at data_line primary_delim 0)))
(assert (= f1 (str.split_at (str.split_rest data_line primary_delim 1) primary_delim 0)))
(assert (= f2 (str.split_at (str.split_rest (str.split_rest data_line primary_delim 1) primary_delim 1) primary_delim 0)))
(assert (= f3 (str.split_rest (str.split_rest (str.split_rest data_line primary_delim 1) primary_delim 1) primary_delim 1)))

; Complex record type validation with sub-components
(declare-const record_main String)
(declare-const record_sub String)
(assert (ite (str.contains f0 secondary_delim)
    (and (= record_main (str.split_at f0 secondary_delim 0))
         (= record_sub (str.split_rest f0 secondary_delim 1)))
    (and (= record_main f0)
         (= record_sub ""))))

; Record type must be one of ["A","B","C"] with optional subtype
(assert (or (= record_main "A") (= record_main "B") (= record_main "C")))
(assert (=> (> (str.len record_sub) 0)
    (and (>= (str.len record_sub) 1)
         (<= (str.len record_sub) 3)
         (str.is_digit (str.split_at record_sub secondary_delim 0)))))

; Timestamp decomposition with multiple splits
(assert (= (str.len f1) 19))
(declare-const date_part String)
(declare-const time_part String)
(assert (= date_part (str.split_at f1 "T" 0)))
(assert (= time_part (str.split_rest f1 "T" 1)))

; Date components validation
(declare-const year_str String)
(declare-const month_str String)
(declare-const day_str String)
(assert (= year_str (str.split_at date_part "-" 0)))
(assert (= month_str (str.split_at (str.split_rest date_part "-" 1) "-" 0)))
(assert (= day_str (str.split_rest (str.split_rest date_part "-" 1) "-" 1)))

(assert (= (str.len year_str) 4))
(assert (= (str.len month_str) 2))
(assert (= (str.len day_str) 2))
(assert (str.is_digit year_str))
(assert (str.is_digit month_str))
(assert (str.is_digit day_str))

; Time components validation
(declare-const hour_str String)
(declare-const minute_str String)
(declare-const second_str String)
(assert (= hour_str (str.split_at time_part ":" 0)))
(assert (= minute_str (str.split_at (str.split_rest time_part ":" 1) ":" 0)))
(assert (= second_str (str.split_rest (str.split_rest time_part ":" 1) ":" 1)))

(assert (= (str.len hour_str) 2))
(assert (= (str.len minute_str) 2))
(assert (= (str.len second_str) 2))
(assert (str.is_digit hour_str))
(assert (str.is_digit minute_str))
(assert (str.is_digit second_str))

; Complex value parsing with units and precision
(declare-const numeric_part String)
(declare-const unit_part String)
(assert (ite (str.contains f2 " ")
    (and (= numeric_part (str.split_at f2 " " 0))
         (= unit_part (str.split_rest f2 " " 1)))
    (and (= numeric_part f2)
         (= unit_part ""))))

; Numeric validation with decimal handling
(assert (str.is_digit (str.replace numeric_part "." "")))
(assert (<= (str.num_splits numeric_part ".") 1))

; Unit validation if present
(assert (or (= unit_part "") 
           (= unit_part "kg") 
           (= unit_part "lbs") 
           (= unit_part "cm") 
           (= unit_part "m")))

; Status field with hierarchical codes
(declare-const status_code String)
(declare-const status_detail String)
(assert (ite (str.contains f3 ":")
    (and (= status_code (str.split_at f3 ":" 0))
         (= status_detail (str.split_rest f3 ":" 1)))
    (and (= status_code f3)
         (= status_detail ""))))

; Status constraints with complex conditions
(assert (<= (str.len status_code) 1))
(assert (or (= status_code "") 
           (= status_code "A") 
           (= status_code "W") 
           (= status_code "E")))

(assert (=> (> (str.len status_detail) 0)
    (and (>= (str.len status_detail) 2)
         (<= (str.len status_detail) 5)
         (= (str.num_splits status_detail secondary_delim) 1))))

; Enhanced empty field validation with escape consideration
(assert (> (str.len (str.replace_all f0 escape_char "")) 0))
(assert (> (str.len (str.replace_all f1 escape_char "")) 0))
(assert (> (str.len (str.replace_all f2 escape_char "")) 0))

; Complex delimiter escaping validation
(assert (not (str.contains (str.replace_all f0 (str.++ escape_char primary_delim) "") primary_delim)))
(assert (not (str.contains (str.replace_all f1 (str.++ escape_char primary_delim) "") primary_delim)))
(assert (not (str.contains (str.replace_all f2 (str.++ escape_char primary_delim) "") primary_delim)))
(assert (not (str.contains (str.replace_all f3 (str.++ escape_char primary_delim) "") primary_delim)))

; Advanced constraint: If status is empty, numeric value must be zero and no units
(assert (=> (= (str.len f3) 0) 
    (and (= numeric_part "0")
         (= unit_part ""))))

; Additional constraint: Record type determines value range
(assert (=> (= record_main "A")
    (<= (str.to_int (str.split_at numeric_part "." 0)) 100)))
(assert (=> (= record_main "B")
    (>= (str.to_int (str.split_at numeric_part "." 0)) 50)))
(assert (=> (= record_main "C")
    (or (= unit_part "kg") (= unit_part "lbs"))))

; Complex timestamp validation - year must be reasonable
(assert (>= (str.to_int year_str) 2000))
(assert (<= (str.to_int year_str) 2030))

; Verify no secondary delimiters in timestamp components
(assert (not (str.contains date_part secondary_delim)))
(assert (not (str.contains time_part secondary_delim)))

(check-sat)
(exit)