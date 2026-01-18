(
  ;; universe for var1901:
  ;;   var1901!val!1 var1901!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1901!val!1 () var1901)
  (declare-fun var1901!val!0 () var1901)
  ;; cardinality constraint:
  (forall ((x var1901)) (or (= x var1901!val!1) (= x var1901!val!0)))
  ;; -----------
  ;; universe for var2257:
  ;;   var2257!val!0 var2257!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2257!val!0 () var2257)
  (declare-fun var2257!val!1 () var2257)
  ;; cardinality constraint:
  (forall ((x var2257)) (or (= x var2257!val!0) (= x var2257!val!1)))
  ;; -----------
  (define-fun var3512 () (Array Int Int)
    arr-Int-init)
  (define-fun null-var2257 () var2257
    var2257!val!1)
  (define-fun var2928 () var1840
    var1840-init)
  (define-fun null-var1901 () var1901
    var1901!val!1)
  (define-fun var37 () String
    "/")
  (define-fun var2667 () Bool
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var37 "/") (- 1))
                     (num_splits var37 "/")
                     (- 1))
                (num_splits var37 "/"))))
(let ((a!2 (and (> (- 1) 0)
                (= (- a!1 1) (- (- 1) 1))
                (>= (num_splits var37 "/") (- 1)))))
(let ((a!3 (ite a!2
                (split_rest var37 "/" (- (- 1) 1))
                (split_at var37 "/" (- a!1 1)))))
  (var1901_hasEntry/-919956893 var1973 a!3)))))
  (define-fun var1004 () var1047
    var1047-init)
  (define-fun var2585 () var2257
    var2257!val!0)
  (define-fun var7 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var37 "/") (- 1)) (num_splits var37 "/") (- 1))
     (num_splits var37 "/")))
  (define-fun var3006 () Int
    (getWriteIndex/-1813127352 var2928!2))
  (define-fun var144 () String
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var37 "/") (- 1))
                     (num_splits var37 "/")
                     (- 1))
                (num_splits var37 "/"))))
(let ((a!2 (and (> (- 1) 0)
                (= (- a!1 1) (- (- 1) 1))
                (>= (num_splits var37 "/") (- 1)))))
  (ite a!2 (split_rest var37 "/" (- (- 1) 1)) (split_at var37 "/" (- a!1 1))))))
  (define-fun var291 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var37 "/") (- 1))
                     (num_splits var37 "/")
                     (- 1))
                (num_splits var37 "/"))))
  (- a!1 1)))
  (define-fun var1469 () var1241
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var37 "/") (- 1))
                     (num_splits var37 "/")
                     (- 1))
                (num_splits var37 "/"))))
(let ((a!2 (and (> (- 1) 0)
                (= (- a!1 1) (- (- 1) 1))
                (>= (num_splits var37 "/") (- 1)))))
(let ((a!3 (ite a!2
                (split_rest var37 "/" (- (- 1) 1))
                (split_at var37 "/" (- a!1 1)))))
  (var1901_createDocument/310456128
    var1973
    a!3
    (getWriteIndex/-1813127352 var2928!2)
    (cast-from-var1047-to-var855 var1004!1))))))
  (define-fun null-String () String
    "")
  (define-fun var2716 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var37 "/") (- 1)) (num_splits var37 "/") (- 1))
     (num_splits var37 "/")))
  (define-fun var1376 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var37 "/") (- 1))
                     (num_splits var37 "/")
                     (- 1))
                (num_splits var37 "/"))))
  (- a!1 1)))
  (define-fun var3193 () Int
    0)
  (define-fun var1973 () var1901
    var1901!val!0)
  (define-fun var1840-init () var1840
    var1840!val!0)
  (define-fun var2928!1 () var1840
    var1840!val!0)
  (define-fun var1047-init () var1047
    var1047!val!0)
  (define-fun var3512!1 () (Array Int Int)
    ((as const (Array Int Int)) 0))
  (define-fun var2585!1 () var2257
    var2257!val!0)
  (define-fun var3512!2 () (Array Int Int)
    ((as const (Array Int Int)) 0))
  (define-fun var1004!1 () var1047
    var1047!val!0)
  (define-fun arr-Int-init () (Array Int Int)
    ((as const (Array Int Int)) 0))
  (define-fun var1875 () Int
    0)
  (define-fun var2928!2 () var1840
    var1840!val!0)
  (define-fun var1901_hasEntry/-919956893 ((x!0 var1901) (x!1 String)) Bool
    false)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun getWriteIndex/-1813127352 ((x!0 var1840)) Int
    0)
  (define-fun <init>/-513080946 ((x!0 var1047) (x!1 (Array Int Int))) void
    void!val!0)
  (define-fun <init>/2076123439 ((x!0 var1840) (x!1 (Array Int Int)) (x!2 Int)) void
    void!val!0)
  (define-fun cast-from-var1047-to-var855 ((x!0 var1047)) var855
    var855!val!0)
  (define-fun var2257_write/489016319 ((x!0 var2257) (x!1 var1840)) void
    void!val!0)
  (define-fun var1901_createDocument/310456128 ((x!0 var1901)
   (x!1 String)
   (x!2 Int)
   (x!3 var855)) var1241
    var1241!val!0)
)
