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

(declare-sort var2570 0)
(declare-sort var3940 0)
(declare-sort var1550 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3940_getValue/381491177 (var3940) var1550)
(declare-fun cast-from-var1550-to-String (var1550) String)
(declare-fun var2570_contains/1636690605 (var2570 var1550) Bool)
(declare-fun cast-from-String-to-var1550 (String) var1550)
(declare-const null-var2570 var2570)
(declare-const null-var3940 var3940)
(declare-const var1846 var2570) ; Statement: r0 := @parameter0: java.util.Set 
(assert (not (= var1846 null-var2570)))
(declare-const var1576 var3940) ; Statement: r1 := @parameter1: java.util.Map$Entry 
(assert (not (= var1576 null-var3940)))
(define-const var3795 var1550 (var3940_getValue/381491177 var1576)) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>() 
(define-const var1738 String (cast-from-var1550-to-String var3795)) ; Statement: $r3 = (java.lang.String) $r2 
; split operation: var2638 = var1738.split(" ") ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var1306 String (get_split_element var1738 " " (- 1) 0)) ; Statement: $r5 = $r4[0] 
(define-const var1122 Bool (var2570_contains/1636690605 var1846 (cast-from-String-to-var1550 var1306))) ; Statement: $z0 = interfaceinvoke r0.<java.util.Set: boolean contains(java.lang.Object)>($r5) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var1122 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3494 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var3940_getValue/381491177=([java.util.Map$Entry], java.lang.Object), cast-from-var1550-to-String=([java.lang.Object], java.lang.String), var2570_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var1550=([java.lang.String], java.lang.Object)}
; {var2570=java.util.Set, var1846=r0, var3940=java.util.Map$Entry, var1576=r1, var1550=java.lang.Object, var3795=$r2, var1738=$r3, var2638=$r4, var1306=$r5, var1122=$z0, var3494=$z1}
; {java.util.Set=var2570, r0=var1846, java.util.Map$Entry=var3940, r1=var1576, java.lang.Object=var1550, $r2=var3795, $r3=var1738, $r4=var2638, $r5=var1306, $z0=var1122, $z1=var3494}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Set;	r1 := @parameter1: java.util.Map$Entry;	$r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>();	$r3 = (java.lang.String) $r2;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$r5 = $r4[0];	$z0 = interfaceinvoke r0.<java.util.Set: boolean contains(java.lang.Object)>($r5);	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3
(exit)
