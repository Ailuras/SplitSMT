(let ((_let_1 (str.to_re "z"))) 
(let ((_let_2 (str.to_re "c"))) 
(let ((_let_3 (str.to_re "a"))) 
(let ((_let_4 (str.to_re "b"))) 
(not 
    (str.in_re 
        var_4 
        (re.++ 
            (re.* (re.union _let_1 _let_3 _let_4 _let_2)) 
            (re.* (re.union _let_4 _let_3 _let_2 _let_1))
        )
    )
)))))

(let ((_let_1 (str.to_re "c"))) 
(let ((_let_2 (str.to_re "b"))) 
(let ((_let_3 (str.to_re "a"))) 
(let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) 
(let ((_let_5 (str.to_re "z"))) 
(not 
    (str.in_re 
        (str.++ "z" var_4) 
        (re.++ 
            (re.* (re.++ (re.union _let_5 _let_3 _let_1) _let_4 _let_5)) 
            (re.union _let_5 _let_3 _let_2) 
            _let_4
        )
    )
))))))

(let ((_let_1 (str.to_re "c"))) 
(let ((_let_2 (str.to_re "b"))) 
(let ((_let_3 (str.to_re "a"))) 
(let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) 
(let ((_let_5 (str.to_re "z"))) 
(str.in_re 
    "z" 
    (re.++ 
        (re.* (re.++ (re.union _let_5 _let_3 _let_1) _let_4 _let_5)) 
        (re.union _let_5 _let_3 _let_2) 
        _let_4
    )
))))))

x: (str.++ "z" var_4), r: (let ((_let_1 (str.to_re "c"))) (let ((_let_2 (str.to_re "b"))) (let ((_let_3 (str.to_re "a"))) (let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) (let ((_let_5 (str.to_re "z"))) (re.++ (re.* (re.++ (re.union _let_5 _let_3 _let_1) _let_4 _let_5)) (re.union _let_5 _let_3 _let_2) _let_4))))))
x: (str.++ "z" var_4), s: "z", t: ""
left: var_4, dc: (let ((_let_1 (str.to_re "c"))) (let ((_let_2 (str.to_re "b"))) (let ((_let_3 (str.to_re "a"))) (let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) (let ((_let_5 (str.to_re "z"))) (re.union (re.++ _let_4 _let_5 (re.* (re.++ (re.union _let_5 _let_3 _let_1) _let_4 _let_5)) (re.union _let_5 _let_3 _let_2) _let_4) _let_4))))))

(let ((_let_1 (str.to_re "c"))) 
(let ((_let_2 (str.to_re "b"))) 
(let ((_let_3 (str.to_re "a"))) 
(let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) 
(let ((_let_5 (str.to_re "z"))) 
(not 
    (str.in_re 
        var_4 
        (re.union 
            ; z是最短前缀
            (re.++ 
                _let_4 
                _let_5 
                (re.* (re.++ (re.union _let_5 _let_3 _let_1) _let_4 _let_5)) 
                (re.union _let_5 _let_3 _let_2) 
                _let_4
            ) 
            ; z是最长前缀
            _let_4
        )
    )
))))))

Atom need inactivate : (let ((_let_1 (str.to_re "c"))) (let ((_let_2 (str.to_re "b"))) (let ((_let_3 (str.to_re "a"))) (let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) (let ((_let_5 (str.to_re "z"))) (not (str.in_re (str.++ "z" var_4) (re.++ (re.* (re.++ (re.union _let_5 _let_3 _let_1) _let_4 _let_5)) (re.union _let_5 _let_3 _let_2) _let_4))))))))
Step 3: checkUnfold
Get new lemma : 

