(
  ;; universe for var3085:
  ;;   var3085!val!1 var3085!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3085!val!1 () var3085)
  (declare-fun var3085!val!0 () var3085)
  ;; cardinality constraint:
  (forall ((x var3085)) (or (= x var3085!val!1) (= x var3085!val!0)))
  ;; -----------
  ;; universe for var1618:
  ;;   var1618!val!0 var1618!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1618!val!0 () var1618)
  (declare-fun var1618!val!1 () var1618)
  ;; cardinality constraint:
  (forall ((x var1618)) (or (= x var1618!val!0) (= x var1618!val!1)))
  ;; -----------
  (define-fun var2047 () Int
    (let ((a!1 (num_splits (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"))
      (a!3 (split_rest (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"
                       (- (- 1) 1)))
      (a!4 (split_at (cast-from-var937-to-String
                       (var640_get/1088891777
                         (docInfo/-1745439537 var3610)
                         (cast-from-String-to-var937 "DOC_ID")))
                     "/"
                     0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
(let ((a!5 (cast-from-var937-to-Int
             (var640_get/1088891777
               (genres/1476566127 var1823)
               (cast-from-String-to-var937 (ite a!2 a!3 a!4))))))
  (intValue/-1815674922 a!5)))))
  (define-fun var2412 () Int
    (let ((a!1 (num_splits (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"))
      (a!3 (split_rest (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"
                       (- (- 1) 1)))
      (a!4 (split_at (cast-from-var937-to-String
                       (var640_get/1088891777
                         (docInfo/-1745439537 var3610)
                         (cast-from-String-to-var937 "DOC_ID")))
                     "/"
                     0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
  (cast-from-var937-to-Int
    (var640_get/1088891777
      (genres/1476566127 var1823)
      (cast-from-String-to-var937 (ite a!2 a!3 a!4)))))))
  (define-fun var131 () var640
    (genres/1476566127 var1823))
  (define-fun var3610 () var3085
    var3085!val!0)
  (define-fun var413 () var640
    (docInfo/-1745439537 var3610))
  (define-fun null-var3085 () var3085
    var3085!val!1)
  (define-fun var2907 () Bool
    (conll/1476566127 var1823))
  (define-fun null-var1618 () var1618
    var1618!val!1)
  (define-fun var552 () var937
    (var640_get/1088891777
  (docInfo/-1745439537 var3610)
  (cast-from-String-to-var937 "DOC_ID")))
  (define-fun var492 () String
    (cast-from-var937-to-String
  (var640_get/1088891777
    (docInfo/-1745439537 var3610)
    (cast-from-String-to-var937 "DOC_ID"))))
  (define-fun var2321 () var640
    (genres/1476566127 var1823))
  (define-fun var563 () var1374
    (let ((a!1 (num_splits (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"))
      (a!3 (split_rest (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"
                       (- (- 1) 1)))
      (a!4 (split_at (cast-from-var937-to-String
                       (var640_get/1088891777
                         (docInfo/-1745439537 var3610)
                         (cast-from-String-to-var937 "DOC_ID")))
                     "/"
                     0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
(let ((a!5 (cast-from-var937-to-Int
             (var640_get/1088891777
               (genres/1476566127 var1823)
               (cast-from-String-to-var937 (ite a!2 a!3 a!4))))))
  (var1071_oneHot/961599073
    (intValue/-1815674922 a!5)
    (var640_size/-1594421051 (genres/1476566127 var1823)))))))
  (define-fun var2849 () var937
    (let ((a!1 (num_splits (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"))
      (a!3 (split_rest (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"
                       (- (- 1) 1)))
      (a!4 (split_at (cast-from-var937-to-String
                       (var640_get/1088891777
                         (docInfo/-1745439537 var3610)
                         (cast-from-String-to-var937 "DOC_ID")))
                     "/"
                     0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
  (var640_get/1088891777
    (genres/1476566127 var1823)
    (cast-from-String-to-var937 (ite a!2 a!3 a!4))))))
  (define-fun var1823 () var1618
    var1618!val!0)
  (define-fun var2002 () String
    (let ((a!1 (num_splits (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"))
      (a!3 (split_rest (cast-from-var937-to-String
                         (var640_get/1088891777
                           (docInfo/-1745439537 var3610)
                           (cast-from-String-to-var937 "DOC_ID")))
                       "/"
                       (- (- 1) 1)))
      (a!4 (split_at (cast-from-var937-to-String
                       (var640_get/1088891777
                         (docInfo/-1745439537 var3610)
                         (cast-from-String-to-var937 "DOC_ID")))
                     "/"
                     0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
  (ite a!2 a!3 a!4))))
  (define-fun var1767 () Int
    (var640_size/-1594421051 (genres/1476566127 var1823)))
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
  (define-fun conll/1476566127 ((x!0 var1618)) Bool
    true)
  (define-fun cast-from-var937-to-String ((x!0 var937)) String
    "")
  (define-fun var640_get/1088891777 ((x!0 var640) (x!1 var937)) var937
    var937!val!0)
  (define-fun var1071_oneHot/961599073 ((x!0 Int) (x!1 Int)) var1374
    var1374!val!0)
  (define-fun intValue/-1815674922 ((x!0 Int)) Int
    0)
  (define-fun genres/1476566127 ((x!0 var1618)) var640
    var640!val!0)
  (define-fun var640_size/-1594421051 ((x!0 var640)) Int
    0)
  (define-fun cast-from-String-to-var937 ((x!0 String)) var937
    var937!val!0)
  (define-fun docInfo/-1745439537 ((x!0 var3085)) var640
    var640!val!0)
  (define-fun cast-from-var937-to-Int ((x!0 var937)) Int
    0)
)
