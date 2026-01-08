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

(declare-sort var1923 0)
(declare-sort var420 0)
(declare-sort var423 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var423_max/1360571700 (Int Int) Int)
(declare-fun arr-String-init () (Array Int String))
(declare-const null-var1923 var1923)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var841 var1923) ; Statement: r9 := @this: org.jline.builtins.ScreenTerminal 
(assert (not (= var841 null-var1923)))
(declare-const var3243 String) ; Statement: r10 := @parameter0: java.lang.String 
(assert (not (= var3243 null-String)))
(declare-const var3242 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var3242 null-__Array__Int__String__)))
(define-const var1350 String "") ; Statement: r11 = "" 
(assert true)
(define-const var2207 Int (length/-134980193 var3243)) ; Statement: $i0 = virtualinvoke r10.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r12 = virtualinvoke r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(assert (<= var2207 0)) ; Cond: $i0 <= 0 
; split operation: var1338 = var3243.split(";") ; Statement: $r12 = virtualinvoke r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var766 Int (get_split_length var3243 ";" (- 1))) ; Statement: $i7 = lengthof $r12 
(define-const var2096 Int (getLength-Arr-String-1 var3242)) ; Statement: $i8 = lengthof r0 
(define-const var1242 Int (var423_max/1360571700 var766 var2096)) ; Statement: $i9 = staticinvoke <java.lang.Math: int max(int,int)>($i7, $i8) 
(define-const var1256 (Array Int String) arr-String-init) ; Statement: $r13 = newarray (java.lang.String)[$i9] 
(define-const var3036 Int 0) ; Statement: i10 = 0 
(assert true) ; Non Conditional
 ; Statement: if i10 >= $i9 goto return $r13 
(assert (>= var3036 var1242)) ; Cond: i10 >= $i9 
 ; Statement: return $r13 
(check-sat)
; {length/-134980193=([java.lang.String], int), getLength-Arr-String-1=([java.lang.String[]], int), var423_max/1360571700=([int, int], int), arr-String-init=([], java.lang.String[])}
; {var1923=org.jline.builtins.ScreenTerminal, var841=r9, var3243=r10, var420=null_type, var3242=r0, var1350=r11, var2207=$i0, var1338=$r12, var766=$i7, var2096=$i8, var423=java.lang.Math, var1242=$i9, var1256=$r13, var3036=i10}
; {org.jline.builtins.ScreenTerminal=var1923, r9=var841, r10=var3243, null_type=var420, r0=var3242, r11=var1350, $i0=var2207, $r12=var1338, $i7=var766, $i8=var2096, java.lang.Math=var423, $i9=var1242, $r13=var1256, i10=var3036}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r9 := @this: org.jline.builtins.ScreenTerminal;	r10 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String[];	r11 = "";	$i0 = virtualinvoke r10.<java.lang.String: int length()>();	if $i0 <= 0 goto $r12 = virtualinvoke r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$r12 = virtualinvoke r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$i7 = lengthof $r12;	$i8 = lengthof r0;	$i9 = staticinvoke <java.lang.Math: int max(int,int)>($i7, $i8);	$r13 = newarray (java.lang.String)[$i9];	i10 = 0;	if i10 >= $i9 goto return $r13;	return $r13
;block_num 4
(exit)
