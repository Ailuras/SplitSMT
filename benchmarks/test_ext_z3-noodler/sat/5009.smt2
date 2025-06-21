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

(declare-sort var634 0)
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
(declare-const var1064 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1064 null-String)))
(assert true)
(define-const var790 Bool (startsWith/-1785782452 var1064 "get")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("get") 
 ; Statement: if $z0 == 0 goto $b5 = 2 
(assert (not (= (ite var790 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2106 Int 3) ; Statement: $b5 = 3 
(define-const var1668 Int 3) ; Statement: $b4 = 3 
(define-const var1571 Int 3) ; Statement: $b3 = 3 
 ; Statement: goto [?= $r1 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var44 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var44)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var44!1 String)
(assert (= var44!1 ""))
(define-const var1609 Int (+ var1571 1)) ; Statement: $i0 = $b3 + 1 
(assert (and true (and (>= var1668 0) (>= (str.len var1064) var1609) (>= var1609 var1668))))
(define-const var3596 String (substring/-1240304868 var1064 var1668 var1609)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($b4, $i0) 
(assert true)
(define-const var2534 String (toLowerCase/415700667 var3596)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var2578 String (append/672562846 var44!1 var2534)) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var44!2 String)
(assert (= var44!2 (str.++ var44!1 var2534)))
(define-const var1263 Int (+ var2106 1)) ; Statement: $i1 = $b5 + 1 
(assert (and true (and (>= var1263 0) (>= (str.len var1064) var1263))))
(define-const var2005 String (substring/850833817 var1064 var1263)) ; Statement: $r4 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1) 
(assert true)
(define-const var2207 String (append/672562846 var2578 var2005)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2578!1 String)
(assert (= var2578!1 (str.++ var2578 var2005)))
(assert true)
(define-const var3195 String (toString/-2075883882 var2207)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1064=r0, var634=null_type, var790=$z0, var2106=$b5, var1668=$b4, var1571=$b3, var44=$r1, var1609=$i0, var3596=$r2, var2534=$r3, var2578=$r5, var1263=$i1, var2005=$r4, var2207=$r6, var3195=$r7}
; {r0=var1064, null_type=var634, $z0=var790, $b5=var2106, $b4=var1668, $b3=var1571, $r1=var44, $i0=var1609, $r2=var3596, $r3=var2534, $r5=var2578, $i1=var1263, $r4=var2005, $r6=var2207, $r7=var3195}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toLowerCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("get");	if $z0 == 0 goto $b5 = 2;	$b5 = 3;	$b4 = 3;	$b3 = 3;	goto [?= $r1 = new java.lang.StringBuilder];	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$i0 = $b3 + 1;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($b4, $i0);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toLowerCase()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$i1 = $b5 + 1;	$r4 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 3