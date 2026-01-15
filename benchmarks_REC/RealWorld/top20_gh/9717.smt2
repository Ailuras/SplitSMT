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

(declare-sort var3344 0)
(declare-sort var1020 0)
(declare-sort var3888 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun size/-1863229846 (var3344) Int)
(declare-fun add/1770215592 (var3344 var3888) Bool)
(declare-fun cast-from-String-to-var3888 (String) var3888)
(declare-const null-var3344 var3344)
(declare-const null-String String)
(declare-const var3932 var3344) ; Statement: r0 := @parameter0: java.util.ArrayList 
(assert (not (= var3932 null-var3344)))
(declare-const var2747 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2747 null-String)))
(assert true)
(define-const var191 Int (size/-1863229846 var3932)) ; Statement: $i0 = virtualinvoke r0.<java.util.ArrayList: int size()>() 
(define-const var2078 Int (mod var191 2)) ; Statement: $i1 = $i0 % 2 
 ; Statement: if $i1 != 1 goto r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(assert (not (= var2078 1))) ; Cond: $i1 != 1 
; split operation: var2213 = var2747.split(":") ; Statement: r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var1813 Int (get_split_length var2747 ":" (- 1))) ; Statement: $i2 = lengthof r15 
 ; Statement: if $i2 <= 0 goto $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(assert (<= var1813 0)) ; Cond: $i2 <= 0 
; split operation: var1091 = var2747.split("=") ; Statement: $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var3063 Int (get_split_length var2747 "=" (- 1))) ; Statement: $i3 = lengthof $r8 
 ; Statement: if $i3 <= 0 goto virtualinvoke r0.<java.util.ArrayList: boolean add(java.lang.Object)>(r1) 
(assert (<= var3063 0)) ; Cond: $i3 <= 0 
(assert true)
;(assert (add/1770215592 var3932 (cast-from-String-to-var3888 var2747))) ; Statement: virtualinvoke r0.<java.util.ArrayList: boolean add(java.lang.Object)>(r1) 

(declare-const var3932!1 var3344)
(declare-const var2747!1 String)
 ; Statement: return r0 
(check-sat)
; {size/-1863229846=([java.util.ArrayList], int), add/1770215592=([java.util.ArrayList, java.lang.Object], boolean), cast-from-String-to-var3888=([java.lang.String], java.lang.Object)}
; {var3344=java.util.ArrayList, var3932=r0, var2747=r1, var1020=null_type, var191=$i0, var2078=$i1, var2213=r15, var1813=$i2, var1091=$r8, var3063=$i3, var3888=java.lang.Object}
; {java.util.ArrayList=var3344, r0=var3932, r1=var2747, null_type=var1020, $i0=var191, $i1=var2078, r15=var2213, $i2=var1813, $r8=var1091, $i3=var3063, java.lang.Object=var3888}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.util.ArrayList;	r1 := @parameter1: java.lang.String;	$i0 = virtualinvoke r0.<java.util.ArrayList: int size()>();	$i1 = $i0 % 2;	if $i1 != 1 goto r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i2 = lengthof r15;	if $i2 <= 0 goto $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	$r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	$i3 = lengthof $r8;	if $i3 <= 0 goto virtualinvoke r0.<java.util.ArrayList: boolean add(java.lang.Object)>(r1);	virtualinvoke r0.<java.util.ArrayList: boolean add(java.lang.Object)>(r1);	return r0
;block_num 4
(exit)
