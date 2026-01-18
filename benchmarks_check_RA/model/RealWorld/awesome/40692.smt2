(
  ;; universe for var3026:
  ;;   var3026!val!0 var3026!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3026!val!0 () var3026)
  (declare-fun var3026!val!1 () var3026)
  ;; cardinality constraint:
  (forall ((x var3026)) (or (= x var3026!val!0) (= x var3026!val!1)))
  ;; -----------
  ;; universe for var1005:
  ;;   var1005!val!3 var1005!val!0 var1005!val!4 var1005!val!2 var1005!val!5 var1005!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1005!val!3 () var1005)
  (declare-fun var1005!val!0 () var1005)
  (declare-fun var1005!val!4 () var1005)
  (declare-fun var1005!val!2 () var1005)
  (declare-fun var1005!val!5 () var1005)
  (declare-fun var1005!val!1 () var1005)
  ;; cardinality constraint:
  (forall ((x var1005))
          (or (= x var1005!val!3)
              (= x var1005!val!0)
              (= x var1005!val!4)
              (= x var1005!val!2)
              (= x var1005!val!5)
              (= x var1005!val!1)))
  ;; -----------
  ;; universe for var327:
  ;;   var327!val!0 var327!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var327!val!0 () var327)
  (declare-fun var327!val!1 () var327)
  ;; cardinality constraint:
  (forall ((x var327)) (or (= x var327!val!0) (= x var327!val!1)))
  ;; -----------
  ;; universe for var2124:
  ;;   var2124!val!1 var2124!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2124!val!1 () var2124)
  (declare-fun var2124!val!0 () var2124)
  ;; cardinality constraint:
  (forall ((x var2124)) (or (= x var2124!val!1) (= x var2124!val!0)))
  ;; -----------
  ;; universe for var1164:
  ;;   var1164!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1164!val!0 () var1164)
  ;; cardinality constraint:
  (forall ((x var1164)) (= x var1164!val!0))
  ;; -----------
  ;; universe for var80:
  ;;   var80!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var80!val!0 () var80)
  ;; cardinality constraint:
  (forall ((x var80)) (= x var80!val!0))
  ;; -----------
  ;; universe for var1810:
  ;;   var1810!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1810!val!0 () var1810)
  ;; cardinality constraint:
  (forall ((x var1810)) (= x var1810!val!0))
  ;; -----------
  ;; universe for var1496:
  ;;   var1496!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1496!val!0 () var1496)
  ;; cardinality constraint:
  (forall ((x var1496)) (= x var1496!val!0))
  ;; -----------
  (define-fun var1046 () var1810
    (this$0/1045148940 (this$1/-329981954 var2113)))
  (define-fun var528 () Float64
    (fp.add roundNearestTiesToEven
        (cast-from-Int-to-Float64
          (y/-2076290636 (getLocation/-2100520407 var2539)))
        (fp.div roundNearestTiesToEven
                (getHeight/714790842 var2539)
                ((_ to_fp 11 53) #x4014000000000000))))
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var707 () var80
    (var80_makePair/452216261 var1270 var3745))
  (define-fun var2928 () Float64
    (fp.add roundNearestTiesToEven
        (cast-from-Int-to-Float64
          (x/-2076290636 (getLocation/-2100520407 var2539)))
        (fp.div roundNearestTiesToEven
                (getWidth/489074803 var2539)
                ((_ to_fp 11 53) #x4014000000000000))))
  (define-fun var1919!1 () String
    "Guess: \nGold: \nValue: ")
  (define-fun null-var1005 () var1005
    var1005!val!1)
  (define-fun var509 () Int
    (x/-2076290636 (getLocation/-2100520407 var2539)))
  (define-fun null-var2124 () var2124
    var2124!val!1)
  (define-fun var1560 () Int
    (getSize/1707555820 (getFont/-1191561058 (cast-from-var3026-to-var3286 var313))))
  (define-fun var418 () var3933
    (getLocation/-2100520407 var2539))
  (define-fun var2043 () String
    (let ((a!1 (get/791961573 (var1810_access$300/-62264586
                            (this$0/1045148940 (this$1/-329981954 var2113)))
                          (cast-from-var80-to-var1005
                            (var80_makePair/452216261 var1270 var3745)))))
  (append/-1031950772
    (str.++ var1656!1
            "Guess: "
            (toString/-522406933 var1270)
            "\nGold: "
            (toString/-522406933 var3745)
            "\nValue: ")
    (cast-from-Int-to-var1005 (cast-from-var1005-to-Int a!1)))))
  (define-fun var3745 () var1005
    var1005!val!2)
  (define-fun var2066 () var3933
    (getLocation/-2100520407 var2539))
  (define-fun var2988 () var2633
    (getFont/-1191561058 (cast-from-var3026-to-var3286 var313)))
  (define-fun var2681 () String
    (str.++ var1656!1
        "Guess: "
        (toString/-522406933 var1270)
        "\nGold: "
        (toString/-522406933 var3745)))
  (define-fun var1221 () var1005
    (get/791961573 (var1810_access$300/-62264586
                 (this$0/1045148940 (this$1/-329981954 var2113)))
               (cast-from-var80-to-var1005
                 (var80_makePair/452216261 var1270 var3745))))
  (define-fun var2855 () String
    (toString/-522406933 var3745))
  (define-fun var1388 () var1496
    (var1810_access$300/-62264586 (this$0/1045148940 (this$1/-329981954 var2113))))
  (define-fun var2548 () Int
    (y/-2076290636 (getLocation/-2100520407 var2539)))
  (define-fun var1233 () Int
    (let ((a!1 (fp.add roundNearestTiesToEven
                   (cast-from-Int-to-Float64
                     (x/-2076290636 (getLocation/-2100520407 var2539)))
                   (fp.div roundNearestTiesToEven
                           (getWidth/489074803 var2539)
                           ((_ to_fp 11 53) #x4014000000000000)))))
  (cast-from-Float64-to-Int a!1)))
  (define-fun var1353 () Float32
    (cast-from-Int-to-Float32
  (getSize/1707555820
    (getFont/-1191561058 (cast-from-var3026-to-var3286 var313)))))
  (define-fun var3906 () String
    (str.++ var1656!1 "Guess: " (toString/-522406933 var1270)))
  (define-fun var498 () Int
    (let ((a!1 (fp.add roundNearestTiesToEven
                   (cast-from-Int-to-Float64
                     (y/-2076290636 (getLocation/-2100520407 var2539)))
                   (fp.div roundNearestTiesToEven
                           (getHeight/714790842 var2539)
                           ((_ to_fp 11 53) #x4014000000000000)))))
  (cast-from-Float64-to-Int a!1)))
  (define-fun var2137 () var1164
    (this$1/-329981954 var2113))
  (define-fun var2539 () var327
    var327!val!0)
  (define-fun var1270 () var1005
    var1005!val!0)
  (define-fun var1118 () Float64
    (getHeight/714790842 var2539))
  (define-fun var2684 () Float64
    (fp.div roundNearestTiesToEven
        (getWidth/489074803 var2539)
        ((_ to_fp 11 53) #x4014000000000000)))
  (define-fun var1542 () var2633
    (let ((a!1 (cast-from-Int-to-Float32
             (getSize/1707555820
               (getFont/-1191561058 (cast-from-var3026-to-var3286 var313))))))
  (deriveFont/-816435095
    (getFont/-1191561058 (cast-from-var3026-to-var3286 var313))
    (fp.mul roundNearestTiesToEven a!1 ((_ to_fp 8 24) #x40000000)))))
  (define-fun null-var3026 () var3026
    var3026!val!1)
  (define-fun var2921 () String
    (let ((a!1 (get/791961573 (var1810_access$300/-62264586
                            (this$0/1045148940 (this$1/-329981954 var2113)))
                          (cast-from-var80-to-var1005
                            (var80_makePair/452216261 var1270 var3745)))))
  (append/-1031950772
    (str.++ var1656!1
            "Guess: "
            (toString/-522406933 var1270)
            "\nGold: "
            (toString/-522406933 var3745)
            "\nValue: ")
    (cast-from-Int-to-var1005 (cast-from-var1005-to-Int a!1)))))
  (define-fun var2897 () Int
    (let ((a!1 (get/791961573 (var1810_access$300/-62264586
                            (this$0/1045148940 (this$1/-329981954 var2113)))
                          (cast-from-var80-to-var1005
                            (var80_makePair/452216261 var1270 var3745)))))
  (cast-from-var1005-to-Int a!1)))
  (define-fun var3080 () String
    (toString/-522406933 var1270))
  (define-fun var3425 () Float32
    (let ((a!1 (cast-from-Int-to-Float32
             (getSize/1707555820
               (getFont/-1191561058 (cast-from-var3026-to-var3286 var313))))))
  (fp.mul roundNearestTiesToEven a!1 ((_ to_fp 8 24) #x40000000))))
  (define-fun var888 () Int
    0)
  (define-fun var2509 () Float64
    (fp.div roundNearestTiesToEven
        (getHeight/714790842 var2539)
        ((_ to_fp 11 53) #x4014000000000000)))
  (define-fun var2113 () var2124
    var2124!val!0)
  (define-fun null-var327 () var327
    var327!val!1)
  (define-fun var2056 () String
    (str.++ var1656!1 "Guess: "))
  (define-fun var864 () var2924
    var2924-WHITE)
  (define-fun var1596 () Int
    (let ((a!1 (get/791961573 (var1810_access$300/-62264586
                            (this$0/1045148940 (this$1/-329981954 var2113)))
                          (cast-from-var80-to-var1005
                            (var80_makePair/452216261 var1270 var3745)))))
(let ((a!2 (num_splits_re (append/-1031950772
                            (str.++ var1656!1
                                    "Guess: "
                                    (toString/-522406933 var1270)
                                    "\nGold: "
                                    (toString/-522406933 var3745)
                                    "\nValue: ")
                            (cast-from-Int-to-var1005
                              (cast-from-var1005-to-Int a!1)))
                          (str.to_re "\u{a}"))))
  (ite (> (- 1) 0) (ite (< a!2 (- 1)) a!2 (- 1)) a!2))))
  (define-fun var2843 () var2924
    var2924-BLACK)
  (define-fun var1656 () String
    String-init)
  (define-fun var1919 () String
    (str.++ var1656!1
        "Guess: "
        (toString/-522406933 var1270)
        "\nGold: "
        (toString/-522406933 var3745)
        "\nValue: "))
  (define-fun var303 () Float64
    (cast-from-Int-to-Float64 (x/-2076290636 (getLocation/-2100520407 var2539))))
  (define-fun var313 () var3026
    var3026!val!0)
  (define-fun var503 () Float64
    (cast-from-Int-to-Float64 (y/-2076290636 (getLocation/-2100520407 var2539))))
  (define-fun var579 () String
    (str.++ var1656!1 "Guess: " (toString/-522406933 var1270) "\nGold: "))
  (define-fun var3705 () Float64
    (getWidth/489074803 var2539))
  (define-fun null-Int () Int
    26)
  (define-fun var2681!1 () String
    "Guess: \nGold: \nValue: ")
  (define-fun var1656!2 () String
    "Guess: ")
  (define-fun var1656!1 () String
    "")
  (define-fun var579!1 () String
    "Guess: \nGold: ")
  (define-fun var3906!1 () String
    "Guess: \nGold: ")
  (define-fun var2056!1 () String
    "Guess: ")
  (define-fun var313!1 () var3026
    var3026!val!0)
  (define-fun var313!5 () var3026
    var3026!val!0)
  (define-fun var313!3 () var3026
    var3026!val!0)
  (define-fun var313!2 () var3026
    var3026!val!0)
  (define-fun var864!1 () var2924
    var2924!val!0)
  (define-fun var2924-BLACK () var2924
    var2924!val!0)
  (define-fun var2843!1 () var2924
    var2924!val!0)
  (define-fun var2988!1 () var2633
    var2633!val!0)
  (define-fun var1542!1 () var2633
    var2633!val!0)
  (define-fun var2924-WHITE () var2924
    var2924!val!0)
  (define-fun var313!4 () var3026
    var3026!val!0)
  (define-fun var2539!1 () var327
    var327!val!0)
  (define-fun String-init () String
    "")
  (define-fun this$0/1045148940 ((x!0 var1164)) var1810
    var1810!val!0)
  (define-fun toString/-522406933 ((x!0 var1005)) String
    "")
  (define-fun get/791961573 ((x!0 var1496) (x!1 var1005)) var1005
    var1005!val!4)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun cast-from-var1005-to-Int ((x!0 var1005)) Int
    25)
  (define-fun var80_makePair/452216261 ((x!0 var1005) (x!1 var1005)) var80
    var80!val!0)
  (define-fun this$1/-329981954 ((x!0 var2124)) var1164
    var1164!val!0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun cast-from-var80-to-var1005 ((x!0 var80)) var1005
    var1005!val!3)
  (define-fun append/-1031950772 ((x!0 String) (x!1 var1005)) String
    "G")
  (define-fun cast-from-Int-to-var1005 ((x!0 Int)) var1005
    var1005!val!5)
  (define-fun var1810_access$300/-62264586 ((x!0 var1810)) var1496
    var1496!val!0)
  (define-fun getHeight/714790842 ((x!0 var327)) Float64
    (_ NaN 11 53))
  (define-fun cast-from-Int-to-Float64 ((x!0 Int)) Float64
    (_ NaN 11 53))
  (define-fun cast-from-var3026-to-var3286 ((x!0 var3026)) var3286
    var3286!val!0)
  (define-fun x/-2076290636 ((x!0 var3933)) Int
    0)
  (define-fun getWidth/489074803 ((x!0 var327)) Float64
    (_ NaN 11 53))
  (define-fun getFont/-1191561058 ((x!0 var3286)) var2633
    var2633!val!0)
  (define-fun fill/1396239382 ((x!0 var3026) (x!1 var2867)) void
    void!val!0)
  (define-fun getSize/1707555820 ((x!0 var2633)) Int
    0)
  (define-fun cast-from-Float64-to-Int ((x!0 Float64)) Int
    0)
  (define-fun y/-2076290636 ((x!0 var3933)) Int
    0)
  (define-fun setColor/1206064488 ((x!0 var3286) (x!1 var2924)) void
    void!val!0)
  (define-fun getLocation/-2100520407 ((x!0 var327)) var3933
    var3933!val!0)
  (define-fun cast-from-Int-to-Float32 ((x!0 Int)) Float32
    (_ NaN 8 24))
  (define-fun cast-from-var327-to-var2867 ((x!0 var327)) var2867
    var2867!val!0)
  (define-fun deriveFont/-816435095 ((x!0 var2633) (x!1 Float32)) var2633
    var2633!val!0)
  (define-fun setFont/-1113720754 ((x!0 var3286) (x!1 var2633)) void
    void!val!0)
)
