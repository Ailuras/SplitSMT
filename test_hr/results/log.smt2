(let ((_let_1 (not (= "aa" "")))) 
(let ((_let_2 (str.to_re "aa"))) 
    (or 
        (= var_4 "") 
        (str.in_re var_4 _let_2) 
        (and 
            (and 
                (= var_4 (str.++ "aa" @RE_UNFOLD_POS_COMPONENT_4 "aa")) 
                (str.in_re @RE_UNFOLD_POS_COMPONENT_4 (re.* _let_2))
            ) 
            _let_1 
            _let_1
        )
    )
))