(
  ;; universe for var2299:
  ;;   var2299!val!1 var2299!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2299!val!1 () var2299)
  (declare-fun var2299!val!0 () var2299)
  ;; cardinality constraint:
  (forall ((x var2299)) (or (= x var2299!val!1) (= x var2299!val!0)))
  ;; -----------
  (define-fun var2462 () String
    (let ((a!1 (>= (num_splits_re var578
                              (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
               (- 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) a!1)))
  (ite a!2
       (split_rest_re var578
                      (re.union (str.to_re "\u{d}") (str.to_re "\u{a}"))
                      (- (- 1) 1))
       (split_at_re var578 (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")) 0)))))
  (define-fun var578 () String
    "\u{d}")
  (define-fun null-String () String
    "")
  (define-fun var2887 () Int
    (let ((a!1 (< (num_splits_re var578
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var578
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var578 (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun var911 () Int
    0)
  (define-fun var2995 () var2299
    var2299!val!0)
  (define-fun null-var2299 () var2299
    var2299!val!1)
  (define-fun var2394 () Bool
    (let ((a!1 (>= (num_splits_re var578
                              (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
               (- 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) a!1)))
(let ((a!3 (ite a!2
                (split_rest_re var578
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}"))
                               (- (- 1) 1))
                (split_at_re var578
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}"))
                             0))))
  (str.prefixof "Identification of Mentions" a!3)))))
  (define-fun null-Bool () Bool
    true)
  (define-fun var2838 () Bool
    false)
  (define-fun var2462!1 () String
    "")
  (define-fun var2995!1 () var2299
    var2299!val!1)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    1)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "Identification of Mentions")
  (define-fun info/114590825 ((x!0 var2299) (x!1 String)) void
    void!val!0)
)
