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

(declare-sort var423 0)
(declare-sort var2733 0)
(declare-sort var3156 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/1403215111 (var2733) String)
(declare-fun var3156-init () var3156)
(declare-fun <init>/-325640736 (var3156) void)
(declare-fun arr-String-init () (Array Int String))
(declare-const null-var423 var423)
(declare-const null-var2733 var2733)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var119 var423) ; Statement: r18 := @this: org.apache.logging.log4j.core.config.DefaultConfigurationFactory 
(assert (not (= var119 null-var423)))
(declare-const var3365 var2733) ; Statement: r0 := @parameter0: java.net.URI 
(assert (not (= var3365 null-var2733)))
(assert true)
(define-const var2401 String (toString/1403215111 var3365)) ; Statement: $r1 = virtualinvoke r0.<java.net.URI: java.lang.String toString()>() 
; split operation: var3281 = var2401.split("\u005c?") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\?") 
(define-const var406 var3156 var3156-init) ; Statement: $r3 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var406)) ; Statement: specialinvoke $r3.<java.util.ArrayList: void <init>()>() 

(declare-const var406!1 var3156)
(define-const var1399 Int (get_split_length_re var2401 (str.to_re "?") (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 1 goto $r4 = newarray (java.lang.String)[1] 
(assert (<= var1399 1)) ; Cond: $i0 <= 1 
(define-const var1058 (Array Int String) arr-String-init) ; Statement: $r4 = newarray (java.lang.String)[1] 
(define-const var1152 String (get_split_element_re var2401 (str.to_re "?") (- 1) 0)) ; Statement: $r5 = r2[0] 
(declare-const var1058!1 (Array Int String))
(assert (not (= var1058!1 null-__Array__Int__String__)))
(assert (= (select var1058!1 0) var1152)) ; Statement: $r4[0] = $r5 
 ; Statement: return $r4 
; {toString/1403215111=([java.net.URI], java.lang.String), var3156-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), arr-String-init=([], java.lang.String[])}
; {var423=org.apache.logging.log4j.core.config.DefaultConfigurationFactory, var119=r18, var2733=java.net.URI, var3365=r0, var2401=$r1, var3281=r2, var3156=java.util.ArrayList, var406=$r3, var1399=$i0, var1058=$r4, var1152=$r5}
; {org.apache.logging.log4j.core.config.DefaultConfigurationFactory=var423, r18=var119, java.net.URI=var2733, r0=var3365, $r1=var2401, r2=var3281, java.util.ArrayList=var3156, $r3=var406, $i0=var1399, $r4=var1058, $r5=var1152}
;seq <java.net.URI: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r18 := @this: org.apache.logging.log4j.core.config.DefaultConfigurationFactory;	r0 := @parameter0: java.net.URI;	$r1 = virtualinvoke r0.<java.net.URI: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\?");	$r3 = new java.util.ArrayList;	specialinvoke $r3.<java.util.ArrayList: void <init>()>();	$i0 = lengthof r2;	if $i0 <= 1 goto $r4 = newarray (java.lang.String)[1];	$r4 = newarray (java.lang.String)[1];	$r5 = r2[0];	$r4[0] = $r5;	return $r4
;block_num 2
(assert (= var2401 (toString/1403215111 var3365)))
(assert (= var1058!1 ((as const (Array Int String)) "?")))
(assert (= null-__Array__Int__String__ ((as const (Array Int String)) "")))
(assert (= var1058 arr-String-init))
(assert (= var406 var3156-init))
(assert (= arr-String-init ((as const (Array Int String)) "")))
(check-sat)
(exit)
