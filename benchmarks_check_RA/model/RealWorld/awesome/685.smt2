(
  ;; universe for var1897:
  ;;   var1897!val!0 var1897!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1897!val!0 () var1897)
  (declare-fun var1897!val!1 () var1897)
  ;; cardinality constraint:
  (forall ((x var1897)) (or (= x var1897!val!0) (= x var1897!val!1)))
  ;; -----------
  (define-fun var1342 () String
    (entitySubclassification/-179725236 (flags/769901519 var1451)))
  (define-fun null-String () String
    "")
  (define-fun var2057 () Bool
    (intern/-179725236 (flags/769901519 var1451)))
  (define-fun var740 () String
    "\u{a}")
  (define-fun var3816 () var3458
    (flags/769901519 var1451))
  (define-fun var930 () Int
    0)
  (define-fun var3377 () var2615
    var2615-init)
  (define-fun null-var1897 () var1897
    var1897!val!1)
  (define-fun var3194 () String
    (backgroundSymbol/-179725236 (flags/769901519 var1451)))
  (define-fun var2280 () Int
    (let ((a!1 (ite (< (num_splits_re var740 (str.to_re "\u{a}")) (- 1))
                (num_splits_re var740 (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var740 (str.to_re "\u{a}")))))
  (define-fun var3321 () var3458
    (flags/769901519 var1451))
  (define-fun var3896 () var3458
    (flags/769901519 var1451))
  (define-fun var1451 () var1897
    var1897!val!0)
  (define-fun var3377!2 () var2615
    var2615!val!0)
  (define-fun var1476!class () ClassObject
    ClassObject!val!0)
  (define-fun var1501 () ClassObject
    ClassObject!val!0)
  (define-fun var1342!1 () String
    "")
  (define-fun var3377!1 () var2615
    var2615!val!0)
  (define-fun var2615-init () var2615
    var2615!val!0)
  (define-fun var3194!1 () String
    "")
  (define-fun var2057!1 () Bool
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
  (define-fun <init>/-325640736 ((x!0 var2615)) void
    void!val!0)
  (define-fun backgroundSymbol/-179725236 ((x!0 var3458)) String
    "")
  (define-fun cast-from-var2615-to-var3151 ((x!0 var2615)) var3151
    var3151!val!0)
  (define-fun entitySubclassification/-179725236 ((x!0 var3458)) String
    "")
  (define-fun var1560_entitySubclassify/209045334 ((x!0 var3151)
   (x!1 ClassObject)
   (x!2 String)
   (x!3 String)
   (x!4 Bool)) void
    void!val!0)
  (define-fun flags/769901519 ((x!0 var1897)) var3458
    var3458!val!0)
  (define-fun intern/-179725236 ((x!0 var3458)) Bool
    false)
)
