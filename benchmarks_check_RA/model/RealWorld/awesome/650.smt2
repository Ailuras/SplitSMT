(
  ;; universe for var1761:
  ;;   var1761!val!1 var1761!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1761!val!1 () var1761)
  (declare-fun var1761!val!0 () var1761)
  ;; cardinality constraint:
  (forall ((x var1761)) (or (= x var1761!val!1) (= x var1761!val!0)))
  ;; -----------
  ;; universe for var2449:
  ;;   var2449!val!1 var2449!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2449!val!1 () var2449)
  (declare-fun var2449!val!0 () var2449)
  ;; cardinality constraint:
  (forall ((x var2449)) (or (= x var2449!val!1) (= x var2449!val!0)))
  ;; -----------
  (define-fun var1189 () Int
    (let ((a!1 (getHeight/-2047551061
             (getFontMetrics/1328729825
               (cast-from-var430-to-var2036 (viewer/-1439921249 var1751))
               (font/-151695256 (viewer/-1439921249 var1751))))))
  (+ a!1 (* (nodeHeightPadding/-151695256 (viewer/-1439921249 var1751)) 2))))
  (define-fun var1751 () var1761
    var1761!val!0)
  (define-fun var3049 () Int
    (nodeHeightPadding/-151695256 (viewer/-1439921249 var1751)))
  (define-fun var57 () var2449
    var2449!val!0)
  (define-fun var2295 () var430
    (viewer/-1439921249 var1751))
  (define-fun var3175 () var1632
    (font/-151695256 (viewer/-1439921249 var1751)))
  (define-fun var3107 () var3034
    (getFontMetrics/1328729825
  (cast-from-var430-to-var2036 (viewer/-1439921249 var1751))
  (font/-151695256 (viewer/-1439921249 var1751))))
  (define-fun null-var2449 () var2449
    var2449!val!1)
  (define-fun var518 () Float64
    (let ((a!1 (getHeight/-2047551061
             (getFontMetrics/1328729825
               (cast-from-var430-to-var2036 (viewer/-1439921249 var1751))
               (font/-151695256 (viewer/-1439921249 var1751)))))
      (a!3 (< (num_splits_re (getText/1718706454
                               (viewer/-1439921249 var1751)
                               var57)
                             (str.to_re "\u{a}"))
              (- 1))))
(let ((a!2 (+ a!1
              (* (nodeHeightPadding/-151695256 (viewer/-1439921249 var1751)) 2)))
      (a!4 (ite a!3
                (num_splits_re (getText/1718706454
                                 (viewer/-1439921249 var1751)
                                 var57)
                               (str.to_re "\u{a}"))
                (- 1))))
(let ((a!5 (ite (> (- 1) 0)
                a!4
                (num_splits_re (getText/1718706454
                                 (viewer/-1439921249 var1751)
                                 var57)
                               (str.to_re "\u{a}")))))
  (cast-from-Int-to-Float64 (* a!2 a!5))))))
  (define-fun var2173 () Int
    (let ((a!1 (< (num_splits_re (getText/1718706454
                               (viewer/-1439921249 var1751)
                               var57)
                             (str.to_re "\u{a}"))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (getText/1718706454
                                 (viewer/-1439921249 var1751)
                                 var57)
                               (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re (getText/1718706454 (viewer/-1439921249 var1751) var57)
                      (str.to_re "\u{a}"))))))
  (define-fun var2594 () Int
    (let ((a!1 (getHeight/-2047551061
             (getFontMetrics/1328729825
               (cast-from-var430-to-var2036 (viewer/-1439921249 var1751))
               (font/-151695256 (viewer/-1439921249 var1751)))))
      (a!3 (< (num_splits_re (getText/1718706454
                               (viewer/-1439921249 var1751)
                               var57)
                             (str.to_re "\u{a}"))
              (- 1))))
(let ((a!2 (+ a!1
              (* (nodeHeightPadding/-151695256 (viewer/-1439921249 var1751)) 2)))
      (a!4 (ite a!3
                (num_splits_re (getText/1718706454
                                 (viewer/-1439921249 var1751)
                                 var57)
                               (str.to_re "\u{a}"))
                (- 1))))
(let ((a!5 (ite (> (- 1) 0)
                a!4
                (num_splits_re (getText/1718706454
                                 (viewer/-1439921249 var1751)
                                 var57)
                               (str.to_re "\u{a}")))))
  (* a!2 a!5)))))
  (define-fun var1862 () String
    (getText/1718706454 (viewer/-1439921249 var1751) var57))
  (define-fun null-var1761 () var1761
    var1761!val!1)
  (define-fun var1081 () var430
    (viewer/-1439921249 var1751))
  (define-fun var705 () Int
    (* (nodeHeightPadding/-151695256 (viewer/-1439921249 var1751)) 2))
  (define-fun var2555 () var430
    (viewer/-1439921249 var1751))
  (define-fun var1290 () var430
    (viewer/-1439921249 var1751))
  (define-fun var3058 () Int
    (getHeight/-2047551061
  (getFontMetrics/1328729825
    (cast-from-var430-to-var2036 (viewer/-1439921249 var1751))
    (font/-151695256 (viewer/-1439921249 var1751)))))
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
  (define-fun viewer/-1439921249 ((x!0 var1761)) var430
    var430!val!0)
  (define-fun cast-from-var430-to-var2036 ((x!0 var430)) var2036
    var2036!val!0)
  (define-fun font/-151695256 ((x!0 var430)) var1632
    var1632!val!0)
  (define-fun cast-from-Int-to-Float64 ((x!0 Int)) Float64
    (_ NaN 11 53))
  (define-fun nodeHeightPadding/-151695256 ((x!0 var430)) Int
    0)
  (define-fun getHeight/-2047551061 ((x!0 var3034)) Int
    0)
  (define-fun getText/1718706454 ((x!0 var430) (x!1 var2449)) String
    "")
  (define-fun getFontMetrics/1328729825 ((x!0 var2036) (x!1 var1632)) var3034
    var3034!val!0)
)
