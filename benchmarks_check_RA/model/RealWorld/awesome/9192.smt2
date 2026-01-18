(
  ;; universe for var72:
  ;;   var72!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var72!val!0 () var72)
  ;; cardinality constraint:
  (forall ((x var72)) (= x var72!val!0))
  ;; -----------
  ;; universe for var1264:
  ;;   var1264!val!1 var1264!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1264!val!1 () var1264)
  (declare-fun var1264!val!0 () var1264)
  ;; cardinality constraint:
  (forall ((x var1264)) (or (= x var1264!val!1) (= x var1264!val!0)))
  ;; -----------
  ;; universe for var1699:
  ;;   var1699!val!1 var1699!val!2 var1699!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1699!val!1 () var1699)
  (declare-fun var1699!val!2 () var1699)
  (declare-fun var1699!val!0 () var1699)
  ;; cardinality constraint:
  (forall ((x var1699))
          (or (= x var1699!val!1) (= x var1699!val!2) (= x var1699!val!0)))
  ;; -----------
  (define-fun var2212 () String
    String-init)
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var3966 () Int
    (+ 0 1))
  (define-fun var3996 () Int
    (let ((a!1 (num_splits_re (getOutput/-1207014030
                            (cast-from-var1264-to-var72 var3528))
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var309 () String
    (str.++ var2212!1
        "in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n"))
  (define-fun var3559 () String
    (getOutput/-1207014030 (cast-from-var1264-to-var72 var3528)))
  (define-fun var850 () var1036
    var1264-log)
  (define-fun null-__Array__Int__var1699__ () (Array Int var1699)
    ((as const (Array Int var1699)) var1699!val!2))
  (define-fun var964 () Int
    (let ((a!1 (num_splits_re (getOutput/-1207014030
                            (cast-from-var1264-to-var72 var3528))
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var3518 () String
    (str.++ var2212!1
        "in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n"
        (getOutput/-1207014030 (cast-from-var1264-to-var72 var3528))))
  (define-fun var1732 () String
    (str.++ var2212!1
        "in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n"
        (getOutput/-1207014030 (cast-from-var1264-to-var72 var3528))))
  (define-fun var3528 () var1264
    var1264!val!0)
  (define-fun null-var1264 () var1264
    var1264!val!1)
  (define-fun var3825!1 () (Array Int var1699)
    (store ((as const (Array Int var1699)) var1699!val!0) 2 var1699!val!1))
  (define-fun var3825 () (Array Int var1699)
    arr-var1699-init)
  (define-fun var3096 () Int
    0)
  (define-fun var2212!2 () String
    "in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n")
  (define-fun var2212!1 () String
    "")
  (define-fun var309!1 () String
    "in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n!0!")
  (define-fun var850!1 () var1036
    var1036!val!0)
  (define-fun var3825!2 () (Array Int var1699)
    ((as const (Array Int var1699)) var1699!val!0))
  (define-fun String-init () String
    "")
  (define-fun arr-var1699-init () (Array Int var1699)
    ((as const (Array Int var1699)) var1699!val!0))
  (define-fun var1264-log () var1036
    var1036!val!0)
  (define-fun cast-from-String-to-var1699 ((x!0 String)) var1699
    var1699!val!0)
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
  (define-fun getOutput/-1207014030 ((x!0 var72)) String
    "!0!")
  (define-fun cast-from-var1264-to-var72 ((x!0 var1264)) var72
    var72!val!0)
  (define-fun error/-1794152874 ((x!0 var1036) (x!1 (Array Int var1699))) void
    void!val!0)
)
