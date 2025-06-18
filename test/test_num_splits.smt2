(set-logic QF_SLIA)
(declare-fun input () String)
(declare-fun temp () String)

(assert (not (= (str.num_splits input "/") 1)))
(assert (= (str.split_at input "/" 1) temp))
; (assert (= (str.num_splits temp ":") 2))

(check-sat)
(get-model)
(exit)

; public String someMethod(String input) {
;     String[] parts1 = input.split("/", -1);
;     String temp;
;     if (parts1.length != 1) {
;         temp = parts1[1];
;     } else {
;         temp = input;
;     }
    
;     String[] parts2 = temp.split(":");
;     if (parts2.length != 1) {
;         // 会取parts2[0]，但这个路径没有执行到
;     }
;     return temp;
; }