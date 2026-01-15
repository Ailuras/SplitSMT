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

(declare-sort var1154 0)
(declare-sort var3626 0)
(declare-sort var774 0)
(declare-sort var3277 0)
(declare-sort var782 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isLoggable/-616065502 (var3277 var782) Bool)
(declare-const null-var1154 var1154)
(declare-const null-var3626 var3626)
(declare-const null-String String)
(declare-const var1154-log var3277)
(declare-const var782-FINEST var782)
(declare-const var2478 var1154) ; Statement: r3 := @this: org.jline.utils.StyleResolver 
(assert (not (= var2478 null-var1154)))
(declare-const var3271 var3626) ; Statement: r10 := @parameter0: org.jline.utils.AttributedStyle 
(assert (not (= var3271 null-var3626)))
(declare-const var19 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var19 null-String)))
(define-const var629 var3277 var1154-log) ; Statement: $r1 = <org.jline.utils.StyleResolver: java.util.logging.Logger log> 
(define-const var2789 var782 var782-FINEST) ; Statement: $r0 = <java.util.logging.Level: java.util.logging.Level FINEST> 
(assert true)
(define-const var3610 Bool (isLoggable/-616065502 var629 var2789)) ; Statement: $z0 = virtualinvoke $r1.<java.util.logging.Logger: boolean isLoggable(java.util.logging.Level)>($r0) 
 ; Statement: if $z0 == 0 goto $r9 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(assert (= (ite var3610 1 0) 0)) ; Cond: $z0 == 0 
; split operation: var3110 = var19.split(",") ; Statement: $r9 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var664 Int (get_split_length var19 "," (- 1))) ; Statement: $i0 = lengthof $r9 
(define-const var3925 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return r10 
(assert (>= var3925 var664)) ; Cond: i1 >= $i0 
 ; Statement: return r10 
(check-sat)
; {isLoggable/-616065502=([java.util.logging.Logger, java.util.logging.Level], boolean)}
; {var1154=org.jline.utils.StyleResolver, var2478=r3, var3626=org.jline.utils.AttributedStyle, var3271=r10, var19=r2, var774=null_type, var3277=java.util.logging.Logger, var629=$r1, var782=java.util.logging.Level, var2789=$r0, var3610=$z0, var3110=$r9, var664=$i0, var3925=i1}
; {org.jline.utils.StyleResolver=var1154, r3=var2478, org.jline.utils.AttributedStyle=var3626, r10=var3271, r2=var19, null_type=var774, java.util.logging.Logger=var3277, $r1=var629, java.util.logging.Level=var782, $r0=var2789, $z0=var3610, $r9=var3110, $i0=var664, i1=var3925}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: org.jline.utils.StyleResolver;	r10 := @parameter0: org.jline.utils.AttributedStyle;	r2 := @parameter1: java.lang.String;	$r1 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>;	$r0 = <java.util.logging.Level: java.util.logging.Level FINEST>;	$z0 = virtualinvoke $r1.<java.util.logging.Logger: boolean isLoggable(java.util.logging.Level)>($r0);	if $z0 == 0 goto $r9 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r9 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof $r9;	i1 = 0;	if i1 >= $i0 goto return r10;	return r10
;block_num 4
(exit)
