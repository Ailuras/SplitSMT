(
  (define-fun var2604 () Bool
    (let ((a!1 (re.++ (re.++ (re.++ (str.to_re "\") (str.to_re "|"))
                         (str.to_re "\"))
                  (str.to_re "|"))))
(let ((a!2 (num_splits_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))))
      (a!4 (split_rest_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))
                          (- (- 1) 1)))
      (a!5 (split_at_re var2942
                        (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))
                        0)))
(let ((a!3 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!2 (- 1)))))
  (str.prefixof "word:::" (ite a!3 a!4 a!5))))))
  (define-fun var2568 () String
    "word:::")
  (define-fun var1006 () Int
    (str.len "word:::"))
  (define-fun var2287 () String
    (let ((a!1 (re.++ (re.++ (re.++ (str.to_re "\") (str.to_re "|"))
                         (str.to_re "\"))
                  (str.to_re "|"))))
(let ((a!2 (num_splits_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))))
      (a!4 (split_rest_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))
                          (- (- 1) 1)))
      (a!5 (split_at_re var2942
                        (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))
                        0)))
(let ((a!3 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!2 (- 1)))))
  (ite a!3 a!4 a!5)))))
  (define-fun var3374 () Int
    (let ((a!1 (re.++ (re.++ (re.++ (str.to_re "\") (str.to_re "|"))
                         (str.to_re "\"))
                  (str.to_re "|"))))
(let ((a!2 (num_splits_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|")))))
  (ite (> (- 1) 0) (ite (< a!2 (- 1)) a!2 (- 1)) a!2))))
  (define-fun var2656 () var292
    var292-init)
  (define-fun var2311 () String
    "word:::")
  (define-fun var2942 () String
    "\")
  (define-fun var1781 () String
    (let ((a!1 (re.++ (re.++ (re.++ (str.to_re "\") (str.to_re "|"))
                         (str.to_re "\"))
                  (str.to_re "|"))))
(let ((a!2 (num_splits_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))))
      (a!4 (split_rest_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))
                          (- (- 1) 1)))
      (a!5 (split_at_re var2942
                        (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))
                        0)))
(let ((a!3 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!2 (- 1)))))
  (str.substr (ite a!3 a!4 a!5)
              (str.len "word:::")
              (- (str.len (ite a!3 a!4 a!5)) (str.len "word:::")))))))
  (define-fun null-String () String
    "")
  (define-fun var1106!1 () Int
    (+ 0 1))
  (define-fun var805 () String
    (let ((a!1 (re.++ (re.++ (re.++ (str.to_re "\") (str.to_re "|"))
                         (str.to_re "\"))
                  (str.to_re "|"))))
(let ((a!2 (num_splits_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))))
      (a!4 (split_rest_re var2942
                          (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))
                          (- (- 1) 1)))
      (a!5 (split_at_re var2942
                        (re.++ (re.++ a!1 (str.to_re "\")) (str.to_re "|"))
                        0)))
(let ((a!3 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= a!2 (- 1)))))
  (str.substr (ite a!3 a!4 a!5)
              (str.len "word:::")
              (- (str.len (ite a!3 a!4 a!5)) (str.len "word:::")))))))
  (define-fun var2776 () Int
    (str.len "word:::"))
  (define-fun var1106 () Int
    0)
  (define-fun var2656!1 () var292
    var292!val!0)
  (define-fun var1781!1 () String
    "")
  (define-fun var2656!2 () var292
    var292!val!0)
  (define-fun var805!1 () String
    "")
  (define-fun var292-init () var292
    var292!val!0)
  (define-fun var2656!3 () var292
    var292!val!0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "word:::")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    1)
  (define-fun setWord/-781399982 ((x!0 var292) (x!1 String)) void
    void!val!0)
  (define-fun <init>/598147663 ((x!0 var292)) void
    void!val!0)
  (define-fun setValue/611793815 ((x!0 var292) (x!1 String)) void
    void!val!0)
)
