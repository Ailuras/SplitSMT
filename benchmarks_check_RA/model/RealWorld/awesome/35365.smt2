(
  (define-fun var3066 () var3763
    (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "POS")))
  (define-fun var52 () String
    (cast-from-var3763-to-String
  (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "value"))))
  (define-fun var645 () var3763
    (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "lemma")))
  (define-fun var287 () var3763
    (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "value")))
  (define-fun var1731!1 () Int
    (+ 0 1))
  (define-fun var3811 () var3763
    (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "word")))
  (define-fun var1041 () String
    (str.substr var3830 1 (- (- (str.len var3830) 1) 1)))
  (define-fun var3830 () String
    "AB")
  (define-fun var2819 () String
    (cast-from-var3763-to-String
  (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "lemma"))))
  (define-fun var18 () var2024
    var2024-init)
  (define-fun var3485 () String
    (cast-from-var3763-to-String
  (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "current"))))
  (define-fun var1731 () Int
    0)
  (define-fun null-String () String
    " ")
  (define-fun var2966 () Int
    (let ((a!1 (str.substr var3830 1 (- (- (str.len var3830) 1) 1))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!1 " ") (- 1)) (num_splits a!1 " ") (- 1))
       (num_splits a!1 " "))))
  (define-fun var2278 () String
    (let ((a!1 (str.substr var3830 1 (- (- (str.len var3830) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
  (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0)))))
  (define-fun var3063 () Int
    (let ((a!1 (str.substr var3830 1 (- (- (str.len var3830) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!3 "=") (- 1)) (num_splits a!3 "=") (- 1))
       (num_splits a!3 "="))))))
  (define-fun var1419 () var3763
    (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "current")))
  (define-fun var3490 () Int
    (- (str.len var3830) 1))
  (define-fun var1032 () String
    (let ((a!1 (str.substr var3830 1 (- (- (str.len var3830) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
(let ((a!4 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 0)))))))
  (define-fun var763 () Int
    (str.len var3830))
  (define-fun var3243 () var920
    var343_newHashMap/701256970)
  (define-fun var1925 () String
    (cast-from-var3763-to-String
  (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "word"))))
  (define-fun var1143 () String
    "")
  (define-fun var3055 () String
    (cast-from-var3763-to-String
  (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "POS"))))
  (define-fun var2024-init () var2024
    var2024!val!0)
  (define-fun var3243!1 () var920
    var920!val!0)
  (define-fun var18!1 () var2024
    var2024!val!0)
  (define-fun var52!1 () String
    "")
  (define-fun var3485!1 () String
    "")
  (define-fun var1143!1 () String
    "")
  (define-fun var18!5 () var2024
    var2024!val!0)
  (define-fun var18!3 () var2024
    var2024!val!0)
  (define-fun var3055!1 () String
    "")
  (define-fun var18!6 () var2024
    var2024!val!0)
  (define-fun var2819!1 () String
    "")
  (define-fun var18!4 () var2024
    var2024!val!0)
  (define-fun var18!2 () var2024
    var2024!val!0)
  (define-fun var1925!1 () String
    "")
  (define-fun var1032!1 () String
    "")
  (define-fun var343_newHashMap/701256970 () var920
    var920!val!0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 (seq.unit (_ Char 32))) (= x!1 (seq.unit (_ Char 61)))) 3
      1))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) " "
      " "))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun setValue/-1305364003 ((x!0 var2024) (x!1 String)) void
    void!val!0)
  (define-fun setLemma/-2044772538 ((x!0 var2024) (x!1 String)) void
    void!val!0)
  (define-fun setOriginalText/-1052378824 ((x!0 var2024) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-String-to-var3763 ((x!0 String)) var3763
    var3763!val!0)
  (define-fun cast-from-var3763-to-String ((x!0 var3763)) String
    "")
  (define-fun <init>/379364885 ((x!0 var2024)) void
    void!val!0)
  (define-fun setTag/-492450796 ((x!0 var2024) (x!1 String)) void
    void!val!0)
  (define-fun var920_put/1464166817 ((x!0 var920) (x!1 var3763) (x!2 var3763)) var3763
    var3763!val!0)
  (define-fun setWord/1927702860 ((x!0 var2024) (x!1 String)) void
    void!val!0)
  (define-fun var920_get/1088891777 ((x!0 var920) (x!1 var3763)) var3763
    var3763!val!0)
)
