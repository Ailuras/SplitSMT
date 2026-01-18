(
  (define-fun var3384 () String
    ",")
  (define-fun var170 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3384 ",") (- 1)) (num_splits var3384 ",") (- 1))
     (num_splits var3384 ",")))
  (define-fun var1359 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3384 ",") (- 1)) (num_splits var3384 ",") (- 1))
     (num_splits var3384 ",")))
  (define-fun null-String () String
    "")
  (define-fun var2162 () Int
    0)
  (define-fun var2511 () var3087
    var3087-init)
  (define-fun var2280 () String
    null-String)
  (define-fun var1359!1 () Int
    0)
  (define-fun var3087-init () var3087
    var3087!val!0)
  (define-fun var2511!1 () var3087
    var3087!val!0)
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
  (define-fun <init>/1228603609 ((x!0 var3087) (x!1 Int)) void
    void!val!0)
)
