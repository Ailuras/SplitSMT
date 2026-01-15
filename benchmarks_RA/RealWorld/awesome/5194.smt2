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
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

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

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var2405 0)
(declare-sort var876 0)
(declare-sort var84 0)
(declare-sort var2892 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var876-init () var876)
(declare-fun <init>/-325640736 (var876) void)
(declare-fun var84_getSieves/-107895238 (var2405) String)
(declare-fun var84_getCurrentSieveForTrain/-1427544085 (var2405) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var2405 var2405)
(declare-const null-String String)
(declare-const var1504 var2405) ; Statement: r1 := @parameter0: java.util.Properties 
(assert (not (= var1504 null-var2405)))
(define-const var2393 var876 var876-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2393)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2393!1 var876)
(define-const var2051 String (var84_getSieves/-107895238 var1504)) ; Statement: r2 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getSieves(java.util.Properties)>(r1) 
(define-const var1630 String (var84_getCurrentSieveForTrain/-1427544085 var1504)) ; Statement: r3 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getCurrentSieveForTrain(java.util.Properties)>(r1) 
 ; Statement: if r3 != null goto $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3) 
(assert (not (not (= var1630 null-String)))) ; Negate: Cond: r3 != null  
(assert true)
(define-const var3067 String (trim/-847153721 var2051)) ; Statement: $r10 = virtualinvoke r2.<java.lang.String: java.lang.String trim()>() 
; split operation: var3464 = var3067.split(",\u005cs*") ; Statement: $r11 = virtualinvoke $r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*") 
 ; Statement: goto [?= r7 = $r11] 
(assert true) ; Non Conditional
(declare-const var3464 (Array Int String))
(define-const var2670 (Array Int String) var3464) ; Statement: r7 = $r11 
(define-const var2774 Int (get_split_length_re var3067 (re.++ (str.to_re ",") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: $i0 = lengthof $r11 
(define-const var87 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return $r0 
(assert (>= var87 var2774)) ; Cond: i1 >= $i0 
 ; Statement: return $r0 
(check-sat)
; {var876-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var84_getSieves/-107895238=([java.util.Properties], java.lang.String), var84_getCurrentSieveForTrain/-1427544085=([java.util.Properties], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var2405=java.util.Properties, var1504=r1, var876=java.util.ArrayList, var2393=$r0, var84=edu.stanford.nlp.coref.hybrid.HybridCorefProperties, var2051=r2, var1630=r3, var2892=null_type, var3067=$r10, var3464=$r11, var2670=r7, var2774=$i0, var87=i1}
; {java.util.Properties=var2405, r1=var1504, java.util.ArrayList=var876, $r0=var2393, edu.stanford.nlp.coref.hybrid.HybridCorefProperties=var84, r2=var2051, r3=var1630, null_type=var2892, $r10=var3067, $r11=var3464, r7=var2670, $i0=var2774, i1=var87}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.util.Properties;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getSieves(java.util.Properties)>(r1);	r3 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getCurrentSieveForTrain(java.util.Properties)>(r1);	if r3 != null goto $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3);	$r10 = virtualinvoke r2.<java.lang.String: java.lang.String trim()>();	$r11 = virtualinvoke $r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*");	goto [?= r7 = $r11];	r7 = $r11;	$i0 = lengthof $r11;	i1 = 0;	if i1 >= $i0 goto return $r0;	return $r0
;block_num 5
(exit)
