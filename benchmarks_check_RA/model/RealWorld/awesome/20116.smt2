(
  ;; universe for var2513:
  ;;   var2513!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2513!val!0 () var2513)
  ;; cardinality constraint:
  (forall ((x var2513)) (= x var2513!val!0))
  ;; -----------
  ;; universe for Iterator:
  ;;   Iterator!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun Iterator!val!0 () Iterator)
  ;; cardinality constraint:
  (forall ((x Iterator)) (= x Iterator!val!0))
  ;; -----------
  ;; universe for var327:
  ;;   var327!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var327!val!0 () var327)
  ;; cardinality constraint:
  (forall ((x var327)) (= x var327!val!0))
  ;; -----------
  ;; universe for var58:
  ;;   var58!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var58!val!0 () var58)
  ;; cardinality constraint:
  (forall ((x var58)) (= x var58!val!0))
  ;; -----------
  ;; universe for var1969:
  ;;   var1969!val!0 var1969!val!1 var1969!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1969!val!0 () var1969)
  (declare-fun var1969!val!1 () var1969)
  (declare-fun var1969!val!2 () var1969)
  ;; cardinality constraint:
  (forall ((x var1969))
          (or (= x var1969!val!0) (= x var1969!val!1) (= x var1969!val!2)))
  ;; -----------
  ;; universe for var1865:
  ;;   var1865!val!2 var1865!val!0 var1865!val!1 var1865!val!3 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1865!val!2 () var1865)
  (declare-fun var1865!val!0 () var1865)
  (declare-fun var1865!val!1 () var1865)
  (declare-fun var1865!val!3 () var1865)
  ;; cardinality constraint:
  (forall ((x var1865))
          (or (= x var1865!val!2)
              (= x var1865!val!0)
              (= x var1865!val!1)
              (= x var1865!val!3)))
  ;; -----------
  (define-fun var1994 () var1865
    var1865!val!0)
  (define-fun null-var1865 () var1865
    var1865!val!1)
  (define-fun var859 () var797
    var797-init)
  (define-fun var851 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1279 ";") (- 1)) (num_splits var1279 ";") (- 1))
     (num_splits var1279 ";")))
  (define-fun var1014 () var58
    var2715_newHashMap/701256970)
  (define-fun var484 () Iterator
    (iterator/1890858564 (var2513_getLineIterator/915635313 var2149!1)))
  (define-fun var679 () var58
    (lexicon/-613054603 var1994!2))
  (define-fun var1279 () String
    ";")
  (define-fun var2149!1 () var327
    var327!val!0)
  (define-fun var3705 () Int
    1)
  (define-fun var863 () String
    (cast-from-var1969-to-String
  (var58_getOrDefault/-573460120
    (lexicon/-613054603 var1994!2)
    (cast-from-String-to-var1969 "<unk>")
    (cast-from-String-to-var1969 "null"))))
  (define-fun var1649 () var1969
    (var58_getOrDefault/-573460120
  (lexicon/-613054603 var1994!2)
  (cast-from-String-to-var1969 "<unk>")
  (cast-from-String-to-var1969 "null")))
  (define-fun var2149 () var327
    var327-init)
  (define-fun null-String () String
    "<unk>")
  (define-fun var929 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1279 ";") (- 1)))))
  (ite a!1 (split_rest var1279 ";" (- (- 1) 1)) (split_at var1279 ";" 0))))
  (define-fun var1994!3 () var1865
    var1865!val!3)
  (define-fun var3707 () var2513
    (var2513_getLineIterator/915635313 var2149!1))
  (define-fun var1994!2 () var1865
    var1865!val!2)
  (define-fun var1684 () Bool
    (Iterator_hasNext/-1669924200
  (iterator/1890858564 (var2513_getLineIterator/915635313 var2149!1))))
  (define-fun var2715_newHashMap/701256970 () var58
    var58!val!0)
  (define-fun var859!1 () var797
    var797!val!0)
  (define-fun var929!1 () String
    "")
  (define-fun var1994!1 () var1865
    var1865!val!2)
  (define-fun var327-init () var327
    var327!val!0)
  (define-fun var797-init () var797
    var797!val!0)
  (define-fun iterator/1890858564 ((x!0 var2513)) Iterator
    Iterator!val!0)
  (define-fun cast-from-String-to-var1969 ((x!0 String)) var1969
    (ite (= x!0
            (str.++ (seq.unit (_ Char 110))
                    (seq.unit (_ Char 117))
                    (seq.unit (_ Char 108))
                    (seq.unit (_ Char 108))))
      var1969!val!1
      var1969!val!0))
  (define-fun var2513_getLineIterator/915635313 ((x!0 var327)) var2513
    var2513!val!0)
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
  (define-fun var58_getOrDefault/-573460120 ((x!0 var58)
   (x!1 var1969)
   (x!2 var1969)) var1969
    var1969!val!2)
  (define-fun Iterator_hasNext/-1669924200 ((x!0 Iterator)) Bool
    false)
  (define-fun unk/-613054603 ((x!0 var1865)) String
    "!0!")
  (define-fun cast-from-var1969-to-String ((x!0 var1969)) String
    "!0!")
  (define-fun lexicon/-613054603 ((x!0 var1865)) var58
    var58!val!0)
  (define-fun <init>/272540643 ((x!0 var797)) void
    void!val!0)
  (define-fun cast-from-var1865-to-var1969 ((x!0 var1865)) var1969
    var1969!val!0)
  (define-fun <init>/-1681595970 ((x!0 var327) (x!1 String)) void
    void!val!0)
  (define-fun <init>/-279557996 ((x!0 var1969)) void
    void!val!0)
)
