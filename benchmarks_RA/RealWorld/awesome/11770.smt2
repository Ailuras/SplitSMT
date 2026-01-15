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

(declare-sort var3493 0)
(declare-sort var466 0)
(declare-sort var3261 0)
(declare-sort var1750 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun info/114590825 (var466 String) void)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1750-init () var1750)
(declare-fun <init>/451842749 (var1750) void)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3261-logger var466)
(declare-const var1437 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1437 null-String)))
(declare-const var1968 (Array Int String)) ; Statement: r18 := @parameter1: java.lang.String[] 
(assert (not (= var1968 null-__Array__Int__String__)))
(define-const var223 var466 var3261-logger) ; Statement: $r1 = <edu.stanford.nlp.ie.machinereading.MachineReadingProperties: java.util.logging.Logger logger> 
(define-const var2638 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2638)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2638!1 String)
(assert (= var2638!1 ""))
(assert true)
(define-const var683 String (append/672562846 var2638!1 "Making result printers from ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Making result printers from ") 
(declare-const var2638!2 String)
(assert (= var2638!2 (str.++ var2638!1 "Making result printers from ")))
(assert true)
(define-const var1535 String (append/672562846 var683 var1437)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var683!1 String)
(assert (= var683!1 (str.++ var683 var1437)))
(assert true)
(define-const var118 String (toString/-2075883882 var1535)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (info/114590825 var223 var118)) ; Statement: virtualinvoke $r1.<java.util.logging.Logger: void info(java.lang.String)>($r5) 

(declare-const var223!1 var466)
(declare-const var118!1 String)
(assert true)
(define-const var240 String (trim/-847153721 var1437)) ; Statement: $r6 = virtualinvoke r2.<java.lang.String: java.lang.String trim()>() 
; split operation: var535 = var240.split(",\u005cs*") ; Statement: r7 = virtualinvoke $r6.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*") 
(define-const var407 var1750 var1750-init) ; Statement: $r8 = new java.util.HashSet 
(assert true)
;(assert (<init>/451842749 var407)) ; Statement: specialinvoke $r8.<java.util.HashSet: void <init>()>() 

(declare-const var407!1 var1750)
(define-const var71 Int (get_split_length_re var240 (re.++ (str.to_re ",") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: i0 = lengthof r7 
(define-const var3363 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return $r8 
(assert (>= var3363 var71)) ; Cond: i1 >= i0 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), info/114590825=([java.util.logging.Logger, java.lang.String], void), trim/-847153721=([java.lang.String], java.lang.String), var1750-init=([], java.util.HashSet), <init>/451842749=([java.util.HashSet], void)}
; {var1437=r2, var3493=null_type, var1968=r18, var466=java.util.logging.Logger, var3261=edu.stanford.nlp.ie.machinereading.MachineReadingProperties, var223=$r1, var2638=$r0, var683=$r3, var1535=$r4, var118=$r5, var240=$r6, var535=r7, var1750=java.util.HashSet, var407=$r8, var71=i0, var3363=i1}
; {r2=var1437, null_type=var3493, r18=var1968, java.util.logging.Logger=var466, edu.stanford.nlp.ie.machinereading.MachineReadingProperties=var3261, $r1=var223, $r0=var2638, $r3=var683, $r4=var1535, $r5=var118, $r6=var240, r7=var535, java.util.HashSet=var1750, $r8=var407, i0=var71, i1=var3363}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @parameter0: java.lang.String;	r18 := @parameter1: java.lang.String[];	$r1 = <edu.stanford.nlp.ie.machinereading.MachineReadingProperties: java.util.logging.Logger logger>;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Making result printers from ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r1.<java.util.logging.Logger: void info(java.lang.String)>($r5);	$r6 = virtualinvoke r2.<java.lang.String: java.lang.String trim()>();	r7 = virtualinvoke $r6.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*");	$r8 = new java.util.HashSet;	specialinvoke $r8.<java.util.HashSet: void <init>()>();	i0 = lengthof r7;	i1 = 0;	if i1 >= i0 goto return $r8;	return $r8
;block_num 3
(exit)
