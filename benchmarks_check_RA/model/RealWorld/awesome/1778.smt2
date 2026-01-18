(
  ;; universe for var2976:
  ;;   var2976!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2976!val!0 () var2976)
  ;; cardinality constraint:
  (forall ((x var2976)) (= x var2976!val!0))
  ;; -----------
  ;; universe for var785:
  ;;   var785!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var785!val!0 () var785)
  ;; cardinality constraint:
  (forall ((x var785)) (= x var785!val!0))
  ;; -----------
  ;; universe for var229:
  ;;   var229!val!0 var229!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var229!val!0 () var229)
  (declare-fun var229!val!1 () var229)
  ;; cardinality constraint:
  (forall ((x var229)) (or (= x var229!val!0) (= x var229!val!1)))
  ;; -----------
  (define-fun null-var229 () var229
    var229!val!1)
  (define-fun var2427 () String
    (let ((a!1 (num_splits_re (trim-right (trim-left var254))
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))))
      (a!3 (split_rest_re (trim-right (trim-left var254))
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))
                          (- (- 1) 1)))
      (a!4 (split_at_re (trim-right (trim-left var254))
                        (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))
                        0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
  (ite a!2 a!3 a!4))))
  (define-fun var2540 () var785
    (var785_compile/2141929305
  "^\u{9}*[a-zA-Z_]+[a-zA-Z0-9_-]*=([:]?[a-zA-Z]+[a-zA-Z0-9_-]*)(\u{9}+|$)"))
  (define-fun var1225 () var229
    var229!val!0)
  (define-fun var254 () String
    "\u{2fbff}")
  (define-fun null-String () String
    "^\u{9}*[a-zA-Z_]+[a-zA-Z0-9_-]*=([:]?[a-zA-Z]+[a-zA-Z0-9_-]*)(\u{9}+|$)")
  (define-fun var226 () String
    (trim-right (trim-left var254)))
  (define-fun var2154 () Bool
    (find/1809080823 (matcher/468719934
                   (var785_compile/2141929305
                     "^\u{9}*[a-zA-Z_]+[a-zA-Z0-9_-]*=([:]?[a-zA-Z]+[a-zA-Z0-9_-]*)(\u{9}+|$)")
                   var254)))
  (define-fun var3702 () var2976
    (matcher/468719934
  (var785_compile/2141929305
    "^\u{9}*[a-zA-Z_]+[a-zA-Z0-9_-]*=([:]?[a-zA-Z]+[a-zA-Z0-9_-]*)(\u{9}+|$)")
  var254))
  (define-fun var3636 () Bool
    (let ((a!1 (num_splits_re (trim-right (trim-left var254))
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))))
      (a!3 (split_rest_re (trim-right (trim-left var254))
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))
                          (- (- 1) 1)))
      (a!4 (split_at_re (trim-right (trim-left var254))
                        (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}")))
                        0)))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!1 (- 1)))))
  (matches/-643015890 (ite a!2 a!3 a!4) "[:]?[a-zA-Z]+[a-zA-Z0-9_-]*"))))
  (define-fun matcher/468719934 ((x!0 var785) (x!1 String)) var2976
    var2976!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "P")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun matches/-643015890 ((x!0 String) (x!1 String)) Bool
    true)
  (define-fun find/1809080823 ((x!0 var2976)) Bool
    false)
  (define-fun var785_compile/2141929305 ((x!0 String)) var785
    var785!val!0)
)
