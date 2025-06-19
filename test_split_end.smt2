(set-logic QF_SLIA)
(declare-fun div1_split () String)
(declare-fun div1_last () String)
(declare-fun temp () String)
(declare-fun input () String)

(assert (or (= (str.split_at div1_split "/" 1) temp) (= (str.split_end div1_split "/" 1) temp)))
(assert (= input (str.++ div1_split div1_last)))
(assert (or (str.prefixof "/" div1_last) (= "" div1_last)))

(check-sat)
(exit) 