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

(declare-sort var1119 0)
(declare-sort var1952 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getOutput/-1207014030 (var1952) String)
(declare-fun cast-from-var1119-to-var1952 (var1119) var1952)
(declare-fun Float64_parseDouble/1471110886 (String) Float64)
(declare-const null-var1119 var1119)
(declare-const var1051 var1119) ; Statement: r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierEvaluator 
(assert (not (= var1051 null-var1119)))
(assert true)
(define-const var1531 String (getOutput/-1207014030 (cast-from-var1119-to-var1952 var1051))) ; Statement: r1 = virtualinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: java.lang.String getOutput()>() 
; split operation: var1441 = var1531.split("\u005cs+") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1742 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var2524 Int (get_split_length var1531 "\u005cs+" (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if i2 >= $i0 goto i3 = i2 + 1 
(assert (>= var1742 var2524)) ; Cond: i2 >= $i0 
(define-const var3409 Int (+ var1742 1)) ; Statement: i3 = i2 + 1 
(define-const var2269 Int (get_split_length var1531 "\u005cs+" (- 1))) ; Statement: $i1 = lengthof r2 
 ; Statement: if i3 >= $i1 goto $r5 = <edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> 
(assert (not (>= var3409 var2269))) ; Negate: Cond: i3 >= $i1  
(define-const var3970 String (get_split_element var1531 "\u005cs+" (- 1) var3409)) ; Statement: $r9 = r2[i3] 
(define-const var2514 Float64 (Float64_parseDouble/1471110886 var3970)) ; Statement: $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>($r9) 
 ; Statement: return $d0 
(check-sat)
; {getOutput/-1207014030=([edu.stanford.nlp.optimization.CmdEvaluator], java.lang.String), cast-from-var1119-to-var1952=([edu.stanford.nlp.ie.crf.CRFClassifierEvaluator], edu.stanford.nlp.optimization.CmdEvaluator), Float64_parseDouble/1471110886=([java.lang.String], double)}
; {var1119=edu.stanford.nlp.ie.crf.CRFClassifierEvaluator, var1051=r0, var1952=edu.stanford.nlp.optimization.CmdEvaluator, var1531=r1, var1441=r2, var1742=i2, var2524=$i0, var3409=i3, var2269=$i1, var3970=$r9, var2514=$d0}
; {edu.stanford.nlp.ie.crf.CRFClassifierEvaluator=var1119, r0=var1051, edu.stanford.nlp.optimization.CmdEvaluator=var1952, r1=var1531, r2=var1441, i2=var1742, $i0=var2524, i3=var3409, $i1=var2269, $r9=var3970, $d0=var2514}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierEvaluator;	r1 = virtualinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: java.lang.String getOutput()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	i2 = 0;	$i0 = lengthof r2;	if i2 >= $i0 goto i3 = i2 + 1;	i3 = i2 + 1;	$i1 = lengthof r2;	if i3 >= $i1 goto $r5 = <edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>;	$r9 = r2[i3];	$d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>($r9);	return $d0
;block_num 4
(exit)
