(
  ;; universe for var1479:
  ;;   var1479!val!1 var1479!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1479!val!1 () var1479)
  (declare-fun var1479!val!0 () var1479)
  ;; cardinality constraint:
  (forall ((x var1479)) (or (= x var1479!val!1) (= x var1479!val!0)))
  ;; -----------
  ;; universe for var2585:
  ;;   var2585!val!0 var2585!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2585!val!0 () var2585)
  (declare-fun var2585!val!1 () var2585)
  ;; cardinality constraint:
  (forall ((x var2585)) (or (= x var2585!val!0) (= x var2585!val!1)))
  ;; -----------
  ;; universe for var1240:
  ;;   var1240!val!3 var1240!val!0 var1240!val!1 var1240!val!2 var1240!val!4 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1240!val!3 () var1240)
  (declare-fun var1240!val!0 () var1240)
  (declare-fun var1240!val!1 () var1240)
  (declare-fun var1240!val!2 () var1240)
  (declare-fun var1240!val!4 () var1240)
  ;; cardinality constraint:
  (forall ((x var1240))
          (or (= x var1240!val!3)
              (= x var1240!val!0)
              (= x var1240!val!1)
              (= x var1240!val!2)
              (= x var1240!val!4)))
  ;; -----------
  ;; universe for var2772:
  ;;   var2772!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2772!val!0 () var2772)
  ;; cardinality constraint:
  (forall ((x var2772)) (= x var2772!val!0))
  ;; -----------
  (define-fun var421 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1269 "\u{9}") (- 1)))))
  (ite a!1
       (split_rest var1269 "\u{9}" (- (- 1) 1))
       (split_at var1269 "\u{9}" 0))))
  (define-fun var937!4 () var1240
    var1240!val!4)
  (define-fun var937!2 () var1240
    var1240!val!2)
  (define-fun var755 () var1479
    var1479-init)
  (define-fun var409 () Int
    0)
  (define-fun var1269 () String
    "\u{9}")
  (define-fun var1182 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1269 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1269 "\u{9}" (- (- 1) 1))
                (split_at var1269 "\u{9}" 0))))
(let ((a!3 (num_splits_re a!2
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!3 (- 1)) a!3 (- 1)) a!3)))))
  (define-fun var937 () var1240
    var1240!val!0)
  (define-fun var2947 () var2772
    var2772-init)
  (define-fun null-var1240 () var1240
    var1240!val!1)
  (define-fun null-String () String
    "")
  (define-fun var755!1 () var1479
    var1479!val!0)
  (define-fun var451 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1269 "\u{9}") (- 1))
          (num_splits var1269 "\u{9}")
          (- 1))
     (num_splits var1269 "\u{9}")))
  (define-fun var937!3 () var1240
    var1240!val!3)
  (define-fun var1130 () var1479
    var1479-init)
  (define-fun var1130!1 () var1479
    var1479!val!1)
  (define-fun var3916 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1269 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1269 "\u{9}" (- (- 1) 1))
                (split_at var1269 "\u{9}" 0))))
(let ((a!3 (num_splits_re a!2
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!3 (- 1)) a!3 (- 1)) a!3)))))
  (define-fun var2947!1 () var2772
    var2772!val!0)
  (define-fun var2772-init () var2772
    var2772!val!0)
  (define-fun var1235 () Int
    0)
  (define-fun var1479-init () var1479
    var1479!val!1)
  (define-fun var3916!1 () Int
    0)
  (define-fun var937!1 () var1240
    var1240!val!3)
  (define-fun var3736 () Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun tokens/74865948 ((x!0 var1240)) var2585
    var2585!val!0)
  (define-fun pronouns/74865948 ((x!0 var1240)) var2585
    var2585!val!1)
  (define-fun cast-from-var1479-to-var2585 ((x!0 var1479)) var2585
    (ite (= x!0 var1479!val!1) var2585!val!1
      var2585!val!0))
  (define-fun corefPairs/74865948 ((x!0 var1240)) var2772
    var2772!val!0)
  (define-fun cast-from-var1240-to-var436 ((x!0 var1240)) var436
    var436!val!0)
  (define-fun <init>/1228603609 ((x!0 var1479) (x!1 Int)) void
    void!val!0)
  (define-fun <init>/613807010 ((x!0 var2772) (x!1 Int)) void
    void!val!0)
  (define-fun <init>/-279557996 ((x!0 var436)) void
    void!val!0)
)
