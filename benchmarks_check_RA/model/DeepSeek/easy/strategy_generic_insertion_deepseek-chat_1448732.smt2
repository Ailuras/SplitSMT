(
  (define-fun sigmaStar_0 () String
    "!0!\<SCRIPT!1!")
  (define-fun literal_3 () String
    "</td>\n</tr>\n")
  (define-fun x_2 () String
    "<tr>\n<td align='center' colspan='4' class='tbl1'>!0!\<SCRIPT!1!")
  (define-fun literal_1 () String
    "<tr>\n<td align='center' colspan='4' class='tbl1'>")
  (define-fun delimiter_5 () String
    "<")
  (define-fun x_4 () String
    "<tr>\n<td align='center' colspan='4' class='tbl1'>!0!\<SCRIPT!1!</td>\n</tr>\n")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "S")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 "<tr>\n<td align='center' colspan='4' class='tbl1'>!0!\<SCRIPT!1!</td>\n</tr>\n")
              (= x!1 (seq.unit (_ Char 60)))
              (= x!2 1))
      "t"
      "t"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
