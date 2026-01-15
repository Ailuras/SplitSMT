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

(declare-sort var2333 0)
(declare-sort var1622 0)
(declare-sort var92 0)
(declare-sort var282 0)
(declare-sort var699 0)
(declare-sort var2396 0)
(declare-sort var3930 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var2333-init () var2333)
(declare-fun <init>/720541530 (var2333) void)
(declare-fun var1622-init () var1622)
(declare-fun <init>/-1681595970 (var1622 String) void)
(declare-fun var92-init () var92)
(declare-fun var282-init () var282)
(declare-fun var699-init () var699)
(declare-fun printStackTrace/885456489 (var3930) void)
(declare-fun cast-from-var2396-to-var3930 (var2396) var3930)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var2396 var2396)
(declare-const var582 (Array Int String)) ; Statement: r0 := @parameter0: java.lang.String[] 
(assert (not (= var582 null-__Array__Int__String__)))
(define-const var2670 Int (getLength-Arr-String-1 var582)) ; Statement: $i0 = lengthof r0 
 ; Statement: if $i0 == 2 goto $r27 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification 
(assert (= var2670 2)) ; Cond: $i0 == 2 
(define-const var2028 var2333 var2333-init) ; Statement: $r27 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification 
(assert true)
;(assert (<init>/720541530 var2028)) ; Statement: specialinvoke $r27.<edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification: void <init>()>() 

(declare-const var2028!1 var2333)
(define-const var2281 String (select var582 1)) ; Statement: $r2 = r0[1] 
; split operation: var2786 = var2281.split(",") ; Statement: $r21 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1915 Int (get_split_length var2281 "," (- 1))) ; Statement: $i1 = lengthof $r21 
(define-const var3331 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto $r28 = new java.io.File 
(assert (>= var3331 var1915)) ; Cond: i2 >= $i1 
(define-const var2978 var1622 var1622-init) ; Statement: $r28 = new java.io.File 
(define-const var802 String (select var582 0)) ; Statement: $r4 = r0[0] 
(assert true)
;(assert (<init>/-1681595970 var2978 var802)) ; Statement: specialinvoke $r28.<java.io.File: void <init>(java.lang.String)>($r4) 

(declare-const var2978!1 var1622)
(declare-const var802!1 String)
(define-const var2658 var92 var92-init) ; Statement: $r31 = new java.io.BufferedReader 
(define-const var2679 var282 var282-init) ; Statement: $r30 = new java.io.InputStreamReader 
(define-const var1047 var699 var699-init) ; Statement: $r29 = new java.io.FileInputStream 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2158 var2396) ; Statement: $r22 := @caughtexception 
(assert (not (= var2158 null-var2396)))
(assert true)
;(assert (printStackTrace/885456489 (cast-from-var2396-to-var3930 var2158))) ; Statement: virtualinvoke $r22.<java.io.IOException: void printStackTrace()>() 

(declare-const var2158!1 var2396)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getLength-Arr-String-1=([java.lang.String[]], int), var2333-init=([], edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification), <init>/720541530=([edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification], void), var1622-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void), var92-init=([], java.io.BufferedReader), var282-init=([], java.io.InputStreamReader), var699-init=([], java.io.FileInputStream), printStackTrace/885456489=([java.lang.Throwable], void), cast-from-var2396-to-var3930=([java.io.IOException], java.lang.Throwable)}
; {var582=r0, var2670=$i0, var2333=edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification, var2028=$r27, var2281=$r2, var2786=$r21, var1915=$i1, var3331=i2, var1622=java.io.File, var2978=$r28, var802=$r4, var92=java.io.BufferedReader, var2658=$r31, var282=java.io.InputStreamReader, var2679=$r30, var699=java.io.FileInputStream, var1047=$r29, var2396=java.io.IOException, var2158=$r22, var3930=java.lang.Throwable}
; {r0=var582, $i0=var2670, edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification=var2333, $r27=var2028, $r2=var2281, $r21=var2786, $i1=var1915, i2=var3331, java.io.File=var1622, $r28=var2978, $r4=var802, java.io.BufferedReader=var92, $r31=var2658, java.io.InputStreamReader=var282, $r30=var2679, java.io.FileInputStream=var699, $r29=var1047, java.io.IOException=var2396, $r22=var2158, java.lang.Throwable=var3930}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String[];	$i0 = lengthof r0;	if $i0 == 2 goto $r27 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification;	$r27 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification;	specialinvoke $r27.<edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification: void <init>()>();	$r2 = r0[1];	$r21 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i1 = lengthof $r21;	i2 = 0;	if i2 >= $i1 goto $r28 = new java.io.File;	$r28 = new java.io.File;	$r4 = r0[0];	specialinvoke $r28.<java.io.File: void <init>(java.lang.String)>($r4);	$r31 = new java.io.BufferedReader;	$r30 = new java.io.InputStreamReader;	$r29 = new java.io.FileInputStream;	$r22 := @caughtexception;	virtualinvoke $r22.<java.io.IOException: void printStackTrace()>();	return
;block_num 6
(exit)
