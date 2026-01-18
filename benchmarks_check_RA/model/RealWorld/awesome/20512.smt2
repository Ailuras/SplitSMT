(
  ;; universe for var3763:
  ;;   var3763!val!0 var3763!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3763!val!0 () var3763)
  (declare-fun var3763!val!1 () var3763)
  ;; cardinality constraint:
  (forall ((x var3763)) (or (= x var3763!val!0) (= x var3763!val!1)))
  ;; -----------
  (define-fun var3485 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2182-allowedTagsForTrigger "[,;]") (- 1))
          (num_splits var2182-allowedTagsForTrigger "[,;]")
          (- 1))
     (num_splits var2182-allowedTagsForTrigger "[,;]")))
  (define-fun var2182-ignoreRels () String
    "[,;]")
  (define-fun var527 () String
    var2182-ignoreRels)
  (define-fun var2432 () String
    var2182-allowedTagsForTrigger)
  (define-fun var2374 () var3763
    var3763!val!0)
  (define-fun var2182-allowedTagsForTrigger () String
    "[")
  (define-fun var1395 () Int
    0)
  (define-fun var2137 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2182-ignoreRels "[,;]") (- 1))
          (num_splits var2182-ignoreRels "[,;]")
          (- 1))
     (num_splits var2182-ignoreRels "[,;]")))
  (define-fun var3780 () Int
    0)
  (define-fun null-var3763 () var3763
    var3763!val!1)
  (define-fun var941 () ClassObject
    ClassObject!val!0)
  (define-fun var3951 () ClassObject
    ClassObject!val!0)
  (define-fun var2374!1 () var3763
    var3763!val!0)
  (define-fun var3356!class () ClassObject
    ClassObject!val!0)
  (define-fun var2374!2 () var3763
    var3763!val!0)
  (define-fun var2182!class () ClassObject
    ClassObject!val!0)
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
  (define-fun var1099_fillOptions/-926000568 ((x!0 ClassObject) (x!1 var3763)) void
    void!val!0)
)
