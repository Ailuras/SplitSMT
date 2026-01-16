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

(declare-sort var2379 0)
(declare-sort var71 0)
(declare-sort var628 0)
(declare-sort var1894 0)
(declare-sort var2567 0)
(declare-sort var1214 0)
(declare-sort var2251 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1894_info/79011599 (var1894 String var2567) void)
(declare-fun cast-from-var628-to-var2567 (var628) var2567)
(declare-fun pageNumbers/1418557443 (var2379) var1214)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun var1214_put/1464166817 (var1214 var2251 var2251) var2251)
(declare-fun cast-from-String-to-var2251 (String) var2251)
(declare-fun cast-from-Int-to-var2251 (Int) var2251)
(declare-const null-var2379 var2379)
(declare-const null-String String)
(declare-const null-var628 var628)
(declare-const var2379-log var1894)
(declare-const var1217 var2379) ; Statement: r6 := @this: org.docx4j.toc.TocPageNumbersHandler 
(assert (not (= var1217 null-var2379)))
(declare-const var2418 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2418 null-String)))
; split operation: var132 = var2418.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var330 String (get_split_element var2418 "," (- 1) 1)) ; Statement: $r2 = r1[1] 
(assert true)
(define-const var1927 String (replace/2138489945 var330 (cast-from-String-to-String ")") (cast-from-String-to-String ""))) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>(")", "") 
(define-const var135 Int 1) ; Statement: i0 = 1 
(define-const var1098 String (get_split_element var2418 "," (- 1) 0)) ; Statement: $r4 = r1[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2754 var628) ; Statement: $r9 := @caughtexception 
(assert (not (= var2754 null-var628)))
(define-const var2883 var1894 var2379-log) ; Statement: $r10 = <org.docx4j.toc.TocPageNumbersHandler: org.slf4j.Logger log> 
(define-const var3471 String (str.++ "Invalid page number: \u{01}" var2418)) ; Statement: $r11 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>(r0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("Invalid page number: \u{01}") 
;(assert (var1894_info/79011599 var2883 var3471 (cast-from-var628-to-var2567 var2754))) ; Statement: interfaceinvoke $r10.<org.slf4j.Logger: void info(java.lang.String,java.lang.Throwable)>($r11, $r9) 

(declare-const var2883!1 var1894)
(declare-const var3471!1 String)
(declare-const var2754!1 var628)
(assert true) ; Non Conditional
(define-const var1410 var1214 (pageNumbers/1418557443 var1217)) ; Statement: $r7 = r6.<org.docx4j.toc.TocPageNumbersHandler: java.util.Map pageNumbers> 
(define-const var3198 Int (Int_valueOf/-1371140006 var135)) ; Statement: $r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
;(assert (var1214_put/1464166817 var1410 (cast-from-String-to-var2251 var1927) (cast-from-Int-to-var2251 var3198))) ; Statement: interfaceinvoke $r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r3, $r8) 

(declare-const var1410!1 var1214)
(declare-const var1927!1 String)
(declare-const var3198!1 Int)
 ; Statement: return 
; {replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1894_info/79011599=([org.slf4j.Logger, java.lang.String, java.lang.Throwable], void), cast-from-var628-to-var2567=([java.lang.NumberFormatException], java.lang.Throwable), pageNumbers/1418557443=([org.docx4j.toc.TocPageNumbersHandler], java.util.Map), Int_valueOf/-1371140006=([int], java.lang.Integer), var1214_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var2251=([java.lang.String], java.lang.Object), cast-from-Int-to-var2251=([java.lang.Integer], java.lang.Object)}
; {var2379=org.docx4j.toc.TocPageNumbersHandler, var1217=r6, var2418=r0, var71=null_type, var132=r1, var330=$r2, var1927=r3, var135=i0, var1098=$r4, var628=java.lang.NumberFormatException, var2754=$r9, var1894=org.slf4j.Logger, var2883=$r10, var3471=$r11, var2567=java.lang.Throwable, var1214=java.util.Map, var1410=$r7, var3198=$r8, var2251=java.lang.Object}
; {org.docx4j.toc.TocPageNumbersHandler=var2379, r6=var1217, r0=var2418, null_type=var71, r1=var132, $r2=var330, r3=var1927, i0=var135, $r4=var1098, java.lang.NumberFormatException=var628, $r9=var2754, org.slf4j.Logger=var1894, $r10=var2883, $r11=var3471, java.lang.Throwable=var2567, java.util.Map=var1214, $r7=var1410, $r8=var3198, java.lang.Object=var2251}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1}
;stmts r6 := @this: org.docx4j.toc.TocPageNumbersHandler;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r2 = r1[1];	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>(")", "");	i0 = 1;	$r4 = r1[0];	$r9 := @caughtexception;	$r10 = <org.docx4j.toc.TocPageNumbersHandler: org.slf4j.Logger log>;	$r11 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>(r0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("Invalid page number: \u{01}");	interfaceinvoke $r10.<org.slf4j.Logger: void info(java.lang.String,java.lang.Throwable)>($r11, $r9);	$r7 = r6.<org.docx4j.toc.TocPageNumbersHandler: java.util.Map pageNumbers>;	$r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	interfaceinvoke $r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r3, $r8);	return
;block_num 3
(check-sat)
(exit)
