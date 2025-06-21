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

(declare-sort var2766 0)
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
(declare-const var2295 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2295 null-String)))
(define-const var3157 Int 0) ; Statement: i2 = 0 
(assert true)
(define-const var98 Int (length/-134980193 var2295)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return r0 
(assert (not (>= var3157 var98))) ; Negate: Cond: i2 >= i0  
(assert (and true (and (> (str.len var2295) var3157) (<= 0 var3157))))
(define-const var307 Int (charAt/698050440 var2295 var3157)) ; Statement: $c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(i2) 
(define-const var3305 Int (cast-from-Int-to-Int var307)) ; Statement: $i3 = (int) $c1 
 ; Statement: lookupswitch($i3) {     case 36: goto $r6 = new java.lang.StringBuilder;     case 40: goto $r6 = new java.lang.StringBuilder;     case 41: goto $r6 = new java.lang.StringBuilder;     case 46: goto $r6 = new java.lang.StringBuilder;     case 91: goto $r6 = new java.lang.StringBuilder;     case 92: goto $r6 = new java.lang.StringBuilder;     case 93: goto $r6 = new java.lang.StringBuilder;     case 94: goto $r6 = new java.lang.StringBuilder;     case 123: goto $r6 = new java.lang.StringBuilder;     case 124: goto $r6 = new java.lang.StringBuilder;     case 125: goto $r6 = new java.lang.StringBuilder;     default: goto i2 = i2 + 1; } 
(assert (and (= var3305 36) true)) ; Intersect: Cond: $i3 == 36  and Non Conditional 
(define-const var3325 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3325)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3325!1 String)
(assert (= var3325!1 ""))
(assert true)
(define-const var3825 String (append/672562846 var3325!1 "\u005cQ")) ; Statement: $r2 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\Q") 
(declare-const var3325!2 String)
(assert (= var3325!2 (str.++ var3325!1 "\u005cQ")))
(assert true)
(define-const var2035 String (append/672562846 var3825 var2295)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var3825!1 String)
(assert (= var3825!1 (str.++ var3825 var2295)))
(assert true)
(define-const var3477 String (append/672562846 var2035 "\u005cE")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\E") 
(declare-const var2035!1 String)
(assert (= var2035!1 (str.++ var2035 "\u005cE")))
(assert true)
(define-const var3330 String (toString/-2075883882 var3477)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {length/-134980193=([java.lang.String], int), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2295=r0, var2766=null_type, var3157=i2, var98=i0, var307=$c1, var3305=$i3, var3325=$r6, var3825=$r2, var2035=$r3, var3477=$r4, var3330=$r5}
; {r0=var2295, null_type=var2766, i2=var3157, i0=var98, $c1=var307, $i3=var3305, $r6=var3325, $r2=var3825, $r3=var2035, $r4=var3477, $r5=var3330}
;seq <java.lang.String: int length()>;	<java.lang.String: char charAt(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: char charAt(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	i2 = 0;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i2 >= i0 goto return r0;	$c1 = virtualinvoke r0.<java.lang.String: char charAt(int)>(i2);	$i3 = (int) $c1;	lookupswitch($i3) {     case 36: goto $r6 = new java.lang.StringBuilder;     case 40: goto $r6 = new java.lang.StringBuilder;     case 41: goto $r6 = new java.lang.StringBuilder;     case 46: goto $r6 = new java.lang.StringBuilder;     case 91: goto $r6 = new java.lang.StringBuilder;     case 92: goto $r6 = new java.lang.StringBuilder;     case 93: goto $r6 = new java.lang.StringBuilder;     case 94: goto $r6 = new java.lang.StringBuilder;     case 123: goto $r6 = new java.lang.StringBuilder;     case 124: goto $r6 = new java.lang.StringBuilder;     case 125: goto $r6 = new java.lang.StringBuilder;     default: goto i2 = i2 + 1; };	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\Q");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\E");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 4