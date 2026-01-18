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

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var1442 0)
(declare-sort var250 0)
(declare-sort var1487 0)
(declare-sort var812 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-512974245 (var1442) String)
(declare-fun var1487_isNotBlank/-616714458 (String) Bool)
(declare-fun var250_contains/-441121415 (var250 var812) Bool)
(declare-fun cast-from-String-to-var812 (String) var812)
(declare-const null-var1442 var1442)
(declare-const null-var250 var250)
(declare-const var2379 var1442) ; Statement: r0 := @parameter0: java.net.InetAddress 
(assert (not (= var2379 null-var1442)))
(declare-const var3884 var250) ; Statement: r4 := @parameter1: java.util.List 
(assert (not (= var3884 null-var250)))
(assert true)
(define-const var2442 String (toString/-512974245 var2379)) ; Statement: $r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>() 
; split operation: var7 = var2442.split("\u005cs*/\u005cs*") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*") 
(define-const var907 Int (get_split_length_re var2442 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "/") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 0 goto return 
(assert (not (<= var907 0))) ; Negate: Cond: $i0 <= 0  
(define-const var1565 Int (get_split_length_re var2442 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "/") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: i1 = lengthof r2 
(define-const var1571 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (not (>= var1571 var1565))) ; Negate: Cond: i2 >= i1  
(define-const var3421 String (get_split_element_re var2442 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re "/") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1) var1571)) ; Statement: r3 = r2[i2] 
(define-const var1134 Bool (var1487_isNotBlank/-616714458 var3421)) ; Statement: $z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto i2 = i2 + 1 
(assert (not (= (ite var1134 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1592 Bool (var250_contains/-441121415 var3884 (cast-from-String-to-var812 var3421))) ; Statement: $z1 = interfaceinvoke r4.<java.util.List: boolean contains(java.lang.Object)>(r3) 
 ; Statement: if $z1 != 0 goto i2 = i2 + 1 
(assert (not (= (ite var1592 1 0) 0))) ; Cond: $z1 != 0 
(define-const var1571!1 Int (+ var1571 1)) ; Statement: i2 = i2 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (>= var1571!1 var1565)) ; Cond: i2 >= i1 
 ; Statement: return 
; {toString/-512974245=([java.net.InetAddress], java.lang.String), var1487_isNotBlank/-616714458=([java.lang.String], boolean), var250_contains/-441121415=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var812=([java.lang.String], java.lang.Object)}
; {var1442=java.net.InetAddress, var2379=r0, var250=java.util.List, var3884=r4, var2442=$r1, var7=r2, var907=$i0, var1565=i1, var1571=i2, var3421=r3, var1487=org.apache.logging.log4j.util.Strings, var1134=$z0, var812=java.lang.Object, var1592=$z1}
; {java.net.InetAddress=var1442, r0=var2379, java.util.List=var250, r4=var3884, $r1=var2442, r2=var7, $i0=var907, i1=var1565, i2=var1571, r3=var3421, org.apache.logging.log4j.util.Strings=var1487, $z0=var1134, java.lang.Object=var812, $z1=var1592}
;seq <java.net.InetAddress: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.InetAddress;	r4 := @parameter1: java.util.List;	$r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*");	$i0 = lengthof r2;	if $i0 <= 0 goto return;	i1 = lengthof r2;	i2 = 0;	if i2 >= i1 goto return;	r3 = r2[i2];	$z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3);	if $z0 == 0 goto i2 = i2 + 1;	$z1 = interfaceinvoke r4.<java.util.List: boolean contains(java.lang.Object)>(r3);	if $z1 != 0 goto i2 = i2 + 1;	i2 = i2 + 1;	goto [?= (branch)];	if i2 >= i1 goto return;	return
;block_num 8
(assert (= var2442 (toString/-512974245 var2379)))
(assert (= var1571 0))
(assert (= var1571!1 (+ 0 1)))
(check-sat)
(exit)
