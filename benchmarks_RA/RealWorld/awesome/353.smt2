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

(declare-sort var347 0)
(declare-sort var2490 0)
(declare-sort var631 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun commander/-2133873678 (var347) var631)
(declare-fun getColumnSize/-165698927 (var631) Int)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var347_s/45959816 (Int) String)
(declare-const null-var347 var347)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3064 var347) ; Statement: r0 := @this: com.beust.jcommander.DefaultUsageFormatter 
(assert (not (= var3064 null-var347)))
(declare-const var3488 String) ; Statement: r5 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3488 null-String)))
(declare-const var696 Int) ; Statement: i10 := @parameter1: int 
(assert (not (= var696 null-Int)))
(declare-const var3634 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var3634 null-Int)))
(declare-const var3778 String) ; Statement: r2 := @parameter3: java.lang.String 
(assert (not (= var3778 null-String)))
(define-const var3867 var631 (commander/-2133873678 var3064)) ; Statement: $r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander> 
(assert true)
(define-const var1036 Int (getColumnSize/-165698927 var3867)) ; Statement: i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>() 
; split operation: var2759 = var3778.split(" ") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var1829 Int var3634) ; Statement: i14 = i1 
(define-const var74 Int 0) ; Statement: i15 = 0 
(assert true) ; Non Conditional
(define-const var788 Int (get_split_length var3778 " " (- 1))) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (not (>= var74 var788))) ; Negate: Cond: i15 >= $i2  
(define-const var2050 String (get_split_element var3778 " " (- 1) var74)) ; Statement: r4 = r3[i15] 
(assert true)
(define-const var2592 Int (length/-134980193 var2050)) ; Statement: $i3 = virtualinvoke r4.<java.lang.String: int length()>() 
 ; Statement: if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(assert (not (> var2592 var1036))) ; Negate: Cond: $i3 > i0  
(define-const var3458 Int (+ var1829 1)) ; Statement: $i8 = i14 + 1 
(assert true)
(define-const var2249 Int (length/-134980193 var2050)) ; Statement: $i7 = virtualinvoke r4.<java.lang.String: int length()>() 
(define-const var3212 Int (+ var3458 var2249)) ; Statement: $i9 = $i8 + $i7 
 ; Statement: if $i9 > i0 goto $r7 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (> var3212 var1036)) ; Cond: $i9 > i0 
(assert true)
(define-const var396 String (append/672562846 var3488 "\u{0A}")) ; Statement: $r7 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var3488!1 String)
(assert (= var3488!1 (str.++ var3488 "\u{0A}")))
(define-const var3420 String (var347_s/45959816 var696)) ; Statement: $r6 = staticinvoke <com.beust.jcommander.DefaultUsageFormatter: java.lang.String s(int)>(i10) 
(assert true)
(define-const var2306 String (append/672562846 var396 var3420)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var396!1 String)
(assert (= var396!1 (str.++ var396 var3420)))
(assert true)
(define-const var936 String (append/672562846 var2306 var2050)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var2306!1 String)
(assert (= var2306!1 (str.++ var2306 var2050)))
(assert true)
;(assert (append/672562846 var936 " ")) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ") 
(declare-const var936!1 String)
(assert (= var936!1 (str.++ var936 " ")))
(assert true)
(define-const var1805 Int (length/-134980193 var2050)) ; Statement: $i11 = virtualinvoke r4.<java.lang.String: int length()>() 
(define-const var3013 Int (+ var696 var1805)) ; Statement: $i12 = i10 + $i11 
(define-const var1829!1 Int (+ var3013 1)) ; Statement: i14 = $i12 + 1 
(assert true) ; Non Conditional
(define-const var74!1 Int (+ var74 1)) ; Statement: i15 = i15 + 1 
 ; Statement: goto [?= $i2 = lengthof r3] 
(assert true) ; Non Conditional
(define-const var788!1 Int (get_split_length var3778 " " (- 1))) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (>= var74!1 var788!1)) ; Cond: i15 >= $i2 
 ; Statement: return 
; {commander/-2133873678=([com.beust.jcommander.DefaultUsageFormatter], com.beust.jcommander.JCommander), getColumnSize/-165698927=([com.beust.jcommander.JCommander], int), length/-134980193=([java.lang.String], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var347_s/45959816=([int], java.lang.String)}
; {var347=com.beust.jcommander.DefaultUsageFormatter, var3064=r0, var3488=r5, var696=i10, var3634=i1, var3778=r2, var2490=null_type, var631=com.beust.jcommander.JCommander, var3867=$r1, var1036=i0, var2759=r3, var1829=i14, var74=i15, var788=$i2, var2050=r4, var2592=$i3, var3458=$i8, var2249=$i7, var3212=$i9, var396=$r7, var3420=$r6, var2306=$r8, var936=$r9, var1805=$i11, var3013=$i12}
; {com.beust.jcommander.DefaultUsageFormatter=var347, r0=var3064, r5=var3488, i10=var696, i1=var3634, r2=var3778, null_type=var2490, com.beust.jcommander.JCommander=var631, $r1=var3867, i0=var1036, r3=var2759, i14=var1829, i15=var74, $i2=var788, r4=var2050, $i3=var2592, $i8=var3458, $i7=var2249, $i9=var3212, $r7=var396, $r6=var3420, $r8=var2306, $r9=var936, $i11=var1805, $i12=var3013}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: int length()>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4}
;stmts r0 := @this: com.beust.jcommander.DefaultUsageFormatter;	r5 := @parameter0: java.lang.StringBuilder;	i10 := @parameter1: int;	i1 := @parameter2: int;	r2 := @parameter3: java.lang.String;	$r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander>;	i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>();	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	i14 = i1;	i15 = 0;	$i2 = lengthof r3;	if i15 >= $i2 goto return;	r4 = r3[i15];	$i3 = virtualinvoke r4.<java.lang.String: int length()>();	if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$i8 = i14 + 1;	$i7 = virtualinvoke r4.<java.lang.String: int length()>();	$i9 = $i8 + $i7;	if $i9 > i0 goto $r7 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$r7 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$r6 = staticinvoke <com.beust.jcommander.DefaultUsageFormatter: java.lang.String s(int)>(i10);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ");	$i11 = virtualinvoke r4.<java.lang.String: int length()>();	$i12 = i10 + $i11;	i14 = $i12 + 1;	i15 = i15 + 1;	goto [?= $i2 = lengthof r3];	$i2 = lengthof r3;	if i15 >= $i2 goto return;	return
;block_num 8
(check-sat)
(exit)
