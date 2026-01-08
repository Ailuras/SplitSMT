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

(declare-sort var3294 0)
(declare-sort var3234 0)
(declare-sort var86 0)
(declare-sort var2952 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var86) void)
(declare-fun cast-from-var3294-to-var86 (var3294) var86)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-fun var2952-init () var2952)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2952 String) void)
(declare-const null-var3294 var3294)
(declare-const null-String String)
(declare-const var3134 var3294) ; Statement: r0 := @this: edu.stanford.nlp.tagger.maxent.Distsim 
(assert (not (= var3134 null-var3294)))
(declare-const var3854 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3854 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3294-to-var86 var3134))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3134!1 var3294)
; split operation: var3749 = var3854.split(";") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var1905 String (get_split_element var3854 ";" (- 1) 0)) ; Statement: r3 = r2[0] 
(define-const var3502 Int 1) ; Statement: i1 = 1 
(assert true) ; Non Conditional
(define-const var2775 Int (get_split_length var3854 ";" (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto $r4 = new edu.stanford.nlp.util.Interner 
(assert (not (>= var3502 var2775))) ; Negate: Cond: i1 >= $i0  
(define-const var1976 String (get_split_element var3854 ";" (- 1) var3502)) ; Statement: $r18 = r2[i1] 
(assert true)
(define-const var1192 Bool (equalsIgnoreCase/-92311102 var1976 "mapdigits")) ; Statement: $z2 = virtualinvoke $r18.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>("mapdigits") 
 ; Statement: if $z2 == 0 goto $r19 = r2[i1] 
(assert (= (ite var1192 1 0) 0)) ; Cond: $z2 == 0 
(define-const var2472 String (get_split_element var3854 ";" (- 1) var3502)) ; Statement: $r19 = r2[i1] 
(assert true)
(define-const var174 Bool (equalsIgnoreCase/-92311102 var2472 "casedDistSim")) ; Statement: $z3 = virtualinvoke $r19.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>("casedDistSim") 
 ; Statement: if $z3 == 0 goto $r20 = new java.lang.IllegalArgumentException 
(assert (= (ite var174 1 0) 0)) ; Cond: $z3 == 0 
(define-const var3583 var2952 var2952-init) ; Statement: $r20 = new java.lang.IllegalArgumentException 
(define-const var1670 String String-init) ; Statement: $r21 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1670)) ; Statement: specialinvoke $r21.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1670!1 String)
(assert (= var1670!1 ""))
(assert true)
(define-const var2517 String (append/672562846 var1670!1 "Unknown argument ")) ; Statement: $r23 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unknown argument ") 
(declare-const var1670!2 String)
(assert (= var1670!2 (str.++ var1670!1 "Unknown argument ")))
(define-const var1826 String (get_split_element var3854 ";" (- 1) var3502)) ; Statement: $r22 = r2[i1] 
(assert true)
(define-const var1567 String (append/672562846 var2517 var1826)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var2517!1 String)
(assert (= var2517!1 (str.++ var2517 var1826)))
(assert true)
(define-const var2569 String (toString/-2075883882 var1567)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3583 var2569)) ; Statement: specialinvoke $r20.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r25) 

(declare-const var3583!1 var2952)
(declare-const var2569!1 String)
 ; Statement: throw $r20 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3294-to-var86=([edu.stanford.nlp.tagger.maxent.Distsim], java.lang.Object), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean), var2952-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3294=edu.stanford.nlp.tagger.maxent.Distsim, var3134=r0, var3854=r1, var3234=null_type, var86=java.lang.Object, var3749=r2, var1905=r3, var3502=i1, var2775=$i0, var1976=$r18, var1192=$z2, var2472=$r19, var174=$z3, var2952=java.lang.IllegalArgumentException, var3583=$r20, var1670=$r21, var2517=$r23, var1826=$r22, var1567=$r24, var2569=$r25}
; {edu.stanford.nlp.tagger.maxent.Distsim=var3294, r0=var3134, r1=var3854, null_type=var3234, java.lang.Object=var86, r2=var3749, r3=var1905, i1=var3502, $i0=var2775, $r18=var1976, $z2=var1192, $r19=var2472, $z3=var174, java.lang.IllegalArgumentException=var2952, $r20=var3583, $r21=var1670, $r23=var2517, $r22=var1826, $r24=var1567, $r25=var2569}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>;	<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: edu.stanford.nlp.tagger.maxent.Distsim;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	r3 = r2[0];	i1 = 1;	$i0 = lengthof r2;	if i1 >= $i0 goto $r4 = new edu.stanford.nlp.util.Interner;	$r18 = r2[i1];	$z2 = virtualinvoke $r18.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>("mapdigits");	if $z2 == 0 goto $r19 = r2[i1];	$r19 = r2[i1];	$z3 = virtualinvoke $r19.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>("casedDistSim");	if $z3 == 0 goto $r20 = new java.lang.IllegalArgumentException;	$r20 = new java.lang.IllegalArgumentException;	$r21 = new java.lang.StringBuilder;	specialinvoke $r21.<java.lang.StringBuilder: void <init>()>();	$r23 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unknown argument ");	$r22 = r2[i1];	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r20.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r25);	throw $r20
;block_num 5
(exit)
