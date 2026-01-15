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

(declare-sort var2171 0)
(declare-sort var3996 0)
(declare-sort var1939 0)
(declare-sort var3492 0)
(declare-sort var1980 0)
(declare-sort var2009 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1939!class ClassObject)
(declare-fun remove/1441186265 (var3492 ClassObject) var2009)
(declare-fun cast-from-var3996-to-var3492 (var3996) var3492)
(declare-fun word/-864359544 (var3996) String)
(declare-fun replaceAll/1692887130 (String String String) String)
(declare-fun compoundBuffer/893453587 (var2171) var1980)
(declare-fun var1980_remove/1853576941 (var1980 Int) var2009)
(declare-fun cast-from-var2009-to-var3996 (var2009) var3996)
(declare-const null-var2171 var2171)
(declare-const null-var3996 var3996)
(declare-const var3624 var2171) ; Statement: r4 := @this: edu.stanford.nlp.international.french.process.FrenchTokenizer 
(assert (not (= var3624 null-var2171)))
(declare-const var2902 var3996) ; Statement: r0 := @parameter0: edu.stanford.nlp.ling.CoreLabel 
(assert (not (= var2902 null-var3996)))
(assert true)
;(assert (remove/1441186265 (cast-from-var3996-to-var3492 var2902) var1939!class)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.ling.CoreLabel: java.lang.Object remove(java.lang.Class)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$ParentAnnotation;") 

(declare-const var2902!1 var3996)
(declare-const var1607 ClassObject)
(assert true)
(define-const var3784 String (word/-864359544 var2902!1)) ; Statement: $r1 = virtualinvoke r0.<edu.stanford.nlp.ling.CoreLabel: java.lang.String word()>() 
(assert true)
(define-const var32 String (replaceAll/1692887130 var3784 "-" " - ")) ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("-", " - ") 
(assert (= (replaceAll/1692887130 var3784 "-" " - ") (str.replace_re_all var3784 (str.to_re "-") " - ")))
; split operation: var742 = var32.split("\u005cs+") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1421 Int (get_split_length_re var32 (re.+ (re.union (str.to_re " ") (str.to_re "\u{09}"))) (- 1))) ; Statement: i0 = lengthof r3 
(define-const var1112 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r5 = r4.<edu.stanford.nlp.international.french.process.FrenchTokenizer: java.util.List compoundBuffer> 
(assert (>= var1112 var1421)) ; Cond: i1 >= i0 
(define-const var2122 var1980 (compoundBuffer/893453587 var3624)) ; Statement: $r5 = r4.<edu.stanford.nlp.international.french.process.FrenchTokenizer: java.util.List compoundBuffer> 
(define-const var569 var2009 (var1980_remove/1853576941 var2122 0)) ; Statement: $r6 = interfaceinvoke $r5.<java.util.List: java.lang.Object remove(int)>(0) 
(define-const var1149 var3996 (cast-from-var2009-to-var3996 var569)) ; Statement: $r7 = (edu.stanford.nlp.ling.CoreLabel) $r6 
 ; Statement: return $r7 
(check-sat)
; {remove/1441186265=([edu.stanford.nlp.util.ArrayCoreMap, java.lang.Class], java.lang.Object), cast-from-var3996-to-var3492=([edu.stanford.nlp.ling.CoreLabel], edu.stanford.nlp.util.ArrayCoreMap), word/-864359544=([edu.stanford.nlp.ling.CoreLabel], java.lang.String), replaceAll/1692887130=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), compoundBuffer/893453587=([edu.stanford.nlp.international.french.process.FrenchTokenizer], java.util.List), var1980_remove/1853576941=([java.util.List, int], java.lang.Object), cast-from-var2009-to-var3996=([java.lang.Object], edu.stanford.nlp.ling.CoreLabel)}
; {var2171=edu.stanford.nlp.international.french.process.FrenchTokenizer, var3624=r4, var3996=edu.stanford.nlp.ling.CoreLabel, var2902=r0, var1939=edu.stanford.nlp.ling.CoreAnnotations$ParentAnnotation, var3492=edu.stanford.nlp.util.ArrayCoreMap, var1607=class "Ledu/stanford/nlp/ling/CoreAnnotations$ParentAnnotation;", var3784=$r1, var32=$r2, var742=r3, var1421=i0, var1112=i1, var1980=java.util.List, var2122=$r5, var2009=java.lang.Object, var569=$r6, var1149=$r7}
; {edu.stanford.nlp.international.french.process.FrenchTokenizer=var2171, r4=var3624, edu.stanford.nlp.ling.CoreLabel=var3996, r0=var2902, edu.stanford.nlp.ling.CoreAnnotations$ParentAnnotation=var1939, edu.stanford.nlp.util.ArrayCoreMap=var3492, class "Ledu/stanford/nlp/ling/CoreAnnotations$ParentAnnotation;"=var1607, $r1=var3784, $r2=var32, r3=var742, i0=var1421, i1=var1112, java.util.List=var1980, $r5=var2122, java.lang.Object=var2009, $r6=var569, $r7=var1149}
;seq <java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @this: edu.stanford.nlp.international.french.process.FrenchTokenizer;	r0 := @parameter0: edu.stanford.nlp.ling.CoreLabel;	virtualinvoke r0.<edu.stanford.nlp.ling.CoreLabel: java.lang.Object remove(java.lang.Class)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$ParentAnnotation;");	$r1 = virtualinvoke r0.<edu.stanford.nlp.ling.CoreLabel: java.lang.String word()>();	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("-", " - ");	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	i0 = lengthof r3;	i1 = 0;	if i1 >= i0 goto $r5 = r4.<edu.stanford.nlp.international.french.process.FrenchTokenizer: java.util.List compoundBuffer>;	$r5 = r4.<edu.stanford.nlp.international.french.process.FrenchTokenizer: java.util.List compoundBuffer>;	$r6 = interfaceinvoke $r5.<java.util.List: java.lang.Object remove(int)>(0);	$r7 = (edu.stanford.nlp.ling.CoreLabel) $r6;	return $r7
;block_num 3
(exit)
