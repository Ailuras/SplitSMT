(
  (define-fun var1225!1 () Int
    (let ((a!1 (str.substr var166 1 (- (- (str.len var166) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1)))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!3 "=") (- 1)) (num_splits a!3 "=") (- 1))
       (num_splits a!3 "="))))))
  (define-fun var1104!2 () Int
    (+ 0 1 1))
  (define-fun var1861 () String
    "")
  (define-fun var344 () var1373
    (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "POS")))
  (define-fun var452 () var1373
    (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "current")))
  (define-fun var3021!2 () String
    (let ((a!1 (str.substr var166 1 (- (- (str.len var166) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1)))))
(let ((a!4 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 0)))))))
  (define-fun var3606 () String
    (cast-from-var1373-to-String
  (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "lemma"))))
  (define-fun var809!1 () String
    (let ((a!1 (str.substr var166 1 (- (- (str.len var166) 1) 1))))
(let ((a!2 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits a!1 " ") (- 1)))))
  (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " (+ 0 1))))))
  (define-fun var211 () String
    (cast-from-var1373-to-String
  (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "POS"))))
  (define-fun var809 () String
    (let ((a!1 (str.substr var166 1 (- (- (str.len var166) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
  (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0)))))
  (define-fun var3021 () String
    (let ((a!1 (str.substr var166 1 (- (- (str.len var166) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
(let ((a!4 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 0)))))))
  (define-fun var1725 () var1373
    (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "lemma")))
  (define-fun var2694 () String
    (cast-from-var1373-to-String
  (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "current"))))
  (define-fun var1861!1 () String
    (let ((a!1 (str.substr var166 1 (- (- (str.len var166) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
(let ((a!4 (and (> (- 1) 0) (= 1 (- (- 1) 1)) (>= (num_splits a!3 "=") (- 1)))))
  (ite a!4 (split_rest a!3 "=" (- (- 1) 1)) (split_at a!3 "=" 1)))))))
  (define-fun var3651 () var1373
    (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "value")))
  (define-fun var1104 () Int
    0)
  (define-fun var1419 () var639
    var3904_newHashMap/701256970)
  (define-fun var166 () String
    "AB")
  (define-fun var1861!3 () String
    "")
  (define-fun var3601 () String
    (str.substr var166 1 (- (- (str.len var166) 1) 1)))
  (define-fun var1112 () String
    (cast-from-var1373-to-String
  (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "word"))))
  (define-fun var2580 () Int
    (- (str.len var166) 1))
  (define-fun var413 () var2806
    var2806-init)
  (define-fun null-String () String
    " ")
  (define-fun var1104!1 () Int
    (+ 0 1))
  (define-fun var1266 () Int
    (let ((a!1 (str.substr var166 1 (- (- (str.len var166) 1) 1))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!1 " ") (- 1)) (num_splits a!1 " ") (- 1))
       (num_splits a!1 " "))))
  (define-fun var1256 () String
    (cast-from-var1373-to-String
  (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "value"))))
  (define-fun var1225 () Int
    (let ((a!1 (str.substr var166 1 (- (- (str.len var166) 1) 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!1 " ") (- 1)))))
(let ((a!3 (ite a!2 (split_rest a!1 " " (- (- 1) 1)) (split_at a!1 " " 0))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!3 "=") (- 1)) (num_splits a!3 "=") (- 1))
       (num_splits a!3 "="))))))
  (define-fun var1180 () var1373
    (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "word")))
  (define-fun var1528 () Int
    (str.len var166))
  (define-fun var1861!2 () String
    "")
  (define-fun var1419!1 () var639
    var639!val!0)
  (define-fun var413!5 () var2806
    var2806!val!0)
  (define-fun var1419!2 () var639
    var639!val!0)
  (define-fun var2806-init () var2806
    var2806!val!0)
  (define-fun var1112!1 () String
    "")
  (define-fun var3904_newHashMap/701256970 () var639
    var639!val!0)
  (define-fun var211!1 () String
    "")
  (define-fun var2694!1 () String
    "")
  (define-fun var413!3 () var2806
    var2806!val!0)
  (define-fun var3021!1 () String
    "")
  (define-fun var413!2 () var2806
    var2806!val!0)
  (define-fun var3606!1 () String
    "")
  (define-fun var3021!3 () String
    "")
  (define-fun var413!1 () var2806
    var2806!val!0)
  (define-fun var413!6 () var2806
    var2806!val!0)
  (define-fun var1256!1 () String
    "")
  (define-fun var413!4 () var2806
    var2806!val!0)
  (define-fun var1861!4 () String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "=") (= x!1 "=")) 3
      2))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) " "
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "="
      " ")))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun setValue/-1305364003 ((x!0 var2806) (x!1 String)) void
    void!val!0)
  (define-fun setLemma/-2044772538 ((x!0 var2806) (x!1 String)) void
    void!val!0)
  (define-fun setOriginalText/-1052378824 ((x!0 var2806) (x!1 String)) void
    void!val!0)
  (define-fun var639_get/1088891777 ((x!0 var639) (x!1 var1373)) var1373
    var1373!val!0)
  (define-fun <init>/379364885 ((x!0 var2806)) void
    void!val!0)
  (define-fun setTag/-492450796 ((x!0 var2806) (x!1 String)) void
    void!val!0)
  (define-fun setWord/1927702860 ((x!0 var2806) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-String-to-var1373 ((x!0 String)) var1373
    var1373!val!0)
  (define-fun var639_put/1464166817 ((x!0 var639) (x!1 var1373) (x!2 var1373)) var1373
    var1373!val!0)
  (define-fun cast-from-var1373-to-String ((x!0 var1373)) String
    "")
)
