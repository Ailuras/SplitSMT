(
  (define-fun var2369!1 () Int
    (+ 0 1))
  (define-fun var1552 () var372
    var372-init)
  (define-fun null-String () String
    "IJKL")
  (define-fun var1476 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3322 "|||") (- 1)) (num_splits var3322 "|||") (- 1))
     (num_splits var3322 "|||")))
  (define-fun var2369 () Int
    0)
  (define-fun var708 () Bool
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3322 "|||") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3322 "|||" (- (- 1) 1))
                (split_at var3322 "|||" 0))))
  (str.prefixof "word:::" a!2))))
  (define-fun var3322 () String
    "|||")
  (define-fun var38 () Bool
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3322 "|||") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3322 "|||" (- (- 1) 1))
                (split_at var3322 "|||" 0))))
  (str.prefixof "tag:::" a!2))))
  (define-fun var2455 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3322 "|||") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3322 "|||" (- (- 1) 1))
                (split_at var3322 "|||" 0))))
  (str.substr a!2 (str.len "tag:::") (- (str.len a!2) (str.len "tag:::"))))))
  (define-fun var1328 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3322 "|||") (- 1)))))
  (ite a!1 (split_rest var3322 "|||" (- (- 1) 1)) (split_at var3322 "|||" 0))))
  (define-fun var1302 () String
    "tag:::")
  (define-fun var3735 () Int
    (str.len "tag:::"))
  (define-fun var1552!2 () var372
    var372!val!0)
  (define-fun var2455!1 () String
    "")
  (define-fun var1552!1 () var372
    var372!val!0)
  (define-fun var372-init () var372
    var372!val!0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "tag:::H")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun setTag/-302746546 ((x!0 var372) (x!1 String)) void
    void!val!0)
  (define-fun <init>/598147663 ((x!0 var372)) void
    void!val!0)
)
