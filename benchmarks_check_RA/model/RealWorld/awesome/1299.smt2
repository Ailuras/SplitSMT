(
  ;; universe for var934:
  ;;   var934!val!1 var934!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var934!val!1 () var934)
  (declare-fun var934!val!0 () var934)
  ;; cardinality constraint:
  (forall ((x var934)) (or (= x var934!val!1) (= x var934!val!0)))
  ;; -----------
  (define-fun var203 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1281 "/") (- 1)))))
  (ite a!1 (split_rest var1281 "/" (- (- 1) 1)) (split_at var1281 "/" 1))))
  (define-fun var3530 () var934
    var934!val!0)
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var1281 () String
    "/")
  (define-fun var1317 () String
    (str.++ var2388!1 "Invalid subnet: " var1281))
  (define-fun var2388 () String
    String-init)
  (define-fun var2092 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1281 "/") (- 1)) (num_splits var1281 "/") (- 1))
     (num_splits var1281 "/")))
  (define-fun var882 () var2022
    var2022-init)
  (define-fun var2779 () String
    (str.++ var2388!1 "Invalid subnet: " var1281))
  (define-fun null-var934 () var934
    var934!val!1)
  (define-fun null-String () String
    "")
  (define-fun var2192 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1281 "/") (- 1)))))
  (ite a!1 (split_rest var1281 "/" (- (- 1) 1)) (split_at var1281 "/" 0))))
  (define-fun var1736 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1281 "/") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1281 "/" (- (- 1) 1))
                (split_at var1281 "/" 1))))
  (Int_parseInt/1370970945 a!2))))
  (define-fun var2977 () String
    (str.++ var2388!1 "Invalid subnet: "))
  (define-fun var2977!1 () String
    "Invalid subnet: /")
  (define-fun var2388!2 () String
    "Invalid subnet: ")
  (define-fun var2388!1 () String
    "")
  (define-fun var882!1 () var2022
    var2022!val!0)
  (define-fun var2022-init () var2022
    var2022!val!0)
  (define-fun var1317!1 () String
    "")
  (define-fun String-init () String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun Int_parseInt/1370970945 ((x!0 String)) Int
    0)
  (define-fun <init>/875830710 ((x!0 var2022) (x!1 String)) void
    void!val!0)
)
