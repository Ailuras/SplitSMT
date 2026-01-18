(
  (define-fun var3267 () var438
    (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "POS")))
  (define-fun var2558 () var2231
    var1110_newHashMap/701256970)
  (define-fun var2566 () var3743
    var3743-init)
  (define-fun var2934 () String
    (cast-from-var438-to-String
  (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "lemma"))))
  (define-fun var2413!1 () String
    (let ((a!1 (str.substr var850 1 (- (- (str.len var850) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
(let ((a!4 (and (> (- 1) 0) (= 1 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 1)))))))
  (define-fun var1648 () String
    (cast-from-var438-to-String
  (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "POS"))))
  (define-fun var504 () Int
    (- (str.len var850) 1))
  (define-fun var3239 () var438
    (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "word")))
  (define-fun var1899 () Int
    (let ((a!1 (str.substr var850 1 (- (- (str.len var850) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!3 "=") (- 1)) (num_splits a!3 "=") (- 1))
       (num_splits a!3 "="))))))
  (define-fun var3262 () var438
    (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "current")))
  (define-fun var3605 () Int
    (str.len var850))
  (define-fun var2413 () String
    "")
  (define-fun var3681 () var438
    (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "lemma")))
  (define-fun null-String () String
    " ")
  (define-fun var872 () String
    (str.substr var850 1 (- (- (str.len var850) 1) 1)))
  (define-fun var3928 () String
    (cast-from-var438-to-String
  (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "word"))))
  (define-fun var850 () String
    "AB")
  (define-fun var2572 () String
    (let ((a!1 (str.substr var850 1 (- (- (str.len var850) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
(let ((a!4 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 0)))))))
  (define-fun var1226 () Int
    (let ((a!1 (str.substr var850 1 (- (- (str.len var850) 1) 1))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!1 " ") (- 1)) (num_splits a!1 " ") (- 1))
       (num_splits a!1 " "))))
  (define-fun var3457 () Int
    0)
  (define-fun var3323 () String
    (let ((a!1 (str.substr var850 1 (- (- (str.len var850) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
  (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0)))))
  (define-fun var3457!1 () Int
    (+ 0 1))
  (define-fun var207 () var438
    (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "value")))
  (define-fun var1773 () String
    (cast-from-var438-to-String
  (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "value"))))
  (define-fun var1646 () String
    (cast-from-var438-to-String
  (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "current"))))
  (define-fun var1648!1 () String
    "")
  (define-fun var2566!2 () var3743
    var3743!val!0)
  (define-fun var1773!1 () String
    "")
  (define-fun var3743-init () var3743
    var3743!val!0)
  (define-fun var2566!6 () var3743
    var3743!val!0)
  (define-fun var2934!1 () String
    "")
  (define-fun var1110_newHashMap/701256970 () var2231
    var2231!val!0)
  (define-fun var2566!5 () var3743
    var3743!val!0)
  (define-fun var3928!1 () String
    "")
  (define-fun var2566!1 () var3743
    var3743!val!0)
  (define-fun var2566!3 () var3743
    var3743!val!0)
  (define-fun var2572!1 () String
    "")
  (define-fun var1646!1 () String
    "")
  (define-fun var2566!4 () var3743
    var3743!val!0)
  (define-fun var2413!2 () String
    "")
  (define-fun var2558!1 () var2231
    var2231!val!0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 (seq.unit (_ Char 32))) (= x!1 (seq.unit (_ Char 61)))) 2
      1))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) " "
      " "))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun setValue/-1305364003 ((x!0 var3743) (x!1 String)) void
    void!val!0)
  (define-fun setLemma/-2044772538 ((x!0 var3743) (x!1 String)) void
    void!val!0)
  (define-fun var2231_put/1464166817 ((x!0 var2231) (x!1 var438) (x!2 var438)) var438
    var438!val!0)
  (define-fun cast-from-String-to-var438 ((x!0 String)) var438
    var438!val!0)
  (define-fun setOriginalText/-1052378824 ((x!0 var3743) (x!1 String)) void
    void!val!0)
  (define-fun <init>/379364885 ((x!0 var3743)) void
    void!val!0)
  (define-fun setTag/-492450796 ((x!0 var3743) (x!1 String)) void
    void!val!0)
  (define-fun setWord/1927702860 ((x!0 var3743) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-var438-to-String ((x!0 var438)) String
    "")
  (define-fun var2231_get/1088891777 ((x!0 var2231) (x!1 var438)) var438
    var438!val!0)
)
