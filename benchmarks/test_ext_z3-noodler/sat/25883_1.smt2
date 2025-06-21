(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3477 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var1612 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1612 null-String)))
(define-const var157 Int 0) ; Statement: i2 = 0 
(assert true)
(define-const var1521 Int (length/-134980193 var1612)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return r0 
(assert (not (>= var157 var1521))) ; Negate: Cond: i2 >= i0  
(assert (and true (and (> (str.len var1612) var157) (<= 0 var157))))
(define-const var748 Int (charAt/698050440 var1612 var157)) ; Statement: $c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(i2) 
(define-const var1917 Int (cast-from-Int-to-Int var748)) ; Statement: $i3 = (int) $c1 
 ; Statement: lookupswitch($i3) {     case 36: goto $r6 = new java.lang.StringBuilder;     case 40: goto $r6 = new java.lang.StringBuilder;     case 41: goto $r6 = new java.lang.StringBuilder;     case 46: goto $r6 = new java.lang.StringBuilder;     case 91: goto $r6 = new java.lang.StringBuilder;     case 92: goto $r6 = new java.lang.StringBuilder;     case 93: goto $r6 = new java.lang.StringBuilder;     case 94: goto $r6 = new java.lang.StringBuilder;     case 123: goto $r6 = new java.lang.StringBuilder;     case 124: goto $r6 = new java.lang.StringBuilder;     case 125: goto $r6 = new java.lang.StringBuilder;     default: goto i2 = i2 + 1; } 
(assert (and (not (= var1917 125)) (and (not (= var1917 124)) (and (not (= var1917 123)) (and (not (= var1917 94)) (and (not (= var1917 93)) (and (not (= var1917 92)) (and (not (= var1917 91)) (and (not (= var1917 46)) (and (not (= var1917 41)) (and (not (= var1917 40)) (and (not (= var1917 36)) true)))))))))))) ; Intersect: Negate: Cond: $i3 == 125   and Intersect: Negate: Cond: $i3 == 124   and Intersect: Negate: Cond: $i3 == 123   and Intersect: Negate: Cond: $i3 == 94   and Intersect: Negate: Cond: $i3 == 93   and Intersect: Negate: Cond: $i3 == 92   and Intersect: Negate: Cond: $i3 == 91   and Intersect: Negate: Cond: $i3 == 46   and Intersect: Negate: Cond: $i3 == 41   and Intersect: Negate: Cond: $i3 == 40   and Intersect: Negate: Cond: $i3 == 36   and Non Conditional           
(define-const var157!1 Int (+ var157 1)) ; Statement: i2 = i2 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return r0 
(assert (not (>= var157!1 var1521))) ; Negate: Cond: i2 >= i0  
(assert (and true (and (> (str.len var1612) var157!1) (<= 0 var157!1))))
(define-const var748!1 Int (charAt/698050440 var1612 var157!1)) ; Statement: $c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(i2) 
(define-const var1917!1 Int (cast-from-Int-to-Int var748!1)) ; Statement: $i3 = (int) $c1 
 ; Statement: lookupswitch($i3) {     case 36: goto $r6 = new java.lang.StringBuilder;     case 40: goto $r6 = new java.lang.StringBuilder;     case 41: goto $r6 = new java.lang.StringBuilder;     case 46: goto $r6 = new java.lang.StringBuilder;     case 91: goto $r6 = new java.lang.StringBuilder;     case 92: goto $r6 = new java.lang.StringBuilder;     case 93: goto $r6 = new java.lang.StringBuilder;     case 94: goto $r6 = new java.lang.StringBuilder;     case 123: goto $r6 = new java.lang.StringBuilder;     case 124: goto $r6 = new java.lang.StringBuilder;     case 125: goto $r6 = new java.lang.StringBuilder;     default: goto i2 = i2 + 1; } 
(assert (and (= var1917!1 36) true)) ; Intersect: Cond: $i3 == 36  and Non Conditional 
(define-const var3654 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3654)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3654!1 String)
(assert (= var3654!1 ""))
(assert true)
(define-const var3730 String (append/672562846 var3654!1 "\u005cQ")) ; Statement: $r2 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\Q") 
(declare-const var3654!2 String)
(assert (= var3654!2 (str.++ var3654!1 "\u005cQ")))
(assert true)
(define-const var517 String (append/672562846 var3730 var1612)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var3730!1 String)
(assert (= var3730!1 (str.++ var3730 var1612)))
(assert true)
(define-const var3695 String (append/672562846 var517 "\u005cE")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\E") 
(declare-const var517!1 String)
(assert (= var517!1 (str.++ var517 "\u005cE")))
(assert true)
(define-const var1387 String (toString/-2075883882 var3695)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {length/-134980193=([java.lang.String], int), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1612=r0, var3477=null_type, var157=i2, var1521=i0, var748=$c1, var1917=$i3, var3654=$r6, var3730=$r2, var517=$r3, var3695=$r4, var1387=$r5}
; {r0=var1612, null_type=var3477, i2=var157, i0=var1521, $c1=var748, $i3=var1917, $r6=var3654, $r2=var3730, $r3=var517, $r4=var3695, $r5=var1387}
;seq <java.lang.String: int length()>;	<java.lang.String: char charAt(int)>;	<java.lang.String: char charAt(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: char charAt(int)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	i2 = 0;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i2 >= i0 goto return r0;	$c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(i2);	$i3 = (int) $c1;	lookupswitch($i3) {     case 36: goto $r6 = new java.lang.StringBuilder;     case 40: goto $r6 = new java.lang.StringBuilder;     case 41: goto $r6 = new java.lang.StringBuilder;     case 46: goto $r6 = new java.lang.StringBuilder;     case 91: goto $r6 = new java.lang.StringBuilder;     case 92: goto $r6 = new java.lang.StringBuilder;     case 93: goto $r6 = new java.lang.StringBuilder;     case 94: goto $r6 = new java.lang.StringBuilder;     case 123: goto $r6 = new java.lang.StringBuilder;     case 124: goto $r6 = new java.lang.StringBuilder;     case 125: goto $r6 = new java.lang.StringBuilder;     default: goto i2 = i2 + 1; };	i2 = i2 + 1;	goto [?= (branch)];	if i2 >= i0 goto return r0;	$c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(i2);	$i3 = (int) $c1;	lookupswitch($i3) {     case 36: goto $r6 = new java.lang.StringBuilder;     case 40: goto $r6 = new java.lang.StringBuilder;     case 41: goto $r6 = new java.lang.StringBuilder;     case 46: goto $r6 = new java.lang.StringBuilder;     case 91: goto $r6 = new java.lang.StringBuilder;     case 92: goto $r6 = new java.lang.StringBuilder;     case 93: goto $r6 = new java.lang.StringBuilder;     case 94: goto $r6 = new java.lang.StringBuilder;     case 123: goto $r6 = new java.lang.StringBuilder;     case 124: goto $r6 = new java.lang.StringBuilder;     case 125: goto $r6 = new java.lang.StringBuilder;     default: goto i2 = i2 + 1; };	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\Q");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\E");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 7