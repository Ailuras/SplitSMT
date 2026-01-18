(
  ;; universe for var3571:
  ;;   var3571!val!2 var3571!val!4 var3571!val!3 var3571!val!5 var3571!val!0 var3571!val!1 var3571!val!6 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3571!val!2 () var3571)
  (declare-fun var3571!val!4 () var3571)
  (declare-fun var3571!val!3 () var3571)
  (declare-fun var3571!val!5 () var3571)
  (declare-fun var3571!val!0 () var3571)
  (declare-fun var3571!val!1 () var3571)
  (declare-fun var3571!val!6 () var3571)
  ;; cardinality constraint:
  (forall ((x var3571))
          (or (= x var3571!val!2)
              (= x var3571!val!4)
              (= x var3571!val!3)
              (= x var3571!val!5)
              (= x var3571!val!0)
              (= x var3571!val!1)
              (= x var3571!val!6)))
  ;; -----------
  (define-fun null-var3571 () var3571
    var3571!val!1)
  (define-fun var3544!6 () var3571
    var3571!val!6)
  (define-fun var3544 () var3571
    var3571!val!0)
  (define-fun null-String () String
    "")
  (define-fun var3544!4 () var3571
    var3571!val!4)
  (define-fun var1944 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var3120 ":") (- 1)))))
  (ite a!1 (split_rest var3120 ":" (- (- 1) 1)) (split_at var3120 ":" 1))))
  (define-fun var3544!3 () var3571
    var3571!val!3)
  (define-fun var2199 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 3 (- (- 1) 1))
                (>= (num_splits var3120 ":") (- 1)))))
  (ite a!1 (split_rest var3120 ":" (- (- 1) 1)) (split_at var3120 ":" 3))))
  (define-fun var2857 () Int
    (- 1))
  (define-fun var2681 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3120 ":") (- 1)))))
  (ite a!1 (split_rest var3120 ":" (- (- 1) 1)) (split_at var3120 ":" 0))))
  (define-fun var3544!5 () var3571
    var3571!val!5)
  (define-fun var3544!2 () var3571
    var3571!val!2)
  (define-fun var603 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 2 (- (- 1) 1))
                (>= (num_splits var3120 ":") (- 1)))))
  (ite a!1 (split_rest var3120 ":" (- (- 1) 1)) (split_at var3120 ":" 2))))
  (define-fun var3120 () String
    ":")
  (define-fun var3544!1 () var3571
    var3571!val!2)
  (define-fun value/-687932879 ((x!0 var3571)) String
    (ite (= x!0 var3571!val!2) ":"
      ":"))
  (define-fun version/-687932879 ((x!0 var3571)) String
    "!2!")
  (define-fun category/-687932879 ((x!0 var3571)) String
    "!0!")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 58)))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      "!1!"
    (ite (and (= x!0 (seq.unit (_ Char 58)))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 2))
      "!2!"
    (ite (and (= x!0 (seq.unit (_ Char 58)))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 3))
      "!3!"
      "!0!"))))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun group/-687932879 ((x!0 var3571)) String
    "!3!")
  (define-fun serviceInterface/-687932879 ((x!0 var3571)) String
    "!1!")
  (define-fun cast-from-var3571-to-var3117 ((x!0 var3571)) var3117
    var3117!val!0)
  (define-fun <init>/-279557996 ((x!0 var3117)) void
    void!val!0)
)
