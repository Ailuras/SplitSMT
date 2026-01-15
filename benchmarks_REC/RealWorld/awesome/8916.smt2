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

(declare-sort var1774 0)
(declare-sort var2299 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun info/114590825 (var2299 String) void)
(declare-const null-String String)
(declare-const null-var2299 var2299)
(declare-const null-Bool Bool)
(declare-const var578 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var578 null-String)))
(declare-const var2995 var2299) ; Statement: r3 := @parameter1: java.util.logging.Logger 
(assert (not (= var2995 null-var2299)))
(declare-const var2838 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2838 null-Bool)))
; split operation: var1509 = var578.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (not (= (ite var2838 1 0) 0)))) ; Negate: Cond: z0 != 0  
(define-const var2887 Int (get_split_length_re var578 (re.union (str.to_re "\u{0D}") (str.to_re "\u{0A}")) (- 1))) ; Statement: i0 = lengthof r1 
(define-const var911 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto (branch) 
(assert (not (>= var911 var2887))) ; Negate: Cond: i1 >= i0  
(define-const var2462 String (get_split_element_re var578 (re.union (str.to_re "\u{0D}") (str.to_re "\u{0A}")) (- 1) var911)) ; Statement: r7 = r1[i1] 
(assert true)
(define-const var2394 Bool (startsWith/-1785782452 var2462 "Identification of Mentions")) ; Statement: $z4 = virtualinvoke r7.<java.lang.String: boolean startsWith(java.lang.String)>("Identification of Mentions") 
 ; Statement: if $z4 == 0 goto i1 = i1 + 1 
(assert (not (= (ite var2394 1 0) 0))) ; Negate: Cond: $z4 == 0  
(assert true)
;(assert (info/114590825 var2995 var2462)) ; Statement: virtualinvoke r3.<java.util.logging.Logger: void info(java.lang.String)>(r7) 

(declare-const var2995!1 var2299)
(declare-const var2462!1 String)
 ; Statement: return 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), info/114590825=([java.util.logging.Logger, java.lang.String], void)}
; {var578=r0, var1774=null_type, var2299=java.util.logging.Logger, var2995=r3, var2838=z0, var1509=r1, var2887=i0, var911=i1, var2462=r7, var2394=$z4}
; {r0=var578, null_type=var1774, java.util.logging.Logger=var2299, r3=var2995, z0=var2838, r1=var1509, i0=var2887, i1=var911, r7=var2462, $z4=var2394}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto (branch);	r7 = r1[i1];	$z4 = virtualinvoke r7.<java.lang.String: boolean startsWith(java.lang.String)>("Identification of Mentions");	if $z4 == 0 goto i1 = i1 + 1;	virtualinvoke r3.<java.util.logging.Logger: void info(java.lang.String)>(r7);	return
;block_num 5
(exit)
