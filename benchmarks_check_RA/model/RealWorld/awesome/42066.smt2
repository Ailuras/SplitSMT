(
  ;; universe for var767:
  ;;   var767!val!0 var767!val!1 var767!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var767!val!0 () var767)
  (declare-fun var767!val!1 () var767)
  (declare-fun var767!val!2 () var767)
  ;; cardinality constraint:
  (forall ((x var767))
          (or (= x var767!val!0) (= x var767!val!1) (= x var767!val!2)))
  ;; -----------
  ;; universe for var3360:
  ;;   var3360!val!0 var3360!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3360!val!0 () var3360)
  (declare-fun var3360!val!1 () var3360)
  ;; cardinality constraint:
  (forall ((x var3360)) (or (= x var3360!val!0) (= x var3360!val!1)))
  ;; -----------
  (define-fun var2289 () (Array Int var767)
    arr-var767-init)
  (define-fun var2073 () String
    (let ((a!1 (ite (< (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                    var2838
                                    "utf-8")
                                  (str.to_re "\u{a}"))
                   (- 1))
                (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                 var2838
                                 "utf-8")
                               (str.to_re "\u{a}"))
                (- 1))))
(let ((a!2 (str.from_int (ite (> (- 1) 0)
                              a!1
                              (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                               var2838
                                               "utf-8")
                                             (str.to_re "\u{a}"))))))
  (str.++ var3441!1 "  " var2838 ": " a!2))))
  (define-fun var3441 () String
    String-init)
  (define-fun var1646 () String
    (str.++ var3441!1 "  " var2838 ": "))
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var2615 () String
    (let ((a!1 (ite (< (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                    var2838
                                    "utf-8")
                                  (str.to_re "\u{a}"))
                   (- 1))
                (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                 var2838
                                 "utf-8")
                               (str.to_re "\u{a}"))
                (- 1))))
(let ((a!2 (str.from_int (ite (> (- 1) 0)
                              a!1
                              (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                               var2838
                                               "utf-8")
                                             (str.to_re "\u{a}"))))))
  (str.++ var3441!1 "  " var2838 ": " a!2 " entries"))))
  (define-fun var1900 () String
    (str.++ var3441!1 "  "))
  (define-fun var2755 () Int
    (let ((a!1 (ite (< (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                    var2838
                                    "utf-8")
                                  (str.to_re "\u{a}"))
                   (- 1))
                (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                 var2838
                                 "utf-8")
                               (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits_re (var1231_slurpFileNoExceptions/834711247 var2838 "utf-8")
                      (str.to_re "\u{a}")))))
  (define-fun null-__Array__Int__var767__ () (Array Int var767)
    ((as const (Array Int var767)) var767!val!2))
  (define-fun var3471 () String
    (let ((a!1 (ite (< (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                    var2838
                                    "utf-8")
                                  (str.to_re "\u{a}"))
                   (- 1))
                (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                 var2838
                                 "utf-8")
                               (str.to_re "\u{a}"))
                (- 1))))
(let ((a!2 (str.from_int (ite (> (- 1) 0)
                              a!1
                              (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                               var2838
                                               "utf-8")
                                             (str.to_re "\u{a}"))))))
  (str.++ var3441!1 "  " var2838 ": " a!2 " entries"))))
  (define-fun null-var3360 () var3360
    var3360!val!1)
  (define-fun null-String () String
    "utf-8")
  (define-fun var1646!1 () String
    "  : ")
  (define-fun var2289!1 () (Array Int var767)
    (store ((as const (Array Int var767)) var767!val!0) 10 var767!val!1))
  (define-fun var2838 () String
    "")
  (define-fun var3677 () Bool
    true)
  (define-fun var1096 () Int
    0)
  (define-fun var2022 () String
    (var1231_slurpFileNoExceptions/834711247 var2838 "utf-8"))
  (define-fun var1132 () var1514
    var3360-logger)
  (define-fun var3969 () String
    (str.++ var3441!1 "  " var2838))
  (define-fun var593 () var3360
    var3360!val!0)
  (define-fun var1257 () Int
    (let ((a!1 (ite (< (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                    var2838
                                    "utf-8")
                                  (str.to_re "\u{a}"))
                   (- 1))
                (num_splits_re (var1231_slurpFileNoExceptions/834711247
                                 var2838
                                 "utf-8")
                               (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits_re (var1231_slurpFileNoExceptions/834711247 var2838 "utf-8")
                      (str.to_re "\u{a}")))))
  (define-fun null-Bool () Bool
    false)
  (define-fun var2073!1 () String
    "  :  entries")
  (define-fun var3969!1 () String
    "  : ")
  (define-fun var3441!2 () String
    "  ")
  (define-fun var1900!1 () String
    "  ")
  (define-fun var3441!1 () String
    "")
  (define-fun arr-var767-init () (Array Int var767)
    ((as const (Array Int var767)) var767!val!0))
  (define-fun var1132!1 () var1514
    var1514!val!0)
  (define-fun var3360-logger () var1514
    var1514!val!0)
  (define-fun var2289!2 () (Array Int var767)
    ((as const (Array Int var767)) var767!val!0))
  (define-fun String-init () String
    "")
  (define-fun var1231_slurpFileNoExceptions/834711247 ((x!0 String) (x!1 String)) String
    " ")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    (- 2))
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun cast-from-String-to-var767 ((x!0 String)) var767
    var767!val!0)
  (define-fun info/-657332264 ((x!0 var1514) (x!1 (Array Int var767))) void
    void!val!0)
)
