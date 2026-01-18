(
  ;; universe for var1577:
  ;;   var1577!val!1 var1577!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1577!val!1 () var1577)
  (declare-fun var1577!val!0 () var1577)
  ;; cardinality constraint:
  (forall ((x var1577)) (or (= x var1577!val!1) (= x var1577!val!0)))
  ;; -----------
  ;; universe for var2691:
  ;;   var2691!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2691!val!0 () var2691)
  ;; cardinality constraint:
  (forall ((x var2691)) (= x var2691!val!0))
  ;; -----------
  (define-fun var2994 () String
    " ")
  (define-fun var2082 () var1708
    var1708-init)
  (define-fun var2077 () String
    "")
  (define-fun var1221 () Bool
    (var2691_access$000/1195809519 (this$0/-508771627 var843)))
  (define-fun var2801 () String
    (var150_quote/811834350 ">>>"))
  (define-fun var740 () Int
    (let ((a!1 (num_splits_re var2994
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var3458 () Int
    (let ((a!1 (num_splits_re var2994
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var3777 () var2691
    (this$0/-508771627 var843))
  (define-fun var757 () var2691
    (this$0/-508771627 var843))
  (define-fun null-String () String
    "|||")
  (define-fun var2100 () String
    (var150_quote/811834350 "|||"))
  (define-fun var2522 () Int
    0)
  (define-fun null-var1577 () var1577
    var1577!val!1)
  (define-fun var1233 () Bool
    (var2691_access$300/-390947598 (this$0/-508771627 var843)))
  (define-fun var537 () String
    (let ((a!1 (num_splits_re var2994
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))))
      (a!3 (split_rest_re var2994
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))
                          (- (- 1) 1)))
      (a!4 (split_at_re var2994
                        (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))
                        0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
  (ite a!2 a!3 a!4))))
  (define-fun var3205 () var2691
    (this$0/-508771627 var843))
  (define-fun var1867 () Bool
    var1577-$assertionsDisabled)
  (define-fun var569 () var285
    var285-init)
  (define-fun var843 () var1577
    var1577!val!0)
  (define-fun var1164 () Int
    (let ((a!1 (num_splits_re var2994
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))))
      (a!3 (split_rest_re var2994
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))
                          (- (- 1) 1)))
      (a!4 (split_at_re var2994
                        (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))
                        0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
(let ((a!5 (ite (< (num_splits (ite a!2 a!3 a!4) (var150_quote/811834350 "|||"))
                   (- 1))
                (num_splits (ite a!2 a!3 a!4) (var150_quote/811834350 "|||"))
                (- 1))))
  (ite (> (- 1) 0)
       a!5
       (num_splits (ite a!2 a!3 a!4) (var150_quote/811834350 "|||")))))))
  (define-fun var2077!1 () String
    (var2691_access$200/3554864 (this$0/-508771627 var843)))
  (define-fun var1577-$assertionsDisabled () Bool
    false)
  (define-fun var569!1 () var285
    var285!val!0)
  (define-fun var1708-init () var1708
    var1708!val!0)
  (define-fun var2082!1 () var1708
    var1708!val!0)
  (define-fun var740!1 () Int
    0)
  (define-fun var285-init () var285
    var285!val!0)
  (define-fun var150_quote/811834350 ((x!0 String)) String
    "\u{9}")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    1)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    " ")
  (define-fun var2691_access$000/1195809519 ((x!0 var2691)) Bool
    false)
  (define-fun this$0/-508771627 ((x!0 var1577)) var2691
    var2691!val!0)
  (define-fun var2691_access$300/-390947598 ((x!0 var2691)) Bool
    true)
  (define-fun <init>/1228603609 ((x!0 var1708) (x!1 Int)) void
    void!val!0)
  (define-fun var2691_access$200/3554864 ((x!0 var2691)) String
    "")
  (define-fun <init>/-208190597 ((x!0 var285)) void
    void!val!0)
)
