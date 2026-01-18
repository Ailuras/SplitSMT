(
  ;; universe for var3293:
  ;;   var3293!val!1 var3293!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3293!val!1 () var3293)
  (declare-fun var3293!val!0 () var3293)
  ;; cardinality constraint:
  (forall ((x var3293)) (or (= x var3293!val!1) (= x var3293!val!0)))
  ;; -----------
  ;; universe for var3586:
  ;;   var3586!val!0 var3586!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3586!val!0 () var3586)
  (declare-fun var3586!val!1 () var3586)
  ;; cardinality constraint:
  (forall ((x var3586)) (or (= x var3586!val!0) (= x var3586!val!1)))
  ;; -----------
  (define-fun null-var3293 () var3293
    var3293!val!1)
  (define-fun var2596 () Float64
    (width/-707491510 (getBoundsOfNode/-1951447090 var1203 var371)))
  (define-fun var1027 () Int
    (let ((a!1 (ite (< (num_splits_re (getText/-791554220 var1203 var371)
                                  (str.to_re "\u{a}"))
                   (- 1))
                (num_splits_re (getText/-791554220 var1203 var371)
                               (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits_re (getText/-791554220 var1203 var371) (str.to_re "\u{a}")))))
  (define-fun var1345 () Float64
    (cast-from-Int-to-Float64 (nodeWidthPadding/-1930180878 var1203)))
  (define-fun var2130 () Float64
    (fp.add roundNearestTiesToEven
        (y/-707491510 (getBoundsOfNode/-1951447090 var1203 var371))
        (cast-from-Int-to-Float64 (nodeHeightPaddingBelow/-1930180878 var1203))))
  (define-fun var2493 () String
    (getText/-791554220 var1203 var371))
  (define-fun var374 () Int
    (nodeWidthPadding/-1930180878 var1203))
  (define-fun var3888 () Int
    (nodeHeightPaddingBelow/-1930180878 var1203))
  (define-fun var3462 () Float64
    (y/-707491510 (getBoundsOfNode/-1951447090 var1203 var371)))
  (define-fun var1050 () Float64
    (x/-707491510 (getBoundsOfNode/-1951447090 var1203 var371)))
  (define-fun var2607 () Float64
    (fp.add roundNearestTiesToEven
        (x/-707491510 (getBoundsOfNode/-1951447090 var1203 var371))
        (cast-from-Int-to-Float64 (nodeWidthPadding/-1930180878 var1203))))
  (define-fun null-var3586 () var3586
    var3586!val!1)
  (define-fun var411 () var1444
    (doc/-1930180878 var1203))
  (define-fun var2982 () Bool
    true)
  (define-fun var2167 () Float64
    (x/-707491510 (getBoundsOfNode/-1951447090 var1203 var371)))
  (define-fun var763 () var1110
    (getBoundsOfNode/-1951447090 var1203 var371))
  (define-fun var2967 () Float64
    (y/-707491510 (getBoundsOfNode/-1951447090 var1203 var371)))
  (define-fun var3870 () Float64
    (cast-from-Int-to-Float64 (nodeHeightPaddingBelow/-1930180878 var1203)))
  (define-fun var2799 () Float64
    (height/-707491510 (getBoundsOfNode/-1951447090 var1203 var371)))
  (define-fun var1203 () var3293
    var3293!val!0)
  (define-fun var3757 () Int
    0)
  (define-fun var371 () var3586
    var3586!val!0)
  (define-fun var2799!1 () Float64
    (_ NaN 11 53))
  (define-fun var3462!1 () Float64
    (_ NaN 11 53))
  (define-fun var411!1 () var1444
    var1444!val!0)
  (define-fun var2596!1 () Float64
    (_ NaN 11 53))
  (define-fun var2167!1 () Float64
    (_ NaN 11 53))
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun getText/-791554220 ((x!0 var3293) (x!1 var3586)) String
    "!0!")
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
  (define-fun nodeHeightPaddingBelow/-1930180878 ((x!0 var3293)) Int
    0)
  (define-fun y/-707491510 ((x!0 var1110)) Float64
    (_ NaN 11 53))
  (define-fun highlight/-1835093399 ((x!0 var1444)
   (x!1 Float64)
   (x!2 Float64)
   (x!3 Float64)
   (x!4 Float64)) void
    void!val!0)
  (define-fun nodeWidthPadding/-1930180878 ((x!0 var3293)) Int
    0)
  (define-fun cast-from-Int-to-Float64 ((x!0 Int)) Float64
    (_ NaN 11 53))
  (define-fun doc/-1930180878 ((x!0 var3293)) var1444
    var1444!val!0)
  (define-fun getBoundsOfNode/-1951447090 ((x!0 var3293) (x!1 var3586)) var1110
    var1110!val!0)
  (define-fun width/-707491510 ((x!0 var1110)) Float64
    (_ NaN 11 53))
  (define-fun height/-707491510 ((x!0 var1110)) Float64
    (_ NaN 11 53))
  (define-fun x/-707491510 ((x!0 var1110)) Float64
    (_ NaN 11 53))
)
