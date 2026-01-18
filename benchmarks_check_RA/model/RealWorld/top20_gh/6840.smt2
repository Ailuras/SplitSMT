(
  ;; universe for var1128:
  ;;   var1128!val!1 var1128!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1128!val!1 () var1128)
  (declare-fun var1128!val!0 () var1128)
  ;; cardinality constraint:
  (forall ((x var1128)) (or (= x var1128!val!1) (= x var1128!val!0)))
  ;; -----------
  ;; universe for var1046:
  ;;   var1046!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1046!val!0 () var1046)
  ;; cardinality constraint:
  (forall ((x var1046)) (= x var1046!val!0))
  ;; -----------
  ;; universe for var924:
  ;;   var924!val!1 var924!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var924!val!1 () var924)
  (declare-fun var924!val!0 () var924)
  ;; cardinality constraint:
  (forall ((x var924)) (or (= x var924!val!1) (= x var924!val!0)))
  ;; -----------
  ;; universe for var3240:
  ;;   var3240!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3240!val!0 () var3240)
  ;; cardinality constraint:
  (forall ((x var3240)) (= x var3240!val!0))
  ;; -----------
  (define-fun var3677 () var3240
    var3240-init)
  (define-fun var3677!2 () var3240
    var3240!val!0)
  (define-fun var3477 () var1128
    var1128!val!0)
  (define-fun var726 () var1046
    var798-ISO_8859_1)
  (define-fun var659 () String
    var924-EOL)
  (define-fun var798-ISO_8859_1 () var1046
    var1046!val!0)
  (define-fun var2654 () String
    var1222)
  (define-fun var534 () Bool
    (omitComments/-1276310728 var2405))
  (define-fun null-String () String
    "A")
  (define-fun var227 () Int
    (let ((a!1 (< (num_splits_re (toString/-372517094 var3677!2 var798-ISO_8859_1)
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (toString/-372517094 var3677!2 var798-ISO_8859_1)
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re (toString/-372517094 var3677!2 var798-ISO_8859_1)
                      (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun null-var924 () var924
    var924!val!1)
  (define-fun var890 () String
    (toString/-372517094 var3677!2 var798-ISO_8859_1))
  (define-fun var2405 () var924
    var924!val!0)
  (define-fun var1222 () String
    "")
  (define-fun null-var1128 () var1128
    var1128!val!1)
  (define-fun var192 () Int
    0)
  (define-fun var2654!1 () String
    "")
  (define-fun var3240-init () var3240
    var3240!val!0)
  (define-fun var2405!1 () var924
    var924!val!1)
  (define-fun var3677!1 () var3240
    var3240!val!0)
  (define-fun var924-EOL () String
    "")
  (define-fun omitComments/-1276310728 ((x!0 var924)) Bool
    false)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun toString/-372517094 ((x!0 var3240) (x!1 var1046)) String
    "")
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
  (define-fun store/877702891 ((x!0 var2286) (x!1 var1128) (x!2 String)) void
    void!val!0)
  (define-fun cast-from-var924-to-var2286 ((x!0 var924)) var2286
    var2286!val!0)
  (define-fun <init>/-707998177 ((x!0 var3240)) void
    void!val!0)
  (define-fun cast-from-var3240-to-var1128 ((x!0 var3240)) var1128
    var1128!val!1)
)
