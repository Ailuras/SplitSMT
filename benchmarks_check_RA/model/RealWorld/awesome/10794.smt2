(
  ;; universe for var3706:
  ;;   var3706!val!0 var3706!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3706!val!0 () var3706)
  (declare-fun var3706!val!1 () var3706)
  ;; cardinality constraint:
  (forall ((x var3706)) (or (= x var3706!val!0) (= x var3706!val!1)))
  ;; -----------
  ;; universe for var1694:
  ;;   var1694!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1694!val!0 () var1694)
  ;; cardinality constraint:
  (forall ((x var1694)) (= x var1694!val!0))
  ;; -----------
  ;; universe for var90:
  ;;   var90!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var90!val!0 () var90)
  ;; cardinality constraint:
  (forall ((x var90)) (= x var90!val!0))
  ;; -----------
  (define-fun var3182 () String
    (biasedTrainFile/-179725236
  (flags/-865622323 (cast-from-var3706-to-var90 var1534))))
  (define-fun var1603 () Int
    (getLength-Arr-Float64-2 arr-Float64-2-init))
  (define-fun var1105 () var2903
    var2903-init)
  (define-fun var2859 () Int
    0)
  (define-fun var2246 () var1694
    (flags/-865622323 (cast-from-var3706-to-var90 var1534)))
  (define-fun var2321 () String
    (trainFile/-179725236 (flags/-865622323 (cast-from-var3706-to-var90 var1534))))
  (define-fun var2834 () Int
    (getLength-Arr-Float64-2 arr-Float64-2-init))
  (define-fun var1805 () Int
    0)
  (define-fun var949 () Int
    (getLength-Arr-Float64-2 arr-Float64-2-init))
  (define-fun var2297 () var2903
    var2903-init)
  (define-fun var712 () var1835
    (let ((a!1 (makeObjectBankFromFile/1614303798
             (cast-from-var3706-to-var90 var1534)
             (trainFile/-179725236
               (flags/-865622323 (cast-from-var3706-to-var90 var1534)))
             (makeReaderAndWriter/-2081966930
               (cast-from-var3706-to-var90 var1534)))))
  (getDataset/-980257756
    var1534
    (cast-from-var3147-to-var3564 a!1)
    (cast-from-var2903-to-var676 var1105!1)
    (cast-from-var2903-to-var676 var2297!1))))
  (define-fun var2608 () (Array Int (Array Int Float64))
    arr-Float64-2-init)
  (define-fun var3876 () var3147
    (makeObjectBankFromFile/1614303798
  (cast-from-var3706-to-var90 var1534)
  (trainFile/-179725236 (flags/-865622323 (cast-from-var3706-to-var90 var1534)))
  (makeReaderAndWriter/-2081966930 (cast-from-var3706-to-var90 var1534))))
  (define-fun null-var3706 () var3706
    var3706!val!1)
  (define-fun var3831 () String
    (confusionMatrix/-179725236
  (flags/-865622323 (cast-from-var3706-to-var90 var1534))))
  (define-fun var3252 () var3147
    (makeObjectBankFromFile/1614303798
  (cast-from-var3706-to-var90 var1534)
  (biasedTrainFile/-179725236
    (flags/-865622323 (cast-from-var3706-to-var90 var1534)))
  (makeReaderAndWriter/-2081966930 (cast-from-var3706-to-var90 var1534))))
  (define-fun var2659 () Int
    (var676_size/127987506 (cast-from-var2903-to-var676 var2297!1)))
  (define-fun var3742 () Int
    (let ((a!1 (num_splits (confusionMatrix/-179725236
                         (flags/-865622323 (cast-from-var3706-to-var90 var1534)))
                       ":")))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var1455 () Int
    (getLength-Arr-Float64-2 arr-Float64-2-init))
  (define-fun var2385 () Int
    0)
  (define-fun var847 () var1835
    (let ((a!1 (makeObjectBankFromFile/1614303798
             (cast-from-var3706-to-var90 var1534)
             (biasedTrainFile/-179725236
               (flags/-865622323 (cast-from-var3706-to-var90 var1534)))
             (makeReaderAndWriter/-2081966930
               (cast-from-var3706-to-var90 var1534)))))
  (getBiasedDataset/-1766800797
    var1534
    a!1
    (cast-from-var2903-to-var676 var1105!1)
    (cast-from-var2903-to-var676 var2297!1))))
  (define-fun var2133 () Int
    (var676_size/127987506 (cast-from-var2903-to-var676 var2297!1)))
  (define-fun var1534 () var3706
    var3706!val!0)
  (define-fun arr-Float64-2-init () (Array Int (Array Int Float64))
    ((as const (Array Int (Array Int Float64)))
  ((as const (Array Int Float64)) (_ +zero 11 53))))
  (define-fun var1566 () var1968
    (makeReaderAndWriter/-2081966930 (cast-from-var3706-to-var90 var1534)))
  (define-fun var138 () var1694
    (flags/-865622323 (cast-from-var3706-to-var90 var1534)))
  (define-fun var454 () Int
    0)
  (define-fun var3842 () Int
    0)
  (define-fun var2021 () var1694
    (flags/-865622323 (cast-from-var3706-to-var90 var1534)))
  (define-fun var2608!1 () (Array Int (Array Int Float64))
    ((as const (Array Int (Array Int Float64)))
  ((as const (Array Int Float64)) (_ NaN 11 53))))
  (define-fun var1105!1 () var2903
    var2903!val!0)
  (define-fun var2903-init () var2903
    var2903!val!0)
  (define-fun var712!1 () var1835
    var1835!val!0)
  (define-fun var2297!1 () var2903
    var2903!val!0)
  (define-fun var1534!1 () var3706
    var3706!val!0)
  (define-fun var847!1 () var1835
    var1835!val!0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun cast-from-var3706-to-var90 ((x!0 var3706)) var90
    var90!val!0)
  (define-fun flags/-865622323 ((x!0 var90)) var1694
    var1694!val!0)
  (define-fun confusionMatrix/-179725236 ((x!0 var1694)) String
    ":")
  (define-fun getLength-Arr-Float64-2 ((x!0 (Array Int (Array Int Float64)))) Int
    0)
  (define-fun trainFile/-179725236 ((x!0 var1694)) String
    "")
  (define-fun getBiasedDataset/-1766800797 ((x!0 var3706)
   (x!1 var3147)
   (x!2 var676)
   (x!3 var676)) var1835
    var1835!val!0)
  (define-fun makeObjectBankFromFile/1614303798 ((x!0 var90)
   (x!1 String)
   (x!2 var1968)) var3147
    var3147!val!0)
  (define-fun <init>/100578090 ((x!0 var2903)) void
    void!val!0)
  (define-fun makeReaderAndWriter/-2081966930 ((x!0 var90)) var1968
    var1968!val!0)
  (define-fun biasedTrainFile/-179725236 ((x!0 var1694)) String
    "")
  (define-fun var676_size/127987506 ((x!0 var676)) Int
    0)
  (define-fun trainSemiSup/448771690 ((x!0 var3706)
   (x!1 var1835)
   (x!2 var1835)
   (x!3 (Array Int (Array Int Float64)))) void
    void!val!0)
  (define-fun cast-from-var2903-to-var676 ((x!0 var2903)) var676
    var676!val!0)
  (define-fun getDataset/-980257756 ((x!0 var3706)
   (x!1 var3564)
   (x!2 var676)
   (x!3 var676)) var1835
    var1835!val!0)
  (define-fun cast-from-var3147-to-var3564 ((x!0 var3147)) var3564
    var3564!val!0)
)
