(set-logic ALL)
(declare-fun sigmaStar_048 () String)
(declare-fun b_sigmaStar_048 () Bool)
(declare-fun literal_5 () String)
(declare-fun b_literal_5 () Bool)
(declare-fun atkPtn () String)
(declare-fun x_4 () String)
(declare-fun b_x_4 () Bool)
(declare-fun x_6 () String)
(declare-fun b_x_6 () Bool)
(declare-fun sink () String)
(declare-fun atk_sigmaStar_1 () String)
(declare-fun atk_sigmaStar_2 () String)
(declare-fun atk_sink () String)
(declare-fun X () String)
(assert (and b_literal_5 (= literal_5 "\u{2e}\u{70}\u{68}\u{70}")))
(assert (str.in_re atkPtn (str.to_re "/evil")))
(assert (= atk_sink (str.++ atk_sigmaStar_1 (str.++ atkPtn atk_sigmaStar_2))))
(assert (= b_x_4 (and (= x_4 (str.replace sigmaStar_048 X "") ) b_sigmaStar_048) ))
(assert (= b_x_6 (and (= x_6 (str.++ x_4 literal_5) ) b_x_4 b_literal_5) ))
(assert (and (= sink x_6) (= sink atk_sink) b_x_6))
(assert (> 40 (+ (str.len sigmaStar_048) (str.len sink)) ) )

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const sink_prefix String)
(declare-const sink_suffix String)

(assert (>= (num_splits sink "/evil") 2))
(assert (= sink_prefix (split_at sink "/evil" 0)))
(assert (= sink_suffix (split_rest sink "/evil" 1)))
(assert (not (str.contains sink_prefix "/evil")))
(assert (not (str.contains sink_suffix "/evil")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
