(declare-fun var_4 () String)

(assert (str.in_re var_4 (re.++ (str.to_re "a") (re.* (str.to_re "b")))))
(assert (not (str.in_re var_4 (re.++ (re.* (str.to_re "a")) (str.to_re "a") (re.* (str.to_re "b"))))))

#冲突原因
STRINGS_EXTF_D_N

#冲突表达式
TheoryEngine::conflict(
    (let ((_let_1 (re.* (str.to_re "b")))) 
        (and 
            (and 
                (= @RE_UNFOLD_POS_COMPONENT_4 (str.++ "b" @RE_UNFOLD_POS_COMPONENT_6 "b")) 
                (not (str.in_re @RE_UNFOLD_POS_COMPONENT_4 (re.++ (re.* (str.to_re "a")) _let_1)))
            ) 
            (str.in_re @RE_UNFOLD_POS_COMPONENT_6 _let_1)
        )
    ), THEORY_STRINGS): 
    
full = (let ((_let_1 (re.* (str.to_re "b")))) 
    (and 
        (not (str.in_re @RE_UNFOLD_POS_COMPONENT_4 (re.++ (re.* (str.to_re "a")) _let_1))) 
        (str.in_re @RE_UNFOLD_POS_COMPONENT_6 _let_1) 
        (= @RE_UNFOLD_POS_COMPONENT_4 (str.++ "b" @RE_UNFOLD_POS_COMPONENT_6 "b"))
    )
)

(assert (
    => 
    (and 
        (= @RE_UNFOLD_POS_COMPONENT_4 (str.++ "b" @RE_UNFOLD_POS_COMPONENT_6 "b")) 
        (not (str.in_re @RE_UNFOLD_POS_COMPONENT_4 (re.++ (re.* (str.to_re "a")) (re.* (str.to_re "b")))))
    ) 
    (not (str.in_re @RE_UNFOLD_POS_COMPONENT_6 (re.* (str.to_re "b"))))
)) ; STRINGS_EXTF_D_N