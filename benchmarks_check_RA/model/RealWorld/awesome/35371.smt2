(
  (define-fun var3886 () Int
    (let ((a!1 (str.substr var3212 1 (- (- (str.len var3212) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!3 "=") (- 1)) (num_splits a!3 "=") (- 1))
       (num_splits a!3 "="))))))
  (define-fun var3207 () String
    (let ((a!1 (str.substr var3212 1 (- (- (str.len var3212) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
  (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0)))))
  (define-fun var2965 () String
    (let ((a!1 (str.substr var3212 1 (- (- (str.len var3212) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
(let ((a!4 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 0)))))))
  (define-fun var3886!1 () Int
    (let ((a!1 (str.substr var3212 1 (- (- (str.len var3212) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1)))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!3 "=") (- 1)) (num_splits a!3 "=") (- 1))
       (num_splits a!3 "="))))))
  (define-fun var2914 () String
    (str.substr var3212 1 (- (- (str.len var3212) 1) 1)))
  (define-fun var1947 () String
    (cast-from-var1521-to-String
  (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "POS"))))
  (define-fun var3207!1 () String
    (let ((a!1 (str.substr var3212 1 (- (- (str.len var3212) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
  (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1))))))
  (define-fun var3347 () String
    (cast-from-var1521-to-String
  (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "word"))))
  (define-fun var979 () Int
    (- (str.len var3212) 1))
  (define-fun var16 () Int
    (let ((a!1 (str.substr var3212 1 (- (- (str.len var3212) 1) 1))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!1 " ") (- 1)) (num_splits a!1 " ") (- 1))
       (num_splits a!1 " "))))
  (define-fun var2953!3 () String
    (let ((a!1 (str.substr var3212 1 (- (- (str.len var3212) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1)))))
(let ((a!4 (and (> (- 1) 0) (= 1 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 1)))))))
  (define-fun var3212 () String
    "AB")
  (define-fun var3649!2 () Int
    (+ 0 1 1))
  (define-fun var585 () var1911
    var1911-init)
  (define-fun var1300 () Int
    (str.len var3212))
  (define-fun var3649 () Int
    0)
  (define-fun var3768 () var1521
    (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "POS")))
  (define-fun var1006 () var1521
    (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "value")))
  (define-fun var3649!1 () Int
    (+ 0 1))
  (define-fun var2611 () String
    (cast-from-var1521-to-String
  (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "current"))))
  (define-fun null-String () String
    " ")
  (define-fun var2521 () var1521
    (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "word")))
  (define-fun var2367 () String
    (cast-from-var1521-to-String
  (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "lemma"))))
  (define-fun var2953 () String
    "")
  (define-fun var1214 () var1699
    var3108_newHashMap/701256970)
  (define-fun var2953!2 () String
    "")
  (define-fun var3672 () var1521
    (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "lemma")))
  (define-fun var1835 () String
    (cast-from-var1521-to-String
  (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "value"))))
  (define-fun var2148 () var1521
    (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "current")))
  (define-fun var2965!2 () String
    (let ((a!1 (str.substr var3212 1 (- (- (str.len var3212) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1)))))
(let ((a!4 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 0)))))))
  (define-fun var2367!1 () String
    "")
  (define-fun var585!5 () var1911
    var1911!val!0)
  (define-fun var585!3 () var1911
    var1911!val!0)
  (define-fun var2965!1 () String
    "")
  (define-fun var585!6 () var1911
    var1911!val!0)
  (define-fun var2953!1 () String
    "")
  (define-fun var1947!1 () String
    "")
  (define-fun var585!4 () var1911
    var1911!val!0)
  (define-fun var585!2 () var1911
    var1911!val!0)
  (define-fun var3108_newHashMap/701256970 () var1699
    var1699!val!0)
  (define-fun var1214!2 () var1699
    var1699!val!0)
  (define-fun var2953!4 () String
    "")
  (define-fun var2611!1 () String
    "")
  (define-fun var2965!3 () String
    "")
  (define-fun var3347!1 () String
    "")
  (define-fun var1911-init () var1911
    var1911!val!0)
  (define-fun var1835!1 () String
    "")
  (define-fun var1214!1 () var1699
    var1699!val!0)
  (define-fun var585!1 () var1911
    var1911!val!0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 (seq.unit (_ Char 32))) (= x!1 "=")) 3
      2))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) " "
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "="
      " ")))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun setValue/-1305364003 ((x!0 var1911) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-String-to-var1521 ((x!0 String)) var1521
    var1521!val!0)
  (define-fun setLemma/-2044772538 ((x!0 var1911) (x!1 String)) void
    void!val!0)
  (define-fun setOriginalText/-1052378824 ((x!0 var1911) (x!1 String)) void
    void!val!0)
  (define-fun var1699_put/1464166817 ((x!0 var1699) (x!1 var1521) (x!2 var1521)) var1521
    var1521!val!0)
  (define-fun <init>/379364885 ((x!0 var1911)) void
    void!val!0)
  (define-fun cast-from-var1521-to-String ((x!0 var1521)) String
    "")
  (define-fun var1699_get/1088891777 ((x!0 var1699) (x!1 var1521)) var1521
    var1521!val!0)
  (define-fun setTag/-492450796 ((x!0 var1911) (x!1 String)) void
    void!val!0)
  (define-fun setWord/1927702860 ((x!0 var1911) (x!1 String)) void
    void!val!0)
)
