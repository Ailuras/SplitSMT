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

(declare-sort var1395 0)
(declare-sort var2214 0)
(declare-sort var3543 0)
(declare-sort var2163 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun arr-var3543-init () (Array Int var3543))
(declare-fun cast-from-String-to-var3543 (String) var3543)
(declare-fun var2163_log/2127824580 ((Array Int var3543)) void)
(declare-fun info/114590825 (var2214 String) void)
(declare-const null-String String)
(declare-const null-var2214 var2214)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__var3543__ (Array Int var3543))
(declare-const var3808 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3808 null-String)))
(declare-const var1791 var2214) ; Statement: r5 := @parameter1: java.util.logging.Logger 
(assert (not (= var1791 null-var2214)))
(declare-const var3185 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3185 null-Bool)))
; split operation: var2454 = var3808.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (not (= (ite var3185 1 0) 0)))) ; Negate: Cond: z0 != 0  
(define-const var3211 Int (get_split_length_re var3808 (str.to_re "\u{0A}") (- 1))) ; Statement: i0 = lengthof r1 
(define-const var1496 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto (branch) 
(assert (not (>= var1496 var3211))) ; Negate: Cond: i1 >= i0  
(define-const var3098 String (get_split_element_re var3808 (str.to_re "\u{0A}") (- 1) var1496)) ; Statement: r10 = r1[i1] 
(assert true)
(define-const var3766 Bool (startsWith/-1785782452 var3098 "Identification of Mentions")) ; Statement: $z4 = virtualinvoke r10.<java.lang.String: boolean startsWith(java.lang.String)>("Identification of Mentions") 
 ; Statement: if $z4 == 0 goto i1 = i1 + 1 
(assert (not (= (ite var3766 1 0) 0))) ; Negate: Cond: $z4 == 0  
(define-const var951 (Array Int var3543) arr-var3543-init) ; Statement: $r9 = newarray (java.lang.Object)[1] 
(declare-const var951!1 (Array Int var3543))
(assert (not (= var951!1 null-__Array__Int__var3543__)))
(assert (= (select var951!1 0) (cast-from-String-to-var3543 var3098))) ; Statement: $r9[0] = r10 
;(assert (var2163_log/2127824580 var951!1)) ; Statement: staticinvoke <edu.stanford.nlp.util.logging.Redwood: void log(java.lang.Object[])>($r9) 

(declare-const var951!2 (Array Int var3543))
(assert true)
;(assert (info/114590825 var1791 var3098)) ; Statement: virtualinvoke r5.<java.util.logging.Logger: void info(java.lang.String)>(r10) 

(declare-const var1791!1 var2214)
(declare-const var3098!1 String)
 ; Statement: return 
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), arr-var3543-init=([], java.lang.Object[]), cast-from-String-to-var3543=([java.lang.String], java.lang.Object), var2163_log/2127824580=([java.lang.Object[]], void), info/114590825=([java.util.logging.Logger, java.lang.String], void)}
; {var3808=r0, var1395=null_type, var2214=java.util.logging.Logger, var1791=r5, var3185=z0, var2454=r1, var3211=i0, var1496=i1, var3098=r10, var3766=$z4, var3543=java.lang.Object, var951=$r9, var2163=edu.stanford.nlp.util.logging.Redwood}
; {r0=var3808, null_type=var1395, java.util.logging.Logger=var2214, r5=var1791, z0=var3185, r1=var2454, i0=var3211, i1=var1496, r10=var3098, $z4=var3766, java.lang.Object=var3543, $r9=var951, edu.stanford.nlp.util.logging.Redwood=var2163}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r5 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto (branch);	r10 = r1[i1];	$z4 = virtualinvoke r10.<java.lang.String: boolean startsWith(java.lang.String)>("Identification of Mentions");	if $z4 == 0 goto i1 = i1 + 1;	$r9 = newarray (java.lang.Object)[1];	$r9[0] = r10;	staticinvoke <edu.stanford.nlp.util.logging.Redwood: void log(java.lang.Object[])>($r9);	virtualinvoke r5.<java.util.logging.Logger: void info(java.lang.String)>(r10);	return
;block_num 5
(check-sat)
(exit)
