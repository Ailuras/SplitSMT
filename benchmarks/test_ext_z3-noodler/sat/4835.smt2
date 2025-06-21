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

(declare-sort var2763 0)
(declare-sort var2253 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/1227988463 (var2253) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2763 var2763)
(declare-const null-var2253 var2253)
(declare-const var3786 var2763) ; Statement: r10 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var3786 null-var2763)))
(declare-const var630 var2253) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var630 null-var2253)))
(assert true)
(define-const var2600 String (getName/1227988463 var630)) ; Statement: $r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var1008 Int (length/-134980193 var2600)) ; Statement: $i0 = virtualinvoke $r1.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 3 goto $r11 = "" 
(assert (not (<= var1008 3))) ; Negate: Cond: $i0 <= 3  
(define-const var3952 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3952)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3952!1 String)
(assert (= var3952!1 ""))
(assert true)
(define-const var763 String (getName/1227988463 var630)) ; Statement: $r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert (and true (and (>= 3 0) (>= (str.len var763) 4) (>= 4 3))))
(define-const var719 String (substring/-1240304868 var763 3 4)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String substring(int,int)>(3, 4) 
(assert true)
(define-const var685 String (toLowerCase/415700667 var719)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var2096 String (append/672562846 var3952!1 var685)) ; Statement: $r8 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3952!2 String)
(assert (= var3952!2 (str.++ var3952!1 var685)))
(assert true)
(define-const var1848 String (getName/1227988463 var630)) ; Statement: $r6 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert (and true (and (>= 4 0) (>= (str.len var1848) 4))))
(define-const var3268 String (substring/850833817 var1848 4)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.String: java.lang.String substring(int)>(4) 
(assert true)
(define-const var3863 String (append/672562846 var2096 var3268)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var2096!1 String)
(assert (= var2096!1 (str.++ var2096 var3268)))
(assert true)
(define-const var3239 String (toString/-2075883882 var3863)) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= return $r11] 
(assert true) ; Non Conditional
 ; Statement: return $r11 
(check-sat)
; {getName/1227988463=([java.lang.reflect.Method], java.lang.String), length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/850833817=([java.lang.String, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2763=org.apache.dubbo.common.extension.ExtensionLoader, var3786=r10, var2253=java.lang.reflect.Method, var630=r0, var2600=$r1, var1008=$i0, var3952=$r2, var763=$r3, var719=$r4, var685=$r5, var2096=$r8, var1848=$r6, var3268=$r7, var3863=$r9, var3239=$r11}
; {org.apache.dubbo.common.extension.ExtensionLoader=var2763, r10=var3786, java.lang.reflect.Method=var2253, r0=var630, $r1=var2600, $i0=var1008, $r2=var3952, $r3=var763, $r4=var719, $r5=var685, $r8=var2096, $r6=var1848, $r7=var3268, $r9=var3863, $r11=var3239}
;seq <java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String toLowerCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r0 := @parameter0: java.lang.reflect.Method;	$r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$i0 = virtualinvoke $r1.<java.lang.String: int length()>();	if $i0 <= 3 goto $r11 = "";	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String substring(int,int)>(3, 4);	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String toLowerCase()>();	$r8 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r6 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	$r7 = virtualinvoke $r6.<java.lang.String: java.lang.String substring(int)>(4);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= return $r11];	return $r11
;block_num 3