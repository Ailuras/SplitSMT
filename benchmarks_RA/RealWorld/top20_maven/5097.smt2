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

(declare-sort var3575 0)
(declare-sort var1294 0)
(declare-sort var3328 0)
(declare-sort var2050 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-512974245 (var3575) String)
(declare-fun var3328_isNotBlank/-616714458 (String) Bool)
(declare-fun var1294_contains/-441121415 (var1294 var2050) Bool)
(declare-fun cast-from-String-to-var2050 (String) var2050)
(declare-fun var1294_add/328494887 (var1294 var2050) Bool)
(declare-const null-var3575 var3575)
(declare-const null-var1294 var1294)
(declare-const var3638 var3575) ; Statement: r0 := @parameter0: java.net.InetAddress 
(assert (not (= var3638 null-var3575)))
(declare-const var2254 var1294) ; Statement: r4 := @parameter1: java.util.List 
(assert (not (= var2254 null-var1294)))
(assert true)
(define-const var1120 String (toString/-512974245 var3638)) ; Statement: $r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>() 
; split operation: var1938 = var1120.split("\u005cs*/\u005cs*") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*") 
(define-const var1194 Int (get_split_length_re var1120 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "/") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 0 goto return 
(assert (not (<= var1194 0))) ; Negate: Cond: $i0 <= 0  
(define-const var3707 Int (get_split_length_re var1120 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "/") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: i1 = lengthof r2 
(define-const var2450 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (not (>= var2450 var3707))) ; Negate: Cond: i2 >= i1  
(define-const var2398 String (get_split_element_re var1120 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "/") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1) var2450)) ; Statement: r3 = r2[i2] 
(define-const var2051 Bool (var3328_isNotBlank/-616714458 var2398)) ; Statement: $z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto i2 = i2 + 1 
(assert (not (= (ite var2051 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var831 Bool (var1294_contains/-441121415 var2254 (cast-from-String-to-var2050 var2398))) ; Statement: $z1 = interfaceinvoke r4.<java.util.List: boolean contains(java.lang.Object)>(r3) 
 ; Statement: if $z1 != 0 goto i2 = i2 + 1 
(assert (not (not (= (ite var831 1 0) 0)))) ; Negate: Cond: $z1 != 0  
;(assert (var1294_add/328494887 var2254 (cast-from-String-to-var2050 var2398))) ; Statement: interfaceinvoke r4.<java.util.List: boolean add(java.lang.Object)>(r3) 

(declare-const var2254!1 var1294)
(declare-const var2398!1 String)
(assert true) ; Non Conditional
(define-const var2450!1 Int (+ var2450 1)) ; Statement: i2 = i2 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (>= var2450!1 var3707)) ; Cond: i2 >= i1 
 ; Statement: return 
(check-sat)
; {toString/-512974245=([java.net.InetAddress], java.lang.String), var3328_isNotBlank/-616714458=([java.lang.String], boolean), var1294_contains/-441121415=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var2050=([java.lang.String], java.lang.Object), var1294_add/328494887=([java.util.List, java.lang.Object], boolean)}
; {var3575=java.net.InetAddress, var3638=r0, var1294=java.util.List, var2254=r4, var1120=$r1, var1938=r2, var1194=$i0, var3707=i1, var2450=i2, var2398=r3, var3328=org.apache.logging.log4j.util.Strings, var2051=$z0, var2050=java.lang.Object, var831=$z1}
; {java.net.InetAddress=var3575, r0=var3638, java.util.List=var1294, r4=var2254, $r1=var1120, r2=var1938, $i0=var1194, i1=var3707, i2=var2450, r3=var2398, org.apache.logging.log4j.util.Strings=var3328, $z0=var2051, java.lang.Object=var2050, $z1=var831}
;seq <java.net.InetAddress: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.InetAddress;	r4 := @parameter1: java.util.List;	$r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*");	$i0 = lengthof r2;	if $i0 <= 0 goto return;	i1 = lengthof r2;	i2 = 0;	if i2 >= i1 goto return;	r3 = r2[i2];	$z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3);	if $z0 == 0 goto i2 = i2 + 1;	$z1 = interfaceinvoke r4.<java.util.List: boolean contains(java.lang.Object)>(r3);	if $z1 != 0 goto i2 = i2 + 1;	interfaceinvoke r4.<java.util.List: boolean add(java.lang.Object)>(r3);	i2 = i2 + 1;	goto [?= (branch)];	if i2 >= i1 goto return;	return
;block_num 9
(exit)
