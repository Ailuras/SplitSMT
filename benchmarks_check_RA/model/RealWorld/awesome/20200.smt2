(
  ;; universe for var3277:
  ;;   var3277!val!0 var3277!val!3 var3277!val!4 var3277!val!2 var3277!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3277!val!0 () var3277)
  (declare-fun var3277!val!3 () var3277)
  (declare-fun var3277!val!4 () var3277)
  (declare-fun var3277!val!2 () var3277)
  (declare-fun var3277!val!1 () var3277)
  ;; cardinality constraint:
  (forall ((x var3277))
          (or (= x var3277!val!0)
              (= x var3277!val!3)
              (= x var3277!val!4)
              (= x var3277!val!2)
              (= x var3277!val!1)))
  ;; -----------
  ;; universe for var1102:
  ;;   var1102!val!0 var1102!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1102!val!0 () var1102)
  (declare-fun var1102!val!1 () var1102)
  ;; cardinality constraint:
  (forall ((x var1102)) (or (= x var1102!val!0) (= x var1102!val!1)))
  ;; -----------
  ;; universe for var348:
  ;;   var348!val!0 var348!val!3 var348!val!1 var348!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var348!val!0 () var348)
  (declare-fun var348!val!3 () var348)
  (declare-fun var348!val!1 () var348)
  (declare-fun var348!val!2 () var348)
  ;; cardinality constraint:
  (forall ((x var348))
          (or (= x var348!val!0)
              (= x var348!val!3)
              (= x var348!val!1)
              (= x var348!val!2)))
  ;; -----------
  ;; universe for var270:
  ;;   var270!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var270!val!0 () var270)
  ;; cardinality constraint:
  (forall ((x var270)) (= x var270!val!0))
  ;; -----------
  ;; universe for var3450:
  ;;   var3450!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3450!val!0 () var3450)
  ;; cardinality constraint:
  (forall ((x var3450)) (= x var3450!val!0))
  ;; -----------
  ;; universe for var2765:
  ;;   var2765!val!1 var2765!val!0 var2765!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2765!val!1 () var2765)
  (declare-fun var2765!val!0 () var2765)
  (declare-fun var2765!val!2 () var2765)
  ;; cardinality constraint:
  (forall ((x var2765))
          (or (= x var2765!val!1) (= x var2765!val!0) (= x var2765!val!2)))
  ;; -----------
  ;; universe for var24:
  ;;   var24!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var24!val!0 () var24)
  ;; cardinality constraint:
  (forall ((x var24)) (= x var24!val!0))
  ;; -----------
  (define-fun var1202 () Int
    (let ((a!1 (ite (< (num_splits (featureFactoryClass/-870760670 var3730!1) ";")
                   (- 1))
                (num_splits (featureFactoryClass/-870760670 var3730!1) ";")
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits (featureFactoryClass/-870760670 var3730!1) ";"))))
  (define-fun var3390 () var348
    var348!val!0)
  (define-fun var2914 () var270
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (featureFactoryClass/-870760670 var3730!1) ";")
                    (- 1)))))
(let ((a!2 (ite a!1
                (split_rest (featureFactoryClass/-870760670 var3730!1)
                            ";"
                            (- (- 1) 1))
                (split_at (featureFactoryClass/-870760670 var3730!1) ";" 0))))
  (var2299_loadByReflection/-126565946 a!2 arr-var270-init))))
  (define-fun var2810 () String
    (featureFactoryClass/-870760670 var3730!1))
  (define-fun null-var1102 () var1102
    var1102!val!1)
  (define-fun null-var2765 () var2765
    var2765!val!1)
  (define-fun var3730 () var2765
    var2765!val!0)
  (define-fun var2441 () var1102
    var1102!val!0)
  (define-fun null-var3277 () var3277
    var3277!val!1)
  (define-fun var1718!4 () var3277
    var3277!val!4)
  (define-fun var3569 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (featureFactoryClass/-870760670 var3730!1) ";")
                    (- 1)))))
  (ite a!1
       (split_rest (featureFactoryClass/-870760670 var3730!1) ";" (- (- 1) 1))
       (split_at (featureFactoryClass/-870760670 var3730!1) ";" 0))))
  (define-fun arr-var270-init () (Array Int var270)
    ((as const (Array Int var270)) var270!val!0))
  (define-fun var3153 () (Array Int var270)
    arr-var270-init)
  (define-fun var1718 () var3277
    var3277!val!0)
  (define-fun var1483 () var24
    var24-init)
  (define-fun var3182 () var348
    var348!val!2)
  (define-fun var2096 () var348
    var348!val!3)
  (define-fun null-var348 () var348
    var348!val!1)
  (define-fun var3730!1 () var2765
    var2765!val!2)
  (define-fun var1718!2 () var3277
    var3277!val!2)
  (define-fun var3989 () var3450
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (featureFactoryClass/-870760670 var3730!1) ";")
                    (- 1)))))
(let ((a!2 (ite a!1
                (split_rest (featureFactoryClass/-870760670 var3730!1)
                            ";"
                            (- (- 1) 1))
                (split_at (featureFactoryClass/-870760670 var3730!1) ";" 0))))
  (cast-from-var270-to-var3450
    (var2299_loadByReflection/-126565946 a!2 arr-var270-init)))))
  (define-fun var1718!3 () var3277
    var3277!val!3)
  (define-fun var1483!1 () var24
    var24!val!0)
  (define-fun var24-init () var24
    var24!val!0)
  (define-fun var3390!1 () var348
    var348!val!0)
  (define-fun var3182!1 () var348
    var348!val!0)
  (define-fun var2096!1 () var348
    var348!val!0)
  (define-fun var1718!1 () var3277
    var3277!val!0)
  (define-fun var2441!1 () var1102
    var1102!val!0)
  (define-fun featureFactory/620388015 ((x!0 var3277)) var3450
    var3450!val!0)
  (define-fun var2299_loadByReflection/-126565946 ((x!0 String)
   (x!1 (Array Int var270))) var270
    var270!val!0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    ";")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun learningRate/620388015 ((x!0 var3277)) Float32
    (fp #b0 #x7f #b00000000000000000000000))
  (define-fun featureFactoryClass/-870760670 ((x!0 var2765)) String
    ";")
  (define-fun cast-from-var270-to-var3450 ((x!0 var270)) var3450
    var3450!val!0)
  (define-fun featureWeights/620388015 ((x!0 var3277)) var24
    var24!val!0)
  (define-fun <init>/-1553701343 ((x!0 var24)) void
    void!val!0)
  (define-fun <init>/-1890226404 ((x!0 var3535)
   (x!1 var2765)
   (x!2 var1102)
   (x!3 var348)
   (x!4 var348)
   (x!5 var348)) void
    void!val!0)
  (define-fun cast-from-var3277-to-var3535 ((x!0 var3277)) var3535
    var3535!val!0)
)
