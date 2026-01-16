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

(declare-sort var1081 0)
(declare-sort var2764 0)
(declare-sort var1480 0)
(declare-sort var1300 0)
(declare-sort var3137 0)
(declare-sort var1237 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun replaceAll/1692887130 (String String String) String)
(declare-fun var1480-init () var1480)
(declare-fun <init>/-325640736 (var1480) void)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun var1300_add/-376848345 (var1300 var3137) Bool)
(declare-fun cast-from-var1480-to-var1300 (var1480) var1300)
(declare-fun cast-from-String-to-var3137 (String) var3137)
(declare-fun var1237-init () var1237)
(declare-fun <init>/1828590458 (var1237 var1300 var3137) void)
(declare-const null-String String)
(declare-const var2764-line1 Int)
(declare-const var1498 String) ; Statement: r15 := @parameter0: java.lang.String 
(assert (not (= var1498 null-String)))
(define-const var172 Int var2764-line1) ; Statement: $i0 = <edu.stanford.nlp.classify.Dataset: int line1> 
(define-const var2170 Int (+ var172 1)) ; Statement: $i1 = $i0 + 1 
(define-const var349 Int var2170) ; Statement: <edu.stanford.nlp.classify.Dataset: int line1> = $i1 
(assert true)
(define-const var2177 String (replaceAll/1692887130 var1498 "#.*" "")) ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("#.*", "") 
(assert (= (replaceAll/1692887130 var1498 "#.*" "") (str.replace_re_all var1498 (re.++ (str.to_re "#") (re.* re.allchar)) "")))
; split operation: var3848 = var2177.split("\u005cs+") ; Statement: r0 = virtualinvoke r16.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1364 var1480 var1480-init) ; Statement: $r1 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1364)) ; Statement: specialinvoke $r1.<java.util.ArrayList: void <init>()>() 

(declare-const var1364!1 var1480)
(define-const var3524 Int 1) ; Statement: i6 = 1 
(assert true) ; Non Conditional
(define-const var3973 Int (get_split_length_re var2177 (re.+ (re.union (str.to_re " ") (str.to_re "\u{09}"))) (- 1))) ; Statement: $i2 = lengthof r0 
 ; Statement: if i6 >= $i2 goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647) 
(assert (>= var3524 var3973)) ; Cond: i6 >= $i2 
(define-const var3896 String (String_valueOf/1240665136 2147483647)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647) 
;(assert (var1300_add/-376848345 (cast-from-var1480-to-var1300 var1364!1) (cast-from-String-to-var3137 var3896))) ; Statement: interfaceinvoke $r1.<java.util.Collection: boolean add(java.lang.Object)>($r2) 

(declare-const var1364!2 var1480)
(declare-const var3896!1 String)
(define-const var1550 var1237 var1237-init) ; Statement: $r3 = new edu.stanford.nlp.ling.BasicDatum 
(define-const var3379 String (get_split_element_re var2177 (re.+ (re.union (str.to_re " ") (str.to_re "\u{09}"))) (- 1) 0)) ; Statement: $r4 = r0[0] 
(assert true)
;(assert (<init>/1828590458 var1550 (cast-from-var1480-to-var1300 var1364!2) (cast-from-String-to-var3137 var3379))) ; Statement: specialinvoke $r3.<edu.stanford.nlp.ling.BasicDatum: void <init>(java.util.Collection,java.lang.Object)>($r1, $r4) 

(declare-const var1550!1 var1237)
(declare-const var1364!3 var1480)
(declare-const var3379!1 String)
 ; Statement: return $r3 
; {replaceAll/1692887130=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), var1480-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), String_valueOf/1240665136=([int], java.lang.String), var1300_add/-376848345=([java.util.Collection, java.lang.Object], boolean), cast-from-var1480-to-var1300=([java.util.ArrayList], java.util.Collection), cast-from-String-to-var3137=([java.lang.String], java.lang.Object), var1237-init=([], edu.stanford.nlp.ling.BasicDatum), <init>/1828590458=([edu.stanford.nlp.ling.BasicDatum, java.util.Collection, java.lang.Object], void)}
; {var1498=r15, var1081=null_type, var2764=edu.stanford.nlp.classify.Dataset, var172=$i0, var2170=$i1, var349=<edu.stanford.nlp.classify.Dataset: int line1>, var2177=r16, var3848=r0, var1480=java.util.ArrayList, var1364=$r1, var3524=i6, var3973=$i2, var3896=$r2, var1300=java.util.Collection, var3137=java.lang.Object, var1237=edu.stanford.nlp.ling.BasicDatum, var1550=$r3, var3379=$r4}
; {r15=var1498, null_type=var1081, edu.stanford.nlp.classify.Dataset=var2764, $i0=var172, $i1=var2170, <edu.stanford.nlp.classify.Dataset: int line1>=var349, r16=var2177, r0=var3848, java.util.ArrayList=var1480, $r1=var1364, i6=var3524, $i2=var3973, $r2=var3896, java.util.Collection=var1300, java.lang.Object=var3137, edu.stanford.nlp.ling.BasicDatum=var1237, $r3=var1550, $r4=var3379}
;seq <java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r15 := @parameter0: java.lang.String;	$i0 = <edu.stanford.nlp.classify.Dataset: int line1>;	$i1 = $i0 + 1;	<edu.stanford.nlp.classify.Dataset: int line1> = $i1;	r16 = virtualinvoke r15.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("#.*", "");	r0 = virtualinvoke r16.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r1 = new java.util.ArrayList;	specialinvoke $r1.<java.util.ArrayList: void <init>()>();	i6 = 1;	$i2 = lengthof r0;	if i6 >= $i2 goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647);	interfaceinvoke $r1.<java.util.Collection: boolean add(java.lang.Object)>($r2);	$r3 = new edu.stanford.nlp.ling.BasicDatum;	$r4 = r0[0];	specialinvoke $r3.<edu.stanford.nlp.ling.BasicDatum: void <init>(java.util.Collection,java.lang.Object)>($r1, $r4);	return $r3
;block_num 3
(check-sat)
(exit)
