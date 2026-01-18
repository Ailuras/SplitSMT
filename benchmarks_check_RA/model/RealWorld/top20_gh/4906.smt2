(
  (define-fun var3426 () var2421
    var2421-init)
  (define-fun var324 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2143 "&") (- 1)) (num_splits var2143 "&") (- 1))
     (num_splits var2143 "&")))
  (define-fun var3882 () var344
    var344-init)
  (define-fun var2997 () var2421
    var2421-init)
  (define-fun var3727 () var1354
    var1354-init)
  (define-fun var2258 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var2143 "&") (- 1))
                     (num_splits var2143 "&")
                     (- 1))
                (num_splits var2143 "&"))))
  (+ (cast-from-Float32-to-Int
       (fp.div roundNearestTiesToEven
               (cast-from-Int-to-Float32 a!1)
               ((_ to_fp 8 24) #x3f400000)))
     1)))
  (define-fun var385 () var2421
    var2421-init)
  (define-fun var1650 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2143 "&") (- 1)) (num_splits var2143 "&") (- 1))
     (num_splits var2143 "&")))
  (define-fun var1030 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var2143 "&") (- 1))
                     (num_splits var2143 "&")
                     (- 1))
                (num_splits var2143 "&"))))
  (cast-from-Float32-to-Int
    (fp.div roundNearestTiesToEven
            (cast-from-Int-to-Float32 a!1)
            ((_ to_fp 8 24) #x3f400000)))))
  (define-fun var3107 () Int
    0)
  (define-fun null-String () String
    "")
  (define-fun var3435 () Float32
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var2143 "&") (- 1))
                     (num_splits var2143 "&")
                     (- 1))
                (num_splits var2143 "&"))))
  (cast-from-Int-to-Float32 a!1)))
  (define-fun var3663 () Float32
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var2143 "&") (- 1))
                     (num_splits var2143 "&")
                     (- 1))
                (num_splits var2143 "&"))))
  (fp.div roundNearestTiesToEven
          (cast-from-Int-to-Float32 a!1)
          ((_ to_fp 8 24) #x3f400000))))
  (define-fun var2143 () String
    "&")
  (define-fun var3426!2 () var2421
    var2421!val!0)
  (define-fun var2143!1 () String
    "")
  (define-fun var385!1 () var2421
    var2421!val!0)
  (define-fun var344-init () var344
    var344!val!0)
  (define-fun var1354-init () var1354
    var1354!val!0)
  (define-fun var3426!1 () var2421
    var2421!val!0)
  (define-fun var3727!1 () var1354
    var1354!val!0)
  (define-fun var2421-init () var2421
    var2421!val!0)
  (define-fun var3882!1 () var344
    var344!val!0)
  (define-fun var385!2 () var2421
    var2421!val!0)
  (define-fun var2258!4 () Int
    0)
  (define-fun var2997!1 () var2421
    var2421!val!0)
  (define-fun var2258!1 () Int
    0)
  (define-fun var2258!2 () Int
    0)
  (define-fun var2258!3 () Int
    0)
  (define-fun var3727!2 () var1354
    var1354!val!0)
  (define-fun var2997!2 () var2421
    var2421!val!0)
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
  (define-fun cast-from-Int-to-Float32 ((x!0 Int)) Float32
    (_ NaN 8 24))
  (define-fun <init>/613807010 ((x!0 var2421) (x!1 Int)) void
    void!val!0)
  (define-fun cast-from-Float32-to-Int ((x!0 Float32)) Int
    0)
  (define-fun <init>/643259939 ((x!0 var1354) (x!1 Int)) void
    void!val!0)
  (define-fun <init>/-130489206 ((x!0 var344)
   (x!1 var1354)
   (x!2 var2757)
   (x!3 var2757)
   (x!4 var2757)
   (x!5 String)) void
    void!val!0)
  (define-fun cast-from-var2421-to-var2757 ((x!0 var2421)) var2757
    var2757!val!0)
)
