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

(declare-sort var1902 0)
(declare-sort var2060 0)
(declare-sort var198 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun var198_max/1360571700 (Int Int) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-const null-var1902 var1902)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var1372 var1902) ; Statement: r7 := @this: org.jline.builtins.ScreenTerminal 
(assert (not (= var1372 null-var1902)))
(declare-const var921 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var921 null-String)))
(declare-const var3653 (Array Int Int)) ; Statement: r0 := @parameter1: int[] 
(assert (not (= var3653 null-__Array__Int__Int__)))
(define-const var2813 String "") ; Statement: r9 = "" 
 ; Statement: if r8 != null goto $r10 = r8 
(assert (not (= var921 null-String))) ; Cond: r8 != null 
(define-const var3463 String var921) ; Statement: $r10 = r8 
(assert true) ; Non Conditional
(define-const var853 String var3463) ; Statement: r11 = $r10 
(assert true)
(define-const var834 Int (length/-134980193 var3463)) ; Statement: $i0 = virtualinvoke $r10.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r12 = virtualinvoke r11.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(assert (<= var834 0)) ; Cond: $i0 <= 0 
; split operation: var3749 = var853.split(";") ; Statement: $r12 = virtualinvoke r11.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var2306 Int (get_split_length var853 ";" (- 1))) ; Statement: $i8 = lengthof $r12 
(define-const var1685 Int (getLength-Arr-Int-1 var3653)) ; Statement: $i9 = lengthof r0 
(define-const var2908 Int (var198_max/1360571700 var2306 var1685)) ; Statement: $i10 = staticinvoke <java.lang.Math: int max(int,int)>($i8, $i9) 
(define-const var3451 (Array Int Int) arr-Int-init) ; Statement: $r13 = newarray (int)[$i10] 
(define-const var3519 Int 0) ; Statement: i11 = 0 
(assert true) ; Non Conditional
 ; Statement: if i11 >= $i10 goto return $r13 
(assert (>= var3519 var2908)) ; Cond: i11 >= $i10 
 ; Statement: return $r13 
(check-sat)
; {length/-134980193=([java.lang.String], int), getLength-Arr-Int-1=([int[]], int), var198_max/1360571700=([int, int], int), arr-Int-init=([], int[])}
; {var1902=org.jline.builtins.ScreenTerminal, var1372=r7, var921=r8, var2060=null_type, var3653=r0, var2813=r9, var3463=$r10, var853=r11, var834=$i0, var3749=$r12, var2306=$i8, var1685=$i9, var198=java.lang.Math, var2908=$i10, var3451=$r13, var3519=i11}
; {org.jline.builtins.ScreenTerminal=var1902, r7=var1372, r8=var921, null_type=var2060, r0=var3653, r9=var2813, $r10=var3463, r11=var853, $i0=var834, $r12=var3749, $i8=var2306, $i9=var1685, java.lang.Math=var198, $i10=var2908, $r13=var3451, i11=var3519}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r7 := @this: org.jline.builtins.ScreenTerminal;	r8 := @parameter0: java.lang.String;	r0 := @parameter1: int[];	r9 = "";	if r8 != null goto $r10 = r8;	$r10 = r8;	r11 = $r10;	$i0 = virtualinvoke $r10.<java.lang.String: int length()>();	if $i0 <= 0 goto $r12 = virtualinvoke r11.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$r12 = virtualinvoke r11.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$i8 = lengthof $r12;	$i9 = lengthof r0;	$i10 = staticinvoke <java.lang.Math: int max(int,int)>($i8, $i9);	$r13 = newarray (int)[$i10];	i11 = 0;	if i11 >= $i10 goto return $r13;	return $r13
;block_num 6
(exit)
