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

(declare-sort var1021 0)
(declare-sort var2188 0)
(declare-sort var2387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2188-init () var2188)
(declare-fun <init>/-1102441200 (var2188) void)
(declare-fun readLine/150542008 (var1021) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var2387-init () var2387)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var2387 String) void)
(declare-const null-var1021 var1021)
(declare-const var818 var1021) ; Statement: r1 := @parameter0: java.io.BufferedReader 
(assert (not (= var818 null-var1021)))
(define-const var401 var2188 var2188-init) ; Statement: $r43 = new edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph 
(assert true)
;(assert (<init>/-1102441200 var401)) ; Statement: specialinvoke $r43.<edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph: void <init>()>() 

(declare-const var401!1 var2188)
(assert true)
(define-const var115 String (readLine/150542008 var818)) ; Statement: $r2 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>() 
(assert true)
(define-const var3643 String (trim/-847153721 var115)) ; Statement: r31 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var2140 Int (length/-134980193 var3643)) ; Statement: $i0 = virtualinvoke r31.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r3 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>() 
(assert (not (<= var2140 0))) ; Negate: Cond: $i0 <= 0  
; split operation: var1648 = var3643.split("\t") ; Statement: r32 = virtualinvoke r31.<java.lang.String: java.lang.String[] split(java.lang.String)>("\t") 
(define-const var105 Int (get_split_length var3643 "\u{09}" (- 1))) ; Statement: $i8 = lengthof r32 
 ; Statement: if $i8 >= 3 goto r33 = r32[0] 
(assert (not (>= var105 3))) ; Negate: Cond: $i8 >= 3  
(define-const var2659 var2387 var2387-init) ; Statement: $r45 = new java.lang.RuntimeException 
(define-const var2874 String String-init) ; Statement: $r44 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2874)) ; Statement: specialinvoke $r44.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2874!1 String)
(assert (= var2874!1 ""))
(assert true)
(define-const var3784 String (append/672562846 var2874!1 "ERROR: Invalid dependency node line: ")) ; Statement: $r28 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ERROR: Invalid dependency node line: ") 
(declare-const var2874!2 String)
(assert (= var2874!2 (str.++ var2874!1 "ERROR: Invalid dependency node line: ")))
(assert true)
(define-const var2433 String (append/672562846 var3784 var3643)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r31) 
(declare-const var3784!1 String)
(assert (= var3784!1 (str.++ var3784 var3643)))
(assert true)
(define-const var420 String (toString/-2075883882 var2433)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var2659 var420)) ; Statement: specialinvoke $r45.<java.lang.RuntimeException: void <init>(java.lang.String)>($r30) 

(declare-const var2659!1 var2387)
(declare-const var420!1 String)
 ; Statement: throw $r45 
; {var2188-init=([], edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph), <init>/-1102441200=([edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph], void), readLine/150542008=([java.io.BufferedReader], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int), var2387-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var1021=java.io.BufferedReader, var818=r1, var2188=edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph, var401=$r43, var115=$r2, var3643=r31, var2140=$i0, var1648=r32, var105=$i8, var2387=java.lang.RuntimeException, var2659=$r45, var2874=$r44, var3784=$r28, var2433=$r29, var420=$r30}
; {java.io.BufferedReader=var1021, r1=var818, edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph=var2188, $r43=var401, $r2=var115, r31=var3643, $i0=var2140, r32=var1648, $i8=var105, java.lang.RuntimeException=var2387, $r45=var2659, $r44=var2874, $r28=var3784, $r29=var2433, $r30=var420}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.io.BufferedReader;	$r43 = new edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph;	specialinvoke $r43.<edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph: void <init>()>();	$r2 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>();	r31 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	$i0 = virtualinvoke r31.<java.lang.String: int length()>();	if $i0 <= 0 goto $r3 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>();	r32 = virtualinvoke r31.<java.lang.String: java.lang.String[] split(java.lang.String)>("\t");	$i8 = lengthof r32;	if $i8 >= 3 goto r33 = r32[0];	$r45 = new java.lang.RuntimeException;	$r44 = new java.lang.StringBuilder;	specialinvoke $r44.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ERROR: Invalid dependency node line: ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r31);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r45.<java.lang.RuntimeException: void <init>(java.lang.String)>($r30);	throw $r45
;block_num 3
(check-sat)
(exit)
