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

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var229 0)
(declare-sort var958 0)
(declare-sort var785 0)
(declare-sort var2976 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var785_compile/2141929305 (String) var785)
(declare-fun matcher/468719934 (var785 String) var2976)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun find/1809080823 (var2976) Bool)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun matches/-643015890 (String String) Bool)
(declare-const null-var229 var229)
(declare-const null-String String)
(declare-const var1225 var229) ; Statement: r5 := @this: org.jline.reader.Parser 
(assert (not (= var1225 null-var229)))
(declare-const var254 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var254 null-String)))
(define-const var2540 var785 (var785_compile/2141929305 "^\u{09}*[a-zA-Z_]+[a-zA-Z0-9_-]*=([:]?[a-zA-Z]+[a-zA-Z0-9_-]*)(\u{09}+|$)")) ; Statement: r0 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("^\\s*[a-zA-Z_]+[a-zA-Z0-9_-]*=([:]?[a-zA-Z]+[a-zA-Z0-9_-]*)(\\s+|$)") 
(assert true)
(define-const var3702 var2976 (matcher/468719934 var2540 (cast-from-String-to-String var254))) ; Statement: r2 = virtualinvoke r0.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r1) 
(assert true)
(define-const var2154 Bool (find/1809080823 var3702)) ; Statement: $z0 = virtualinvoke r2.<java.util.regex.Matcher: boolean find()>() 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>() 
(assert (= (ite var2154 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var226 String (trim/-847153721 var254)) ; Statement: $r3 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>() 
; split operation: var2476 = var226.split("\u005cs+") ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var2427 String (get_split_element_re var226 (re.+ (re.union (str.to_re " ") (str.to_re "\u{09}"))) (- 1) 0)) ; Statement: r6 = $r4[0] 
(assert true)
(define-const var3636 Bool (matches/-643015890 var2427 "[:]?[a-zA-Z]+[a-zA-Z0-9_-]*")) ; Statement: $z1 = virtualinvoke r6.<java.lang.String: boolean matches(java.lang.String)>("[:]?[a-zA-Z]+[a-zA-Z0-9_-]*") 
(assert (= (matches/-643015890 var2427 "[:]?[a-zA-Z]+[a-zA-Z0-9_-]*") (str.in_re var2427 (re.++ (re.opt (str.to_re ":")) (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))) (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-")))))))
 ; Statement: if $z1 != 0 goto return r6 
(assert (not (= (ite var3636 1 0) 0))) ; Cond: $z1 != 0 
 ; Statement: return r6 
; {var785_compile/2141929305=([java.lang.String], java.util.regex.Pattern), matcher/468719934=([java.util.regex.Pattern, java.lang.CharSequence], java.util.regex.Matcher), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), find/1809080823=([java.util.regex.Matcher], boolean), trim/-847153721=([java.lang.String], java.lang.String), matches/-643015890=([java.lang.String, java.lang.String], boolean)}
; {var229=org.jline.reader.Parser, var1225=r5, var254=r1, var958=null_type, var785=java.util.regex.Pattern, var2540=r0, var2976=java.util.regex.Matcher, var3702=r2, var2154=$z0, var226=$r3, var2476=$r4, var2427=r6, var3636=$z1}
; {org.jline.reader.Parser=var229, r5=var1225, r1=var254, null_type=var958, java.util.regex.Pattern=var785, r0=var2540, java.util.regex.Matcher=var2976, r2=var3702, $z0=var2154, $r3=var226, $r4=var2476, r6=var2427, $z1=var3636}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean matches(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean matches(java.lang.String)>": 1}
;stmts r5 := @this: org.jline.reader.Parser;	r1 := @parameter0: java.lang.String;	r0 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("^\\s*[a-zA-Z_]+[a-zA-Z0-9_-]*=([:]?[a-zA-Z]+[a-zA-Z0-9_-]*)(\\s+|$)");	r2 = virtualinvoke r0.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r1);	$z0 = virtualinvoke r2.<java.util.regex.Matcher: boolean find()>();	if $z0 == 0 goto $r3 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>();	$r3 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>();	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	r6 = $r4[0];	$z1 = virtualinvoke r6.<java.lang.String: boolean matches(java.lang.String)>("[:]?[a-zA-Z]+[a-zA-Z0-9_-]*");	if $z1 != 0 goto return r6;	return r6
;block_num 3
(check-sat)
(exit)
