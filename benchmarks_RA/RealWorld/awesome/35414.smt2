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

(declare-sort var901 0)
(declare-sort var390 0)
(declare-sort var3475 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3475-init () var3475)
(declare-fun <init>/1228603609 (var3475 Int) void)
(declare-const null-var901 var901)
(declare-const null-String String)
(declare-const var375 var901) ; Statement: r13 := @this: edu.stanford.nlp.sequences.TrueCasingForNISTDocumentReaderAndWriter$LineToTrueCasesParser 
(assert (not (= var375 null-var901)))
(declare-const var1341 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1341 null-String)))
(define-const var452 Int 0) ; Statement: i3 = 0 
; split operation: var3105 = var1341.split(" ") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var3772 var3475 var3475-init) ; Statement: $r2 = new java.util.ArrayList 
(define-const var1163 Int (get_split_length var1341 " " (- 1))) ; Statement: $i0 = lengthof r1 
(assert true)
;(assert (<init>/1228603609 var3772 var1163)) ; Statement: specialinvoke $r2.<java.util.ArrayList: void <init>(int)>($i0) 

(declare-const var3772!1 var3475)
(declare-const var1163!1 Int)
(define-const var2576 Int (get_split_length var1341 " " (- 1))) ; Statement: i1 = lengthof r1 
(define-const var3500 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i1 goto return $r2 
(assert (>= var3500 var2576)) ; Cond: i4 >= i1 
 ; Statement: return $r2 
; {var3475-init=([], java.util.ArrayList), <init>/1228603609=([java.util.ArrayList, int], void)}
; {var901=edu.stanford.nlp.sequences.TrueCasingForNISTDocumentReaderAndWriter$LineToTrueCasesParser, var375=r13, var1341=r0, var390=null_type, var452=i3, var3105=r1, var3475=java.util.ArrayList, var3772=$r2, var1163=$i0, var2576=i1, var3500=i4}
; {edu.stanford.nlp.sequences.TrueCasingForNISTDocumentReaderAndWriter$LineToTrueCasesParser=var901, r13=var375, r0=var1341, null_type=var390, i3=var452, r1=var3105, java.util.ArrayList=var3475, $r2=var3772, $i0=var1163, i1=var2576, i4=var3500}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r13 := @this: edu.stanford.nlp.sequences.TrueCasingForNISTDocumentReaderAndWriter$LineToTrueCasesParser;	r0 := @parameter0: java.lang.String;	i3 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$r2 = new java.util.ArrayList;	$i0 = lengthof r1;	specialinvoke $r2.<java.util.ArrayList: void <init>(int)>($i0);	i1 = lengthof r1;	i4 = 0;	if i4 >= i1 goto return $r2;	return $r2
;block_num 3
(check-sat)
(exit)
