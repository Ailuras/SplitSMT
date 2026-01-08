(set-logic ALL)
(declare-const result String)
(declare-const attack String)
(declare-const prefix RegLan)
(declare-const infix RegLan)
(declare-const postfix RegLan)
(declare-const postfixs String)
(assert (str.in_re attack (re.++ prefix ((_ re.loop 16 16) infix) postfix)))
(assert (= prefix 
     (re.++  (str.to_re "\u{3c}") (re.++  (str.to_re "\u{31}")  (str.to_re "\u{20}")))
))
(assert (= infix 
         (re.inter  (re.++ (re.+  (re.union  (re.++  (str.to_re "\u{27}") (re.++ (re.*  (str.to_re "\u{27}") )  (str.to_re "\u{27}")))  (str.to_re "\u{3e}")) ) (re.+  (re.union  (re.++  (str.to_re "\u{27}") (re.++ (re.*  (str.to_re "\u{27}") )  (str.to_re "\u{27}")))  (re.++  (str.to_re "\u{22}") (re.++ (re.*  (str.to_re "\u{22}") )  (str.to_re "\u{22}")))) )) (re.+  (re.union  (re.++  (str.to_re "\u{27}") (re.++ (re.*  (str.to_re "\u{27}") )  (str.to_re "\u{27}")))  (str.to_re "\u{3e}")) )  (re.++  (str.to_re "\u{22}") (re.* re.allchar )) ) 
))
(assert (= postfix 
        (re.inter  (re.inter  (re.++  (str.to_re "\u{22}") (re.++  (str.to_re "\u{22}") (re.++  (str.to_re "\u{27}") (re.++  (str.to_re "\u{27}") (re.*  (re.union (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " ")) (re.inter re.allchar (re.comp (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " "))))) ))))) (re.comp (re.+  (re.union  (re.++  (str.to_re "\u{22}") (re.++ (re.*  (str.to_re "\u{22}") )  (str.to_re "\u{22}"))) (re.union  (re.++  (str.to_re "\u{27}") (re.++ (re.*  (str.to_re "\u{27}") )  (str.to_re "\u{27}")))  (str.to_re "\u{3e}"))) )))  (re.inter  (re.++  (str.to_re "\u{22}") (re.++  (str.to_re "\u{22}") (re.++  (str.to_re "\u{27}") (re.++  (str.to_re "\u{27}") (re.*  (re.union (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " ")) (re.inter re.allchar (re.comp (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " "))))) ))))) (re.comp  (re.++ (re.+  (re.union  (re.++  (str.to_re "\u{22}") (re.++ (re.*  (str.to_re "\u{22}") )  (str.to_re "\u{22}"))) (re.union  (re.++  (str.to_re "\u{27}") (re.++ (re.*  (str.to_re "\u{27}") )  (str.to_re "\u{27}")))  (str.to_re "\u{3e}"))) )  (re.++ (re.opt  (str.to_re "\u{5c}\u{2f}") )  (str.to_re "\u{3e}"))))) )
))
(assert (str.in_re postfixs postfix))
(assert (>= (str.len postfixs) 1))
(assert (= result (str.++ attack postfixs)))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (str.num_splits result delimiter) 3))
(assert (= (str.split_at result delimiter 0) attack))
(assert (str.contains (str.split_rest result delimiter 1) postfixs))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
