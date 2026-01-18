(
  ;; universe for var3173:
  ;;   var3173!val!0 var3173!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3173!val!0 () var3173)
  (declare-fun var3173!val!1 () var3173)
  ;; cardinality constraint:
  (forall ((x var3173)) (or (= x var3173!val!0) (= x var3173!val!1)))
  ;; -----------
  ;; universe for var1425:
  ;;   var1425!val!0 var1425!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1425!val!0 () var1425)
  (declare-fun var1425!val!1 () var1425)
  ;; cardinality constraint:
  (forall ((x var1425)) (or (= x var1425!val!0) (= x var1425!val!1)))
  ;; -----------
  (define-fun var69 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1012 "/") (- 1)) (num_splits var1012 "/") (- 1))
     (num_splits var1012 "/")))
  (define-fun var1872 () var3950
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var1012 "/") (- 1))
                     (num_splits var1012 "/")
                     (- 1))
                (num_splits var1012 "/"))))
(let ((a!2 (and (> (- 1) 0)
                (= (- a!1 1) (- (- 1) 1))
                (>= (num_splits var1012 "/") (- 1)))))
(let ((a!3 (ite a!2
                (split_rest var1012 "/" (- (- 1) 1))
                (split_at var1012 "/" (- a!1 1)))))
  (var3173_createDocument/-450016166
    var1404
    a!3
    (getWriteIndex/-178493442 var740!2)
    (var335_bootstrap$/-1224113051 var2635!1))))))
  (define-fun var1012 () String
    "/")
  (define-fun var2635 () (Array Int Int)
    arr-Int-init)
  (define-fun var2675 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var1012 "/") (- 1))
                     (num_splits var1012 "/")
                     (- 1))
                (num_splits var1012 "/"))))
  (- a!1 1)))
  (define-fun var236 () String
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var1012 "/") (- 1))
                     (num_splits var1012 "/")
                     (- 1))
                (num_splits var1012 "/"))))
(let ((a!2 (and (> (- 1) 0)
                (= (- a!1 1) (- (- 1) 1))
                (>= (num_splits var1012 "/") (- 1)))))
  (ite a!2
       (split_rest var1012 "/" (- (- 1) 1))
       (split_at var1012 "/" (- a!1 1))))))
  (define-fun var1606 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1012 "/") (- 1)) (num_splits var1012 "/") (- 1))
     (num_splits var1012 "/")))
  (define-fun var1827 () var1425
    var1425!val!0)
  (define-fun var1404 () var3173
    var3173!val!0)
  (define-fun var2971 () Int
    (getWriteIndex/-178493442 var740!2))
  (define-fun var1115 () Int
    0)
  (define-fun var1043 () var1468
    (var335_bootstrap$/-1224113051 var2635!1))
  (define-fun null-String () String
    "")
  (define-fun null-var3173 () var3173
    var3173!val!1)
  (define-fun var908 () Bool
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var1012 "/") (- 1))
                     (num_splits var1012 "/")
                     (- 1))
                (num_splits var1012 "/"))))
(let ((a!2 (and (> (- 1) 0)
                (= (- a!1 1) (- (- 1) 1))
                (>= (num_splits var1012 "/") (- 1)))))
(let ((a!3 (ite a!2
                (split_rest var1012 "/" (- (- 1) 1))
                (split_at var1012 "/" (- a!1 1)))))
  (var3173_hasEntryCaseInsensitive/-240204854 var1404 a!3)))))
  (define-fun var740 () var1376
    var1376-init)
  (define-fun null-var1425 () var1425
    var1425!val!1)
  (define-fun var1355 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var1012 "/") (- 1))
                     (num_splits var1012 "/")
                     (- 1))
                (num_splits var1012 "/"))))
  (- a!1 1)))
  (define-fun var543 () Int
    0)
  (define-fun var740!2 () var1376
    var1376!val!0)
  (define-fun var1376-init () var1376
    var1376!val!0)
  (define-fun var1827!1 () var1425
    var1425!val!0)
  (define-fun arr-Int-init () (Array Int Int)
    ((as const (Array Int Int)) 0))
  (define-fun var740!1 () var1376
    var1376!val!0)
  (define-fun var2635!1 () (Array Int Int)
    ((as const (Array Int Int)) 0))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun var3173_hasEntryCaseInsensitive/-240204854 ((x!0 var3173)
   (x!1 String)) Bool
    false)
  (define-fun getWriteIndex/-178493442 ((x!0 var1376)) Int
    0)
  (define-fun var3173_createDocument/-450016166 ((x!0 var3173)
   (x!1 String)
   (x!2 Int)
   (x!3 var1468)) var3950
    var3950!val!0)
  (define-fun var335_bootstrap$/-1224113051 ((x!0 (Array Int Int))) var1468
    var1468!val!0)
  (define-fun <init>/-55681307 ((x!0 var1376) (x!1 (Array Int Int)) (x!2 Int)) void
    void!val!0)
  (define-fun var1425_write/-459365051 ((x!0 var1425) (x!1 var1376)) void
    void!val!0)
)
