(
  ;; universe for var3093:
  ;;   var3093!val!1 var3093!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3093!val!1 () var3093)
  (declare-fun var3093!val!0 () var3093)
  ;; cardinality constraint:
  (forall ((x var3093)) (or (= x var3093!val!1) (= x var3093!val!0)))
  ;; -----------
  ;; universe for var3572:
  ;;   var3572!val!1 var3572!val!2 var3572!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3572!val!1 () var3572)
  (declare-fun var3572!val!2 () var3572)
  (declare-fun var3572!val!0 () var3572)
  ;; cardinality constraint:
  (forall ((x var3572))
          (or (= x var3572!val!1) (= x var3572!val!2) (= x var3572!val!0)))
  ;; -----------
  ;; universe for var2112:
  ;;   var2112!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2112!val!0 () var2112)
  ;; cardinality constraint:
  (forall ((x var2112)) (= x var2112!val!0))
  ;; -----------
  ;; universe for var2617:
  ;;   var2617!val!1 var2617!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2617!val!1 () var2617)
  (declare-fun var2617!val!0 () var2617)
  ;; cardinality constraint:
  (forall ((x var2617)) (or (= x var2617!val!1) (= x var2617!val!0)))
  ;; -----------
  (define-fun var425 () String
    "-")
  (define-fun var3572-GEN () var3572
    var3572!val!0)
  (define-fun var8 () Bool
    (isActive/1224434730 (cast-from-var2617-to-var2112 var2829) var3572-GEN))
  (define-fun var3572-NUM () var3572
    var3572!val!2)
  (define-fun var1072 () String
    (let ((a!1 (< (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1)))
      (a!4 (>= (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
(let ((a!2 (ite a!1 (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
(let ((a!3 (ite (> (- 1) 0) a!2 (num_splits_re var425 (re.+ (str.to_re "-"))))))
(let ((a!5 (and (> (- 1) 0) (= (- a!3 1) (- (- 1) 1)) a!4)))
  (ite a!5
       (split_rest_re var425 (re.+ (str.to_re "-")) (- (- 1) 1))
       (split_at_re var425 (re.+ (str.to_re "-")) (- a!3 1))))))))
  (define-fun var2057 () String
    (let ((a!1 (< (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1)))
      (a!4 (>= (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
(let ((a!2 (ite a!1 (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
(let ((a!3 (ite (> (- 1) 0) a!2 (num_splits_re var425 (re.+ (str.to_re "-"))))))
(let ((a!5 (and (> (- 1) 0) (= (- a!3 1) (- (- 1) 1)) a!4)))
(let ((a!6 (ite a!5
                (split_rest_re var425 (re.+ (str.to_re "-")) (- (- 1) 1))
                (split_at_re var425 (re.+ (str.to_re "-")) (- a!3 1)))))
(let ((a!7 (str.replace_all (str.replace_all (str.replace_all (str.replace_all a!6
                                                                               "A"
                                                                               "a")
                                                              "B"
                                                              "b")
                                             "C"
                                             "c")
                            "D"
                            "d")))
(let ((a!8 (str.replace_all (str.replace_all (str.replace_all (str.replace_all a!7
                                                                               "E"
                                                                               "e")
                                                              "F"
                                                              "f")
                                             "G"
                                             "g")
                            "H"
                            "h")))
(let ((a!9 (str.replace_all (str.replace_all (str.replace_all (str.replace_all a!8
                                                                               "I"
                                                                               "i")
                                                              "J"
                                                              "j")
                                             "K"
                                             "k")
                            "L"
                            "l")))
(let ((a!10 (str.replace_all (str.replace_all (str.replace_all (str.replace_all a!9
                                                                                "M"
                                                                                "m")
                                                               "N"
                                                               "n")
                                              "O"
                                              "o")
                             "P"
                             "p")))
(let ((a!11 (str.replace_all (str.replace_all (str.replace_all (str.replace_all a!10
                                                                                "Q"
                                                                                "q")
                                                               "R"
                                                               "r")
                                              "S"
                                              "s")
                             "T"
                             "t")))
(let ((a!12 (str.replace_all (str.replace_all (str.replace_all (str.replace_all a!11
                                                                                "U"
                                                                                "u")
                                                               "V"
                                                               "v")
                                              "W"
                                              "w")
                             "X"
                             "x")))
  (str.replace_all (str.replace_all a!12 "Y" "y") "Z" "z")))))))))))))
  (define-fun var114 () var3093
    var3093!val!0)
  (define-fun var3572-PER () var3572
    var3572!val!1)
  (define-fun null-var3093 () var3093
    var3093!val!1)
  (define-fun var1944 () Bool
    (isActive/1224434730 (cast-from-var2617-to-var2112 var2829) var3572-PER))
  (define-fun var2521 () var3572
    var3572-NUM)
  (define-fun var3714 () Int
    (let ((a!1 (< (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
(let ((a!2 (ite a!1 (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
  (ite (> (- 1) 0) a!2 (num_splits_re var425 (re.+ (str.to_re "-")))))))
  (define-fun var551 () var3572
    var3572-PER)
  (define-fun var583 () var3572
    var3572-GEN)
  (define-fun null-String () String
    "")
  (define-fun null-var2617 () var2617
    var2617!val!1)
  (define-fun var2829 () var2617
    var2617!val!0)
  (define-fun var3680 () Int
    (let ((a!1 (< (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
(let ((a!2 (ite a!1 (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
  (ite (> (- 1) 0) a!2 (num_splits_re var425 (re.+ (str.to_re "-")))))))
  (define-fun var1977 () Bool
    (isActive/1224434730 (cast-from-var2617-to-var2112 var2829) var3572-NUM))
  (define-fun var916 () Int
    (let ((a!1 (< (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
(let ((a!2 (ite a!1 (num_splits_re var425 (re.+ (str.to_re "-"))) (- 1))))
(let ((a!3 (ite (> (- 1) 0) a!2 (num_splits_re var425 (re.+ (str.to_re "-"))))))
  (- a!3 1)))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun cast-from-var2617-to-var2112 ((x!0 var2617)) var2112
    var2112!val!0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    2)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun isActive/1224434730 ((x!0 var2112) (x!1 var3572)) Bool
    false)
)
