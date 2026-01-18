(
  (define-fun var3422 () String
    (var223_slurpFile/458402865 var3162))
  (define-fun var1408 () (Array Int (Array Int Float64))
    arr-__Array__Int__Float64__-init)
  (define-fun null-String () String
    "A")
  (define-fun arr-__Array__Int__Float64__-init () (Array Int (Array Int Float64))
    ((as const (Array Int (Array Int Float64)))
  ((as const (Array Int Float64)) (_ +zero 11 53))))
  (define-fun var791 () Int
    (let ((a!1 (num_splits_re (var223_slurpFile/458402865 var3162)
                          (re.+ (re.union (str.to_re "\u{d}")
                                          (str.to_re "\u{a}"))))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var394 () Int
    0)
  (define-fun var27 () Int
    (getLength-Arr-Float64-2 arr-__Array__Int__Float64__-init))
  (define-fun var3162 () String
    "")
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
  (define-fun getLength-Arr-Float64-2 ((x!0 (Array Int (Array Int Float64)))) Int
    0)
  (define-fun var223_slurpFile/458402865 ((x!0 String)) String
    "")
)
