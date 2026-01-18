(
  ;; universe for var1761:
  ;;   var1761!val!0 var1761!val!1 var1761!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1761!val!0 () var1761)
  (declare-fun var1761!val!1 () var1761)
  (declare-fun var1761!val!2 () var1761)
  ;; cardinality constraint:
  (forall ((x var1761))
          (or (= x var1761!val!0) (= x var1761!val!1) (= x var1761!val!2)))
  ;; -----------
  ;; universe for ClassObject:
  ;;   ClassObject!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun ClassObject!val!0 () ClassObject)
  ;; cardinality constraint:
  (forall ((x ClassObject)) (= x ClassObject!val!0))
  ;; -----------
  (define-fun var116 () String
    "normArDigits,normArPunc,normAlif,removeDiacritics,removeTatweel,removeQuranChars")
  (define-fun var538!1 () (Array Int var1761)
    (store ((as const (Array Int var1761)) var1761!val!0) 2 var1761!val!1))
  (define-fun var1042 () var512
    (var447_channels/-1873906782 var538!1))
  (define-fun var3442 () var158
    var218!1)
  (define-fun var538 () (Array Int var1761)
    arr-var1761-init)
  (define-fun var1048 () Int
    0)
  (define-fun var609!class () ClassObject
    ClassObject!val!0)
  (define-fun var382 () var512
    (var447_channels/-1873906782 var538!1))
  (define-fun var3733 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits "normArDigits,normArPunc,normAlif,removeDiacritics,removeTatweel,removeQuranChars"
                         ",")
             (- 1))
          (num_splits "normArDigits,normArPunc,normAlif,removeDiacritics,removeTatweel,removeQuranChars"
                      ",")
          (- 1))
     (num_splits "normArDigits,normArPunc,normAlif,removeDiacritics,removeTatweel,removeQuranChars"
                 ",")))
  (define-fun var218 () var158
    var158-init)
  (define-fun null-__Array__Int__var1761__ () (Array Int var1761)
    ((as const (Array Int var1761)) var1761!val!2))
  (define-fun arr-var1761-init () (Array Int var1761)
    ((as const (Array Int var1761)) var1761!val!0))
  (define-fun var218!1 () var158
    var158!val!0)
  (define-fun var158-init () var158
    var158!val!0)
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
  (define-fun cast-from-ClassObject-to-var1761 ((x!0 ClassObject)) var1761
    var1761!val!0)
  (define-fun <init>/964458484 ((x!0 var158)) void
    void!val!0)
  (define-fun var447_channels/-1873906782 ((x!0 (Array Int var1761))) var512
    var512!val!0)
)
