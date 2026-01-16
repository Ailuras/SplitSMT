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

(declare-sort var1017 0)
(declare-sort var1839 0)
(declare-sort var3598 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun put/-1127386829 (var1017 var3598 var3598) var3598)
(declare-fun cast-from-String-to-var3598 (String) var3598)
(declare-fun cast-from-var3598-to-String (var3598) String)
(declare-const null-var1017 var1017)
(declare-const null-String String)
(declare-const var2918 var1017) ; Statement: r0 := @parameter0: java.util.HashMap 
(assert (not (= var2918 null-var1017)))
(declare-const var2380 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2380 null-String)))
; split operation: var2149 = var2380.split("=") ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var3370 String (get_split_element var2380 "=" (- 1) 0)) ; Statement: $r3 = $r2[0] 
; split operation: var3998 = var2380.split("=") ; Statement: $r4 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var1687 String (get_split_element var2380 "=" (- 1) 1)) ; Statement: $r5 = $r4[1] 
(assert true)
(define-const var3144 var3598 (put/-1127386829 var2918 (cast-from-String-to-var3598 var3370) (cast-from-String-to-var3598 var1687))) ; Statement: $r6 = virtualinvoke r0.<java.util.HashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r3, $r5) 
(define-const var2164 String (cast-from-var3598-to-String var3144)) ; Statement: $r7 = (java.lang.String) $r6 
 ; Statement: return 
; {put/-1127386829=([java.util.HashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3598=([java.lang.String], java.lang.Object), cast-from-var3598-to-String=([java.lang.Object], java.lang.String)}
; {var1017=java.util.HashMap, var2918=r0, var2380=r1, var1839=null_type, var2149=$r2, var3370=$r3, var3998=$r4, var1687=$r5, var3598=java.lang.Object, var3144=$r6, var2164=$r7}
; {java.util.HashMap=var1017, r0=var2918, r1=var2380, null_type=var1839, $r2=var2149, $r3=var3370, $r4=var3998, $r5=var1687, java.lang.Object=var3598, $r6=var3144, $r7=var2164}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.util.HashMap;	r1 := @parameter1: java.lang.String;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	$r3 = $r2[0];	$r4 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	$r5 = $r4[1];	$r6 = virtualinvoke r0.<java.util.HashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>($r3, $r5);	$r7 = (java.lang.String) $r6;	return
;block_num 1
(check-sat)
(exit)
