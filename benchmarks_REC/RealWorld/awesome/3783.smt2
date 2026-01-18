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

(declare-sort var637 0)
(declare-sort var1219 0)
(declare-sort var2963 0)
(declare-sort var1648 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun arr-var2963-init () (Array Int var2963))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var2963 (String) var2963)
(declare-fun var1648_log/2127824580 ((Array Int var2963)) void)
(declare-fun info/114590825 (var1219 String) void)
(declare-const null-String String)
(declare-const null-var1219 var1219)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__var2963__ (Array Int var2963))
(declare-const var2604 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2604 null-String)))
(declare-const var1643 var1219) ; Statement: r5 := @parameter1: java.util.logging.Logger 
(assert (not (= var1643 null-var1219)))
(declare-const var1599 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var1599 null-Bool)))
; split operation: var14 = var2604.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (= (ite var1599 1 0) 0))) ; Cond: z0 != 0 
(define-const var1525 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1525)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1525!1 String)
(assert (= var1525!1 ""))
(define-const var0 Int (get_split_length_re var2604 (str.to_re "\u{0A}") (- 1))) ; Statement: i2 = lengthof r1 
(define-const var292 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i2 goto $r3 = newarray (java.lang.Object)[1] 
(assert (>= var292 var0)) ; Cond: i3 >= i2 
(define-const var3816 (Array Int var2963) arr-var2963-init) ; Statement: $r3 = newarray (java.lang.Object)[1] 
(assert true)
(define-const var269 String (toString/-2075883882 var1525!1)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var3816!1 (Array Int var2963))
(assert (not (= var3816!1 null-__Array__Int__var2963__)))
(assert (= (select var3816!1 0) (cast-from-String-to-var2963 var269))) ; Statement: $r3[0] = $r4 
;(assert (var1648_log/2127824580 var3816!1)) ; Statement: staticinvoke <edu.stanford.nlp.util.logging.Redwood: void log(java.lang.Object[])>($r3) 

(declare-const var3816!2 (Array Int var2963))
(assert true)
(define-const var2815 String (toString/-2075883882 var1525!1)) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (info/114590825 var1643 var2815)) ; Statement: virtualinvoke r5.<java.util.logging.Logger: void info(java.lang.String)>($r6) 

(declare-const var1643!1 var1219)
(declare-const var2815!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), arr-var2963-init=([], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var2963=([java.lang.String], java.lang.Object), var1648_log/2127824580=([java.lang.Object[]], void), info/114590825=([java.util.logging.Logger, java.lang.String], void)}
; {var2604=r0, var637=null_type, var1219=java.util.logging.Logger, var1643=r5, var1599=z0, var14=r1, var1525=$r2, var0=i2, var292=i3, var2963=java.lang.Object, var3816=$r3, var269=$r4, var1648=edu.stanford.nlp.util.logging.Redwood, var2815=$r6}
; {r0=var2604, null_type=var637, java.util.logging.Logger=var1219, r5=var1643, z0=var1599, r1=var14, $r2=var1525, i2=var0, i3=var292, java.lang.Object=var2963, $r3=var3816, $r4=var269, edu.stanford.nlp.util.logging.Redwood=var1648, $r6=var2815}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @parameter0: java.lang.String;	r5 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	i2 = lengthof r1;	i3 = 0;	if i3 >= i2 goto $r3 = newarray (java.lang.Object)[1];	$r3 = newarray (java.lang.Object)[1];	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>();	$r3[0] = $r4;	staticinvoke <edu.stanford.nlp.util.logging.Redwood: void log(java.lang.Object[])>($r3);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r5.<java.util.logging.Logger: void info(java.lang.String)>($r6);	return
;block_num 5
(check-sat)
(exit)
