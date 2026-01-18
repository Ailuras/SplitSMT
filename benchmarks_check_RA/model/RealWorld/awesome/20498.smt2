(
  ;; universe for var2823:
  ;;   var2823!val!1 var2823!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2823!val!1 () var2823)
  (declare-fun var2823!val!0 () var2823)
  ;; cardinality constraint:
  (forall ((x var2823)) (or (= x var2823!val!1) (= x var2823!val!0)))
  ;; -----------
  ;; universe for var3244:
  ;;   var3244!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3244!val!0 () var3244)
  ;; cardinality constraint:
  (forall ((x var3244)) (= x var3244!val!0))
  ;; -----------
  ;; universe for var2009:
  ;;   var2009!val!1 var2009!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2009!val!1 () var2009)
  (declare-fun var2009!val!0 () var2009)
  ;; cardinality constraint:
  (forall ((x var2009)) (or (= x var2009!val!1) (= x var2009!val!0)))
  ;; -----------
  ;; universe for var1730:
  ;;   var1730!val!1 var1730!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1730!val!1 () var1730)
  (declare-fun var1730!val!0 () var1730)
  ;; cardinality constraint:
  (forall ((x var1730)) (or (= x var1730!val!1) (= x var1730!val!0)))
  ;; -----------
  ;; universe for var3023:
  ;;   var3023!val!2 var3023!val!3 var3023!val!1 var3023!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3023!val!2 () var3023)
  (declare-fun var3023!val!3 () var3023)
  (declare-fun var3023!val!1 () var3023)
  (declare-fun var3023!val!0 () var3023)
  ;; cardinality constraint:
  (forall ((x var3023))
          (or (= x var3023!val!2)
              (= x var3023!val!3)
              (= x var3023!val!1)
              (= x var3023!val!0)))
  ;; -----------
  (define-fun var2040 () var3023
    var3023-SURFACE)
  (define-fun var1337-numWordsCompound () String
    ",")
  (define-fun var1604 () var2009
    var2009!val!0)
  (define-fun var3481 () var3023
    var3023-DEP)
  (define-fun var2936 () Bool
    (equals/1194252418
  (cast-from-var3023-to-var3244 var779)
  (cast-from-var3023-to-var1730 var3023-DEP)))
  (define-fun null-var3023 () var3023
    var3023!val!1)
  (define-fun var455 () String
    var1337-numWordsCompound)
  (define-fun var3023-DEP () var3023
    var3023!val!3)
  (define-fun var2832 () var3282
    var3282-init)
  (define-fun var1841 () String
    var1337-numWordsCompound)
  (define-fun var1958 () Int
    0)
  (define-fun null-var2009 () var2009
    var2009!val!1)
  (define-fun var3023-SURFACE () var3023
    var3023!val!2)
  (define-fun var632 () Bool
    (equals/1194252418
  (cast-from-var3023-to-var3244 var779)
  (cast-from-var3023-to-var1730 var3023-SURFACE)))
  (define-fun var1151 () Int
    0)
  (define-fun var3243 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1337-numWordsCompound ";") (- 1))
          (num_splits var1337-numWordsCompound ";")
          (- 1))
     (num_splits var1337-numWordsCompound ";")))
  (define-fun var209 () Bool
    (str.contains var1337-numWordsCompound ","))
  (define-fun null-var2823 () var2823
    var2823!val!1)
  (define-fun var3260 () var2823
    var2823!val!0)
  (define-fun var779 () var3023
    var3023!val!0)
  (define-fun var1604!1 () var2009
    var2009!val!1)
  (define-fun var1332 () ClassObject
    ClassObject!val!0)
  (define-fun var1337!class () ClassObject
    ClassObject!val!0)
  (define-fun var2832!1 () var3282
    var3282!val!0)
  (define-fun var3282-init () var3282
    var3282!val!0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun cast-from-var3023-to-var3244 ((x!0 var3023)) var3244
    var3244!val!0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun equals/1194252418 ((x!0 var3244) (x!1 var1730)) Bool
    false)
  (define-fun cast-from-var3023-to-var1730 ((x!0 var3023)) var1730
    (ite (= x!0 var3023!val!3) var1730!val!1
      var1730!val!0))
  (define-fun <init>/-1040522254 ((x!0 var3282)) void
    void!val!0)
  (define-fun var1673_fillOptions/-926000568 ((x!0 ClassObject) (x!1 var2009)) void
    void!val!0)
)
