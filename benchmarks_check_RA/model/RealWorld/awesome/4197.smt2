(model
  (define-fun var2265 () String "#$")
  (define-fun null-String () String "")
  (define-fun abbrev_126 ((x!0 Int)) Int (ite (= x!0 0) 1 0))
  (define-fun replaceFirst/750800361 ((x!0 String) (x!1 String) (x!2 String)) String (ite (and (and (= x!0 "#$") (= x!1 "#.*$")) (= x!2 "")) "" ""))
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int (ite (and (= x!0 "") (= x!1 RegLan!40)) 1 0))
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String (ite (and (and (= x!0 "") (= x!1 RegLan!40)) (= x!2 0)) "" ""))
)
