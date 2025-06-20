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

(declare-sort var3567 0)
(declare-sort var1534 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1534-init () var1534)
(declare-fun <init>/2073162924 (var1534) void)
(declare-const null-String String)
(declare-const var689 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var689 null-String)))
(define-const var1261 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1261)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1261!1 String)
(assert (= var1261!1 ""))
(assert true)
(define-const var3930 Int (lastIndexOf/-1292097097 var689 91)) ; Statement: $i0 = virtualinvoke r1.<java.lang.String: int lastIndexOf(int)>(91) 
(define-const var2601 Int (+ var3930 1)) ; Statement: i7 = $i0 + 1 
(assert true)
(define-const var3274 Int (length/-134980193 var689)) ; Statement: $i2 = virtualinvoke r1.<java.lang.String: int length()>() 
(define-const var1232 Int (+ var2601 1)) ; Statement: $i1 = i7 + 1 
 ; Statement: if $i2 != $i1 goto $i5 = i7 + 1 
(assert (not (not (= var3274 var1232)))) ; Negate: Cond: $i2 != $i1  
(assert (and true (and (> (str.len var689) var2601) (<= 0 var2601))))
(define-const var1201 Int (charAt/698050440 var689 var2601)) ; Statement: $c6 = virtualinvoke r1.<java.lang.String: char charAt(int)>(i7) 
(define-const var1605 Int (cast-from-Int-to-Int var1201)) ; Statement: $i9 = (int) $c6 
 ; Statement: tableswitch($i9) {     case 66: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("byte");     case 67: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("char");     case 68: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("double");     case 69: goto $r7 = new java.lang.RuntimeException;     case 70: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("float");     case 71: goto $r7 = new java.lang.RuntimeException;     case 72: goto $r7 = new java.lang.RuntimeException;     case 73: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("int");     case 74: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("long");     case 75: goto $r7 = new java.lang.RuntimeException;     case 76: goto $r7 = new java.lang.RuntimeException;     case 77: goto $r7 = new java.lang.RuntimeException;     case 78: goto $r7 = new java.lang.RuntimeException;     case 79: goto $r7 = new java.lang.RuntimeException;     case 80: goto $r7 = new java.lang.RuntimeException;     case 81: goto $r7 = new java.lang.RuntimeException;     case 82: goto $r7 = new java.lang.RuntimeException;     case 83: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("short");     case 84: goto $r7 = new java.lang.RuntimeException;     case 85: goto $r7 = new java.lang.RuntimeException;     case 86: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("void");     case 87: goto $r7 = new java.lang.RuntimeException;     case 88: goto $r7 = new java.lang.RuntimeException;     case 89: goto $r7 = new java.lang.RuntimeException;     case 90: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("boolean");     default: goto $r7 = new java.lang.RuntimeException; } 
(assert (and (not (= var1605 68)) (and (not (= var1605 67)) (and (not (= var1605 66)) true)))) ; Intersect: Negate: Cond: $i9 == 68   and Intersect: Negate: Cond: $i9 == 67   and Intersect: Negate: Cond: $i9 == 66   and Non Conditional   
(define-const var2852 var1534 var1534-init) ; Statement: $r7 = new java.lang.RuntimeException 
(assert true)
;(assert (<init>/2073162924 var2852)) ; Statement: specialinvoke $r7.<java.lang.RuntimeException: void <init>()>() 

(declare-const var2852!1 var1534)
 ; Statement: throw $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), lastIndexOf/-1292097097=([java.lang.String, int], int), length/-134980193=([java.lang.String], int), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), var1534-init=([], java.lang.RuntimeException), <init>/2073162924=([java.lang.RuntimeException], void)}
; {var689=r1, var3567=null_type, var1261=$r6, var3930=$i0, var2601=i7, var3274=$i2, var1232=$i1, var1201=$c6, var1605=$i9, var1534=java.lang.RuntimeException, var2852=$r7}
; {r1=var689, null_type=var3567, $r6=var1261, $i0=var3930, i7=var2601, $i2=var3274, $i1=var1232, $c6=var1201, $i9=var1605, java.lang.RuntimeException=var1534, $r7=var2852}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: int lastIndexOf(int)>;	<java.lang.String: int length()>;	<java.lang.String: char charAt(int)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: int length()>": 1,"<java.lang.String: char charAt(int)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$i0 = virtualinvoke r1.<java.lang.String: int lastIndexOf(int)>(91);	i7 = $i0 + 1;	$i2 = virtualinvoke r1.<java.lang.String: int length()>();	$i1 = i7 + 1;	if $i2 != $i1 goto $i5 = i7 + 1;	$c6 = virtualinvoke r1.<java.lang.String: char charAt(int)>(i7);	$i9 = (int) $c6;	tableswitch($i9) {     case 66: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("byte");     case 67: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("char");     case 68: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("double");     case 69: goto $r7 = new java.lang.RuntimeException;     case 70: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("float");     case 71: goto $r7 = new java.lang.RuntimeException;     case 72: goto $r7 = new java.lang.RuntimeException;     case 73: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("int");     case 74: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("long");     case 75: goto $r7 = new java.lang.RuntimeException;     case 76: goto $r7 = new java.lang.RuntimeException;     case 77: goto $r7 = new java.lang.RuntimeException;     case 78: goto $r7 = new java.lang.RuntimeException;     case 79: goto $r7 = new java.lang.RuntimeException;     case 80: goto $r7 = new java.lang.RuntimeException;     case 81: goto $r7 = new java.lang.RuntimeException;     case 82: goto $r7 = new java.lang.RuntimeException;     case 83: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("short");     case 84: goto $r7 = new java.lang.RuntimeException;     case 85: goto $r7 = new java.lang.RuntimeException;     case 86: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("void");     case 87: goto $r7 = new java.lang.RuntimeException;     case 88: goto $r7 = new java.lang.RuntimeException;     case 89: goto $r7 = new java.lang.RuntimeException;     case 90: goto virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("boolean");     default: goto $r7 = new java.lang.RuntimeException; };	$r7 = new java.lang.RuntimeException;	specialinvoke $r7.<java.lang.RuntimeException: void <init>()>();	throw $r7
;block_num 3