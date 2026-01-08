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

(declare-sort var546 0)
(declare-sort var1403 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getPath/39698060 (var546) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1403-init () var1403)
(declare-fun <init>/875830710 (var1403 String) void)
(declare-const null-var546 var546)
(declare-const var1012 var546) ; Statement: r1 := @parameter0: java.net.URI 
(assert (not (= var1012 null-var546)))
(declare-const var1175 var546) ; Statement: r4 := @parameter1: java.net.URI 
(assert (not (= var1175 null-var546)))
(define-const var1132 String String-init) ; Statement: $r25 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1132)) ; Statement: specialinvoke $r25.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1132!1 String)
(assert (= var1132!1 ""))
(assert true)
(define-const var520 String (getPath/39698060 var1012)) ; Statement: $r2 = virtualinvoke r1.<java.net.URI: java.lang.String getPath()>() 
(define-const var594 Int (cast-from-Int-to-Int (- 1))) ; Statement: $i25 = (int) (- 1) 
; split operation: var911 = var520.split("/", var594) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("/", $i25) 
(assert true)
(define-const var2564 String (getPath/39698060 var1175)) ; Statement: $r5 = virtualinvoke r4.<java.net.URI: java.lang.String getPath()>() 
(define-const var1345 Int (cast-from-Int-to-Int (- 1))) ; Statement: $i27 = (int) (- 1) 
; split operation: var2844 = var2564.split("/", var1345) ; Statement: r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("/", $i27) 
(define-const var2014 Int (get_split_length var520 "/" var594)) ; Statement: $i0 = lengthof r3 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r6 
(assert (not (not (= var2014 0)))) ; Negate: Cond: $i0 != 0  
(define-const var2449 var1403 var1403-init) ; Statement: $r26 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var2449 "Can\u0027t relativize an empty source URI !")) ; Statement: specialinvoke $r26.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Can\'t relativize an empty source URI !") 

(declare-const var2449!1 var1403)
(declare-const var2318 String)
 ; Statement: throw $r26 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getPath/39698060=([java.net.URI], java.lang.String), cast-from-Int-to-Int=([int], int), var1403-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var546=java.net.URI, var1012=r1, var1175=r4, var1132=$r25, var520=$r2, var594=$i25, var911=r3, var2564=$r5, var1345=$i27, var2844=r6, var2014=$i0, var1403=java.lang.IllegalArgumentException, var2449=$r26, var2318="Can\'t relativize an empty source URI !"}
; {java.net.URI=var546, r1=var1012, r4=var1175, $r25=var1132, $r2=var520, $i25=var594, r3=var911, $r5=var2564, $i27=var1345, r6=var2844, $i0=var2014, java.lang.IllegalArgumentException=var1403, $r26=var2449, "Can\'t relativize an empty source URI !"=var2318}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 2}
;stmts r1 := @parameter0: java.net.URI;	r4 := @parameter1: java.net.URI;	$r25 = new java.lang.StringBuilder;	specialinvoke $r25.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.net.URI: java.lang.String getPath()>();	$i25 = (int) -1;	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("/", $i25);	$r5 = virtualinvoke r4.<java.net.URI: java.lang.String getPath()>();	$i27 = (int) -1;	r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("/", $i27);	$i0 = lengthof r3;	if $i0 != 0 goto $i1 = lengthof r6;	$r26 = new java.lang.IllegalArgumentException;	specialinvoke $r26.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Can\'t relativize an empty source URI !");	throw $r26
;block_num 2
(exit)
