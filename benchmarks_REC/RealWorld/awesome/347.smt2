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

(declare-sort var3135 0)
(declare-sort var3284 0)
(declare-sort var28 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun commander/-2133873678 (var3135) var28)
(declare-fun getColumnSize/-165698927 (var28) Int)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var3135 var3135)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3498 var3135) ; Statement: r0 := @this: com.beust.jcommander.DefaultUsageFormatter 
(assert (not (= var3498 null-var3135)))
(declare-const var2208 String) ; Statement: r5 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2208 null-String)))
(declare-const var3405 Int) ; Statement: i10 := @parameter1: int 
(assert (not (= var3405 null-Int)))
(declare-const var1881 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var1881 null-Int)))
(declare-const var2549 String) ; Statement: r2 := @parameter3: java.lang.String 
(assert (not (= var2549 null-String)))
(define-const var2525 var28 (commander/-2133873678 var3498)) ; Statement: $r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander> 
(assert true)
(define-const var653 Int (getColumnSize/-165698927 var2525)) ; Statement: i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>() 
; split operation: var2153 = var2549.split(" ") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var3076 Int var1881) ; Statement: i14 = i1 
(define-const var3246 Int 0) ; Statement: i15 = 0 
(assert true) ; Non Conditional
(define-const var2125 Int (get_split_length var2549 " " (- 1))) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (not (>= var3246 var2125))) ; Negate: Cond: i15 >= $i2  
(define-const var3656 String (get_split_element var2549 " " (- 1) var3246)) ; Statement: r4 = r3[i15] 
(assert true)
(define-const var1943 Int (length/-134980193 var3656)) ; Statement: $i3 = virtualinvoke r4.<java.lang.String: int length()>() 
 ; Statement: if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(assert (not (> var1943 var653))) ; Negate: Cond: $i3 > i0  
(define-const var992 Int (+ var3076 1)) ; Statement: $i8 = i14 + 1 
(assert true)
(define-const var325 Int (length/-134980193 var3656)) ; Statement: $i7 = virtualinvoke r4.<java.lang.String: int length()>() 
(define-const var203 Int (+ var992 var325)) ; Statement: $i9 = $i8 + $i7 
 ; Statement: if $i9 > i0 goto $r7 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (not (> var203 var653))) ; Negate: Cond: $i9 > i0  
(assert true)
;(assert (append/672562846 var2208 var3656)) ; Statement: virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var2208!1 String)
(assert (= var2208!1 (str.++ var2208 var3656)))
(assert true)
(define-const var2753 Int (length/-134980193 var3656)) ; Statement: $i4 = virtualinvoke r4.<java.lang.String: int length()>() 
(define-const var367 Int (+ var3076 var2753)) ; Statement: $i13 = i14 + $i4 
(define-const var3076!1 Int var367) ; Statement: i14 = $i13 
(define-const var2971 Int (get_split_length var2549 " " (- 1))) ; Statement: $i5 = lengthof r3 
(define-const var533 Int (- var2971 1)) ; Statement: $i6 = $i5 - 1 
 ; Statement: if i15 == $i6 goto i15 = i15 + 1 
(assert (= var3246 var533)) ; Cond: i15 == $i6 
(define-const var3246!1 Int (+ var3246 1)) ; Statement: i15 = i15 + 1 
 ; Statement: goto [?= $i2 = lengthof r3] 
(assert true) ; Non Conditional
(define-const var2125!1 Int (get_split_length var2549 " " (- 1))) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (>= var3246!1 var2125!1)) ; Cond: i15 >= $i2 
 ; Statement: return 
(check-sat)
; {commander/-2133873678=([com.beust.jcommander.DefaultUsageFormatter], com.beust.jcommander.JCommander), getColumnSize/-165698927=([com.beust.jcommander.JCommander], int), length/-134980193=([java.lang.String], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var3135=com.beust.jcommander.DefaultUsageFormatter, var3498=r0, var2208=r5, var3405=i10, var1881=i1, var2549=r2, var3284=null_type, var28=com.beust.jcommander.JCommander, var2525=$r1, var653=i0, var2153=r3, var3076=i14, var3246=i15, var2125=$i2, var3656=r4, var1943=$i3, var992=$i8, var325=$i7, var203=$i9, var2753=$i4, var367=$i13, var2971=$i5, var533=$i6}
; {com.beust.jcommander.DefaultUsageFormatter=var3135, r0=var3498, r5=var2208, i10=var3405, i1=var1881, r2=var2549, null_type=var3284, com.beust.jcommander.JCommander=var28, $r1=var2525, i0=var653, r3=var2153, i14=var3076, i15=var3246, $i2=var2125, r4=var3656, $i3=var1943, $i8=var992, $i7=var325, $i9=var203, $i4=var2753, $i13=var367, $i5=var2971, $i6=var533}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: int length()>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: com.beust.jcommander.DefaultUsageFormatter;	r5 := @parameter0: java.lang.StringBuilder;	i10 := @parameter1: int;	i1 := @parameter2: int;	r2 := @parameter3: java.lang.String;	$r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander>;	i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>();	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	i14 = i1;	i15 = 0;	$i2 = lengthof r3;	if i15 >= $i2 goto return;	r4 = r3[i15];	$i3 = virtualinvoke r4.<java.lang.String: int length()>();	if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$i8 = i14 + 1;	$i7 = virtualinvoke r4.<java.lang.String: int length()>();	$i9 = $i8 + $i7;	if $i9 > i0 goto $r7 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$i4 = virtualinvoke r4.<java.lang.String: int length()>();	$i13 = i14 + $i4;	i14 = $i13;	$i5 = lengthof r3;	$i6 = $i5 - 1;	if i15 == $i6 goto i15 = i15 + 1;	i15 = i15 + 1;	goto [?= $i2 = lengthof r3];	$i2 = lengthof r3;	if i15 >= $i2 goto return;	return
;block_num 8
(exit)
