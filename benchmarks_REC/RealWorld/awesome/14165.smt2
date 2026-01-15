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

(declare-sort var454 0)
(declare-sort var2347 0)
(declare-sort var3002 0)
(declare-sort var3046 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2347_debug/594372212 (var2347 String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var3046-init () var3046)
(declare-fun <init>/-1053635008 (var3046 String) void)
(declare-const null-String String)
(declare-const var3002-log var2347)
(declare-const var1017 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1017 null-String)))
(define-const var85 var2347 var3002-log) ; Statement: $r1 = <org.docx4j.model.fields.FormattingSwitchHelper: org.slf4j.Logger log> 
(define-const var424 String (str.++ "\u0001 to Locale" var1017)) ; Statement: $r2 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>(r0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001 to Locale") 
;(assert (var2347_debug/594372212 var85 var424)) ; Statement: interfaceinvoke $r1.<org.slf4j.Logger: void debug(java.lang.String)>($r2) 

(declare-const var85!1 var2347)
(declare-const var424!1 String)
(define-const var1387 Int (cast-from-Int-to-Int (- 1))) ; Statement: $i3 = (int) (- 1) 
; split operation: var2160 = var1017.split("-", var1387) ; Statement: r3 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("-", $i3) 
(define-const var1499 Int (get_split_length var1017 "-" var1387)) ; Statement: $i0 = lengthof r3 
 ; Statement: if $i0 != 1 goto $i1 = lengthof r3 
(assert (not (not (= var1499 1)))) ; Negate: Cond: $i0 != 1  
(define-const var3690 var3046 var3046-init) ; Statement: $r13 = new java.util.Locale 
(define-const var3546 String (get_split_element var1017 "-" var1387 0)) ; Statement: $r12 = r3[0] 
(assert true)
;(assert (<init>/-1053635008 var3690 var3546)) ; Statement: specialinvoke $r13.<java.util.Locale: void <init>(java.lang.String)>($r12) 

(declare-const var3690!1 var3046)
(declare-const var3546!1 String)
 ; Statement: return $r13 
(check-sat)
; {var2347_debug/594372212=([org.slf4j.Logger, java.lang.String], void), cast-from-Int-to-Int=([int], int), var3046-init=([], java.util.Locale), <init>/-1053635008=([java.util.Locale, java.lang.String], void)}
; {var1017=r0, var454=null_type, var2347=org.slf4j.Logger, var3002=org.docx4j.model.fields.FormattingSwitchHelper, var85=$r1, var424=$r2, var1387=$i3, var2160=r3, var1499=$i0, var3046=java.util.Locale, var3690=$r13, var3546=$r12}
; {r0=var1017, null_type=var454, org.slf4j.Logger=var2347, org.docx4j.model.fields.FormattingSwitchHelper=var3002, $r1=var85, $r2=var424, $i3=var1387, r3=var2160, $i0=var1499, java.util.Locale=var3046, $r13=var3690, $r12=var3546}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = <org.docx4j.model.fields.FormattingSwitchHelper: org.slf4j.Logger log>;	$r2 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>(r0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001 to Locale");	interfaceinvoke $r1.<org.slf4j.Logger: void debug(java.lang.String)>($r2);	$i3 = (int) (- 1);	r3 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("-", $i3);	$i0 = lengthof r3;	if $i0 != 1 goto $i1 = lengthof r3;	$r13 = new java.util.Locale;	$r12 = r3[0];	specialinvoke $r13.<java.util.Locale: void <init>(java.lang.String)>($r12);	return $r13
;block_num 2
(exit)
