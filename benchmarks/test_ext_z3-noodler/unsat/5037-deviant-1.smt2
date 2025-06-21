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

(declare-sort var3164 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var338 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var338 null-String)))
(assert true)
(define-const var2015 Bool (startsWith/-1785782452 var338 "get")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 == 0 goto $b5 = 2 
(assert (= (ite var2015 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3771 Int 2) ; Statement: $b5 = 2 
(define-const var2003 Int 2) ; Statement: $b4 = 2 
(define-const var3077 Int 2) ; Statement: $b3 = 2 
(assert true) ; Non Conditional
(define-const var2308 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2308)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2308!1 String)
(assert (= var2308!1 ""))
(define-const var964 Int (+ var3077 1)) ; Statement: $i0 = $b3 + 1 
(assert (and true (and (>= var2003 0) (>= (str.len var338) var964) (>= var964 var2003))))
(define-const var3252 String (substring/-1240304868 var338 var2003 var964)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($b4, $i0) 
(assert true)
(define-const var1608 String (toLowerCase/415700667 var3252)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var2033 String (append/672562846 var2308!1 var1608)) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2308!2 String)
(assert (= var2308!2 (str.++ var2308!1 var1608)))
(define-const var3980 Int (+ var3771 1)) ; Statement: $i1 = $b5 + 1 
(assert (not (and true (and (>= var3980 0) (>= (str.len var338) var3980)))))
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var338=r0, var3164=null_type, var2015=$z0, var3771=$b5, var2003=$b4, var3077=$b3, var2308=$r1, var964=$i0, var3252=$r2, var1608=$r3, var2033=$r5, var3980=$i1, var2348=$r4, var3211=$r6, var2101=$r7}
; {r0=var338, null_type=var3164, $z0=var2015, $b5=var3771, $b4=var2003, $b3=var3077, $r1=var2308, $i0=var964, $r2=var3252, $r3=var1608, $r5=var2033, $i1=var3980, $r4=var2348, $r6=var3211, $r7=var2101}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toLowerCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 == 0 goto $b5 = 2;	$b5 = 2;	$b4 = 2;	$b3 = 2;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$i0 = $b3 + 1;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($b4, $i0);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$i1 = $b5 + 1;	$r4 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 3