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

(declare-sort var1618 0)
(declare-sort var3085 0)
(declare-sort var640 0)
(declare-sort var937 0)
(declare-sort var1374 0)
(declare-sort var1071 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun conll/1476566127 (var1618) Bool)
(declare-fun genres/1476566127 (var1618) var640)
(declare-fun docInfo/-1745439537 (var3085) var640)
(declare-fun var640_get/1088891777 (var640 var937) var937)
(declare-fun cast-from-String-to-var937 (String) var937)
(declare-fun cast-from-var937-to-String (var937) String)
(declare-fun cast-from-var937-to-Int (var937) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-fun var640_size/-1594421051 (var640) Int)
(declare-fun var1071_oneHot/961599073 (Int Int) var1374)
(declare-const null-var1618 var1618)
(declare-const null-var3085 var3085)
(declare-const var1823 var1618) ; Statement: r0 := @this: edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor 
(assert (not (= var1823 null-var1618)))
(declare-const var3610 var3085) ; Statement: r1 := @parameter0: edu.stanford.nlp.coref.data.Document 
(assert (not (= var3610 null-var3085)))
(define-const var2907 Bool (conll/1476566127 var1823)) ; Statement: $z0 = r0.<edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor: boolean conll> 
 ; Statement: if $z0 == 0 goto $r11 = new org.ejml.simple.SimpleMatrix 
(assert (not (= (ite var2907 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2321 var640 (genres/1476566127 var1823)) ; Statement: $r3 = r0.<edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor: java.util.Map genres> 
(define-const var413 var640 (docInfo/-1745439537 var3610)) ; Statement: $r2 = r1.<edu.stanford.nlp.coref.data.Document: java.util.Map docInfo> 
(define-const var552 var937 (var640_get/1088891777 var413 (cast-from-String-to-var937 "DOC_ID"))) ; Statement: $r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("DOC_ID") 
(define-const var492 String (cast-from-var937-to-String var552)) ; Statement: $r5 = (java.lang.String) $r4 
; split operation: var3511 = var492.split("/") ; Statement: $r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var2002 String (get_split_element var492 "/" (- 1) 0)) ; Statement: $r7 = $r6[0] 
(define-const var2849 var937 (var640_get/1088891777 var2321 (cast-from-String-to-var937 var2002))) ; Statement: $r8 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>($r7) 
(define-const var2412 Int (cast-from-var937-to-Int var2849)) ; Statement: $r9 = (java.lang.Integer) $r8 
(assert true)
(define-const var2047 Int (intValue/-1815674922 var2412)) ; Statement: $i1 = virtualinvoke $r9.<java.lang.Integer: int intValue()>() 
(define-const var131 var640 (genres/1476566127 var1823)) ; Statement: $r10 = r0.<edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor: java.util.Map genres> 
(define-const var1767 Int (var640_size/-1594421051 var131)) ; Statement: $i0 = interfaceinvoke $r10.<java.util.Map: int size()>() 
(define-const var563 var1374 (var1071_oneHot/961599073 var2047 var1767)) ; Statement: $r11 = staticinvoke <edu.stanford.nlp.neural.NeuralUtils: org.ejml.simple.SimpleMatrix oneHot(int,int)>($i1, $i0) 
 ; Statement: goto [?= return $r11] 
(assert true) ; Non Conditional
 ; Statement: return $r11 
(check-sat)
; {conll/1476566127=([edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor], boolean), genres/1476566127=([edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor], java.util.Map), docInfo/-1745439537=([edu.stanford.nlp.coref.data.Document], java.util.Map), var640_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var937=([java.lang.String], java.lang.Object), cast-from-var937-to-String=([java.lang.Object], java.lang.String), cast-from-var937-to-Int=([java.lang.Object], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int), var640_size/-1594421051=([java.util.Map], int), var1071_oneHot/961599073=([int, int], org.ejml.simple.SimpleMatrix)}
; {var1618=edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor, var1823=r0, var3085=edu.stanford.nlp.coref.data.Document, var3610=r1, var2907=$z0, var640=java.util.Map, var2321=$r3, var413=$r2, var937=java.lang.Object, var552=$r4, var492=$r5, var3511=$r6, var2002=$r7, var2849=$r8, var2412=$r9, var2047=$i1, var131=$r10, var1767=$i0, var1374=org.ejml.simple.SimpleMatrix, var1071=edu.stanford.nlp.neural.NeuralUtils, var563=$r11}
; {edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor=var1618, r0=var1823, edu.stanford.nlp.coref.data.Document=var3085, r1=var3610, $z0=var2907, java.util.Map=var640, $r3=var2321, $r2=var413, java.lang.Object=var937, $r4=var552, $r5=var492, $r6=var3511, $r7=var2002, $r8=var2849, $r9=var2412, $i1=var2047, $r10=var131, $i0=var1767, org.ejml.simple.SimpleMatrix=var1374, edu.stanford.nlp.neural.NeuralUtils=var1071, $r11=var563}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor;	r1 := @parameter0: edu.stanford.nlp.coref.data.Document;	$z0 = r0.<edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor: boolean conll>;	if $z0 == 0 goto $r11 = new org.ejml.simple.SimpleMatrix;	$r3 = r0.<edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor: java.util.Map genres>;	$r2 = r1.<edu.stanford.nlp.coref.data.Document: java.util.Map docInfo>;	$r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("DOC_ID");	$r5 = (java.lang.String) $r4;	$r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$r7 = $r6[0];	$r8 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>($r7);	$r9 = (java.lang.Integer) $r8;	$i1 = virtualinvoke $r9.<java.lang.Integer: int intValue()>();	$r10 = r0.<edu.stanford.nlp.coref.neural.CategoricalFeatureExtractor: java.util.Map genres>;	$i0 = interfaceinvoke $r10.<java.util.Map: int size()>();	$r11 = staticinvoke <edu.stanford.nlp.neural.NeuralUtils: org.ejml.simple.SimpleMatrix oneHot(int,int)>($i1, $i0);	goto [?= return $r11];	return $r11
;block_num 3
(exit)
