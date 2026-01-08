(set-logic ALL)
(declare-fun sigmaStar_safe_48 () String)
(declare-fun b_sigmaStar_safe_48 () Bool)
(declare-fun atkPtn () String)
(declare-fun x_3 () String)
(declare-fun b_x_3 () Bool)
(declare-fun sink () String)
(declare-fun atk_sigmaStar_1 () String)
(declare-fun atk_sigmaStar_2 () String)
(declare-fun atk_sink () String)
(assert (= b_sigmaStar_safe_48 (str.in_re sigmaStar_safe_48 (re.* (re.union (re.range "0" "9") (re.union (re.range "a" "z") (re.range "A" "Z")))))))
(assert (str.in_re atkPtn (str.to_re "/evil")))
(assert (= atk_sink (str.++ atk_sigmaStar_1 (str.++ atkPtn atk_sigmaStar_2))))
(assert (= b_x_3 (and (= x_3 (str.replace_all sigmaStar_safe_48 "http://" "https://") ) b_sigmaStar_safe_48) ))
(assert (and (= sink x_3) (= sink atk_sink) b_x_3))
(assert (> 20 (+ (str.len sigmaStar_safe_48) (str.len sink)) ) )

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
; Assert constraints using str_split on sigmaStar_safe_48
(assert (= protocol (str.split_at sigmaStar_safe_48 "://" 0)))
(assert (= host (str.split_at sigmaStar_safe_48 "://" 1)))
(assert (= path (str.split_rest sigmaStar_safe_48 "://" 2)))
(assert (>= (str.num_splits sigmaStar_safe_48 "://") 2))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
