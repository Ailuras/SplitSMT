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

(declare-sort var2542 0)
(declare-sort var1710 0)
(declare-sort var2616 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_charAt/1466887330 (String Int) Int)
(declare-fun var2542_decodeHexNibble/-72227405 (Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1710-init () var1710)
(declare-fun arr-var2616-init () (Array Int var2616))
(declare-fun String_subSequence/-1087362312 (String Int Int) String)
(declare-fun cast-from-String-to-var2616 (String) var2616)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var2616 (Int) var2616)
(declare-fun String_format/1339386452 (String (Array Int var2616)) String)
(declare-fun <init>/875830710 (var1710 String) void)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var2616__ (Array Int var2616))
(declare-const var588 String) ; Statement: r0 := @parameter0: java.lang.CharSequence 
(assert (not (= var588 null-String)))
(declare-const var545 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var545 null-Int)))
(define-const var560 Int (String_charAt/1466887330 var588 var545)) ; Statement: $c1 = interfaceinvoke r0.<java.lang.CharSequence: char charAt(int)>(i0) 
(define-const var533 Int (var2542_decodeHexNibble/-72227405 var560)) ; Statement: i2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int decodeHexNibble(char)>($c1) 
(define-const var2901 Int (+ var545 1)) ; Statement: $i3 = i0 + 1 
(define-const var1148 Int (String_charAt/1466887330 var588 var2901)) ; Statement: $c4 = interfaceinvoke r0.<java.lang.CharSequence: char charAt(int)>($i3) 
(define-const var603 Int (var2542_decodeHexNibble/-72227405 var1148)) ; Statement: i5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int decodeHexNibble(char)>($c4) 
(define-const var2060 Int (cast-from-Int-to-Int -1)) ; Statement: $i11 = (int) -1 
 ; Statement: if i2 == $i11 goto $r6 = new java.lang.IllegalArgumentException 
(assert (= var533 var2060)) ; Cond: i2 == $i11 
(define-const var1551 var1710 var1710-init) ; Statement: $r6 = new java.lang.IllegalArgumentException 
(define-const var2343 (Array Int var2616) arr-var2616-init) ; Statement: $r2 = newarray (java.lang.Object)[3] 
(define-const var1657 Int (+ var545 2)) ; Statement: $i6 = i0 + 2 
(define-const var2761 String (String_subSequence/-1087362312 var588 var545 var1657)) ; Statement: $r3 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>(i0, $i6) 
(declare-const var2343!1 (Array Int var2616))
(assert (not (= var2343!1 null-__Array__Int__var2616__)))
(assert (= (select var2343!1 0) (cast-from-String-to-var2616 var2761))) ; Statement: $r2[0] = $r3 
(define-const var85 Int (Int_valueOf/-1371140006 var545)) ; Statement: $r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var2343!2 (Array Int var2616))
(assert (not (= var2343!2 null-__Array__Int__var2616__)))
(assert (= (select var2343!2 1) (cast-from-Int-to-var2616 var85))) ; Statement: $r2[1] = $r4 
(declare-const var2343!3 (Array Int var2616))
(assert (not (= var2343!3 null-__Array__Int__var2616__)))
(assert (= (select var2343!3 2) (cast-from-String-to-var2616 var588))) ; Statement: $r2[2] = r0 
(define-const var2720 String (String_format/1339386452 "invalid hex byte \u0027%s\u0027 at index %d of \u0027%s\u0027" var2343!3)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("invalid hex byte \'%s\' at index %d of \'%s\'", $r2) 
(assert true)
;(assert (<init>/875830710 var1551 var2720)) ; Statement: specialinvoke $r6.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r5) 

(declare-const var1551!1 var1710)
(declare-const var2720!1 String)
 ; Statement: throw $r6 
(check-sat)
; {String_charAt/1466887330=([java.lang.CharSequence, int], char), var2542_decodeHexNibble/-72227405=([char], int), cast-from-Int-to-Int=([int], int), var1710-init=([], java.lang.IllegalArgumentException), arr-var2616-init=([], java.lang.Object[]), String_subSequence/-1087362312=([java.lang.CharSequence, int, int], java.lang.CharSequence), cast-from-String-to-var2616=([java.lang.CharSequence], java.lang.Object), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var2616=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var588=r0, var545=i0, var560=$c1, var2542=org.apache.dubbo.common.utils.StringUtils, var533=i2, var2901=$i3, var1148=$c4, var603=i5, var2060=$i11, var1710=java.lang.IllegalArgumentException, var1551=$r6, var2616=java.lang.Object, var2343=$r2, var1657=$i6, var2761=$r3, var85=$r4, var2720=$r5}
; {r0=var588, i0=var545, $c1=var560, org.apache.dubbo.common.utils.StringUtils=var2542, i2=var533, $i3=var2901, $c4=var1148, i5=var603, $i11=var2060, java.lang.IllegalArgumentException=var1710, $r6=var1551, java.lang.Object=var2616, $r2=var2343, $i6=var1657, $r3=var2761, $r4=var85, $r5=var2720}
;seq <java.lang.CharSequence: char charAt(int)>;	<org.apache.dubbo.common.utils.StringUtils: int decodeHexNibble(char)>;	<java.lang.CharSequence: char charAt(int)>;	<org.apache.dubbo.common.utils.StringUtils: int decodeHexNibble(char)>;	<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.CharSequence: char charAt(int)>": 2,"<org.apache.dubbo.common.utils.StringUtils: int decodeHexNibble(char)>": 2,"<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>": 1,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: java.lang.CharSequence;	i0 := @parameter1: int;	$c1 = interfaceinvoke r0.<java.lang.CharSequence: char charAt(int)>(i0);	i2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int decodeHexNibble(char)>($c1);	$i3 = i0 + 1;	$c4 = interfaceinvoke r0.<java.lang.CharSequence: char charAt(int)>($i3);	i5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int decodeHexNibble(char)>($c4);	$i11 = (int) -1;	if i2 == $i11 goto $r6 = new java.lang.IllegalArgumentException;	$r6 = new java.lang.IllegalArgumentException;	$r2 = newarray (java.lang.Object)[3];	$i6 = i0 + 2;	$r3 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>(i0, $i6);	$r2[0] = $r3;	$r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r2[1] = $r4;	$r2[2] = r0;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("invalid hex byte \'%s\' at index %d of \'%s\'", $r2);	specialinvoke $r6.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r5);	throw $r6
;block_num 2