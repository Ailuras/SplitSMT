(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

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

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(declare-sort var292 0)
(declare-sort var3722 0)
(declare-sort var130 0)
(declare-sort var604 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3722-init () var3722)
(declare-fun <init>/-325640736 (var3722) void)
(declare-fun var130_getSieves/-107895238 (var292) String)
(declare-fun var130_getCurrentSieveForTrain/-1427544085 (var292) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var292 var292)
(declare-const null-String String)
(declare-const var2909 var292) ; Statement: r1 := @parameter0: java.util.Properties 
(assert (not (= var2909 null-var292)))
(define-const var1308 var3722 var3722-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1308)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1308!1 var3722)
(define-const var1452 String (var130_getSieves/-107895238 var2909)) ; Statement: r2 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getSieves(java.util.Properties)>(r1) 
(define-const var1642 String (var130_getCurrentSieveForTrain/-1427544085 var2909)) ; Statement: r3 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getCurrentSieveForTrain(java.util.Properties)>(r1) 
 ; Statement: if r3 != null goto $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3) 
(assert (not (= var1642 null-String))) ; Cond: r3 != null 
; split operation: var271 = var1452.split(var1642) ; Statement: $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3) 
(define-const var966 String (get_split_element var1452 var1642 (- 1) 0)) ; Statement: $r5 = $r4[0] 
(assert true)
(define-const var2722 String (trim/-847153721 var966)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.String: java.lang.String trim()>() 
; split operation: var1817 = var2722.split(",\u005cs*") ; Statement: $r11 = virtualinvoke $r6.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*") 
(assert true) ; Non Conditional
(declare-const var1817 (Array Int String))
(define-const var1073 (Array Int String) var1817) ; Statement: r7 = $r11 
(define-const var3817 Int (get_split_length_re var2722 (re.++ (str.to_re ",") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: $i0 = lengthof $r11 
(define-const var386 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return $r0 
(assert (>= var386 var3817)) ; Cond: i1 >= $i0 
 ; Statement: return $r0 
; {var3722-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var130_getSieves/-107895238=([java.util.Properties], java.lang.String), var130_getCurrentSieveForTrain/-1427544085=([java.util.Properties], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var292=java.util.Properties, var2909=r1, var3722=java.util.ArrayList, var1308=$r0, var130=edu.stanford.nlp.coref.hybrid.HybridCorefProperties, var1452=r2, var1642=r3, var604=null_type, var271=$r4, var966=$r5, var2722=$r6, var1817=$r11, var1073=r7, var3817=$i0, var386=i1}
; {java.util.Properties=var292, r1=var2909, java.util.ArrayList=var3722, $r0=var1308, edu.stanford.nlp.coref.hybrid.HybridCorefProperties=var130, r2=var1452, r3=var1642, null_type=var604, $r4=var271, $r5=var966, $r6=var2722, $r11=var1817, r7=var1073, $i0=var3817, i1=var386}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r1 := @parameter0: java.util.Properties;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getSieves(java.util.Properties)>(r1);	r3 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getCurrentSieveForTrain(java.util.Properties)>(r1);	if r3 != null goto $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3);	$r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3);	$r5 = $r4[0];	$r6 = virtualinvoke $r5.<java.lang.String: java.lang.String trim()>();	$r11 = virtualinvoke $r6.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*");	r7 = $r11;	$i0 = lengthof $r11;	i1 = 0;	if i1 >= $i0 goto return $r0;	return $r0
;block_num 5
(check-sat)
(exit)