(let ((_let_1 (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c")))) 
(or 
    (= var_4 "") 
    (str.in_re var_4 _let_1) 
    (and 
        (and 
            (= var_4 (str.++ @RE_UNFOLD_POS_COMPONENT_7 @RE_UNFOLD_POS_COMPONENT_8 @RE_UNFOLD_POS_COMPONENT_9)) 
            (str.in_re @RE_UNFOLD_POS_COMPONENT_7 _let_1) 
            (str.in_re @RE_UNFOLD_POS_COMPONENT_8 (re.* _let_1)) 
            (str.in_re @RE_UNFOLD_POS_COMPONENT_9 _let_1) 
        ) 
        (not (= @RE_UNFOLD_POS_COMPONENT_7 "")) 
        (not (= @RE_UNFOLD_POS_COMPONENT_9 ""))
    )
)) 

(or 
    (= var_4 "") 
    (and 
        (not (= "" @RE_UNFOLD_POS_COMPONENT_7)) 
        (not (= "" @RE_UNFOLD_POS_COMPONENT_9)) 
        (= var_4 (str.++ @RE_UNFOLD_POS_COMPONENT_7 @RE_UNFOLD_POS_COMPONENT_8 @RE_UNFOLD_POS_COMPONENT_9)) 
        (or 
            (= "a" @RE_UNFOLD_POS_COMPONENT_7) 
            (= "b" @RE_UNFOLD_POS_COMPONENT_7) 
            (= "c" @RE_UNFOLD_POS_COMPONENT_7)
        ) 
        (str.in_re 
            @RE_UNFOLD_POS_COMPONENT_8 
            (re.* (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c")))
        ) 
        (or (= "a" @RE_UNFOLD_POS_COMPONENT_9) (= "b" @RE_UNFOLD_POS_COMPONENT_9) (= "c" @RE_UNFOLD_POS_COMPONENT_9))
    ) 
    (= var_4 "a") 
    (= var_4 "b") 
    (= var_4 "c")
)

New lit: 22 => 

(let ((_let_1 (str.to_re "c"))) 
(let ((_let_2 (str.to_re "a"))) 
(let ((_let_3 (str.to_re "b"))) 
(let ((_let_4 (str.to_re "z"))) 
(let ((_let_5 (re.* (re.union _let_2 _let_3 _let_1)))) 
(str.in_re 
    var_4 
    (re.++ 
        _let_5 
        _let_4 
        (re.* (re.++ (re.union _let_4 _let_2 _let_1) _let_5 _let_4)) 
        (re.union _let_4 _let_2 _let_3) 
        (re.* (re.union _let_3 _let_2 _let_1))
    )
))))))

New lit: 23 => (str.in_re var_4 (re.* (re.union (str.to_re "b") (str.to_re "a") (str.to_re "c"))))
New lit: 24 => 

(let ((_let_1 (str.to_re "c"))) 
(let ((_let_2 (str.to_re "a"))) 
(let ((_let_3 (str.to_re "b"))) 
(let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) 
(let ((_let_5 (str.to_re "z"))) 
(let ((_let_6 (re.* (re.union _let_2 _let_3 _let_1)))) 
(or 
    (str.in_re 
        var_4 
        (re.++ 
            _let_6 
            _let_5 
            (re.* (re.++ (re.union _let_5 _let_2 _let_1) _let_6 _let_5)) 
            (re.union _let_5 _let_2 _let_3) 
            _let_4
        )
    ) 
    (str.in_re var_4 _let_4)
)))))))

(let ((_let_1 (str.to_re "c"))) 
(let ((_let_2 (str.to_re "b"))) 
(let ((_let_3 (str.to_re "a"))) 
(let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) 
(let ((_let_5 (str.to_re "z"))) 
(str.in_re 
    (str.++ "z" var_4) 
    (re.++ 
        (re.* (re.++ (re.union _let_5 _let_3 _let_1) _let_4 _let_5)) 
        (re.union _let_5 _let_3 _let_2) 
        _let_4
    )
))))))

(let ((_let_1 (str.to_re "c"))) 
(let ((_let_2 (str.to_re "a"))) 
(let ((_let_3 (str.to_re "b"))) 
(let ((_let_4 (str.to_re "z"))) 
(let ((_let_5 (re.* (re.union _let_2 _let_3 _let_1)))) 
(not (str.in_re 
    @PURIFY_4 
    (re.++ 
        _let_5 
        _let_4 
        (re.* (re.++ (re.union _let_4 _let_2 _let_1) _let_5 _let_4)) 
        (re.union _let_4 _let_2 _let_3) 
        (re.* (re.union _let_3 _let_2 _let_1))
    )
)))))))

(and 
    (= "a" @RE_UNFOLD_POS_COMPONENT_7) 
    (= "" @RE_UNFOLD_POS_COMPONENT_8) 
    (= "a" @RE_UNFOLD_POS_COMPONENT_9) 
    (= var_4 (str.++ @RE_UNFOLD_POS_COMPONENT_7 @RE_UNFOLD_POS_COMPONENT_8 @RE_UNFOLD_POS_COMPONENT_9))
)