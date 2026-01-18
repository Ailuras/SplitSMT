(
  ;; universe for var2682:
  ;;   var2682!val!2 var2682!val!0 var2682!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2682!val!2 () var2682)
  (declare-fun var2682!val!0 () var2682)
  (declare-fun var2682!val!1 () var2682)
  ;; cardinality constraint:
  (forall ((x var2682))
          (or (= x var2682!val!2) (= x var2682!val!0) (= x var2682!val!1)))
  ;; -----------
  ;; universe for var184:
  ;;   var184!val!1 var184!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var184!val!1 () var184)
  (declare-fun var184!val!0 () var184)
  ;; cardinality constraint:
  (forall ((x var184)) (or (= x var184!val!1) (= x var184!val!0)))
  ;; -----------
  ;; universe for var3631:
  ;;   var3631!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3631!val!0 () var3631)
  ;; cardinality constraint:
  (forall ((x var3631)) (= x var3631!val!0))
  ;; -----------
  ;; universe for var3543:
  ;;   var3543!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3543!val!0 () var3543)
  ;; cardinality constraint:
  (forall ((x var3543)) (= x var3543!val!0))
  ;; -----------
  ;; universe for var3519:
  ;;   var3519!val!0 var3519!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3519!val!0 () var3519)
  (declare-fun var3519!val!1 () var3519)
  ;; cardinality constraint:
  (forall ((x var3519)) (or (= x var3519!val!0) (= x var3519!val!1)))
  ;; -----------
  (define-fun var80 () Bool
    (str.contains var1505-numWordsCompound ","))
  (define-fun var709 () String
    var1505-numWordsCompound)
  (define-fun var1505-numWordsCompound () String
    ",")
  (define-fun var1420 () Bool
    (equals/1194252418
  (cast-from-var2682-to-var3631 var3230)
  (cast-from-var2682-to-var3543 var2682-SURFACE)))
  (define-fun var3667 () String
    var1505-numWordsCompound)
  (define-fun var1610 () var184
    var184!val!0)
  (define-fun var3423 () Int
    0)
  (define-fun var3230 () var2682
    var2682!val!0)
  (define-fun null-var184 () var184
    var184!val!1)
  (define-fun var2682-SURFACE () var2682
    var2682!val!2)
  (define-fun var87 () Int
    0)
  (define-fun var2088 () var3519
    var3519!val!0)
  (define-fun null-var2682 () var2682
    var2682!val!1)
  (define-fun var1102 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1505-numWordsCompound ";") (- 1))
          (num_splits var1505-numWordsCompound ";")
          (- 1))
     (num_splits var1505-numWordsCompound ";")))
  (define-fun var3304 () var2682
    var2682-SURFACE)
  (define-fun null-var3519 () var3519
    var3519!val!1)
  (define-fun var1505!class () ClassObject
    ClassObject!val!0)
  (define-fun var2088!1 () var3519
    var3519!val!0)
  (define-fun var2088!2 () var3519
    var3519!val!0)
  (define-fun var2764 () ClassObject
    ClassObject!val!0)
  (define-fun cast-from-var2682-to-var3631 ((x!0 var2682)) var3631
    var3631!val!0)
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
  (define-fun equals/1194252418 ((x!0 var3631) (x!1 var3543)) Bool
    true)
  (define-fun cast-from-var2682-to-var3543 ((x!0 var2682)) var3543
    var3543!val!0)
  (define-fun var478_setUp/-1798686479 ((x!0 var3519)) void
    void!val!0)
  (define-fun var448_fillOptions/-926000568 ((x!0 ClassObject) (x!1 var3519)) void
    void!val!0)
)
