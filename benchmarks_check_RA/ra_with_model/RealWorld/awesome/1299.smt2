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

(declare-sort var1473 0)
(declare-sort var934 0)
(declare-sort var2022 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun var2022-init () var2022)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2022 String) void)
(declare-const null-String String)
(declare-const null-var934 var934)
(declare-const var1281 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1281 null-String)))
; split operation: var3425 = var1281.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var2192 String (get_split_element var1281 "/" (- 1) 0)) ; Statement: r2 = r1[0] 
(define-const var2092 Int (get_split_length var1281 "/" (- 1))) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 >= 2 goto $r3 = r1[1] 
(assert (>= var2092 2)) ; Cond: $i0 >= 2 
(define-const var203 String (get_split_element var1281 "/" (- 1) 1)) ; Statement: $r3 = r1[1] 
(define-const var1736 Int (Int_parseInt/1370970945 var203)) ; Statement: i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r3) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3530 var934) ; Statement: $r8 := @caughtexception 
(assert (not (= var3530 null-var934)))
(define-const var882 var2022 var2022-init) ; Statement: $r9 = new java.lang.IllegalArgumentException 
(define-const var2388 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2388)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2388!1 String)
(assert (= var2388!1 ""))
(assert true)
(define-const var2977 String (append/672562846 var2388!1 "Invalid subnet: ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid subnet: ") 
(declare-const var2388!2 String)
(assert (= var2388!2 (str.++ var2388!1 "Invalid subnet: ")))
(assert true)
(define-const var2779 String (append/672562846 var2977 var1281)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2977!1 String)
(assert (= var2977!1 (str.++ var2977 var1281)))
(assert true)
(define-const var1317 String (toString/-2075883882 var2779)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var882 var1317)) ; Statement: specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13) 

(declare-const var882!1 var2022)
(declare-const var1317!1 String)
 ; Statement: throw $r9 
; {Int_parseInt/1370970945=([java.lang.String], int), var2022-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1281=r0, var1473=null_type, var3425=r1, var2192=r2, var2092=$i0, var203=$r3, var1736=i1, var934=java.net.UnknownHostException, var3530=$r8, var2022=java.lang.IllegalArgumentException, var882=$r9, var2388=$r10, var2977=$r11, var2779=$r12, var1317=$r13}
; {r0=var1281, null_type=var1473, r1=var3425, r2=var2192, $i0=var2092, $r3=var203, i1=var1736, java.net.UnknownHostException=var934, $r8=var3530, java.lang.IllegalArgumentException=var2022, $r9=var882, $r10=var2388, $r11=var2977, $r12=var2779, $r13=var1317}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	r2 = r1[0];	$i0 = lengthof r1;	if $i0 >= 2 goto $r3 = r1[1];	$r3 = r1[1];	i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r3);	$r8 := @caughtexception;	$r9 = new java.lang.IllegalArgumentException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid subnet: ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13);	throw $r9
;block_num 3
(assert (= <init>/1968657023 ""))
(assert (= var1281 "/"))
(assert (= var1317 (str.++ var2388!1 "Invalid subnet: " var1281)))
(assert (= var2388 String-init))
(assert (= var2092 (ite (> (- 1) 0) (ite (< (num_splits var1281 "/") (- 1)) (num_splits var1281 "/") (- 1)) (num_splits var1281 "/"))))
(assert (= var882 var2022-init))
(assert (= var2779 (str.++ var2388!1 "Invalid subnet: " var1281)))
(assert (= null-String ""))
(assert (= var2977 (str.++ var2388!1 "Invalid subnet: ")))
(assert (= var2977!1 "Invalid subnet: /"))
(assert (= var2388!2 "Invalid subnet: "))
(assert (= var2388!1 ""))
(assert (= var1317!1 ""))
(assert (= String-init ""))
(check-sat)
(exit)
