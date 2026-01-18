(
  (define-fun X () String
    "NetTracker.htaServerTheef2trustyfiles.comlogsHost:version\u{a}")
  (define-fun version_part () String
    "version\u{a}")
  (define-fun before_version () String
    "")
  (define-fun after_host () String
    "N")
  (define-fun host_part () String
    "version\u{a}")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "N")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "N") (= x!1 (seq.unit (_ Char 58))) (= x!2 1))
      "version\u{a}"
    (ite (and (= x!0 "N") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) ""
      "version\u{a}")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
