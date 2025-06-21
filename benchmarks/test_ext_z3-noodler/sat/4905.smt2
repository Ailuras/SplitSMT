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

(declare-sort var3457 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var1999 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1999 null-String)))
(define-const var3069 String "set") ; Statement: $r1 = "set" 
(assert true)
(define-const var1360 Int (length/-134980193 var3069)) ; Statement: $i0 = virtualinvoke $r1.<java.lang.String: int length()>() 
(assert (and true (and (>= var1360 0) (>= (str.len var1999) var1360))))
(define-const var935 String (substring/850833817 var1999 var1360)) ; Statement: r8 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i0) 
(define-const var1676 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1676)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1676!1 String)
(assert (= var1676!1 ""))
(assert (and true (and (>= 0 0) (>= (str.len var935) 1) (>= 1 0))))
(define-const var1791 String (substring/-1240304868 var935 0 1)) ; Statement: $r3 = virtualinvoke r8.<java.lang.String: java.lang.String substring(int,int)>(0, 1) 
(assert true)
(define-const var34 String (toLowerCase/415700667 var1791)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var2129 String (append/672562846 var1676!1 var34)) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1676!2 String)
(assert (= var1676!2 (str.++ var1676!1 var34)))
(assert (and true (and (>= 1 0) (>= (str.len var935) 1))))
(define-const var148 String (substring/850833817 var935 1)) ; Statement: $r5 = virtualinvoke r8.<java.lang.String: java.lang.String substring(int)>(1) 
(assert true)
(define-const var3025 String (append/672562846 var2129 var148)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2129!1 String)
(assert (= var2129!1 (str.++ var2129 var148)))
(assert true)
(define-const var1780 String (toString/-2075883882 var3025)) ; Statement: r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return r9 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/850833817=([java.lang.String, int], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1999=r0, var3457=null_type, var3069=$r1, var1360=$i0, var935=r8, var1676=$r2, var1791=$r3, var34=$r4, var2129=$r6, var148=$r5, var3025=$r7, var1780=r9}
; {r0=var1999, null_type=var3457, $r1=var3069, $i0=var1360, r8=var935, $r2=var1676, $r3=var1791, $r4=var34, $r6=var2129, $r5=var148, $r7=var3025, r9=var1780}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toLowerCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = "set";	$i0 = virtualinvoke $r1.<java.lang.String: int length()>();	r8 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i0);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke r8.<java.lang.String: java.lang.String substring(int,int)>(0, 1);	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r5 = virtualinvoke r8.<java.lang.String: java.lang.String substring(int)>(1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return r9
;block_num 1