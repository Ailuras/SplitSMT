(
  ;; universe for ClassObject:
  ;;   ClassObject!val!0 ClassObject!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun ClassObject!val!0 () ClassObject)
  (declare-fun ClassObject!val!1 () ClassObject)
  ;; cardinality constraint:
  (forall ((x ClassObject)) (or (= x ClassObject!val!0) (= x ClassObject!val!1)))
  ;; -----------
  (define-fun var3130 () String
    (toString/-1020053180 var1386))
  (define-fun var2435 () Int
    (let ((a!1 (ite (< (num_splits_re (toString/-1020053180 var1386)
                                  (str.to_re "."))
                   (- 1))
                (num_splits_re (toString/-1020053180 var1386) (str.to_re "."))
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits_re (toString/-1020053180 var1386) (str.to_re ".")))))
  (define-fun var2084 () Bool
    (let ((a!1 (ite (< (num_splits_re (toString/-1020053180 var1386)
                                  (str.to_re "."))
                   (- 1))
                (num_splits_re (toString/-1020053180 var1386) (str.to_re "."))
                (- 1))))
(let ((a!2 (- (ite (> (- 1) 0)
                   a!1
                   (num_splits_re (toString/-1020053180 var1386)
                                  (str.to_re ".")))
              1)))
(let ((a!3 (and (> (- 1) 0)
                (= a!2 (- (- 1) 1))
                (>= (num_splits_re (toString/-1020053180 var1386)
                                   (str.to_re "."))
                    (- 1)))))
(let ((a!4 (ite a!3
                (split_rest_re (toString/-1020053180 var1386)
                               (str.to_re ".")
                               (- (- 1) 1))
                (split_at_re (toString/-1020053180 var1386) (str.to_re ".") a!2))))
  (str.suffixof "Transition" a!4))))))
  (define-fun var3026 () Int
    (let ((a!1 (ite (< (num_splits_re (toString/-1020053180 var1386)
                                  (str.to_re "."))
                   (- 1))
                (num_splits_re (toString/-1020053180 var1386) (str.to_re "."))
                (- 1))))
  (- (ite (> (- 1) 0)
          a!1
          (num_splits_re (toString/-1020053180 var1386) (str.to_re ".")))
     1)))
  (define-fun var1386 () ClassObject
    ClassObject!val!0)
  (define-fun var3397 () String
    (let ((a!1 (ite (< (num_splits_re (toString/-1020053180 var1386)
                                  (str.to_re "."))
                   (- 1))
                (num_splits_re (toString/-1020053180 var1386) (str.to_re "."))
                (- 1))))
(let ((a!2 (- (ite (> (- 1) 0)
                   a!1
                   (num_splits_re (toString/-1020053180 var1386)
                                  (str.to_re ".")))
              1)))
(let ((a!3 (and (> (- 1) 0)
                (= a!2 (- (- 1) 1))
                (>= (num_splits_re (toString/-1020053180 var1386)
                                   (str.to_re "."))
                    (- 1)))))
  (ite a!3
       (split_rest_re (toString/-1020053180 var1386)
                      (str.to_re ".")
                      (- (- 1) 1))
       (split_at_re (toString/-1020053180 var1386) (str.to_re ".") a!2))))))
  (define-fun null-ClassObject () ClassObject
    ClassObject!val!1)
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
  (define-fun toString/-1020053180 ((x!0 ClassObject)) String
    (ite (= x!0 ClassObject!val!0) "T"
      "T"))
)
