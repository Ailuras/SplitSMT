(
  ;; universe for var1951:
  ;;   var1951!val!1 var1951!val!2 var1951!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1951!val!1 () var1951)
  (declare-fun var1951!val!2 () var1951)
  (declare-fun var1951!val!0 () var1951)
  ;; cardinality constraint:
  (forall ((x var1951))
          (or (= x var1951!val!1) (= x var1951!val!2) (= x var1951!val!0)))
  ;; -----------
  ;; universe for var2525:
  ;;   var2525!val!0 var2525!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2525!val!0 () var2525)
  (declare-fun var2525!val!1 () var2525)
  ;; cardinality constraint:
  (forall ((x var2525)) (or (= x var2525!val!0) (= x var2525!val!1)))
  ;; -----------
  ;; universe for var1983:
  ;;   var1983!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1983!val!0 () var1983)
  ;; cardinality constraint:
  (forall ((x var1983)) (= x var1983!val!0))
  ;; -----------
  ;; universe for var350:
  ;;   var350!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var350!val!0 () var350)
  ;; cardinality constraint:
  (forall ((x var350)) (= x var350!val!0))
  ;; -----------
  ;; universe for Iterator:
  ;;   Iterator!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun Iterator!val!0 () Iterator)
  ;; cardinality constraint:
  (forall ((x Iterator)) (= x Iterator!val!0))
  ;; -----------
  (define-fun var1220!4 () var1951
    var1951!val!2)
  (define-fun var2852 () var338
    (parser/-1031716714 var3733))
  (define-fun var360 () Bool
    (buildCharacterMapPerAnnotation/-1031716714 var3733))
  (define-fun var1220 () var1951
    var1951!val!0)
  (define-fun null-var1951 () var1951
    var1951!val!1)
  (define-fun var751 () String
    var2525-COREF_PATH)
  (define-fun var3317 () var3936
    var3936-init)
  (define-fun var3366 () var3077
    (characterMap/-1031716714 var3733))
  (define-fun var3213 () var1120
    var1120-init)
  (define-fun null-var2525 () var2525
    var2525!val!1)
  (define-fun var136 () var1121
    var1121-init)
  (define-fun var2811 () var3077
    (getQMMapping/361786175
  var3733
  var1220!4
  (var902_setupCoref/-491369574
    var2525-COREF_PATH
    (characterMap/-1031716714 var3733)
    var1220!1)))
  (define-fun var10 () String
    (msSieveList/-1031716714 var3733))
  (define-fun var2062 () Bool
    (Iterator_hasNext/-1669924200
  (var1983_iterator/-912451715
    (var3293_gatherQuotes/-846678570 (cast-from-var1951-to-var350 var1220!4)))))
  (define-fun var1513 () Int
    0)
  (define-fun var1399 () var3077
    (var902_setupCoref/-491369574
  var2525-COREF_PATH
  (characterMap/-1031716714 var3733)
  var1220!1))
  (define-fun var151 () var338
    (parser/-1031716714 var3733))
  (define-fun var120 () Int
    (let ((a!1 (ite (< (num_splits (qmSieveList/-1031716714 var3733) ",") (- 1))
                (num_splits (qmSieveList/-1031716714 var3733) ",")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (qmSieveList/-1031716714 var3733) ","))))
  (define-fun var2608 () Int
    (let ((a!1 (ite (< (num_splits (msSieveList/-1031716714 var3733) ",") (- 1))
                (num_splits (msSieveList/-1031716714 var3733) ",")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (msSieveList/-1031716714 var3733) ","))))
  (define-fun var638 () String
    (qmSieveList/-1031716714 var3733))
  (define-fun var3733 () var2525
    var2525!val!0)
  (define-fun var2042 () var3077
    (getMSMapping/592998345
  var3733
  var1220!4
  (var902_setupCoref/-491369574
    var2525-COREF_PATH
    (characterMap/-1031716714 var3733)
    var1220!1)))
  (define-fun var89 () Int
    0)
  (define-fun var1532 () Iterator
    (var1983_iterator/-912451715
  (var3293_gatherQuotes/-846678570 (cast-from-var1951-to-var350 var1220!4))))
  (define-fun var1278 () var1983
    (var3293_gatherQuotes/-846678570 (cast-from-var1951-to-var350 var1220!4)))
  (define-fun var2525-COREF_PATH () String
    "")
  (define-fun var1064 () Int
    0)
  (define-fun var3213!2 () var1120
    var1120!val!0)
  (define-fun var1121-init () var1121
    var1121!val!0)
  (define-fun var3317!2 () var3936
    var3936!val!0)
  (define-fun var1220!3 () var1951
    var1951!val!1)
  (define-fun var2852!1 () var338
    var338!val!0)
  (define-fun var1329 () String
    "")
  (define-fun var3213!1 () var1120
    var1120!val!0)
  (define-fun var136!2 () var1121
    var1121!val!0)
  (define-fun var3936-init () var3936
    var3936!val!0)
  (define-fun var1587 () String
    "")
  (define-fun var136!1 () var1121
    var1121!val!0)
  (define-fun var136!3 () var1121
    var1121!val!0)
  (define-fun var1220!2 () var1951
    var1951!val!1)
  (define-fun var1120-init () var1120
    var1120!val!0)
  (define-fun var151!1 () var338
    var338!val!0)
  (define-fun var1220!1 () var1951
    var1951!val!1)
  (define-fun var3317!1 () var3936
    var3936!val!0)
  (define-fun qmSieveList/-1031716714 ((x!0 var2525)) String
    (ite (= x!0 var2525!val!0) ","
      ","))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun Iterator_hasNext/-1669924200 ((x!0 Iterator)) Bool
    false)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun cast-from-var1951-to-var350 ((x!0 var1951)) var350
    var350!val!0)
  (define-fun msSieveList/-1031716714 ((x!0 var2525)) String
    (ite (= x!0 var2525!val!0) ","
      ","))
  (define-fun var3293_gatherQuotes/-846678570 ((x!0 var350)) var1983
    var1983!val!0)
  (define-fun var1983_iterator/-912451715 ((x!0 var1983)) Iterator
    Iterator!val!0)
  (define-fun buildCharacterMapPerAnnotation/-1031716714 ((x!0 var2525)) Bool
    false)
  (define-fun var902_addEnhancedSentences/-1856196795 ((x!0 var1951) (x!1 var338)) void
    void!val!0)
  (define-fun parser/-1031716714 ((x!0 var2525)) var338
    var338!val!0)
  (define-fun getQMMapping/361786175 ((x!0 var2525) (x!1 var1951) (x!2 var3077)) var3077
    var3077!val!0)
  (define-fun getMSMapping/592998345 ((x!0 var2525) (x!1 var1951) (x!2 var3077)) var3077
    var3077!val!0)
  (define-fun characterMap/-1031716714 ((x!0 var2525)) var3077
    var3077!val!0)
  (define-fun <init>/1273068990 ((x!0 var3936) (x!1 var1121) (x!2 Bool)) void
    void!val!0)
  (define-fun <init>/865666258 ((x!0 var1120)) void
    void!val!0)
  (define-fun var902_setupCoref/-491369574 ((x!0 String)
   (x!1 var3077)
   (x!2 var1951)) var3077
    var3077!val!0)
  (define-fun var902_annotateForDependencyParse/2124179671 ((x!0 var1951)
   (x!1 var338)) void
    void!val!0)
  (define-fun <init>/964458484 ((x!0 var1121)) void
    void!val!0)
  (define-fun annotate/-1213120409 ((x!0 var3936) (x!1 var1951)) void
    void!val!0)
  (define-fun annotate/-1676560150 ((x!0 var1120) (x!1 var1951)) void
    void!val!0)
  (define-fun setProperty/703705272 ((x!0 var1121) (x!1 String) (x!2 String)) var1501
    var1501!val!0)
)
