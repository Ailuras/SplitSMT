(
  ;; universe for Iterator:
  ;;   Iterator!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun Iterator!val!0 () Iterator)
  ;; cardinality constraint:
  (forall ((x Iterator)) (= x Iterator!val!0))
  ;; -----------
  ;; universe for var2050:
  ;;   var2050!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2050!val!0 () var2050)
  ;; cardinality constraint:
  (forall ((x var2050)) (= x var2050!val!0))
  ;; -----------
  ;; universe for var2754:
  ;;   var2754!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2754!val!0 () var2754)
  ;; cardinality constraint:
  (forall ((x var2754)) (= x var2754!val!0))
  ;; -----------
  ;; universe for var2366:
  ;;   var2366!val!0 var2366!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2366!val!0 () var2366)
  (declare-fun var2366!val!1 () var2366)
  ;; cardinality constraint:
  (forall ((x var2366)) (or (= x var2366!val!0) (= x var2366!val!1)))
  ;; -----------
  ;; universe for var523:
  ;;   var523!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var523!val!0 () var523)
  ;; cardinality constraint:
  (forall ((x var523)) (= x var523!val!0))
  ;; -----------
  (define-fun var3368 () String
    (getProperty/-469436802
  var260!1
  "generateTagsModel"
  "edu/stanford/nlp/models/pos-tagger/spanish-ud.tagger"))
  (define-fun var260!1 () var2366
    var2366!val!1)
  (define-fun var1015 () var2754
    (process/-2031771835 var2262!1))
  (define-fun var786 () var2050
    var523-argOptionDefs)
  (define-fun var2262!1 () var523
    var523!val!0)
  (define-fun var523-argOptionDefs () var2050
    var2050!val!0)
  (define-fun var78 () Bool
    (var3041_getBool/43227246 var260!1 "generateTags"))
  (define-fun var1893 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var1671 () Bool
    (Iterator_hasNext/-1669924200
  (var2754_iterator/-912451715 (process/-2031771835 var2262!1))))
  (define-fun var1761 () Int
    0)
  (define-fun var260 () var2366
    (var2103_argsToProperties/-1524630653 var1893 var523-argOptionDefs))
  (define-fun var3571 () Int
    (getLength-Arr-String-1 var1893))
  (define-fun var2190 () Bool
    (var3041_getBool/43227246 var260!1 "convertToUD"))
  (define-fun var2464 () var1698
    var1698-init)
  (define-fun null-__Array__Int__String__ () (Array Int String)
    ((as const (Array Int String)) " "))
  (define-fun var2262 () var523
    var523-init)
  (define-fun var214 () String
    (getProperty/1391780669
  (var2103_argsToProperties/-1524630653 var1893 var523-argOptionDefs)
  ""))
  (define-fun var644 () Iterator
    (var2754_iterator/-912451715 (process/-2031771835 var2262!1)))
  (define-fun var2147 () Int
    (let ((a!1 (< (num_splits_re (getProperty/1391780669
                               (var2103_argsToProperties/-1524630653
                                 var1893
                                 var523-argOptionDefs)
                               "")
                             (re.+ (str.to_re " ")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (getProperty/1391780669
                                 (var2103_argsToProperties/-1524630653
                                   var1893
                                   var523-argOptionDefs)
                                 "")
                               (re.+ (str.to_re " ")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re (getProperty/1391780669
                        (var2103_argsToProperties/-1524630653
                          var1893
                          var523-argOptionDefs)
                        "")
                      (re.+ (str.to_re " ")))))))
  (define-fun var1698-init () var1698
    var1698!val!0)
  (define-fun var2464!1 () var1698
    var1698!val!0)
  (define-fun var2464!2 () var1698
    var1698!val!0)
  (define-fun var523-init () var523
    var523!val!0)
  (define-fun getLength-Arr-String-1 ((x!0 (Array Int String))) Int
    1)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun process/-2031771835 ((x!0 var523)) var2754
    var2754!val!0)
  (define-fun var2103_argsToProperties/-1524630653 ((x!0 (Array Int String))
   (x!1 var2050)) var2366
    var2366!val!0)
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
  (define-fun var2754_iterator/-912451715 ((x!0 var2754)) Iterator
    Iterator!val!0)
  (define-fun getProperty/1391780669 ((x!0 var2366) (x!1 String)) String
    "")
  (define-fun Iterator_hasNext/-1669924200 ((x!0 Iterator)) Bool
    false)
  (define-fun var3041_getBool/43227246 ((x!0 var2366) (x!1 String)) Bool
    false)
  (define-fun <init>/-325640736 ((x!0 var1698)) void
    void!val!0)
  (define-fun getProperty/-469436802 ((x!0 var2366) (x!1 String) (x!2 String)) String
    "")
  (define-fun <init>/1278683649 ((x!0 var523) (x!1 var2754) (x!2 var2366)) void
    void!val!0)
  (define-fun cast-from-var1698-to-var2754 ((x!0 var1698)) var2754
    var2754!val!0)
)
