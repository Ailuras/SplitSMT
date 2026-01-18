(
  ;; universe for var456:
  ;;   var456!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var456!val!0 () var456)
  ;; cardinality constraint:
  (forall ((x var456)) (= x var456!val!0))
  ;; -----------
  ;; universe for var2499:
  ;;   var2499!val!0 var2499!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2499!val!0 () var2499)
  (declare-fun var2499!val!1 () var2499)
  ;; cardinality constraint:
  (forall ((x var2499)) (or (= x var2499!val!0) (= x var2499!val!1)))
  ;; -----------
  ;; universe for var2039:
  ;;   var2039!val!1 var2039!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2039!val!1 () var2039)
  (declare-fun var2039!val!0 () var2039)
  ;; cardinality constraint:
  (forall ((x var2039)) (or (= x var2039!val!1) (= x var2039!val!0)))
  ;; -----------
  ;; universe for var3937:
  ;;   var3937!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3937!val!0 () var3937)
  ;; cardinality constraint:
  (forall ((x var3937)) (= x var3937!val!0))
  ;; -----------
  (define-fun var1886 () String
    null-String)
  (define-fun var1797 () var456
    var102-ISO_8859_1)
  (define-fun var1728 () var2039
    var2039!val!0)
  (define-fun var2977 () Bool
    (omitComments/-1276310728 var2906))
  (define-fun var1296!2 () var3937
    var3937!val!0)
  (define-fun var102-ISO_8859_1 () var456
    var456!val!0)
  (define-fun var87 () String
    (toString/-372517094 var1296!2 var102-ISO_8859_1))
  (define-fun null-String () String
    "A")
  (define-fun var125 () String
    var2499-EOL)
  (define-fun null-var2499 () var2499
    var2499!val!1)
  (define-fun var2021 () String
    "")
  (define-fun var1296 () var3937
    var3937-init)
  (define-fun var1566 () Int
    0)
  (define-fun var2906 () var2499
    var2499!val!0)
  (define-fun null-var2039 () var2039
    var2039!val!1)
  (define-fun var2293 () Int
    (let ((a!1 (< (num_splits_re (toString/-372517094 var1296!2 var102-ISO_8859_1)
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (toString/-372517094 var1296!2 var102-ISO_8859_1)
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re (toString/-372517094 var1296!2 var102-ISO_8859_1)
                      (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun var1886!1 () String
    "")
  (define-fun var3937-init () var3937
    var3937!val!0)
  (define-fun var2499-EOL () String
    "")
  (define-fun var2906!1 () var2499
    var2499!val!0)
  (define-fun var1296!1 () var3937
    var3937!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun omitComments/-1276310728 ((x!0 var2499)) Bool
    true)
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
  (define-fun toString/-372517094 ((x!0 var3937) (x!1 var456)) String
    "")
  (define-fun cast-from-var2499-to-var48 ((x!0 var2499)) var48
    var48!val!0)
  (define-fun store/877702891 ((x!0 var48) (x!1 var2039) (x!2 String)) void
    void!val!0)
  (define-fun <init>/-707998177 ((x!0 var3937)) void
    void!val!0)
  (define-fun cast-from-var3937-to-var2039 ((x!0 var3937)) var2039
    var2039!val!1)
)
