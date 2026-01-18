(
  ;; universe for var2539:
  ;;   var2539!val!1 var2539!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2539!val!1 () var2539)
  (declare-fun var2539!val!0 () var2539)
  ;; cardinality constraint:
  (forall ((x var2539)) (or (= x var2539!val!1) (= x var2539!val!0)))
  ;; -----------
  ;; universe for var318:
  ;;   var318!val!1 var318!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var318!val!1 () var318)
  (declare-fun var318!val!0 () var318)
  ;; cardinality constraint:
  (forall ((x var318)) (or (= x var318!val!1) (= x var318!val!0)))
  ;; -----------
  (define-fun var604 () Float64
    (let ((a!1 (fp.add roundNearestTiesToEven
                   (getLineHeight/1985812787
                     (doc/-1930180878 (this$0/1762336425 var1488)))
                   (cast-from-Int-to-Float64
                     (nodeHeightPaddingAbove/-1930180878
                       (this$0/1762336425 var1488)))))
      (a!3 (< (num_splits_re (getText/-791554220
                               (this$0/1762336425 var1488)
                               var151)
                             (str.to_re "\u{a}"))
              (- 1))))
(let ((a!2 (fp.add roundNearestTiesToEven
                   a!1
                   (cast-from-Int-to-Float64
                     (nodeHeightPaddingBelow/-1930180878
                       (this$0/1762336425 var1488)))))
      (a!4 (ite a!3
                (num_splits_re (getText/-791554220
                                 (this$0/1762336425 var1488)
                                 var151)
                               (str.to_re "\u{a}"))
                (- 1))))
(let ((a!5 (ite (> (- 1) 0)
                a!4
                (num_splits_re (getText/-791554220
                                 (this$0/1762336425 var1488)
                                 var151)
                               (str.to_re "\u{a}")))))
  (fp.mul roundNearestTiesToEven a!2 (cast-from-Int-to-Float64 a!5))))))
  (define-fun var3680 () Float64
    (cast-from-Int-to-Float64
  (nodeHeightPaddingBelow/-1930180878 (this$0/1762336425 var1488))))
  (define-fun var1050 () var127
    (this$0/1762336425 var1488))
  (define-fun var59 () var127
    (this$0/1762336425 var1488))
  (define-fun var3863 () Int
    (let ((a!1 (< (num_splits_re (getText/-791554220
                               (this$0/1762336425 var1488)
                               var151)
                             (str.to_re "\u{a}"))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (getText/-791554220
                                 (this$0/1762336425 var1488)
                                 var151)
                               (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re (getText/-791554220 (this$0/1762336425 var1488) var151)
                      (str.to_re "\u{a}"))))))
  (define-fun var942 () Int
    (nodeHeightPaddingBelow/-1930180878 (this$0/1762336425 var1488)))
  (define-fun var1083 () Float64
    (let ((a!1 (fp.add roundNearestTiesToEven
                   (getLineHeight/1985812787
                     (doc/-1930180878 (this$0/1762336425 var1488)))
                   (cast-from-Int-to-Float64
                     (nodeHeightPaddingAbove/-1930180878
                       (this$0/1762336425 var1488))))))
  (fp.add roundNearestTiesToEven
          a!1
          (cast-from-Int-to-Float64
            (nodeHeightPaddingBelow/-1930180878 (this$0/1762336425 var1488))))))
  (define-fun var3873 () var127
    (this$0/1762336425 var1488))
  (define-fun var1208 () Float64
    (fp.add roundNearestTiesToEven
        (getLineHeight/1985812787 (doc/-1930180878 (this$0/1762336425 var1488)))
        (cast-from-Int-to-Float64
          (nodeHeightPaddingAbove/-1930180878 (this$0/1762336425 var1488)))))
  (define-fun null-var318 () var318
    var318!val!1)
  (define-fun null-var2539 () var2539
    var2539!val!1)
  (define-fun var65 () Float64
    (cast-from-Int-to-Float64
  (nodeHeightPaddingAbove/-1930180878 (this$0/1762336425 var1488))))
  (define-fun var72 () var127
    (this$0/1762336425 var1488))
  (define-fun var2316 () String
    (getText/-791554220 (this$0/1762336425 var1488) var151))
  (define-fun var3342 () Int
    (nodeHeightPaddingAbove/-1930180878 (this$0/1762336425 var1488)))
  (define-fun var3318 () Float64
    (let ((a!1 (< (num_splits_re (getText/-791554220
                               (this$0/1762336425 var1488)
                               var151)
                             (str.to_re "\u{a}"))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (getText/-791554220
                                 (this$0/1762336425 var1488)
                                 var151)
                               (str.to_re "\u{a}"))
                (- 1))))
(let ((a!3 (ite (> (- 1) 0)
                a!2
                (num_splits_re (getText/-791554220
                                 (this$0/1762336425 var1488)
                                 var151)
                               (str.to_re "\u{a}")))))
  (cast-from-Int-to-Float64 a!3)))))
  (define-fun var3169 () Float64
    (getLineHeight/1985812787 (doc/-1930180878 (this$0/1762336425 var1488))))
  (define-fun var151 () var318
    var318!val!0)
  (define-fun var1488 () var2539
    var2539!val!0)
  (define-fun var3073 () var105
    (doc/-1930180878 (this$0/1762336425 var1488)))
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
  (define-fun nodeHeightPaddingBelow/-1930180878 ((x!0 var127)) Int
    0)
  (define-fun nodeHeightPaddingAbove/-1930180878 ((x!0 var127)) Int
    0)
  (define-fun getText/-791554220 ((x!0 var127) (x!1 var318)) String
    "")
  (define-fun cast-from-Int-to-Float64 ((x!0 Int)) Float64
    (_ NaN 11 53))
  (define-fun getLineHeight/1985812787 ((x!0 var105)) Float64
    (_ NaN 11 53))
  (define-fun doc/-1930180878 ((x!0 var127)) var105
    var105!val!0)
  (define-fun this$0/1762336425 ((x!0 var2539)) var127
    var127!val!0)
)
