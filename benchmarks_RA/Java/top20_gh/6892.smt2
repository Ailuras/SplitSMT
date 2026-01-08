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

(declare-sort var620 0)
(declare-sort var3781 0)
(declare-sort var241 0)
(declare-sort var3379 0)
(declare-sort var505 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3379-init () var3379)
(declare-fun <init>/358169345 (var3379) void)
(declare-fun omitComments/-1276310728 (var620) Bool)
(declare-fun store/-1111572071 (var505 var3781 String) void)
(declare-fun cast-from-var620-to-var505 (var620) var505)
(declare-fun cast-from-var3379-to-var3781 (var3379) var3781)
(declare-fun toString/138175384 (var3379) String)
(declare-const null-var620 var620)
(declare-const null-var3781 var3781)
(declare-const null-String String)
(declare-const var620-EOL String)
(declare-const var3438 var620) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var3438 null-var620)))
(declare-const var2040 var3781) ; Statement: r5 := @parameter0: java.io.Writer 
(assert (not (= var2040 null-var3781)))
(declare-const var1859 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1859 null-String)))
(define-const var3362 var3379 var3379-init) ; Statement: $r0 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var3362)) ; Statement: specialinvoke $r0.<java.io.StringWriter: void <init>()>() 

(declare-const var3362!1 var3379)
(define-const var3729 Bool (omitComments/-1276310728 var3438)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r10 = r2 
(assert (= (ite var3729 1 0) 0)) ; Cond: $z0 == 0 
(define-const var678 String var1859) ; Statement: $r10 = r2 
(assert true) ; Non Conditional
(assert true)
;(assert (store/-1111572071 (cast-from-var620-to-var505 var3438) (cast-from-var3379-to-var3781 var3362!1) var678)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10) 

(declare-const var3438!1 var620)
(declare-const var3362!2 var3379)
(declare-const var678!1 String)
(assert true)
(define-const var2013 String (toString/138175384 var3362!2)) ; Statement: $r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>() 
(define-const var515 String var620-EOL) ; Statement: $r3 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var3279 = var2013.split(var515) ; Statement: $r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3) 
(define-const var3590 Int (get_split_length var2013 var515 (- 1))) ; Statement: $i0 = lengthof $r9 
(define-const var907 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var907 var3590)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var3379-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/-1111572071=([java.util.Properties, java.io.Writer, java.lang.String], void), cast-from-var620-to-var505=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var3379-to-var3781=([java.io.StringWriter], java.io.Writer), toString/138175384=([java.io.StringWriter], java.lang.String)}
; {var620=org.springframework.core.SortedProperties, var3438=r1, var3781=java.io.Writer, var2040=r5, var1859=r2, var241=null_type, var3379=java.io.StringWriter, var3362=$r0, var3729=$z0, var678=$r10, var505=java.util.Properties, var2013=$r8, var515=$r3, var3279=$r9, var3590=$i0, var907=i1}
; {org.springframework.core.SortedProperties=var620, r1=var3438, java.io.Writer=var3781, r5=var2040, r2=var1859, null_type=var241, java.io.StringWriter=var3379, $r0=var3362, $z0=var3729, $r10=var678, java.util.Properties=var505, $r8=var2013, $r3=var515, $r9=var3279, $i0=var3590, i1=var907}
;seq <java.io.StringWriter: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r5 := @parameter0: java.io.Writer;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.StringWriter;	specialinvoke $r0.<java.io.StringWriter: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r10 = r2;	$r10 = r2;	specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10);	$r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>();	$r3 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3);	$i0 = lengthof $r9;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5
(exit)
