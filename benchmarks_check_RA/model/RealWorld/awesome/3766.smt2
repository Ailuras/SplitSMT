(
  ;; universe for var628:
  ;;   var628!val!1 var628!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var628!val!1 () var628)
  (declare-fun var628!val!0 () var628)
  ;; cardinality constraint:
  (forall ((x var628)) (or (= x var628!val!1) (= x var628!val!0)))
  ;; -----------
  ;; universe for var2379:
  ;;   var2379!val!0 var2379!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2379!val!0 () var2379)
  (declare-fun var2379!val!1 () var2379)
  ;; cardinality constraint:
  (forall ((x var2379)) (or (= x var2379!val!0) (= x var2379!val!1)))
  ;; -----------
  (define-fun var1927 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var2418 ",") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2418 "," (- (- 1) 1))
                (split_at var2418 "," 1))))
  (str.replace_all a!2 ")" ""))))
  (define-fun var1098 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2418 ",") (- 1)))))
  (ite a!1 (split_rest var2418 "," (- (- 1) 1)) (split_at var2418 "," 0))))
  (define-fun var3471 () String
    (str.++ "Invalid page number: \u{1}" var2418))
  (define-fun var2418 () String
    "A")
  (define-fun var330 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var2418 ",") (- 1)))))
  (ite a!1 (split_rest var2418 "," (- (- 1) 1)) (split_at var2418 "," 1))))
  (define-fun var1410 () var1214
    (pageNumbers/1418557443 var1217))
  (define-fun var135 () Int
    1)
  (define-fun null-String () String
    "")
  (define-fun null-var2379 () var2379
    var2379!val!1)
  (define-fun var2883 () var1894
    var2379-log)
  (define-fun var2754 () var628
    var628!val!0)
  (define-fun null-var628 () var628
    var628!val!1)
  (define-fun var1217 () var2379
    var2379!val!0)
  (define-fun var3198 () Int
    (Int_valueOf/-1371140006 1))
  (define-fun var2379-log () var1894
    var1894!val!0)
  (define-fun var1410!1 () var1214
    var1214!val!0)
  (define-fun var2883!1 () var1894
    var1894!val!0)
  (define-fun var1927!1 () String
    "")
  (define-fun var2754!1 () var628
    var628!val!1)
  (define-fun var3198!1 () Int
    0)
  (define-fun var3471!1 () String
    "")
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
  (define-fun cast-from-Int-to-var2251 ((x!0 Int)) var2251
    var2251!val!0)
  (define-fun cast-from-String-to-var2251 ((x!0 String)) var2251
    var2251!val!0)
  (define-fun var1214_put/1464166817 ((x!0 var1214) (x!1 var2251) (x!2 var2251)) var2251
    var2251!val!0)
  (define-fun cast-from-var628-to-var2567 ((x!0 var628)) var2567
    var2567!val!0)
  (define-fun var1894_info/79011599 ((x!0 var1894) (x!1 String) (x!2 var2567)) void
    void!val!0)
  (define-fun Int_valueOf/-1371140006 ((x!0 Int)) Int
    0)
  (define-fun pageNumbers/1418557443 ((x!0 var2379)) var1214
    var1214!val!0)
)
