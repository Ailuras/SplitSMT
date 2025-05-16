;=========================
;  Uninterpreted Functions Test
;=========================
(set-logic ALL)

;---------- Variables ----------
(declare-const x String)
(declare-const y String)
(declare-const n Int)
(declare-const m Int)

;---------- Uninterpreted Functions ----------
; 0-parameter function (constant)
(declare-fun zero () Int)

; 1-parameter functions
(declare-fun f (Int) Int)
(declare-fun g (String) Int)

; 2-parameter functions  
(declare-fun numSplits (String String) Int)
(declare-fun splitAt (String String Int) String)

; Mixed parameter types
(declare-fun h (Int String) Bool)

;---------- Defined Functions for Comparison ----------
(define-fun dash () String "-")
(define-fun plus (x Int) Int (+ x 1))

;---------- Assertions ----------
; Test 0-parameter function calls
(assert (= zero 0))

; Test 1-parameter function calls
(assert (= (f 5) 10))
(assert (= (g "hello") 5))

; Test 2-parameter function calls
(assert (= (numSplits x dash) 2))
(assert (= (splitAt x dash 0) "first"))

; Test mixed parameter types
(assert (h n x))

; Test function composition
(assert (= (f zero) (plus 9)))

; Test with variables
(assert (= (g x) (f n)))

;---------- Check ----------
(check-sat)
(get-model) 