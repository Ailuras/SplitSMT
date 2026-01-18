(
  ;; universe for var3303:
  ;;   var3303!val!6 var3303!val!1 var3303!val!3 var3303!val!0 var3303!val!7 var3303!val!4 var3303!val!2 var3303!val!5 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3303!val!6 () var3303)
  (declare-fun var3303!val!1 () var3303)
  (declare-fun var3303!val!3 () var3303)
  (declare-fun var3303!val!0 () var3303)
  (declare-fun var3303!val!7 () var3303)
  (declare-fun var3303!val!4 () var3303)
  (declare-fun var3303!val!2 () var3303)
  (declare-fun var3303!val!5 () var3303)
  ;; cardinality constraint:
  (forall ((x var3303))
          (or (= x var3303!val!6)
              (= x var3303!val!1)
              (= x var3303!val!3)
              (= x var3303!val!0)
              (= x var3303!val!7)
              (= x var3303!val!4)
              (= x var3303!val!2)
              (= x var3303!val!5)))
  ;; -----------
  (define-fun null-var3303 () var3303
    var3303!val!1)
  (define-fun var3311 () String
    " ")
  (define-fun var3752!1 () var3303
    var3303!val!2)
  (define-fun var3752!2 () var3303
    var3303!val!3)
  (define-fun var3752!5 () var3303
    var3303!val!6)
  (define-fun var3752 () var3303
    var3303!val!0)
  (define-fun var623 () var1767
    (origItems/615252293 var3752!6))
  (define-fun var140 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 5 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 5)))))
  (define-fun var2037 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 8 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 8)))))
  (define-fun var3752!3 () var3303
    var3303!val!4)
  (define-fun var558 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 2 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 2)))))
  (define-fun var3752!4 () var3303
    var3303!val!5)
  (define-fun var1107 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 1 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 1)))))
  (define-fun var1101 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 7 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 7)))))
  (define-fun var381 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 0 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 0)))))
  (define-fun var3752!6 () var3303
    var3303!val!7)
  (define-fun var1324 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 3 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 3)))))
  (define-fun var2203 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 4 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 4)))))
  (define-fun var1772 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 6 (- 9 1)) (>= (num_splits_re var3311 a!2) 9))
       (split_rest_re var3311 a!2 (- 9 1))
       (split_at_re var3311 a!2 6)))))
  (define-fun var176 () Bool
    (initialized/615252293 var3752))
  (define-fun null-String () String
    "")
  (define-fun var3311!1 () String
    "")
  (define-fun var623!1 () var1767
    var1767!val!0)
  (define-fun text/615252293 ((x!0 var3303)) String
    "!0!")
  (define-fun docId/615252293 ((x!0 var3303)) String
    " ")
  (define-fun sentId/615252293 ((x!0 var3303)) String
    " ")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "!0!")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    9)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    (ite (and (= x!0 " ")
              (= x!1
                 (let ((a!1 (re.* (re.union (str.to_re (seq.unit (_ Char 32)))
                                            (str.to_re (seq.unit (_ Char 9)))))))
                   (re.++ (re.++ a!1 (str.to_re (seq.unit (_ Char 124)))) a!1)))
              (= x!2 4))
      ""
      " "))
  (define-fun docPubDate/615252293 ((x!0 var3303)) String
    " ")
  (define-fun initialized/615252293 ((x!0 var3303)) Bool
    (ite (= x!0 var3303!val!7) true
      false))
  (define-fun docFilename/615252293 ((x!0 var3303)) String
    " ")
  (define-fun cast-from-String-to-var1109 ((x!0 String)) var1109
    var1109!val!0)
  (define-fun origItems/615252293 ((x!0 var3303)) var1767
    var1767!val!0)
  (define-fun var1767_add/328494887 ((x!0 var1767) (x!1 var1109)) Bool
    false)
)
