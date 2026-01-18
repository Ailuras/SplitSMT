(
  (define-fun var627 () var3336
    (var3971_get/1088891777
  var1252_newHashMap/701256970
  (cast-from-String-to-var3336 "word")))
  (define-fun var2625 () Int
    (- (str.len var3291) 1))
  (define-fun var415 () var3971
    var1252_newHashMap/701256970)
  (define-fun var2797 () String
    (cast-from-var3336-to-String
  (var3971_get/1088891777
    var1252_newHashMap/701256970
    (cast-from-String-to-var3336 "POS"))))
  (define-fun var3038 () Int
    (str.len var3291))
  (define-fun var1542 () Int
    (let ((a!1 (str.substr var3291 1 (- (- (str.len var3291) 1) 1))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!1 " ") (- 1)) (num_splits a!1 " ") (- 1))
       (num_splits a!1 " "))))
  (define-fun var2658 () var3336
    (var3971_get/1088891777
  var1252_newHashMap/701256970
  (cast-from-String-to-var3336 "POS")))
  (define-fun var2725 () String
    (cast-from-var3336-to-String
  (var3971_get/1088891777
    var1252_newHashMap/701256970
    (cast-from-String-to-var3336 "lemma"))))
  (define-fun var2743 () var3336
    (var3971_get/1088891777
  var1252_newHashMap/701256970
  (cast-from-String-to-var3336 "current")))
  (define-fun var3513 () var3336
    (var3971_get/1088891777
  var1252_newHashMap/701256970
  (cast-from-String-to-var3336 "lemma")))
  (define-fun var460 () Int
    0)
  (define-fun var161 () String
    (cast-from-var3336-to-String
  (var3971_get/1088891777
    var1252_newHashMap/701256970
    (cast-from-String-to-var3336 "value"))))
  (define-fun var740 () String
    (cast-from-var3336-to-String
  (var3971_get/1088891777
    var1252_newHashMap/701256970
    (cast-from-String-to-var3336 "current"))))
  (define-fun null-String () String
    " ")
  (define-fun var964 () String
    (str.substr var3291 1 (- (- (str.len var3291) 1) 1)))
  (define-fun var2035 () String
    (cast-from-var3336-to-String
  (var3971_get/1088891777
    var1252_newHashMap/701256970
    (cast-from-String-to-var3336 "word"))))
  (define-fun var1412 () var3861
    var3861-init)
  (define-fun var2581 () var3336
    (var3971_get/1088891777
  var1252_newHashMap/701256970
  (cast-from-String-to-var3336 "value")))
  (define-fun var3291 () String
    "AB")
  (define-fun var2725!1 () String
    "")
  (define-fun var1412!2 () var3861
    var3861!val!0)
  (define-fun var1252_newHashMap/701256970 () var3971
    var3971!val!0)
  (define-fun var2035!1 () String
    "")
  (define-fun var740!1 () String
    "")
  (define-fun var2797!1 () String
    "")
  (define-fun var1412!5 () var3861
    var3861!val!0)
  (define-fun var1412!4 () var3861
    var3861!val!0)
  (define-fun var3861-init () var3861
    var3861!val!0)
  (define-fun var1412!1 () var3861
    var3861!val!0)
  (define-fun var1412!6 () var3861
    var3861!val!0)
  (define-fun var161!1 () String
    "")
  (define-fun var1412!3 () var3861
    var3861!val!0)
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
  (define-fun var3971_get/1088891777 ((x!0 var3971) (x!1 var3336)) var3336
    var3336!val!0)
  (define-fun cast-from-String-to-var3336 ((x!0 String)) var3336
    var3336!val!0)
  (define-fun setValue/-1305364003 ((x!0 var3861) (x!1 String)) void
    void!val!0)
  (define-fun setLemma/-2044772538 ((x!0 var3861) (x!1 String)) void
    void!val!0)
  (define-fun setOriginalText/-1052378824 ((x!0 var3861) (x!1 String)) void
    void!val!0)
  (define-fun <init>/379364885 ((x!0 var3861)) void
    void!val!0)
  (define-fun cast-from-var3336-to-String ((x!0 var3336)) String
    "")
  (define-fun setTag/-492450796 ((x!0 var3861) (x!1 String)) void
    void!val!0)
  (define-fun setWord/1927702860 ((x!0 var3861) (x!1 String)) void
    void!val!0)
)
