(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(declare-sort var3242 0)
(declare-sort var2858 0)
(declare-sort var751 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun readLine/150542008 (var2858) String)
(declare-fun var751-init () var751)
(declare-fun <init>/-1084991535 (var751 String) void)
(declare-const null-var3242 var3242)
(declare-const null-var2858 var2858)
(declare-const var3799 var3242) ; Statement: r3 := @this: edu.stanford.nlp.ie.crf.CRFClassifier 
(assert (not (= var3799 null-var3242)))
(declare-const var3484 var2858) ; Statement: r0 := @parameter0: java.io.BufferedReader 
(assert (not (= var3484 null-var2858)))
(assert true)
(define-const var1492 String (readLine/150542008 var3484)) ; Statement: r86 = virtualinvoke r0.<java.io.BufferedReader: java.lang.String readLine()>() 
; split operation: var3925 = var1492.split("\u005ct") ; Statement: r87 = virtualinvoke r86.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t") 
(define-const var1133 String (get_split_element var1492 "\u005ct" (- 1) 0)) ; Statement: $r1 = r87[0] 
(assert true)
(define-const var2898 Bool (= var1133 "labelIndices.length=")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("labelIndices.length=") 
 ; Statement: if $z0 != 0 goto $r2 = r87[1] 
(assert (not (not (= (ite var2898 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2345 var751 var751-init) ; Statement: $r85 = new java.lang.RuntimeException 
(assert true)
;(assert (<init>/-1084991535 var2345 "format error")) ; Statement: specialinvoke $r85.<java.lang.RuntimeException: void <init>(java.lang.String)>("format error") 

(declare-const var2345!1 var751)
(declare-const var3520 String)
 ; Statement: throw $r85 
(check-sat)
; {readLine/150542008=([java.io.BufferedReader], java.lang.String), var751-init=([], java.lang.RuntimeException), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3242=edu.stanford.nlp.ie.crf.CRFClassifier, var3799=r3, var2858=java.io.BufferedReader, var3484=r0, var1492=r86, var3925=r87, var1133=$r1, var2898=$z0, var751=java.lang.RuntimeException, var2345=$r85, var3520="format error"}
; {edu.stanford.nlp.ie.crf.CRFClassifier=var3242, r3=var3799, java.io.BufferedReader=var2858, r0=var3484, r86=var1492, r87=var3925, $r1=var1133, $z0=var2898, java.lang.RuntimeException=var751, $r85=var2345, "format error"=var3520}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: edu.stanford.nlp.ie.crf.CRFClassifier;	r0 := @parameter0: java.io.BufferedReader;	r86 = virtualinvoke r0.<java.io.BufferedReader: java.lang.String readLine()>();	r87 = virtualinvoke r86.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t");	$r1 = r87[0];	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("labelIndices.length=");	if $z0 != 0 goto $r2 = r87[1];	$r85 = new java.lang.RuntimeException;	specialinvoke $r85.<java.lang.RuntimeException: void <init>(java.lang.String)>("format error");	throw $r85
;block_num 2
(exit)
