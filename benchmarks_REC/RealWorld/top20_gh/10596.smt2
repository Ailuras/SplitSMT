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

(declare-sort var3951 0)
(declare-sort var1997 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-var1997 var1997)
(declare-const var2425 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2425 null-String)))
(define-const var2347 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
(assert true)
(define-const var2113 Int (length/-134980193 var2425)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if i6 >= $i0 goto (branch) 
(assert (>= var2347 var2113)) ; Cond: i6 >= $i0 
 ; Statement: if i6 != 0 goto $i1 = i6 - 1 
(assert (not (not (= var2347 0)))) ; Negate: Cond: i6 != 0  
(define-const var1250 String "") ; Statement: $r6 = "" 
 ; Statement: goto [?= r1 = $r6] 
(assert true) ; Non Conditional
(define-const var1684 String var1250) ; Statement: r1 = $r6 
(define-const var432 var1997 null-var1997) ; Statement: r7 = null 
(assert (and true (and (>= var2347 0) (>= (str.len var2425) var2347))))
(define-const var280 String (substring/850833817 var2425 var2347)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(i6) 
(define-const var1356 Int (cast-from-Int-to-Int (- 1))) ; Statement: $i9 = (int) (- 1) 
; split operation: var3749 = var280.split("\u005c.", var1356) ; Statement: $r4 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i9) 
(define-const var2880 Int (get_split_length_re var280 (str.to_re ".") var1356)) ; Statement: $i3 = lengthof $r4 
(define-const var1861 Int 0) ; Statement: i7 = 0 
(assert true) ; Non Conditional
 ; Statement: if i7 >= $i3 goto return r7 
(assert (>= var1861 var2880)) ; Cond: i7 >= $i3 
 ; Statement: return r7 
; {length/-134980193=([java.lang.String], int), substring/850833817=([java.lang.String, int], java.lang.String), cast-from-Int-to-Int=([int], int)}
; {var2425=r0, var3951=null_type, var2347=i6, var2113=$i0, var1250=$r6, var1684=r1, var1997=org.springframework.javapoet.ClassName, var432=r7, var280=$r2, var1356=$i9, var3749=$r4, var2880=$i3, var1861=i7}
; {r0=var2425, null_type=var3951, i6=var2347, $i0=var2113, $r6=var1250, r1=var1684, org.springframework.javapoet.ClassName=var1997, r7=var432, $r2=var280, $i9=var1356, $r4=var3749, $i3=var2880, i7=var1861}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i6 = 0;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i6 >= $i0 goto (branch);	if i6 != 0 goto $i1 = i6 - 1;	$r6 = "";	goto [?= r1 = $r6];	r1 = $r6;	r7 = null;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(i6);	$i9 = (int) (- 1);	$r4 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i9);	$i3 = lengthof $r4;	i7 = 0;	if i7 >= $i3 goto return r7;	return r7
;block_num 7
(check-sat)
(exit)
