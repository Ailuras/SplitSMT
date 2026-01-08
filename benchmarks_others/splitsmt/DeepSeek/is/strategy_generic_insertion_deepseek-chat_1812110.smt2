(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.+ (re.union (str.to_re "") (str.to_re "")))))
(assert (= 7 (str.to_int x)))
(assert (not (= x "aC")))
(assert (not (= x "d;`Ap@'\\r''")))
(assert (not (= x "w|iaG{c")))
(assert (not (= x "%%CsTx}")))
(assert (not (= x "sXpj$")))
(assert (not (= x "^UA'' ''K<")))
(assert (not (= x "KuGv2F")))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (str.num_splits x delimiter) 2))
(assert (= (str.split_at x delimiter 0) "7"))
(assert (str.contains (str.split_rest x delimiter 1) "C"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
