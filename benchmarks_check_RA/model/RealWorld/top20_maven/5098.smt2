(
  ;; universe for var1864:
  ;;   var1864!val!0 var1864!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1864!val!0 () var1864)
  (declare-fun var1864!val!1 () var1864)
  ;; cardinality constraint:
  (forall ((x var1864)) (or (= x var1864!val!0) (= x var1864!val!1)))
  ;; -----------
  ;; universe for var3392:
  ;;   var3392!val!0 var3392!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3392!val!0 () var3392)
  (declare-fun var3392!val!1 () var3392)
  ;; cardinality constraint:
  (forall ((x var3392)) (or (= x var3392!val!0) (= x var3392!val!1)))
  ;; -----------
  (define-fun var87!1 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var3863) a!2) (- 1)))))
(let ((a!4 (ite a!3
                (split_rest_re (toString/-512974245 var3863) a!2 (- (- 1) 1))
                (split_at_re (toString/-512974245 var3863) a!2 (+ 0 1)))))
  (var3522_isNotBlank/-616714458 a!4))))))
  (define-fun var1235 () var1864
    var1864!val!0)
  (define-fun var3456 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var3863) a!2) (- 1)))))
  (ite a!3
       (split_rest_re (toString/-512974245 var3863) a!2 (- (- 1) 1))
       (split_at_re (toString/-512974245 var3863) a!2 0))))))
  (define-fun var2723 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var3863) a!2) (- 1))
                (num_splits_re (toString/-512974245 var3863) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var3863) a!2))))))
  (define-fun var1759!1 () Int
    (+ 0 1))
  (define-fun var3863 () var3392
    var3392!val!0)
  (define-fun var3456!1 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= (+ 0 1) (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var3863) a!2) (- 1)))))
  (ite a!3
       (split_rest_re (toString/-512974245 var3863) a!2 (- (- 1) 1))
       (split_at_re (toString/-512974245 var3863) a!2 (+ 0 1)))))))
  (define-fun var3976 () String
    (toString/-512974245 var3863))
  (define-fun var1759!2 () Int
    (+ 0 1 1))
  (define-fun null-var1864 () var1864
    var1864!val!1)
  (define-fun null-var3392 () var3392
    var3392!val!1)
  (define-fun var1759 () Int
    0)
  (define-fun var1619 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var3863) a!2) (- 1))
                (num_splits_re (toString/-512974245 var3863) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var3863) a!2))))))
  (define-fun var87 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var3863) a!2) (- 1)))))
(let ((a!4 (ite a!3
                (split_rest_re (toString/-512974245 var3863) a!2 (- (- 1) 1))
                (split_at_re (toString/-512974245 var3863) a!2 0))))
  (var3522_isNotBlank/-616714458 a!4))))))
  (define-fun toString/-512974245 ((x!0 var3392)) String
    " ")
  (define-fun var3522_isNotBlank/-616714458 ((x!0 String)) Bool
    false)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    2)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    (ite (and (= x!0 " ")
              (= x!1
                 (let ((a!1 (re.* (re.union (str.to_re (seq.unit (_ Char 32)))
                                            (str.to_re (seq.unit (_ Char 9)))))))
                   (re.++ (re.++ a!1 (str.to_re (seq.unit (_ Char 47)))) a!1)))
              (= x!2 1))
      "\u{9}"
      " "))
)
