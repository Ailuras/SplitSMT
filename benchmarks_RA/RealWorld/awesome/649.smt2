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

(declare-sort var2980 0)
(declare-sort var2366 0)
(declare-sort var191 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun containsKey/437427949 (var2366 var191) Bool)
(declare-fun cast-from-String-to-var191 (String) var191)
(declare-fun getFirst/-1258182190 (var2366 String) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var2980 var2980)
(declare-const null-var2366 var2366)
(declare-const var3557 var2980) ; Statement: r4 := @this: edu.stanford.nlp.pipeline.StanfordCoreNLPServer 
(assert (not (= var3557 null-var2980)))
(declare-const var1866 var2366) ; Statement: r0 := @parameter0: com.sun.net.httpserver.Headers 
(assert (not (= var1866 null-var2366)))
(define-const var1355 String "application/x-www-form-urlencoded") ; Statement: r5 = "application/x-www-form-urlencoded" 
(assert true)
(define-const var3986 Bool (containsKey/437427949 var1866 (cast-from-String-to-var191 "Content-type"))) ; Statement: $z0 = virtualinvoke r0.<com.sun.net.httpserver.Headers: boolean containsKey(java.lang.Object)>("Content-type") 
 ; Statement: if $z0 == 0 goto return r5 
(assert (not (= (ite var3986 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1448 String (getFirst/-1258182190 var1866 "Content-type")) ; Statement: $r1 = virtualinvoke r0.<com.sun.net.httpserver.Headers: java.lang.String getFirst(java.lang.String)>("Content-type") 
; split operation: var1168 = var1448.split(";") ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var3615 String (get_split_element var1448 ";" (- 1) 0)) ; Statement: $r3 = $r2[0] 
(assert true)
(define-const var1355!1 String (trim/-847153721 var3615)) ; Statement: r5 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>() 
(assert true) ; Non Conditional
 ; Statement: return r5 
(check-sat)
; {containsKey/437427949=([com.sun.net.httpserver.Headers, java.lang.Object], boolean), cast-from-String-to-var191=([java.lang.String], java.lang.Object), getFirst/-1258182190=([com.sun.net.httpserver.Headers, java.lang.String], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var2980=edu.stanford.nlp.pipeline.StanfordCoreNLPServer, var3557=r4, var2366=com.sun.net.httpserver.Headers, var1866=r0, var1355=r5, var191=java.lang.Object, var3986=$z0, var1448=$r1, var1168=$r2, var3615=$r3}
; {edu.stanford.nlp.pipeline.StanfordCoreNLPServer=var2980, r4=var3557, com.sun.net.httpserver.Headers=var2366, r0=var1866, r5=var1355, java.lang.Object=var191, $z0=var3986, $r1=var1448, $r2=var1168, $r3=var3615}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r4 := @this: edu.stanford.nlp.pipeline.StanfordCoreNLPServer;	r0 := @parameter0: com.sun.net.httpserver.Headers;	r5 = "application/x-www-form-urlencoded";	$z0 = virtualinvoke r0.<com.sun.net.httpserver.Headers: boolean containsKey(java.lang.Object)>("Content-type");	if $z0 == 0 goto return r5;	$r1 = virtualinvoke r0.<com.sun.net.httpserver.Headers: java.lang.String getFirst(java.lang.String)>("Content-type");	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$r3 = $r2[0];	r5 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>();	return r5
;block_num 3
(exit)
