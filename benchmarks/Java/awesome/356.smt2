(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2364 0)
(declare-sort var3585 0)
(declare-sort var3627 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun commander/-2133873678 (var2364) var3627)
(declare-fun getColumnSize/-165698927 (var3627) Int)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var2364 var2364)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3784 var2364) ; Statement: r0 := @this: com.beust.jcommander.DefaultUsageFormatter 
(assert (not (= var3784 null-var2364)))
(declare-const var3465 String) ; Statement: r5 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3465 null-String)))
(declare-const var1971 Int) ; Statement: i10 := @parameter1: int 
(assert (not (= var1971 null-Int)))
(declare-const var3413 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var3413 null-Int)))
(declare-const var3705 String) ; Statement: r2 := @parameter3: java.lang.String 
(assert (not (= var3705 null-String)))
(define-const var1457 var3627 (commander/-2133873678 var3784)) ; Statement: $r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander> 
(assert true)
(define-const var56 Int (getColumnSize/-165698927 var1457)) ; Statement: i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>() 
; split operation: var2677 = var3705.split(" ") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var2128 Int var3413) ; Statement: i14 = i1 
(define-const var3771 Int 0) ; Statement: i15 = 0 
(assert true) ; Non Conditional
(define-const var2582 Int (get_split_length var3705 " " -1)) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (not (>= var3771 var2582))) ; Negate: Cond: i15 >= $i2  
(define-const var1987 String (get_split_element var3705 " " -1 var3771)) ; Statement: r4 = r3[i15] 
(assert true)
(define-const var3229 Int (length/-134980193 var1987)) ; Statement: $i3 = virtualinvoke r4.<java.lang.String: int length()>() 
 ; Statement: if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(assert (> var3229 var56)) ; Cond: $i3 > i0 
(assert true)
;(assert (append/672562846 var3465 var1987)) ; Statement: virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var3465!1 String)
(assert (= var3465!1 (str.++ var3465 var1987)))
(assert true)
(define-const var758 Int (length/-134980193 var1987)) ; Statement: $i4 = virtualinvoke r4.<java.lang.String: int length()>() 
(define-const var388 Int (+ var2128 var758)) ; Statement: $i13 = i14 + $i4 
(define-const var2128!1 Int var388) ; Statement: i14 = $i13 
(define-const var1961 Int (get_split_length var3705 " " -1)) ; Statement: $i5 = lengthof r3 
(define-const var732 Int (- var1961 1)) ; Statement: $i6 = $i5 - 1 
 ; Statement: if i15 == $i6 goto i15 = i15 + 1 
(assert (not (= var3771 var732))) ; Negate: Cond: i15 == $i6  
(assert true)
;(assert (append/672562846 var3465!1 " ")) ; Statement: virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ") 
(declare-const var3465!2 String)
(assert (= var3465!2 (str.++ var3465!1 " ")))
(define-const var2128!2 Int (+ var388 1)) ; Statement: i14 = $i13 + 1 
 ; Statement: goto [?= i15 = i15 + 1] 
(assert true) ; Non Conditional
(define-const var3771!1 Int (+ var3771 1)) ; Statement: i15 = i15 + 1 
 ; Statement: goto [?= $i2 = lengthof r3] 
(assert true) ; Non Conditional
(define-const var2582!1 Int (get_split_length var3705 " " -1)) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (>= var3771!1 var2582!1)) ; Cond: i15 >= $i2 
 ; Statement: return 
(check-sat)
; {commander/-2133873678=([com.beust.jcommander.DefaultUsageFormatter], com.beust.jcommander.JCommander), getColumnSize/-165698927=([com.beust.jcommander.JCommander], int), length/-134980193=([java.lang.String], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var2364=com.beust.jcommander.DefaultUsageFormatter, var3784=r0, var3465=r5, var1971=i10, var3413=i1, var3705=r2, var3585=null_type, var3627=com.beust.jcommander.JCommander, var1457=$r1, var56=i0, var2677=r3, var2128=i14, var3771=i15, var2582=$i2, var1987=r4, var3229=$i3, var758=$i4, var388=$i13, var1961=$i5, var732=$i6}
; {com.beust.jcommander.DefaultUsageFormatter=var2364, r0=var3784, r5=var3465, i10=var1971, i1=var3413, r2=var3705, null_type=var3585, com.beust.jcommander.JCommander=var3627, $r1=var1457, i0=var56, r3=var2677, i14=var2128, i15=var3771, $i2=var2582, r4=var1987, $i3=var3229, $i4=var758, $i13=var388, $i5=var1961, $i6=var732}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: int length()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r0 := @this: com.beust.jcommander.DefaultUsageFormatter;	r5 := @parameter0: java.lang.StringBuilder;	i10 := @parameter1: int;	i1 := @parameter2: int;	r2 := @parameter3: java.lang.String;	$r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander>;	i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>();	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	i14 = i1;	i15 = 0;	$i2 = lengthof r3;	if i15 >= $i2 goto return;	r4 = r3[i15];	$i3 = virtualinvoke r4.<java.lang.String: int length()>();	if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$i4 = virtualinvoke r4.<java.lang.String: int length()>();	$i13 = i14 + $i4;	i14 = $i13;	$i5 = lengthof r3;	$i6 = $i5 - 1;	if i15 == $i6 goto i15 = i15 + 1;	virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ");	i14 = $i13 + 1;	goto [?= i15 = i15 + 1];	i15 = i15 + 1;	goto [?= $i2 = lengthof r3];	$i2 = lengthof r3;	if i15 >= $i2 goto return;	return
;block_num 8