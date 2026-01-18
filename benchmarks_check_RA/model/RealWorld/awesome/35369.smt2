(
  (define-fun var3298 () String
    (str.substr var2632 1 (- (- (str.len var2632) 1) 1)))
  (define-fun var840!1 () Int
    (+ 0 1))
  (define-fun var21 () String
    (let ((a!1 (str.substr var2632 1 (- (- (str.len var2632) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
  (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0)))))
  (define-fun var3604 () var3839
    (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "POS")))
  (define-fun var3516 () var3839
    (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "current")))
  (define-fun var2707 () var3044
    var3119_newHashMap/701256970)
  (define-fun var368!2 () String
    "")
  (define-fun var2632 () String
    "AB")
  (define-fun var3745 () String
    (cast-from-var3839-to-String
  (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "word"))))
  (define-fun var368 () String
    "")
  (define-fun var1987 () var3839
    (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "value")))
  (define-fun var3113 () var3839
    (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "word")))
  (define-fun var3882 () Int
    (str.len var2632))
  (define-fun var3973 () Int
    (- (str.len var2632) 1))
  (define-fun var2583 () Int
    (let ((a!1 (str.substr var2632 1 (- (- (str.len var2632) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!3 "=") (- 1)) (num_splits a!3 "=") (- 1))
       (num_splits a!3 "="))))))
  (define-fun var2177 () String
    (cast-from-var3839-to-String
  (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "POS"))))
  (define-fun var3084 () var832
    var832-init)
  (define-fun var3258 () String
    (cast-from-var3839-to-String
  (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "lemma"))))
  (define-fun var1469!2 () String
    (let ((a!1 (str.substr var2632 1 (- (- (str.len var2632) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1)))))
(let ((a!4 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 0)))))))
  (define-fun var840!2 () Int
    (+ 0 1 1))
  (define-fun var1469 () String
    (let ((a!1 (str.substr var2632 1 (- (- (str.len var2632) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
(let ((a!4 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 0)))))))
  (define-fun var261 () String
    (cast-from-var3839-to-String
  (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "current"))))
  (define-fun var3201 () Int
    (let ((a!1 (str.substr var2632 1 (- (- (str.len var2632) 1) 1))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!1 " ") (- 1)) (num_splits a!1 " ") (- 1))
       (num_splits a!1 " "))))
  (define-fun null-String () String
    " ")
  (define-fun var840 () Int
    0)
  (define-fun var2583!1 () Int
    (let ((a!1 (str.substr var2632 1 (- (- (str.len var2632) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1)))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!3 "=") (- 1)) (num_splits a!3 "=") (- 1))
       (num_splits a!3 "="))))))
  (define-fun var89 () String
    (cast-from-var3839-to-String
  (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "value"))))
  (define-fun var21!1 () String
    (let ((a!1 (str.substr var2632 1 (- (- (str.len var2632) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
  (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1))))))
  (define-fun var3779 () var3839
    (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "lemma")))
  (define-fun var3084!6 () var832
    var832!val!0)
  (define-fun var3084!5 () var832
    var832!val!0)
  (define-fun var3084!3 () var832
    var832!val!0)
  (define-fun var2707!1 () var3044
    var3044!val!0)
  (define-fun var368!1 () String
    "")
  (define-fun var2707!2 () var3044
    var3044!val!0)
  (define-fun var1469!3 () String
    "")
  (define-fun var3258!1 () String
    "")
  (define-fun var261!1 () String
    "")
  (define-fun var3084!4 () var832
    var832!val!0)
  (define-fun var1469!1 () String
    "")
  (define-fun var3745!1 () String
    "")
  (define-fun var3119_newHashMap/701256970 () var3044
    var3044!val!0)
  (define-fun var89!1 () String
    "")
  (define-fun var3084!2 () var832
    var832!val!0)
  (define-fun var832-init () var832
    var832!val!0)
  (define-fun var368!3 () String
    "")
  (define-fun var3084!1 () var832
    var832!val!0)
  (define-fun var2177!1 () String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 (seq.unit (_ Char 32))) (= x!1 (seq.unit (_ Char 61)))) 3
      2))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) " "
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) " "
      " ")))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun setValue/-1305364003 ((x!0 var832) (x!1 String)) void
    void!val!0)
  (define-fun setLemma/-2044772538 ((x!0 var832) (x!1 String)) void
    void!val!0)
  (define-fun setOriginalText/-1052378824 ((x!0 var832) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-var3839-to-String ((x!0 var3839)) String
    "")
  (define-fun <init>/379364885 ((x!0 var832)) void
    void!val!0)
  (define-fun var3044_get/1088891777 ((x!0 var3044) (x!1 var3839)) var3839
    var3839!val!0)
  (define-fun var3044_put/1464166817 ((x!0 var3044) (x!1 var3839) (x!2 var3839)) var3839
    var3839!val!0)
  (define-fun setTag/-492450796 ((x!0 var832) (x!1 String)) void
    void!val!0)
  (define-fun setWord/1927702860 ((x!0 var832) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-String-to-var3839 ((x!0 String)) var3839
    var3839!val!0)
)
