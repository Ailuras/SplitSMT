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

(declare-sort var2501 0)
(declare-sort var939 0)
(declare-sort var3524 0)
(declare-sort var1672 0)
(declare-sort var3500 0)
(declare-sort var3923 0)
(declare-sort var1071 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var2501-init () var2501)
(declare-fun <init>/720541530 (var2501) void)
(declare-fun var939-init () var939)
(declare-fun <init>/-1681595970 (var939 String) void)
(declare-fun var3524-init () var3524)
(declare-fun var1672-init () var1672)
(declare-fun var3500-init () var3500)
(declare-fun printStackTrace/885456489 (var1071) void)
(declare-fun cast-from-var3923-to-var1071 (var3923) var1071)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var3923 var3923)
(declare-const var2007 (Array Int String)) ; Statement: r0 := @parameter0: java.lang.String[] 
(assert (not (= var2007 null-__Array__Int__String__)))
(define-const var815 Int (getLength-Arr-String-1 var2007)) ; Statement: $i0 = lengthof r0 
 ; Statement: if $i0 == 2 goto $r27 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification 
(assert (= var815 2)) ; Cond: $i0 == 2 
(define-const var1954 var2501 var2501-init) ; Statement: $r27 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification 
(assert true)
;(assert (<init>/720541530 var1954)) ; Statement: specialinvoke $r27.<edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification: void <init>()>() 

(declare-const var1954!1 var2501)
(define-const var1286 String (select var2007 1)) ; Statement: $r2 = r0[1] 
; split operation: var2244 = var1286.split(",") ; Statement: $r21 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var694 Int (get_split_length var1286 "," (- 1))) ; Statement: $i1 = lengthof $r21 
(define-const var654 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto $r28 = new java.io.File 
(assert (>= var654 var694)) ; Cond: i2 >= $i1 
(define-const var3374 var939 var939-init) ; Statement: $r28 = new java.io.File 
(define-const var3215 String (select var2007 0)) ; Statement: $r4 = r0[0] 
(assert true)
;(assert (<init>/-1681595970 var3374 var3215)) ; Statement: specialinvoke $r28.<java.io.File: void <init>(java.lang.String)>($r4) 

(declare-const var3374!1 var939)
(declare-const var3215!1 String)
(define-const var54 var3524 var3524-init) ; Statement: $r31 = new java.io.BufferedReader 
(define-const var3519 var1672 var1672-init) ; Statement: $r30 = new java.io.InputStreamReader 
(define-const var3907 var3500 var3500-init) ; Statement: $r29 = new java.io.FileInputStream 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3449 var3923) ; Statement: $r23 := @caughtexception 
(assert (not (= var3449 null-var3923)))
(assert true)
;(assert (printStackTrace/885456489 (cast-from-var3923-to-var1071 var3449))) ; Statement: virtualinvoke $r23.<java.io.FileNotFoundException: void printStackTrace()>() 

(declare-const var3449!1 var3923)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
; {getLength-Arr-String-1=([java.lang.String[]], int), var2501-init=([], edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification), <init>/720541530=([edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification], void), var939-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void), var3524-init=([], java.io.BufferedReader), var1672-init=([], java.io.InputStreamReader), var3500-init=([], java.io.FileInputStream), printStackTrace/885456489=([java.lang.Throwable], void), cast-from-var3923-to-var1071=([java.io.FileNotFoundException], java.lang.Throwable)}
; {var2007=r0, var815=$i0, var2501=edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification, var1954=$r27, var1286=$r2, var2244=$r21, var694=$i1, var654=i2, var939=java.io.File, var3374=$r28, var3215=$r4, var3524=java.io.BufferedReader, var54=$r31, var1672=java.io.InputStreamReader, var3519=$r30, var3500=java.io.FileInputStream, var3907=$r29, var3923=java.io.FileNotFoundException, var3449=$r23, var1071=java.lang.Throwable}
; {r0=var2007, $i0=var815, edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification=var2501, $r27=var1954, $r2=var1286, $r21=var2244, $i1=var694, i2=var654, java.io.File=var939, $r28=var3374, $r4=var3215, java.io.BufferedReader=var3524, $r31=var54, java.io.InputStreamReader=var1672, $r30=var3519, java.io.FileInputStream=var3500, $r29=var3907, java.io.FileNotFoundException=var3923, $r23=var3449, java.lang.Throwable=var1071}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String[];	$i0 = lengthof r0;	if $i0 == 2 goto $r27 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification;	$r27 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification;	specialinvoke $r27.<edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification: void <init>()>();	$r2 = r0[1];	$r21 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i1 = lengthof $r21;	i2 = 0;	if i2 >= $i1 goto $r28 = new java.io.File;	$r28 = new java.io.File;	$r4 = r0[0];	specialinvoke $r28.<java.io.File: void <init>(java.lang.String)>($r4);	$r31 = new java.io.BufferedReader;	$r30 = new java.io.InputStreamReader;	$r29 = new java.io.FileInputStream;	$r23 := @caughtexception;	virtualinvoke $r23.<java.io.FileNotFoundException: void printStackTrace()>();	goto [?= return];	return
;block_num 6
(check-sat)
(exit)
